#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="$HOME/.claude/sddw"
REPO_URL="https://github.com/sermakarevich/sddw.git"

echo "sddw installer"
echo "==============="
echo ""

# Check if already installed
if [ -d "$INSTALL_DIR" ]; then
    echo "Existing installation found at $INSTALL_DIR"
    echo "Updating..."
    cd "$INSTALL_DIR"
    git pull --ff-only origin main
    echo ""
    echo "Updated successfully."
else
    echo "Installing to $INSTALL_DIR..."
    git clone "$REPO_URL" "$INSTALL_DIR"
    echo ""
    echo "Installed successfully."
fi

echo ""
echo "Commands available:"
echo "  /sddw:requirement <feature-name>"
echo "  /sddw:design <feature-name>"
echo "  /sddw:implement <feature-name>"
echo "  /sddw:verify <feature-name>"
echo ""
echo "Done."
