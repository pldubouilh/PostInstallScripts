set -g mouse on

# Fancy cpu bar
set -g status-interval 2
set -g status-right "#(tmux-mem-cpu-load --interval 2)#[default]"
set -g status-right-length 60

# Use Alt-arrow keys without prefix key to switch panes
bind -n M-Left select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up select-pane -U
bind -n M-Down select-pane -D

# Shift arrow to switch windows
bind -n S-Left  previous-window
bind -n S-Right next-window

# Simply system copy
#bind y run-shell "tmux show-buffer | xclip -sel clip -i" \; display-message "Copied tmux buffer to system clipboard"
bind y run-shell "tmux show-buffer | pbcopy" \; display-message "Copied tmux buffer to system clipboard"

# Server side stuff
# > Bind prefix to ctrl + a
unbind C-b
set -g prefix C-z
bind C-z send-prefix

# > Remove status bar
# set -g status off

# Install TPM
# git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# prefix + I to dl

# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'nhdaly/tmux-scroll-copy-mode'
set -g @plugin 'tmux-plugins/tmux-copycat'

run '~/.tmux/plugins/tpm/tpm'
