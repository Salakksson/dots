# xhost si:localuser:root > /dev/null
# clear
autoload -Uz promptinit vcs_info

precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
# PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f» '
PROMPT='%F{cyan}%~%f %F{red}${vcs_info_msg_0_}%f» '

HISTSIZE=500
SAVEHIST=500
HISTFILE=~/.config/zsh/history
setopt histignorealldups sharehistory

bindkey -e

alias ls='ls --color=auto -A'
alias lah='ls -lAh'
alias emcs='emacsclient -c -nw'

function rrun() {
	killall $1
	$@ & ; disown
}

function run() {
	$@ & ; disown
}

# cant use emacsclient because might be ran in sudo
export EDITOR="emacs -nw"
export VISUAL="emacs -nw"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt nocaseglob
setopt dotglob
setopt no_case_match
setopt auto_cd

eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"

export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# dotnet tools
export PATH="$PATH:/home/been/.local/share/dotnet/.dotnet/tools"

ulimit -n 16384 # temporary fix to prevent kitty crashing ):
