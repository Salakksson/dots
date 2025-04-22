xhost si:localuser:root > /dev/null
clear
autoload -Uz promptinit vcs_info

# git prompt
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '

setopt PROMPT_SUBST
PROMPT='%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f$ '

# History configuration
HISTSIZE=500
SAVEHIST=500
HISTFILE=~/.config/zsh/history
setopt histignorealldups sharehistory

bindkey -e
bindkey "^[[3~" delete-char

export PATH="$PATH:/bin"
export PATH="/usr/local/bin:$PATH"

export EDITOR=nvim
export VISUAL=nvim

# alias rbt='systemctl reboot'
# alias sdn='systemctl poweroff'
# alias package_size='echo https://bbs.archlinux.org/viewtopic.php?id=112038'
 
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
setopt nocaseglob
setopt no_case_match
setopt auto_cd
alias ls='ls --color=auto -A'
alias lah='ls -lAh'

eval "$(atuin init zsh)"
eval "$(zoxide init --cmd cd zsh)"

# rm -fr ~/.steam ~/.steampath ~/.steampid

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export DOTNET_CLI_HOME="$XDG_DATA_HOME"/dotnet
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export NUGET_PACKAGES="$XDG_CACHE_HOME"/NuGetPackages
export PARALLEL_HOME="$XDG_CONFIG_HOME"/parallel
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export CALCHISTFILE="$XGH_DATA_HOME"/calc-history

export GTK2_RC_FILES="$XDG_CACHE_COME/.gtkrc-2.0"
export _GL_SHADER_DISK_CACHE_PATH="$XDG_CACHE_HOME/.nv"
export EMACSDIR=$HOME/.config/emacs
