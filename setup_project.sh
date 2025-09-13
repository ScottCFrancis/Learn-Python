#!/bin/bash

# Learn Python Project Setup Script
# This script standardizes the Python environment setup across all Macs

set -e  # Exit on any error

echo "🐍 Learn Python Project Setup"
echo "=============================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if we're in the right directory
if [[ ! "$(pwd)" =~ "Learn-Python" ]]; then
    print_error "Please run this script from the Learn-Python directory"
    exit 1
fi

# Step 1: Check for Xcode command line tools
print_status "Checking for Xcode command line tools..."
if ! command -v git &> /dev/null; then
    print_warning "Xcode command line tools not found. Installing..."
    xcode-select --install
    print_warning "Please complete the Xcode installation dialog and run this script again."
    exit 1
fi
print_success "Xcode command line tools are installed"

# Step 2: Check Python installation
print_status "Checking Python installation..."
if ! command -v python3 &> /dev/null; then
    print_error "Python 3 is not installed. Please install Python 3 first."
    print_status "You can install it using: brew install python3"
    exit 1
fi

PYTHON_VERSION=$(python3 --version)
print_success "Found $PYTHON_VERSION"

# Step 3: Check for Homebrew (optional but recommended)
print_status "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print_status "Please add Homebrew to your PATH and run this script again."
    exit 1
fi
print_success "Homebrew is installed"

# Step 4: Clone repository if not already present
if [[ ! -d ".git" ]]; then
    print_status "Repository not found. Let's set up GitHub access..."
    
    # Check for GitHub CLI (makes authentication easier)
    if ! command -v gh &> /dev/null; then
        print_status "GitHub CLI not found. This makes authentication easier."
        read -p "Would you like to install GitHub CLI? (y/n): " INSTALL_GH
        
        if [[ "$INSTALL_GH" =~ ^[Yy]$ ]]; then
            print_status "Installing GitHub CLI..."
            brew install gh
            print_success "GitHub CLI installed"
            print_status "You can authenticate with: gh auth login"
        fi
    else
        print_success "GitHub CLI is available"
        
        # Check if already authenticated
        if gh auth status &> /dev/null; then
            print_success "GitHub CLI is already authenticated"
        else
            print_status "GitHub CLI needs authentication. Run 'gh auth login' after setup."
        fi
    fi
    
    # Check if Git is configured
    if ! git config --global user.name &> /dev/null; then
        print_warning "Git not configured. Setting up Git configuration..."
        read -p "Enter your name: " GIT_NAME
        read -p "Enter your email: " GIT_EMAIL
        
        git config --global user.name "$GIT_NAME"
        git config --global user.email "$GIT_EMAIL"
        print_success "Git configured with name: $GIT_NAME, email: $GIT_EMAIL"
    else
        GIT_NAME=$(git config --global user.name)
        GIT_EMAIL=$(git config --global user.email)
        print_success "Git already configured: $GIT_NAME <$GIT_EMAIL>"
    fi
    
    echo ""
    print_status "Choose your GitHub repository access method:"
    echo "1) HTTPS (will use GitHub CLI or browser authentication)"
    echo "2) SSH (if you have SSH keys set up)"
    echo "3) Skip repository setup for now"
    read -p "Enter choice (1-3): " REPO_CHOICE
    
    case $REPO_CHOICE in
        1)
            read -p "GitHub repository URL (HTTPS): " REPO_URL
            if [[ -z "$REPO_URL" ]]; then
                print_error "No repository URL provided."
                exit 1
            fi
            
            print_status "Cloning repository via HTTPS..."
            print_status "If prompted for authentication, GitHub will open your browser"
            git clone "$REPO_URL" .
            print_success "Repository cloned successfully"
            ;;
        2)
            read -p "GitHub repository URL (SSH): " REPO_URL
            if [[ -z "$REPO_URL" ]]; then
                print_error "No repository URL provided."
                exit 1
            fi
            
            print_status "Cloning repository via SSH..."
            git clone "$REPO_URL" .
            print_success "Repository cloned successfully"
            ;;
        3)
            print_warning "Skipping repository setup. You can clone it manually later."
            ;;
        *)
            print_error "Invalid choice. Exiting."
            exit 1
            ;;
    esac
else
    print_success "Repository already exists"
fi

# Step 5: Create virtual environment
print_status "Creating Python virtual environment..."
if [[ -d "venv" ]]; then
    print_warning "Virtual environment already exists. Removing old one..."
    rm -rf venv
fi

python3 -m venv venv
print_success "Virtual environment created"

# Step 6: Activate virtual environment and upgrade pip
print_status "Activating virtual environment and upgrading pip..."
source venv/bin/activate
pip install --upgrade pip
print_success "Pip upgraded to latest version"

# Step 7: Install dependencies
print_status "Installing project dependencies..."

# Check for requirements.txt
if [[ -f "requirements.txt" ]]; then
    print_status "Found requirements.txt, installing dependencies..."
    pip install -r requirements.txt
    print_success "Dependencies installed from requirements.txt"
else
    print_warning "No requirements.txt found. Installing common Python learning packages..."
    
    # Install common packages for Python learning
    pip install \
        jupyter \
        notebook \
        ipython \
        matplotlib \
        numpy \
        pandas \
        requests \
        beautifulsoup4 \
        flask \
        pytest \
        black \
        flake8
    
    print_success "Common Python learning packages installed"
    
    # Create a basic requirements.txt
    pip freeze > requirements.txt
    print_success "Created requirements.txt with installed packages"
fi

# Step 8: Create .gitignore if it doesn't exist
if [[ ! -f ".gitignore" ]]; then
    print_status "Creating .gitignore file..."
    cat > .gitignore << EOF
# Python
__pycache__/
*.py[cod]
*$py.class
*.so
.Python
build/
develop-eggs/
dist/
downloads/
eggs/
.eggs/
lib/
lib64/
parts/
sdist/
var/
wheels/
*.egg-info/
.installed.cfg
*.egg

# Virtual Environment
venv/
env/
ENV/

# IDE
.vscode/
.idea/
*.swp
*.swo

# Jupyter Notebook
.ipynb_checkpoints

# OS
.DS_Store
Thumbs.db

# Environment variables
.env
EOF
    print_success ".gitignore created"
fi

# Step 9: Create a basic project structure if it doesn't exist
print_status "Setting up project structure..."

# Create directories
mkdir -p src
mkdir -p notebooks
mkdir -p tests
mkdir -p docs

# Create a basic README if it doesn't exist
if [[ ! -f "README.md" ]]; then
    cat > README.md << EOF
# Learn Python Project

This is my Python learning project.

## Setup

1. Clone this repository
2. Run the setup script: \`./setup_project.sh\`
3. Activate the virtual environment: \`source venv/bin/activate\`
4. Start learning Python!

## Project Structure

- \`src/\` - Source code
- \`notebooks/\` - Jupyter notebooks
- \`tests/\` - Test files
- \`docs/\` - Documentation

## Virtual Environment

To activate the virtual environment:
\`\`\`bash
source venv/bin/activate
\`\`\`

To deactivate:
\`\`\`bash
deactivate
\`\`\`

## Running Jupyter Notebooks

\`\`\`bash
source venv/bin/activate
jupyter notebook
\`\`\`
EOF
    print_success "README.md created"
fi

# Step 10: Final verification
print_status "Verifying setup..."

# Check Python version in venv
VENV_PYTHON_VERSION=$(venv/bin/python --version)
print_success "Virtual environment Python version: $VENV_PYTHON_VERSION"

# Check pip packages
PACKAGE_COUNT=$(venv/bin/pip list | wc -l)
print_success "Installed packages: $PACKAGE_COUNT"

echo ""
print_success "🎉 Setup completed successfully!"
echo ""
echo "Next steps:"
echo "1. Activate the virtual environment: source venv/bin/activate"
echo "2. Start coding: jupyter notebook"
echo "3. Or run Python scripts: python src/your_script.py"
echo ""
echo "To deactivate the virtual environment later: deactivate"
