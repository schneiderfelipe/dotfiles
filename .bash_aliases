#!/bin/bash

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  if test -r "$HOME/.dircolors"; then
    eval "$(dircolors -b "$HOME/.dircolors")"
  else
    eval "$(dircolors -b)"
  fi
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate $HOME/.zshrc"
# alias ohmyzsh="mate $HOME/.oh-my-zsh"

# Life hacks
# 1. Get GPT-3 to summarize text from the clipboard.
alias tldr="xsel -b -o | mico -n 512 -T 1.0 -i 'Summarize the following academic text, keeping the original style (max. 40 words)'"
# 2. Get GPT-3 to complete text from the clipboard.
alias tsdw="xsel -b -o | mico -n 512 -T 0.7 -i 'Complete the following text, keeping the original style (max. 100 words)'"
# 3. Get GPT-3 to describe table from clipboard (works with LaTeX).
alias tbds="xsel -b -o | mico -n 512 -T 1.0 -i 'Describe the most important relationships in the data presented by the following table, using examples (max. 100 words)'"

# Use bat as a replacement for cat
alias cat="bat --paging=never"

# Get colorized help pages with bat too (see <https://github.com/sharkdp/bat#highlighting---help-messages>)
alias -g -- --help='--help 2>&1 | bat --paging=never --language=help --style=plain'

# I was gonna type 'lazygit', but then I got high.
alias lg='lazygit'

# Use Chemcraft in a more ergonomic way.
alias chemcraft="wine /opt/Chemcraft/Chemcraft.exe"
