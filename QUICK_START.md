# Quick Start Guide for Other Macs

This guide shows you how to set up your Learn-Python project on any other Mac in just a few commands.

## 🚀 Super Quick Setup (One Command)

Copy and paste this single command into Terminal on any Mac:

```bash
curl -fsSL https://raw.githubusercontent.com/ScottCFrancis/Learn-Python/master/quick_setup.sh | bash
```

That's it! This will:
- ✅ Install Xcode command line tools (if needed)
- ✅ Install Homebrew (if needed)
- ✅ Install GitHub CLI
- ✅ Set up Git configuration
- ✅ Authenticate with GitHub (opens browser)
- ✅ Clone your repository
- ✅ Create Python virtual environment
- ✅ Install all dependencies
- ✅ Set up project structure

## 📋 Manual Setup (If you prefer step-by-step)

If you want to see what's happening or prefer manual control:

```bash
# 1. Create project directory
mkdir -p ~/Development/Python/Learn-Python
cd ~/Development/Python/Learn-Python

# 2. Download and run bootstrap script
curl -fsSL https://raw.githubusercontent.com/ScottCFrancis/Learn-Python/master/bootstrap_setup.sh | bash
```

## 🎯 After Setup

Once setup is complete on any Mac:

```bash
# Navigate to project
cd ~/Development/Python/Learn-Python

# Activate virtual environment
source activate.sh

# Start coding!
python Calculator.py
# or
jupyter notebook
```

## 🔄 Updating on Other Macs

To get the latest changes from GitHub:

```bash
cd ~/Development/Python/Learn-Python
git pull origin main
```

## 🛠️ What Gets Installed

- **Xcode Command Line Tools** - For Git and development
- **Homebrew** - Package manager
- **GitHub CLI** - For easy GitHub authentication
- **Python 3.9.6** - Python interpreter
- **Virtual Environment** - Isolated Python environment
- **Essential Packages**:
  - Jupyter Notebook & Lab
  - NumPy, Pandas, Matplotlib
  - Flask, Requests, BeautifulSoup4
  - Testing tools (pytest)
  - Code formatting (black, flake8)

## 🆘 Troubleshooting

### If the one-liner doesn't work:
1. Make sure you have internet connection
2. Try the manual setup steps above
3. Check that the GitHub repository is accessible

### If GitHub authentication fails:
```bash
gh auth login
```

### If you get permission errors:
```bash
chmod +x *.sh
```

## 📱 For Your Other Macs

Just run the one-liner command on each Mac:
- Mac #1: `curl -fsSL https://raw.githubusercontent.com/ScottCFrancis/Learn-Python/master/quick_setup.sh | bash`
- Mac #2: `curl -fsSL https://raw.githubusercontent.com/ScottCFrancis/Learn-Python/master/quick_setup.sh | bash`
- Mac #3: `curl -fsSL https://raw.githubusercontent.com/ScottCFrancis/Learn-Python/master/quick_setup.sh | bash`

Each Mac will have the exact same setup! 🎉
