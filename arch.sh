#! /bin/sh

# ARCH
yaourt --noconfirm - S vlc spotify gimp
yaourt --noconfirm - S google-chrome firefox chromium firefox-extension-ublock
yaourt --noconfirm - S atom-editor-beta-bin gnome-shell-extension-pixel-saver gnome-shell-system-monitor-applet-git
yaourt --noconfirm - S tmux tree htop nettop zsh

# Atom
apm install minimap pigments seti-icons terminal-status

# Tmux
echo "set -g mode-mouse on
set -g mouse-resize-pane on
set -g mouse-select-pane on
set -g mouse-select-window on" > ~/.tmux.conf

# some aliases
echo "alias streamTorrent='peerflix -v -f ~/Movies'

alias tree='tree -C'

# My weirdiness :)
alias find='find . | grep'

alias airplayOff='sudo chmod 000 /System/Library/CoreServices/AirPlayUIAgent.app/Contents/MacOS/AirPlayUIAgent'
alias airplayOn='sudo chmod 755 /System/Library/CoreServices/AirPlayUIAgent.app/Contents/MacOS/AirPlayUIAgent'

alias serialConnect='sudo cu -l'
# serialConnect $devicename -s $speed
# ~. to quit..." | cat - ~/.zshrc > ~/.temp && mv ~/.temp ~/.zshrc

echo "Finished. Just need to install manually a few ff/chrome extensions"

# Other Addons
echo "Chrome/ium >> ublock, disable-webrtc chromium"
echo "Firefox >> treestyle, flagfox, gnome-theme-tweak, disable-webrtc, user-agent-switcher, tab-wheel-scroll, hackbar, omnibar"
