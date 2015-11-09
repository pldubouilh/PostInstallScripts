#! /bin/sh

# Install oh my zsh !
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# adam2 theme
echo "# adam2 prompt theme

prompt_adam2_help () {
  cat <<'EOF'
This prompt is color-scheme-able.  You can invoke it thus:

  prompt adam2 [ 8bit ] [<color1> [<color2> [<color3>] [<color4>]]

where the colors are for the hyphens, current directory, user@host,
and user input bits respectively.  The default colors are cyan, green,
cyan, and white.  This theme works best with a dark background.

If you have the `nexus' or `vga' console fonts or similar, you
can specify the `8bit' option to use 8-bit replacements for the
7-bit characters.

And you probably thought adam1 was overkill ...
EOF
}

prompt_adam2_setup () {
  # Some can't be local
  local prompt_gfx_tlc prompt_gfx_mlc prompt_gfx_blc

  if [[ $1 == '8bit' ]]; then
    shift
    prompt_gfx_tlc=$'\xda'
    prompt_gfx_mlc=$'\xc3'
    prompt_gfx_blc=$'\xc0'
    prompt_gfx_hyphen=$'\xc4'
  else
    prompt_gfx_tlc='.'
    prompt_gfx_mlc='|'
    prompt_gfx_blc='\`'
    prompt_gfx_hyphen='-'
  fi

  # Colour scheme
  prompt_adam2_color1=${1:-'cyan'}    # hyphens
  prompt_adam2_color2=${2:-'green'}   # current directory
  prompt_adam2_color3=${3:-'cyan'}    # user@host
  prompt_adam2_color4=${4:-'white'}   # user input

  local prompt_gfx_bbox
  prompt_gfx_tbox=\"%{$fg_bold[$prompt_adam2_color1]%}${prompt_gfx_tlc}%{$fg_no_bold[$prompt_adam2_color1]%}${prompt_gfx_hyphen}\"
  prompt_gfx_bbox=\"%{$fg_bold[$prompt_adam2_color1]%}${prompt_gfx_blc}${prompt_gfx_hyphen}%{$fg_no_bold[$prompt_adam2_color1]%}\"

  # This is a cute hack.  Well I like it, anyway.
  prompt_gfx_bbox_to_mbox=$'%{\e[A\r'\"$fg_bold[$prompt_adam2_color1]${prompt_gfx_mlc}$fg_no_bold[$prompt_adam2_color1]${prompt_gfx_hyphen}\"$'\e[B%}'

  prompt_l_paren=\"%{$fg_bold[grey]%}(\"
  prompt_r_paren=\"%{$fg_bold[grey]%})\"

  prompt_user_host=\"%{$fg_no_bold[$prompt_adam2_color3]%}%n%{$fg_bold[$prompt_adam2_color3]%}@%{$fg_no_bold[$prompt_adam2_color3]%}%m\"

  prompt_line_1a=\"$prompt_gfx_tbox$prompt_l_paren%{$fg_bold[$prompt_adam2_color2]%}%~$prompt_r_paren%{$fg_no_bold[$prompt_adam2_color1]%}\"
  prompt_line_1b=\"$prompt_l_paren$prompt_user_host$prompt_r_paren%{$fg_no_bold[$prompt_adam2_color1]%}${prompt_gfx_hyphen}\"

  prompt_line_2=\"$prompt_gfx_bbox${prompt_gfx_hyphen}%{$fg_bold[white]%}\"

  prompt_char=\"%(!.#.>)\"

  precmd () { prompt_adam2_precmd; setopt promptsubst }
  preexec () { prompt_adam2_preexec }
}

prompt_adam2_precmd () {
  setopt noxtrace localoptions extendedglob
  local prompt_line_1

  prompt_adam2_choose_prompt

  PS1=\"$prompt_line_1$prompt_newline$prompt_line_2%{$fg_bold[white]%}$prompt_char %{$fg_bold[$prompt_adam2_color4]%}\"
  PS2=\"$prompt_line_2%{$prompt_gfx_bbox_to_mbox$fg_bold[white]%}%_> %{$fg_bold[$prompt_adam2_color4]%}\"
  PS3=\"$prompt_line_2%{$prompt_gfx_bbox_to_mbox$fg_bold[white]%}?# %{$fg_bold[$prompt_adam2_color4]%}\"
}

prompt_adam2_choose_prompt () {
  local prompt_line_1a_width=${#${(S%%)prompt_line_1a//\%\{*\%\}}}
  local prompt_line_1b_width=${#${(S%%)prompt_line_1b//\%\{*\%\}}}

  local prompt_padding_size=$(( COLUMNS
                                  - prompt_line_1a_width
                                  - prompt_line_1b_width ))

  # Try to fit in long path and user@host.
  if (( prompt_padding_size > 0 )); then
    local prompt_padding
    eval \"prompt_padding=\${(l:${prompt_padding_size}::${prompt_gfx_hyphen}:)_empty_zz}\"
    prompt_line_1=\"$prompt_line_1a$prompt_padding$prompt_line_1b\"
    return
  fi

  prompt_padding_size=$(( COLUMNS - prompt_line_1a_width ))

  # Didn't fit; try to fit in just long path.
  if (( prompt_padding_size > 0 )); then
    local prompt_padding
    eval \"prompt_padding=\${(l:${prompt_padding_size}::${prompt_gfx_hyphen}:)_empty_zz}\"
    prompt_line_1=\"$prompt_line_1a$prompt_padding\"
    return
  fi

  # Still didn't fit; truncate
  local prompt_pwd_size=$(( COLUMNS - 5 ))
  prompt_line_1=\"$prompt_gfx_tbox$prompt_l_paren%{$fg_bold[$prompt_adam2_color2]%}%$prompt_pwd_size<...<%~%<<$prompt_r_paren%{$fg_no_bold[$prompt_adam2_color1]$prompt_gfx_hyphen%}\"
}

prompt_adam2_preexec () {
  print -n \"$reset_color\"
}

prompt_adam2_setup \"$@\"
" > ~/.oh-my-zsh/themes/adam2.zsh-theme

# Install adam2
sed 's/robbyrussel/adam2/g' ~/.zshrc
source ~/.zshrc
