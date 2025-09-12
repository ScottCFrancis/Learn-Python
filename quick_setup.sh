#!/bin/bash

# Quick Setup for Learn-Python Project
# One-liner to set up everything on any Mac

echo "🚀 Quick Setup for Learn-Python Project"
echo "======================================"

# Create project directory
mkdir -p ~/Development/Python/Learn-Python
cd ~/Development/Python/Learn-Python

# Download and run bootstrap script
curl -fsSL https://raw.githubusercontent.com/ScottCFrancis/Learn-Python/main/bootstrap_setup.sh | bash

echo ""
echo "✅ Setup complete! Your project is ready at:"
echo "   ~/Development/Python/Learn-Python"
echo ""
echo "To start working:"
echo "   cd ~/Development/Python/Learn-Python"
echo "   source activate.sh"
