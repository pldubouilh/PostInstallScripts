#! /bin/sh

# some aliases
echo "alias streamTorrent='peerflix -v -f ~/Movies'

alias tree='tree -C'

alias airplayOff='sudo chmod 000 /System/Library/CoreServices/AirPlayUIAgent.app/Contents/MacOS/AirPlayUIAgent'
alias airplayOn='sudo chmod 755 /System/Library/CoreServices/AirPlayUIAgent.app/Contents/MacOS/AirPlayUIAgent'

alias serialConnect='sudo cu -l'
# serialConnect $devicename -s $speed
# ~. to quit..." | cat - ~/.zshrc > ~/.temp && mv ~/.temp ~/.zshrc
