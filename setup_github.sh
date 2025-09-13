#!/bin/bash

# GitHub Authentication Setup Script
# This script helps set up GitHub authentication without passwords

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

echo "🔐 GitHub Authentication Setup"
echo "=============================="

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
print_status "Choose your preferred GitHub authentication method:"
echo ""
echo "1) GitHub CLI (Recommended - easiest, no passwords needed)"
echo "2) SSH Keys (if you already have them set up)"
echo "3) Personal Access Token (manual setup)"
echo "4) Skip authentication setup"
echo ""

read -p "Enter your choice (1-4): " AUTH_CHOICE

case $AUTH_CHOICE in
    1)
        print_status "Setting up GitHub CLI authentication..."
        
        # Check if GitHub CLI is installed
        if ! command -v gh &> /dev/null; then
            print_status "Installing GitHub CLI..."
            if command -v brew &> /dev/null; then
                brew install gh
            else
                print_error "Homebrew not found. Please install GitHub CLI manually:"
                print_status "Visit: https://cli.github.com/"
                exit 1
            fi
        fi
        
        print_success "GitHub CLI is installed"
        print_status "Starting GitHub authentication..."
        print_warning "This will open your browser for authentication"
        
        # Authenticate with GitHub CLI
        gh auth login
        
        if gh auth status &> /dev/null; then
            print_success "GitHub CLI authentication successful!"
            print_status "You can now clone repositories without passwords"
        else
            print_error "GitHub CLI authentication failed"
        fi
        ;;
        
    2)
        print_status "SSH Key authentication setup..."
        
        # Check if SSH key exists
        if [[ -f ~/.ssh/id_rsa.pub ]] || [[ -f ~/.ssh/id_ed25519.pub ]]; then
            print_success "SSH key found"
            
            # Display the public key
            if [[ -f ~/.ssh/id_ed25519.pub ]]; then
                SSH_KEY=$(cat ~/.ssh/id_ed25519.pub)
                print_status "Your SSH public key (ed25519):"
            else
                SSH_KEY=$(cat ~/.ssh/id_rsa.pub)
                print_status "Your SSH public key (RSA):"
            fi
            
            echo "$SSH_KEY"
            echo ""
            print_status "If this key is not added to your GitHub account:"
            print_status "1. Copy the key above"
            print_status "2. Go to GitHub.com → Settings → SSH and GPG keys"
            print_status "3. Click 'New SSH key' and paste the key"
            
        else
            print_warning "No SSH key found. Would you like to generate one?"
            read -p "Generate SSH key? (y/n): " GENERATE_SSH
            
            if [[ "$GENERATE_SSH" =~ ^[Yy]$ ]]; then
                read -p "Enter your email for SSH key: " SSH_EMAIL
                print_status "Generating SSH key..."
                ssh-keygen -t ed25519 -C "$SSH_EMAIL" -f ~/.ssh/id_ed25519 -N ""
                
                # Start SSH agent and add key
                eval "$(ssh-agent -s)"
                ssh-add ~/.ssh/id_ed25519
                
                print_success "SSH key generated!"
                print_status "Your SSH public key:"
                cat ~/.ssh/id_ed25519.pub
                echo ""
                print_status "Add this key to your GitHub account:"
                print_status "1. Copy the key above"
                print_status "2. Go to GitHub.com → Settings → SSH and GPG keys"
                print_status "3. Click 'New SSH key' and paste the key"
            fi
        fi
        ;;
        
    3)
        print_status "Personal Access Token setup..."
        print_warning "This method requires you to create a token manually"
        print_status "1. Go to GitHub.com → Settings → Developer settings → Personal access tokens"
        print_status "2. Generate a new token with 'repo' permissions"
        print_status "3. Copy the token"
        print_status "4. When Git asks for password, use the token instead"
        print_status "5. You can also store it in Git credential manager"
        ;;
        
    4)
        print_warning "Skipping authentication setup"
        ;;
        
    *)
        print_error "Invalid choice"
        exit 1
        ;;
esac

echo ""
print_success "GitHub authentication setup complete!"
echo ""
print_status "Next steps:"
print_status "1. Clone your repository: git clone <your-repo-url>"
print_status "2. Or run the main setup script: ./setup_project.sh"
