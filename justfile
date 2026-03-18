# sddw development commands

# Install from local source (symlink + register commands)
install:
    bash bin/install.sh --local

# Uninstall (remove symlink and commands)
uninstall:
    rm -rf ~/.claude/sddw
    rm -rf ~/.claude/commands/sddw
    @echo "Uninstalled."
