# Learn Python Project Setup Instructions

This document provides standardized setup instructions for your Python learning project across all your Macs.

## Prerequisites

Before running the setup script, ensure you have:

1. **Xcode Command Line Tools** - Required for Git and Python development
2. **Python 3** - Should be installed by default on macOS, but you can install via Homebrew if needed
3. **Homebrew** (optional but recommended) - For easy package management

## Quick Setup

### Step 1: Install Xcode Command Line Tools
```bash
xcode-select --install
```
Follow the installation dialog that appears.

### Step 2: Set Up GitHub Authentication (No Passwords!)
```bash
./setup_github.sh
```
This script helps you set up GitHub authentication without passwords using:
- **GitHub CLI** (recommended - easiest)
- **SSH Keys** (if you have them)
- **Personal Access Tokens** (manual setup)

### Step 3: Run the Main Setup Script
```bash
./setup_project.sh
```

The script will:
- ✅ Check for required tools
- 📥 Clone your GitHub repository (if not already present)
- 🐍 Create a Python virtual environment
- 📦 Install dependencies from requirements.txt (or common learning packages)
- 📁 Set up project structure
- 📝 Create necessary configuration files

### Step 3: Activate the Environment
```bash
source activate.sh
```

## Manual Setup (Alternative)

If you prefer to set up manually or the script doesn't work:

### 1. Clone Repository
```bash
git clone <your-github-repo-url> .
```

### 2. Create Virtual Environment
```bash
python3 -m venv venv
```

### 3. Activate Virtual Environment
```bash
source venv/bin/activate
```

### 4. Upgrade Pip
```bash
pip install --upgrade pip
```

### 5. Install Dependencies
```bash
# If you have requirements.txt
pip install -r requirements.txt

# Or install common packages
pip install jupyter notebook ipython matplotlib numpy pandas requests beautifulsoup4 flask pytest black flake8
```

## Project Structure

After setup, your project will have this structure:
```
Learn-Python/
├── src/                    # Your Python source code
├── notebooks/              # Jupyter notebooks
├── tests/                  # Test files
├── docs/                   # Documentation
├── venv/                   # Virtual environment (don't commit)
├── requirements.txt        # Python dependencies
├── .gitignore             # Git ignore rules
├── setup_project.sh       # Setup script
├── activate.sh            # Quick activation script
└── README.md              # Project documentation
```

## Daily Usage

### Starting Work
```bash
# Navigate to project directory
cd /path/to/Learn-Python

# Activate virtual environment
source activate.sh

# Start Jupyter notebook
jupyter notebook
```

### Ending Work
```bash
# Deactivate virtual environment
deactivate
```

## GitHub Authentication Methods

### Method 1: GitHub CLI (Recommended)
The easiest way to avoid passwords is using GitHub CLI:

```bash
# Install GitHub CLI
brew install gh

# Authenticate (opens browser)
gh auth login

# Now you can clone without passwords
git clone https://github.com/username/repo.git
```

### Method 2: SSH Keys
If you already have SSH keys set up on your other Macs:

```bash
# Check if you have SSH keys
ls ~/.ssh/

# If you have id_rsa.pub or id_ed25519.pub, you can use SSH URLs
git clone git@github.com:username/repo.git
```

### Method 3: Personal Access Token
For manual token setup:

1. Go to GitHub.com → Settings → Developer settings → Personal access tokens
2. Generate new token with 'repo' permissions
3. Use token as password when Git prompts

## Troubleshooting

### Xcode Tools Not Found
```bash
xcode-select --install
```

### Python Not Found
```bash
# Install via Homebrew
brew install python3
```

### Virtual Environment Issues
```bash
# Remove and recreate
rm -rf venv
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
```

### Git Issues
```bash
# Configure Git (first time only)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

## Standardizing Across Macs

To ensure consistency across all your Macs:

1. **Use the same Python version** - The script will show you the version being used
2. **Commit requirements.txt** - This ensures all Macs use the same packages
3. **Use the setup script** - Run `./setup_project.sh` on each Mac
4. **Document any customizations** - Add notes to this file if you make changes

## Common Python Learning Packages

The setup script installs these packages by default:
- **jupyter** - Interactive notebooks
- **notebook** - Jupyter notebook interface
- **ipython** - Enhanced Python shell
- **matplotlib** - Plotting and visualization
- **numpy** - Numerical computing
- **pandas** - Data manipulation
- **requests** - HTTP library
- **beautifulsoup4** - Web scraping
- **flask** - Web framework
- **pytest** - Testing framework
- **black** - Code formatting
- **flake8** - Code linting

## Next Steps

1. Run the setup script
2. Start with Jupyter notebooks for interactive learning
3. Create Python scripts in the `src/` directory
4. Write tests in the `tests/` directory
5. Document your learning progress in `docs/`

Happy coding! 🐍
