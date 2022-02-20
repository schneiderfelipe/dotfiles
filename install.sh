#!/bin/sh

function info() {
    echo -n "$(tput setaf 4)"
    echo -n "$@"
    echo -n "$(tput sgr0)"
}

function warning() {
    echo -n "$(tput setaf 3)$(tput bold)"
    echo -n "$@"
    echo -n "$(tput sgr0)"
}

function success() {
    echo -n "$(tput setaf 2)"
    echo -n "$@"
    echo -n "$(tput sgr0)"
}

function code() {
    echo -n "$(tput dim)"
    echo -n "$@"
    echo -n "$(tput sgr0)"
}

info "This will install most of what is needed for my dotfiles... "
warning "proceed? [y/n]?"
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg
if ! echo "$answer" | grep -iq "^y"; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo
echo

if [ ! -d ~/.oh-my-zsh ]; then
    info "Installing oh-my-zsh...\n"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    success "oh-my-zsh is already installed\n"
fi

if ! command -v starship >/dev/null 2>&1; then
    info "Installing starship...\n"
    sh -c "$(curl -fsSL https://starship.rs/install.sh)"
else
    success "starship is already installed\n"
fi

echo
sleep 0.5

warning "Things that need to be installed manually:\n\n"

info "zsh:\n"
code "sudo apt install zsh\n\n"

info "tmux:\n"
code "sudo apt install tmux\n\n"

info "neovim:\n"
code "sudo add-apt-repository ppa:neovim-ppa/stable\n"
code "sudo apt update\n"
code "sudo apt install neovim\n\n"

info "bat:\n"
code "https://github.com/sharkdp/bat/releases\n\n"

info "fzf:\n"
code "sudo apt install fzf\n\n"

info "ripgrep:\n"
code "sudo apt install ripgrep\n\n"

info "fd:\n"
code "https://github.com/sharkdp/fd/releases\n\n"

info "JetBrains Mono:\n"
code "https://github.com/ryanoasis/nerd-fonts/releases\n\n"

info "alacritty:\n"
code "https://github.com/alacritty/alacritty/blob/master/INSTALL.md#manual-installation\n\n"
