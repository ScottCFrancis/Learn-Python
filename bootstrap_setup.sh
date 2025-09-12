#!/bin/bash

# Bootstrap Setup Script for Learn-Python Project
# This script downloads and runs the complete setup on any Mac
# Usage: curl -fsSL https://raw.githubusercontent.com/ScottCFrancis/Learn-Python/main/bootstrap_setup.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

echo "🚀 Learn Python Project Bootstrap Setup"
echo "========================================"

# Get the directory where this script is running
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$SCRIPT_DIR"

print_status "Setting up Learn-Python project in: $PROJECT_DIR"

# Check if we're in the right directory
if [[ ! "$PROJECT_DIR" =~ "Learn-Python" ]]; then
    print_warning "This doesn't look like a Learn-Python directory"
    read -p "Continue anyway? (y/n): " CONTINUE
    if [[ ! "$CONTINUE" =~ ^[Yy]$ ]]; then
        print_error "Setup cancelled"
        exit 1
    fi
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

# Step 3: Install Homebrew if not present
print_status "Checking for Homebrew..."
if ! command -v brew &> /dev/null; then
    print_warning "Homebrew not found. Installing..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    print_success "Homebrew installed and added to PATH"
else
    print_success "Homebrew is installed"
fi

# Step 4: Install GitHub CLI
print_status "Installing GitHub CLI..."
if ! command -v gh &> /dev/null; then
    brew install gh
    print_success "GitHub CLI installed"
else
    print_success "GitHub CLI is already installed"
fi

# Step 5: Set up Git configuration if needed
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

# Step 6: Authenticate with GitHub CLI
print_status "Setting up GitHub authentication..."
if ! gh auth status &> /dev/null; then
    print_status "Starting GitHub authentication..."
    print_warning "This will open your browser for authentication"
    gh auth login
else
    print_success "GitHub CLI is already authenticated"
fi

# Step 7: Clone or update repository
if [[ -d ".git" ]]; then
    print_success "Repository already exists"
    print_status "Updating repository..."
    git pull origin main
else
    print_status "Cloning repository..."
    git clone https://github.com/ScottCFrancis/Learn-Python.git .
    print_success "Repository cloned successfully"
fi

# Step 8: Run the main setup script
print_status "Running main setup script..."
if [[ -f "setup_project.sh" ]]; then
    chmod +x setup_project.sh
    ./setup_project.sh
else
    print_error "setup_project.sh not found. Please check the repository."
    exit 1
fi

print_success "🎉 Bootstrap setup completed successfully!"
echo ""
print_status "Next steps:"
print_status "1. Activate the virtual environment: source activate.sh"
print_status "2. Start coding: python Calculator.py"
print_status "3. Or start Jupyter: jupyter notebook"
