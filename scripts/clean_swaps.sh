#!/bin/bash

# Script to clean all nvim swap files
# Run this to clean up lingering swap files that might be causing issues

echo "🧹 Cleaning nvim swap files..."

# Find and count swap files
SWAP_COUNT=$(find ~/.local/state/nvim/swap -name "*.swp" -o -name "*.swo" 2>/dev/null | wc -l)

if [ "$SWAP_COUNT" -eq 0 ]; then
    echo "✅ No swap files found!"
    exit 0
fi

echo "Found $SWAP_COUNT swap files:"
find ~/.local/state/nvim/swap -name "*.swp" -o -name "*.swo" 2>/dev/null | head -10

if [ "$SWAP_COUNT" -gt 10 ]; then
    echo "... and $(($SWAP_COUNT - 10)) more"
fi

# Ask for confirmation
read -p "🗑️  Delete all swap files? (y/N): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    # Delete all swap files
    find ~/.local/state/nvim/swap -name "*.swp" -delete 2>/dev/null
    find ~/.local/state/nvim/swap -name "*.swo" -delete 2>/dev/null
    
    # Also clean any stray swap files in other locations
    find ~ -name ".*.swp" -delete 2>/dev/null
    find ~ -name ".*.swo" -delete 2>/dev/null
    
    echo "✅ All swap files deleted!"
else
    echo "❌ Cancelled - no files deleted"
fi