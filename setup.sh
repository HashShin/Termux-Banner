#!/bin/bash

# Create the directory
mkdir -p $HOME/.local/bin/home

# Download the banner.sh script and banner.txt
curl -L -o $HOME/.local/bin/home/banner.sh https://raw.githubusercontent.com/HashShin/Termux-Banner/main/banner/banner.sh
curl -L -o $HOME/.local/bin/home/banner.txt https://raw.githubusercontent.com/HashShin/Termux-Banner/main/banner/banner.txt

# Check if the condition is already in .bashrc
if ! grep -q 'if \[ -z "\$TERMUX_SESSION_ID" \]; then' ~/.bashrc; then
    echo '' >> ~/.bashrc
    echo 'if [ -z "$TERMUX_SESSION_ID" ]; then' >> ~/.bashrc
    echo '    bash $HOME/.local/bin/home/banner.sh' >> ~/.bashrc
    echo 'fi' >> ~/.bashrc
fi

# Source .bashrc to apply changes
source ~/.bashrc
