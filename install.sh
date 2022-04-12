#!/bin/bash

function info() {
    tput setaf 4
    echo -n "$@"
    tput sgr0
}

function warning() {
    tput setaf 3
    tput bold
    echo -n "$@"
    tput sgr0
    sleep 0.5
}

function success() {
    tput setaf 2
    echo -n "$@"
    tput sgr0
}

function code() {
    tput dim
    echo -n "$@"
    tput sgr0
}

function install() {
    package=$1
    code=$2
    if ! command -v "$package" >/dev/null 2>&1; then
        info "Installing $package...\n"
        eval "$code"
    else
        success "$package is already installed\n"
    fi
}


info "This will install most of what is needed for my dotfiles... "
warning "proceed? [y/n]?"
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty "$old_stty_cfg"
if ! echo "$answer" | grep -iq "^y"; then
    [[ "$0" = "${BASH_SOURCE[0]}" ]] && exit 1 || return 1
fi

echo
echo

if [[ ! -d ~/.oh-my-zsh ]]; then
    info "Installing oh-my-zsh...\n"
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    success "oh-my-zsh is already installed\n"
fi

zsh_completions=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
if [[ ! -d "$zsh_completions" ]]; then
    info "Installing zsh-completions...\n"
    git clone https://github.com/zsh-users/zsh-completions "$zsh_completions"
else
    success "zsh-completions is already installed\n"
fi

zsh_history_substring_search=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
if [[ ! -d "$zsh_history_substring_search" ]]; then
    info "Installing zsh-history-substring-search...\n"
    git clone https://github.com/zsh-users/zsh-history-substring-search "$zsh_history_substring_search"
else
    success "zsh-history-substring-search is already installed\n"
fi

zsh_autosuggestions=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [[ ! -d "$zsh_autosuggestions" ]]; then
    info "Installing zsh-autosuggestions...\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_autosuggestions"
else
    success "zsh-autosuggestions is already installed\n"
fi

zsh_syntax_highlighting=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [[ ! -d "$zsh_syntax_highlighting" ]]; then
    info "Installing zsh-syntax-highlighting...\n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_syntax_highlighting"
else
    success "zsh-syntax-highlighting is already installed\n"
fi

install "starship" 'sh -c "$(curl -fsSL https://starship.rs/install.sh)"'
install "names" 'curl -sSf https://fnichol.github.io/names/install.sh | sh -s -- -d ~/.local/bin'
install "juliaup" 'curl -fsSL https://install.julialang.org | sh'
install "rustup" 'curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh'

echo


warning "Things that need to be installed manually:\n\n"

info "git-secrets:\n"
code "https://github.com/awslabs/git-secrets#nix-linuxmacos\n\n"

info "bat:\n"
code "https://github.com/sharkdp/bat/releases\n\n"

info "fd:\n"
code "https://github.com/sharkdp/fd/releases\n\n"

info "vivid:\n"
code "https://github.com/sharkdp/vivid/releases\n\n"

info "alacritty:\n"
code "https://github.com/alacritty/alacritty/blob/master/INSTALL.md#manual-installation\n\n"

info "JetBrains Mono:\n"
code "https://github.com/ryanoasis/nerd-fonts/releases\n"
code "https://askubuntu.com/a/3706/361183\n\n"

info "Golang:\n"
code "https://go.dev/doc/install\n\n"


info "Some things require super user privileges... "
warning "proceed? [y/n]?"
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty "$old_stty_cfg"
if ! echo "$answer" | grep -iq "^y"; then
    [[ "$0" = "${BASH_SOURCE[0]}" ]] && exit 1 || return 1
fi

echo
echo

install "zsh" 'sudo apt install zsh -y'
install "tmux" 'sudo apt install tmux -y'
install "fzf" 'sudo apt install fzf -y'
install "rg" 'sudo apt install ripgrep -y'
install "ctags" 'sudo apt install universal-ctags -y'

echo
info "Attempting to install neovim...\n"
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install neovim -y


echo
info "Setting some default applications:\n\n"

if command -v alacritty >/dev/null 2>&1; then
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(which alacritty)" 50
    sudo update-alternatives --config x-terminal-emulator
fi

if command -v nvim >/dev/null 2>&1; then
    sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 50
    sudo update-alternatives --config editor
fi


echo
success "Done!\n"
