#!/bin/bash
# Script to activate the Python virtual environment
echo "🐍 Activating Python virtual environment..."

# Check if virtual environment exists
if [ ! -d "venv" ]; then
    echo "❌ Virtual environment not found. Creating one..."
    python3 -m venv venv
    echo "✅ Virtual environment created!"
fi

# Activate the virtual environment
source venv/bin/activate

# Upgrade pip if needed
echo "📦 Upgrading pip..."
pip install --upgrade pip --quiet

echo "✅ Virtual environment activated!"
echo "🐍 Python version: $(python --version)"
echo "📦 Pip version: $(pip --version)"
echo ""
echo "💡 You can now run your Python files with: python filename.py"
echo "🚪 To deactivate the environment, type: deactivate"
echo ""
