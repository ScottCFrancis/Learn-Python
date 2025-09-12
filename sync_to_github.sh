#!/bin/bash
# Easy GitHub sync script
echo "🚀 Syncing to GitHub..."

# Check if we're in a git repository
if [ ! -d ".git" ]; then
    echo "❌ Not in a git repository!"
    exit 1
fi

# Add all changes
echo "📝 Adding all changes..."
git add .

# Check if there are changes to commit
if git diff --staged --quiet; then
    echo "✅ No changes to commit. Everything is up to date!"
    exit 0
fi

# Show what will be committed
echo "📋 Changes to be committed:"
git diff --staged --name-only

# Commit with timestamp
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
echo "💾 Committing changes..."
git commit -m "Update: $TIMESTAMP

- Auto-sync from local development
- Includes setup files and any code changes"

# Push to GitHub
echo "☁️  Pushing to GitHub..."
git push origin master

if [ $? -eq 0 ]; then
    echo "✅ Successfully synced to GitHub!"
    echo "🔗 View your repo: https://github.com/ScottCFrancis/Learn-Python"
else
    echo "❌ Failed to push to GitHub. Check your internet connection and try again."
    exit 1
fi
