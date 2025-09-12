# Auto-activate virtual environment if it exists
if [ -f "venv/bin/activate" ]; then
    source venv/bin/activate
    echo "🐍 Python virtual environment activated!"
fi
