#!/usr/bin/env bash
set -euo pipefail

CLAUDE_DIR="$HOME/.claude"
SDDW_DIR="$CLAUDE_DIR/sddw"
COMMANDS_DIR="$CLAUDE_DIR/commands/sddw"
REPO_URL="https://github.com/sermakarevich/sddw.git"
LOCAL=false

# Parse flags
for arg in "$@"; do
    case "$arg" in
        --local) LOCAL=true ;;
    esac
done

echo "sddw installer"
echo "==============="
echo ""

if [ "$LOCAL" = true ]; then
    # Local mode: symlink from current directory
    SRC_DIR="$(cd "$(dirname "$0")/.." && pwd)"
    echo "Installing from local source: $SRC_DIR"

    # Symlink sddw core
    rm -rf "$SDDW_DIR"
    ln -sf "$SRC_DIR" "$SDDW_DIR"
    echo "Symlinked $SDDW_DIR -> $SRC_DIR"
else
    # Remote mode: clone or update from git
    if [ -d "$SDDW_DIR" ]; then
        echo "Existing installation found at $SDDW_DIR"
        echo "Updating..."
        cd "$SDDW_DIR"
        git pull --ff-only origin main
        echo "Updated."
    else
        echo "Installing to $SDDW_DIR..."
        git clone "$REPO_URL" "$SDDW_DIR"
        echo "Installed."
    fi
fi

# Register commands to ~/.claude/commands/sddw/
echo ""
echo "Registering commands..."
rm -rf "$COMMANDS_DIR"
mkdir -p "$COMMANDS_DIR"
cp "$SDDW_DIR"/commands/*.md "$COMMANDS_DIR/"
COUNT=$(ls -1 "$COMMANDS_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ')
echo "Installed $COUNT commands to $COMMANDS_DIR/"

echo ""
echo "Commands available:"
echo "  /sddw:requirement <feature-name>"
echo "  /sddw:design <feature-name>"
echo "  /sddw:implement <feature-name>"
echo "  /sddw:verify <feature-name>"
echo ""
echo "Done."
