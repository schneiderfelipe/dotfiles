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
    if ! command -v "$package" > /dev/null 2>&1; then
        info "Installing $package...\n"
        eval "$code"
    else
        success "$package is already installed\n"
    fi
}

info "This will install most of what is needed for my dotfiles... "
warning "proceed? [y/n]?"
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$(head -c 1)
stty "$old_stty_cfg"
if ! echo "$answer" | grep -iq "^y"; then
    [[ $0 == "${BASH_SOURCE[0]}" ]] && exit 1 || return 1
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
if [[ ! -d $zsh_completions ]]; then
    info "Installing zsh-completions...\n"
    git clone https://github.com/zsh-users/zsh-completions "$zsh_completions"
else
    success "zsh-completions is already installed\n"
fi

zsh_history_substring_search=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-history-substring-search
if [[ ! -d $zsh_history_substring_search ]]; then
    info "Installing zsh-history-substring-search...\n"
    git clone https://github.com/zsh-users/zsh-history-substring-search "$zsh_history_substring_search"
else
    success "zsh-history-substring-search is already installed\n"
fi

zsh_autosuggestions=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [[ ! -d $zsh_autosuggestions ]]; then
    info "Installing zsh-autosuggestions...\n"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_autosuggestions"
else
    success "zsh-autosuggestions is already installed\n"
fi

zsh_syntax_highlighting=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [[ ! -d $zsh_syntax_highlighting ]]; then
    info "Installing zsh-syntax-highlighting...\n"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_syntax_highlighting"
else
    success "zsh-syntax-highlighting is already installed\n"
fi

# TODO: add node/npm/fnm
install "ghcup" "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
install "juliaup" 'curl -fsSL https://install.julialang.org | sh'
install "poetry" 'curl -sSL https://install.python-poetry.org | python3 -'
install "pyenv" 'curl https://pyenv.run | bash'
install "rustup" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
install "tsc" "npm install -g typescript@latest"

install "broot" 'cargo install broot && broot --install'
install "delta" 'cargo install git-delta'
install "dust" 'cargo install du-dust'
install "dym" 'cargo install didyoumean'
install "grip" 'pip install -U grip'
install "just" 'cargo install just'
install "lazygit" 'go install github.com/jesseduffield/lazygit@latest'
install "names" 'curl -sSf https://fnichol.github.io/names/install.sh | sh -s -- -d ~/.local/bin'
install "starship" 'sh -c "$(curl -fsSL https://starship.rs/install.sh)"'
install "xxh" 'pip install -U xxh-xxh'
install "zoxide" 'curl -sS https://webinstall.dev/zoxide | bash'

pip install -U thefuck

echo

warning "Things that need to be installed manually:\n\n"

info "Golang:\n"
code "https://go.dev/doc/install\n\n"

info "Pop!_OS Shell:\n"
info "(might be installed automatically in the future)\n"
code "https://github.com/pop-os/shell#installation\n"
code "https://github.com/pop-os/shell-shortcuts#dependencies\n"
code "https://github.com/pop-os/launcher#installation\n\n"

info "git-secrets:\n"
info "(might be installed automatically in the future)\n"
code "https://github.com/awslabs/git-secrets#nix-linuxmacos\n\n"

info "JetBrains Mono:\n"
code "https://github.com/ryanoasis/nerd-fonts/releases\n"
code "https://askubuntu.com/a/3706/361183\n\n"

info "Helix editor:\n"
code "https://docs.helix-editor.com/install.html#build-from-source\n\n"

# TODO: this can be made automatic
info "alacritty:\n"
code "https://github.com/alacritty/alacritty/blob/master/INSTALL.md#manual-installation\n\n"

info "bat:\n"
code "https://github.com/sharkdp/bat/releases\n\n"

info "fd:\n"
code "https://github.com/sharkdp/fd/releases\n\n"

info "vivid:\n"
code "https://github.com/sharkdp/vivid/releases\n\n"

# TODO: add a Prolog interpreter (scryer-prolog)

info "Some things require super user privileges... "
warning "proceed? [y/n]?"
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$(head -c 1)
stty "$old_stty_cfg"
if ! echo "$answer" | grep -iq "^y"; then
    [[ $0 == "${BASH_SOURCE[0]}" ]] && exit 1 || return 1
fi

echo
echo

install "ctags" 'sudo apt install universal-ctags -y'
install "fzf" 'sudo apt install fzf -y'
install "jq" 'sudo apt install jq -y'
install "rg" 'sudo apt install ripgrep -y'
install "shellcheck" 'sudo apt install shellcheck -y'
install "tmux" 'sudo apt install tmux -y'
install "zsh" 'sudo apt install zsh -y'

if ! command -v "nvim" > /dev/null 2>&1; then
    info "Installing neovim...\n"
    sudo add-apt-repository ppa:neovim-ppa/stable -y

    sudo apt update
    sudo apt install neovim -y
else
    success "neovim is already installed\n"
fi
pip install -U pynvim

if ! command -v "gh" > /dev/null 2>&1; then
    info "Installing github/cli...\n"
    curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

    sudo apt update
    sudo apt install gh -y
else
    success "github/cli is already installed\n"
fi
gh auth login
gh extension install dlvhdr/gh-dash

echo
info "Setting some default applications:\n\n"

if command -v alacritty > /dev/null 2>&1; then
    sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(which alacritty)" 50
    sudo update-alternatives --config x-terminal-emulator
fi

if command -v nvim > /dev/null 2>&1; then
    sudo update-alternatives --install /usr/bin/editor editor "$(which nvim)" 50
    sudo update-alternatives --config editor
fi

echo
success "Done!\n"
