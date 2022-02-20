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

zsh_completions=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
if [ ! -d $zsh_completions ]; then
    info "Installing zsh-completions...\n"
    git clone https://github.com/zsh-users/zsh-completions $zsh_completions
else
    success "zsh-completions is already installed\n"
fi

zsh_history_substring_search=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
if [ ! -d $zsh_history_substring_search ]; then
    info "Installing zsh-history-substring-search...\n"
    git clone https://github.com/zsh-users/zsh-history-substring-search $zsh_history_substring_search
else
    success "zsh-history-substring-search is already installed\n"
fi

zsh_autosuggestions=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [ ! -d $zsh_autosuggestions ]; then
    info "Installing zsh-autosuggestions...\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions $zsh_autosuggestions
else
    success "zsh-autosuggestions is already installed\n"
fi

zsh_syntax_highlighting=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [ ! -d $zsh_syntax_highlighting ]; then
    info "Installing zsh-syntax-highlighting...\n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting $zsh_syntax_highlighting
else
    success "zsh-syntax-highlighting is already installed\n"
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

info "bat:\n"
code "https://github.com/sharkdp/bat/releases\n\n"

info "fd:\n"
code "https://github.com/sharkdp/fd/releases\n\n"

info "alacritty:\n"
code "https://github.com/alacritty/alacritty/blob/master/INSTALL.md#manual-installation\n\n"

info "JetBrains Mono:\n"
code "https://github.com/ryanoasis/nerd-fonts/releases\n"
code "https://askubuntu.com/a/3706/361183\n\n"


info "Some things require super user privileges... "
warning "proceed? [y/n]?"
old_stty_cfg=$(stty -g)
stty raw -echo ; answer=$(head -c 1) ; stty $old_stty_cfg
if ! echo "$answer" | grep -iq "^y"; then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1
fi

echo

echo
info "Attempting to install zsh...\n"
sudo apt install zsh -y

echo
info "Attempting to install tmux...\n"
sudo apt install tmux -y

echo
info "Attempting to install fzf...\n"
sudo apt install fzf -y

echo
info "Attempting to install ripgrep...\n"
sudo apt install ripgrep -y

echo
info "Attempting to install neovim...\n"
sudo add-apt-repository ppa:neovim-ppa/stable -y
sudo apt update
sudo apt install neovim -y


echo
info "Setting some default applications:\n\n"

if command -v alacritty >/dev/null 2>&1; then
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
    sudo update-alternatives --config x-terminal-emulator
fi

if command -v nvim >/dev/null 2>&1; then
    sudo update-alternatives --install /usr/bin/editor editor $(which nvim) 50
    sudo update-alternatives --config editor
fi


echo
success "Done!\n"
