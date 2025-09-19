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
EDITOR="emacs -nw"
VISUAL="emacs -nw"

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt nocaseglob
setopt dotglob
setopt no_case_match
setopt auto_cd

eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"

PATH="$PATH:$HOME/dots/scripts"

for f in $HOME/dots/scripts/*.sh; do
  ln -sf "$f" "${f%.sh}"
done

XDG_CONFIG_HOME="$HOME/.config"
XDG_DATA_HOME="$HOME/.local/share"
XDG_CACHE_HOME="$HOME/.cache"
XDG_STATE_HOME="$HOME/.local/state"

GNUPGHOME="$XDG_DATA_HOME"/gnupg
CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages

# dotnet tools
PATH="$PATH:/home/been/.local/share/dotnet/.dotnet/tools"

ulimit -n 16384 # temporary fix to prevent kitty crashing ):
