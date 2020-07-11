# ZSH config

grep -v '^#' /etc/vt/gruvbox.vt | setvtrgb -


# --- [ Plugins ] ---
source /usr/share/zsh/share/antigen.zsh
#antigen bundle zsh-users/zsh-autosuggestions
antigen apply
# Configuration
bindkey '^ ' autosuggest-accept
ZSH_AUTOSUGGEST_STRATEGY=completion


# --- [ ZSH options ] ---
# General
bindkey -v
setopt   NO_BEEP CLOBBER
setopt   MULTIOS CORRECT_ALL AUTO_CD
# History
setopt HIST_REDUCE_BLANKS
setopt HIST_REDUCE_BLANKS 
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_IGNORE_DUPS 
setopt EXTENDED_HISTORY 
setopt INC_APPEND_HISTORY 
setopt HIST_EXPIRE_DUPS_FIRST
HISTFILE=~/.zhistory
DIRSTACKSIZE=20
HISTSIZE=1000
SAVEHIST=1000


# --- [ Modules ] ---
zmodload -i zsh/complist
autoload -U compinit
autoload -U colors
autoload -U promptinit
compinit 
colors
promptinit


# --- [ Completition system ] ---
setopt COMPLETE_IN_WORD
setopt NO_ALWAYS_TO_END
setopt LIST_PACKED
setopt menucomplete extendedglob

zstyle ':completion:*' completer _complete _match _prefix:-complete _list _correct _approximate _prefix:-approximate _ignored
zstyle ':completion:*:prefix-complete:*' completer _complete
zstyle ':completion:*:prefix-approximate:*' completer _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[-_.]=* r:|=*' 'm:{a-z}={A-Z} r:|[-_.]=* r:|=*'
zstyle ':completion:*:correct:*' max-errors 2 not-numeric
zstyle -e ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX + $#SUFFIX) / 3 )) numeric )'
zstyle ':completion:*' menu select=2
eval $(dircolors)
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Messages/warnings format
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format $'%{\e[01;34m%}---- %d%{\e[m%}'
zstyle ':completion:*:messages' format $'%{\e[01;04;34m%}---- %d%{\e[m%}'
zstyle ':completion:*:warnings' format $'%{\e[01;04;34m%}---- No matches for: %d%{\e[m%}'
zstyle ':completion:*:corrections' format $'%{\e[0;34m%}%d (errors: %e)%{\e[m%}'
# make completions appear below the description of which listing they come from
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' select-prompt %SScrolling active: current selection at %p%s
## Some functions, like _apt and _dpkg, are very slow. You can use a cache in order to proxy the list of results:
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zcache
# complete man pages
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
# tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
## cd will never select the parent directory (e.g.: cd ../<TAB>):
zstyle ':completion:*:(cd|mv|cp):*' ignore-parents parent pwd
zstyle ':completion:*:(ls|mv|cd|chdir|pushd|popd):*' special-dirs ..
## ignores filenames already in the line
zstyle ':completion:*:(rm|kill|diff):*' ignore-line yes
## Ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'
## don't complete backup files as executables
zstyle ':completion:*:complete:-command-::commands' ignored-patterns '*\~'
# A newly added command will may not be found or will cause false
# correction attempts, if you got auto-correction set. By setting the
# following style, we force accept-line() to rehash, if it cannot
# find the first word on the command line in the $command[] hash.
zstyle ':acceptline:*' rehash true


# --- [ Key bindings ] ---
bindkey "^[[3~" delete-char
bindkey '\eq' push-line-or-edit
bindkey '^p' history-search-backward
bindkey "^[[3A"  history-beginning-search-backward
bindkey "^[[3B"  history-beginning-search-forward
bindkey "^[[A"  history-search-backward
bindkey "^[[B"  history-search-forward
bindkey '^r' history-incremental-search-backward
bindkey -s '^B' " &\n"
# if prefix completer is already in list of used completers,
# only bind TAB to expand-or-complete instead of expand-or-complete-prefix
bindkey '^i' expand-or-complete                   # Tab
#bindkey '^i' expand-or-complete-prefix                   # Tab
bindkey -M menuselect '^o' accept-and-infer-next-history
bindkey -M menuselect '^G' send-break


# --- [ Alias ] ---
alias ls='ls --color=auto --group-directories-first'
alias pacman='sudo pacman'
alias paccom='yay'
alias gitlog='git log --graph --pretty=oneline --abbrev-commit --all --decorate'
alias vim='nvim'
alias -s c='nvim'
alias -s h='nvim'


ex () {
 if [ -f $1 ] ; then
   case $1 in
     *.tar.bz2) tar xvjf $1   ;;
     *.tar.gz)  tar xvzf $1   ;;
     *.tar.xz)  tar xvfJ $1   ;;
     *.bz2)     bunzip2 $1    ;;
     *.rar)     unrar x $1    ;;
     *.gz)      gunzip $1     ;;
     *.tar)     tar xvf $1    ;;
     *.tbz2)    tar xvjf $1   ;;
     *.tgz)     tar xvzf $1   ;;
     *.zip)     unzip $1      ;;
     *.Z)       uncompress $1 ;;
     *.7z)      7z x $1       ;;
     *)         echo "'$1' Не может быть распакован при помощи >ex<" ;;
   esac
 else
   echo "'$1' не является допустимым файлом"
 fi
}

pk () {
    if [ $1 ] ; then
        case $1 in
            tbz) tar cjvf $2.tar.bz2 $2   ;;
            tgz) tar czvf $2.tar.gz  $2   ;;
            tar) tar cpvf $2.tar  $2      ;;
            bz2) bzip $2                  ;;
            gz)  gzip -c -9 -n $2 > $2.gz ;;
            zip) zip -r $2.zip $2         ;;
            7z)  7z a $2.7z $2            ;;
            *)   echo "'$1' не может быть упакован с помощью pk()" ;;
        esac
    else
        echo "'$1' не является допустимым файлом"
    fi
}

setopt PROMPT_SUBST

vim_ins_mode="%{$fg[blue]%}insert%{$reset_color%}"
vim_cmd_mode="%{$fg[green]%}normal%{$reset_color%}"
vim_mode=$vim_ins_mode

function zle-keymap-select {
  vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
  zle reset-prompt
}
zle -N zle-keymap-select

function zle-line-finish {
  vim_mode=$vim_ins_mode
}
zle -N zle-line-finish

export KEYTIMEOUT=1

PROMPT='%B%F{red}%n%f%b ${vim_mode} %~ %B%(!.#.>)%b '
