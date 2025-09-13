#!/bin/bash

# Quick activation script for the Python virtual environment
# Usage: source activate.sh

if [[ -f "venv/bin/activate" ]]; then
    echo "🐍 Activating Python virtual environment..."
    source venv/bin/activate
    echo "✅ Virtual environment activated!"
    echo "Python version: $(python --version)"
    echo "Pip version: $(pip --version)"
    echo ""
    echo "Available commands:"
    echo "  jupyter notebook  - Start Jupyter notebook"
    echo "  python src/       - Run Python scripts"
    echo "  deactivate        - Exit virtual environment"
else
    echo "❌ Virtual environment not found!"
    echo "Run ./setup_project.sh first to set up the project."
fi
