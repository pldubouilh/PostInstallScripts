#! /bin/sh

# ARCH
yaourt --noconfirm - S `cat apps`

echo "+++++++++++++++++++++"
echo "Installing gui stuff now !"

sleep 10
yaourt --noconfirm - S vlc spotify gimp
yaourt --noconfirm - S google-chrome firefox chromium firefox-extension-ublock
yaourt --noconfirm - S atom-editor-beta-bin gnome-shell-extension-pixel-saver gnome-shell-system-monitor-applet-git
