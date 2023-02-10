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

info "First, some updates and utilities... (requires super user privileges)... "
warning "proceed? [y/n]?"
# TODO: make checking answers a function for reuse
old_stty_cfg=$(stty -g)
stty raw -echo
answer=$(head -c 1)
stty "$old_stty_cfg"
if ! echo "$answer" | grep -iq "^y"; then
  [[ $0 == "${BASH_SOURCE[0]}" ]] && exit 1 || return 1
fi

echo
echo

info "Updating apt...\n"
sudo apt update \
  && sudo apt upgrade \
  && sudo apt dist-upgrade \
  && sudo apt autoremove \
  && sudo apt autoclean \
  && sudo apt clean \
  && deborphan | grep -v amdgpu | xargs sudo apt purge

echo
echo

info "Installing some utilities...\n"
install "ctags" 'sudo apt install universal-ctags -y'
install "curl" 'sudo apt install curl -y'
install "fzf" 'sudo apt install fzf -y'
install "git-absorb" 'sudo apt install git-absorb -y'
install "git-extras" 'curl -sSL https://raw.githubusercontent.com/tj/git-extras/master/install.sh | sudo bash /dev/stdin'
install "jq" 'sudo apt install jq -y'
install "latexmk" 'sudo apt install texlive-full -y'
install "pdftotext" 'sudo apt install poppler-utils -y'
install "rg" 'sudo apt install ripgrep -y'
install "shellcheck" 'sudo apt install shellcheck -y'
install "tmux" 'sudo apt install tmux -y'
install "vipe" 'sudo apt install moreutils -y'
install "wine" "sudo apt install wine -y"
install "xsel" 'sudo apt install xsel -y'
install "zsh" 'sudo apt install zsh -y'

if ! command -v "gh" > /dev/null 2>&1; then
  info "Installing github/cli...\n"
  curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
    | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
    && sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
    | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && sudo apt install gh -y
else
  success "github/cli is already installed\n"
fi
gh auth login
gh extension install dlvhdr/gh-dash

echo
echo

info "Updating pyenv and pip (installing if needed)...\n"
install "pyenv" 'curl https://pyenv.run | bash'
pyenv update
pip install -U pip

info "Updating juliaup (installing if needed)...\n"
install "juliaup" 'curl -fsSL https://install.julialang.org | sh'
juliaup update
julia -e "using Pkg; Pkg.update()"

info "Updating npm (installing if needed)...\n"
# TODO: update node as well before npm
npm install -g npm@latest

info "Updating rustup (installing if needed)...\n"
install "rustup" "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh"
rustup update

info "Updating ghcup (installling if needed)...\n"
install "ghcup" "curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh"
ghcup upgrade

echo
echo

info "The following will install most of what is needed for my dotfiles... "
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

if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  info "Installing oh-my-zsh...\n"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
  success "oh-my-zsh is already installed\n"
fi

zsh_completions=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions
if [[ ! -d $zsh_completions ]]; then
  info "Installing zsh-completions...\n"
  git clone https://github.com/zsh-users/zsh-completions "$zsh_completions"
else
  success "zsh-completions is already installed\n"
fi

zsh_autosuggestions=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
if [[ ! -d $zsh_autosuggestions ]]; then
  info "Installing zsh-autosuggestions...\n"
  git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_autosuggestions"
else
  success "zsh-autosuggestions is already installed\n"
fi

zsh_syntax_highlighting=${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
if [[ ! -d $zsh_syntax_highlighting ]]; then
  info "Installing zsh-syntax-highlighting...\n"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$zsh_syntax_highlighting"
else
  success "zsh-syntax-highlighting is already installed\n"
fi

# Cargo goodies
cargo install cargo-audit
cargo install cargo-bloat
cargo install cargo-edit
cargo install cargo-expand
cargo install cargo-generate
cargo install cargo-outdated
cargo install cargo-readme
cargo install cargo-smart-release
cargo install cargo-tarpaulin
cargo install cargo-udeps
cargo install cargo-unused-features
cargo install cargo-watch
cargo install cargo-workspaces

# General command-line goodies
install "broot" 'cargo install broot && broot --install'
install "delta" 'cargo install git-delta'
install "dust" 'cargo install du-dust'
install "dym" 'cargo install didyoumean'
install "fuck" 'pip install -U thefuck'
install "grex" 'cargo install grex'
install "grip" 'pip install -U grip'
install "httpie" 'pip install -U httpie'
install "ipython" 'pip install -U ipython'
install "just" 'cargo install just'
install "lazygit" 'go install github.com/jesseduffield/lazygit@latest'
install "marp" 'npm install -g @marp-team/marp-cli'
install "names" "curl -sSf https://fnichol.github.io/names/install.sh | sh -s -- -d $HOME/.local/bin" # TODO: can we use cargo?
install "proselint" 'pip install -U proselint'
install "sg" 'cargo install ast-grep'
install "so" 'cargo install so'
install "starship" 'curl -sS https://starship.rs/install.sh | sh'
install "tb" 'npm install -g taskbook'
install "tokei" 'cargo install tokei'
install "watchexec" 'cargo install watchexec-cli'
install "zoxide" 'curl -sS https://webinstall.dev/zoxide | bash' # TODO: can we use cargo?

# Programming language utilities
install "fnm" 'curl -fsSL https://fnm.vercel.app/install | bash' # TODO: can we use cargo?
install "poetry" 'curl -sSL https://install.python-poetry.org | python -'
install "tsc" "npm install -g typescript@latest"

# Language servers
install "awk-language-server" "npm install -g \"awk-language-server@>=0.5.2\""
install "bash-language-server" "npm install -g bash-language-server"
install "bibtex-tidy" "npm install -g bibtex-tidy"
install "black" "pip install -U black"
install "elm-language-server" "npm install -g elm-test elm-format elm-review @elm-tooling/elm-language-server" # elm is manually installed
install "prettier" "npm install -g prettier@latest prettier-plugin-svelte @prettier/plugin-xml prettier-plugin-sh prettier-plugin-elm"
install "pyright" "npm install -g pyright"
install "rust-analyzer" "rustup component add rust-analyzer"
install "svelteserver" "npm install -g svelte-language-server"
install "taplo" "cargo install taplo-cli --features lsp"
install "texlab" "cargo install texlab"
install "typescript-language-server" "npm install -g typescript typescript-language-server"
install "vls" "npm install -g vls"
install "vscode-css-language-server" "npm install -g vscode-langservers-extracted" # works with SCSS too
install "vscode-html-language-server" "npm install -g vscode-langservers-extracted"
install "vscode-json-language-server" "npm install -g vscode-langservers-extracted"
install "yaml-language-server" "npm install -g yaml-language-server"
julia -e "using Pkg; Pkg.add(\"LanguageServer\")" # sadly no formatter configured yet

echo
echo

warning "Things that need to be installed manually:\n\n"

info "JetBrains Mono:\n"
code "https://github.com/ryanoasis/nerd-fonts/releases\n"
code "https://askubuntu.com/a/3706/361183\n\n"

info "Pop!_OS Shell:\n"
info "(might be installed automatically in the future)\n"
code "https://github.com/pop-os/shell#installation\n"
code "https://github.com/pop-os/shell-shortcuts#build\n"
code "https://github.com/pop-os/launcher#installation\n\n"

info "alacritty:\n"
code "https://github.com/alacritty/alacritty/blob/master/INSTALL.md#manual-installation\n\n"

info "bat:\n"
code "https://github.com/sharkdp/bat/releases\n\n"

info "dropbox:\n"
code "https://www.dropbox.com/install\n\n"

info "fd:\n"
code "https://github.com/sharkdp/fd/releases\n\n"

info "git-secrets:\n"
info "(might be installed automatically in the future)\n"
code "https://github.com/awslabs/git-secrets#nix-linuxmacos\n\n"

info "Helix editor:\n"
code "https://docs.helix-editor.com/install.html#build-from-source\n\n"

info "vivid:\n"
code "https://github.com/sharkdp/vivid/releases\n\n"

info "Elm:\n"
code "https://github.com/elm/compiler/blob/master/installers/linux/README.md#install-instructions\n\n"

info "Golang:\n"
code "https://go.dev/doc/install\n\n"

info "Marksman:\n"
info "(a language server for Markdown)\n"
code "https://github.com/artempyanykh/marksman#option-1-use-pre-built-binary\n\n"

echo
echo

info "Setting some default applications:\n\n"

# Possible terminal emulators.
if command -v alacritty > /dev/null 2>&1; then
  sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$(which alacritty)" 50
fi
sudo update-alternatives --config x-terminal-emulator

# Possible text editors.
if command -v hx > /dev/null 2>&1; then
  sudo update-alternatives --install /usr/bin/editor editor "$(which hx)" 60
  hx --grammar fetch
  hx --grammar build
fi
sudo update-alternatives --config editor

echo
echo

success "Done!\n"