# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
plugins=(git colored-man-pages command-not-found extract)
source $ZSH/oh-my-zsh.sh


source $HOME/.zsh/plugins/catppuccin/zsh-syntax-highlighting/themes/catppuccin_mocha-zsh-syntax-highlighting.zsh

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $(brew --prefix)/opt/zsh-vi-mode/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# Add Julia bin to PATH
export PATH="$HOME/.julia/bin:$PATH"

# Set XDG_CONFIG_HOME
export XDG_CONFIG_HOME="$HOME/.config"

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# FZF
export FZF_CTRL_T_COMMAND="rg --files"
export FZF_DEFAULT_COMMAND=$FZF_CTRL_T_COMMAND
source $HOME/.config/fzf/catppuccin/fzf/themes/catppuccin-fzf-mocha.sh

# YAZI
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

# Bat theme
export BAT_THEME="Catppuccin Mocha"

# zoxide
eval "$(zoxide init zsh)"

# atuin
zvm_after_init_commands+=(eval "$(atuin init zsh)")

# eza
export EZA_CONFIG_DIR="$HOME/.config/eza"

# Neovide, macOS only
export NEOVIDE_FRAME=buttonless
export NEOVIDE_TITLE_HIDDEN=1

# import aliases
source $HOME/.zsh_aliases

# import private config
source $HOME/.zsh_private

# use starship (this should be at the end of .zshrc)
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
