#!/usr/bin/env bash
tmux_get() {
    local value="$(tmux show -gqv "$1")"
    [ -n "$value" ] && echo "$value" || echo "$2"
}

tmux_set() {
    tmux set-option -gq "$1" "$2"
}

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
get_keyboard_layout="$CURRENT_DIR/scripts/get_keyboard_layout.sh"
keyboard_layout="#($get_keyboard_layout | cut -c1-${length:-16})"

rarrow=''
larrow=''

TC='#A89984'

G01=#080808 #232
G02=#121212 #233
G03=#1c1c1c #234
G04=#262626 #235
G05=#303030 #236
G06=#3a3a3a #237
G07=#444444 #238
G08=#4e4e4e #239
G09=#585858 #240
G10=#626262 #241
G11=#6c6c6c #242
G12=#767676 #243

FG="$G10"
BG="$G04"

tmux_set status-interval 1
tmux_set status on

tmux_set status-fg "$FG"
tmux_set status-bg "$BG"
tmux_set status-attr none

tmux_set @prefix_highlight_fg "$BG"
tmux_set @prefix_highlight_bg "$FG"
tmux_set @prefix_highlight_show_copy_mode 'on'
tmux_set @prefix_highlight_copy_mode_attr "fg=$TC,bg=$BG,bold"
tmux_set @prefix_highlight_output_prefix "#[fg=$TC]#[bg=$BG]$larrow#[bg=$TC]#[fg=$BG]"
tmux_set @prefix_highlight_output_suffix "#[fg=$TC]#[bg=$BG]$rarrow"

tmux_set status-left-bg "$G04"
tmux_set status-left-fg "$G12"
tmux_set status-left-length 150

LS="#[fg=$TC,bg=$G06] #S #[fg=$G06,bg=$BG]$rarrow"

tmux_set status-left "$LS"

tmux_set status-right-bg "$BG"
tmux_set status-right-fg "$G12"
tmux_set status-right-length 150

RS="#{prefix_highlight}#[fg=$TC,bg=$G04]$larrow#[fg=$G04,bg=$TC] $keyboard_layout #[fg=$G06]$larrow#[fg=$TC,bg=$G06] %T #[fg=$TC,bg=$G06]$larrow#[fg=$G04,bg=$TC] %F "

tmux_set status-right "$RS"

tmux_set window-status-format         "#[fg=$BG,bg=$G06]$rarrow#[fg=$TC,bg=$G06] #I:#W#F #[fg=$G06,bg=$BG]$rarrow"
tmux_set window-status-current-format "#[fg=$BG,bg=$TC]$rarrow#[fg=$BG,bg=$TC,bold] #I:#W#F #[fg=$TC,bg=$BG,nobold]$rarrow"

tmux_set window-status-style          "fg=$TC,bg=$BG,none"
tmux_set window-status-last-style     "fg=$TC,bg=$BG,bold"
tmux_set window-status-activity-style "fg=$TC,bg=$BG,bold"

tmux_set window-status-separator ""

tmux_set pane-border-style "fg=$G07,bg=default"

tmux_set pane-active-border-style "fg=$TC,bg=default"

tmux_set display-panes-colour "$G07"
tmux_set display-panes-active-colour "$TC"

tmux_set clock-mode-colour "$TC"
tmux_set clock-mode-style 24

tmux_set message-style "fg=$TC,bg=$BG"

tmux_set message-command-style "fg=$TC,bg=$BG"

tmux_set mode-style "bg=$TC,fg=$FG"
