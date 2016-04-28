if [[ "$TERM" == 'dumb' ]]; then
    return 1
fi

# Colors {{{1
autoload colors
colors

local reset="%{$reset_color%}"

local black="%{$fg[black]%}"
local blue="%{$fg[blue]%}"
local cyan="%{$fg[cyan]%}"
local green="%{$fg[green]%}"
local magenta="%{$fg[magenta]%}"
local red="%{$fg[red]%}"
local white="%{$fg[white]%}"
local yellow="%{$fg[yellow]%}"

local black_bold="%{$fg_bold[black]%}"
local blue_bold="%{$fg_bold[blue]%}"
local cyan_bold="%{$fg_bold[cyan]%}"
local green_bold="%{$fg_bold[green]%}"
local magenta_bold="%{$fg_bold[magenta]%}"
local red_bold="%{$fg_bold[red]%}"
local white_bold="%{$fg_bold[white]%}"
local yellow_bold="%{$fg_bold[yellow]%}"

man() {
    env \
        LESS_TERMCAP_mb="$fg[cyan]" \
        LESS_TERMCAP_md="$fg_bold[red]" \
        LESS_TERMCAP_me="$reset_color" \
        LESS_TERMCAP_se="$reset_color" \
        LESS_TERMCAP_so="$fg[black]$bg[yellow]" \
        LESS_TERMCAP_ue="$reset_color" \
        LESS_TERMCAP_us="$fg_bold[yellow]" \
            man "$@"
}
# Misc {{{1
autoload -U add-zsh-hook
autoload -U run-help
autoload run-help-git  # Enable `git help <command>`

setopt INTERACTIVECOMMENTS  # allow comments on command line
setopt COMBINING_CHARS      # Combine zero-length punctuation characters (accents) with the base character.

# Enable z
if [ -e /usr/local/etc/profile.d/z.sh ]; then
    . "/usr/local/etc/profile.d/z.sh"
fi
# Completion {{{1
# Add zsh-completions to $fpath.
fpath=(/usr/local/share/zsh-completions $fpath)

# Load and initialize the completion system ignoring insecure directories.
autoload -Uz compinit && compinit

unsetopt FLOWCONTROL       # Disable start/stop characters in shell editor.
setopt ALWAYS_TO_END       # Move cursor to the end of a completed word.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt AUTO_MENU           # Show completion menu on a succesive tab press.
setopt AUTO_PARAM_SLASH    # If completed parameter is a directory, add a trailing slash.
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.
setopt PATH_DIRS           # Perform path search even on command names with slashes.

zmodload -i zsh/complist

# Use caching so that commands like apt and dpkg complete are usable
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "$ZSH/cache/"

# Case-insensitive (all), partial-word and then substring completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Group matches and describe
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes

# Fuzzy match mistyped completions.
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# Increase the number of errors based on the length of the typed word.
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'

# Don't complete unavailable commands.
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# Array completion element sorting.
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# Directories
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*' squeeze-slashes true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u $(whoami) -o pid,user,comm -w -w"

# History
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes

# Environment variables
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}

# Populate hostname completion.
zstyle -e ':completion:*:hosts' hosts 'reply=(
  ${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
  ${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
  ${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'

# Don't complete uninteresting users...
zstyle ':completion:*:*:*:users' ignored-patterns \
  adm amanda apache avahi beaglidx bin cacti canna clamav daemon \
  dbus distcache dovecot fax ftp games gdm gkrellmd gopher \
  hacluster haldaemon halt hsqldb ident junkbust ldap lp mail \
  mailman mailnull mldonkey mysql nagios \
  named netdump news nfsnobody nobody nscd ntp nut nx openvpn \
  operator pcap postfix postgres privoxy pulse pvm quagga radvd \
  rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'

# ... unless we really want to
zstyle '*' single-ignored show

# Ignore multiple entries.
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:rm:*' file-patterns '*:all-files'

# Kill
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single

# Man
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true

# SSH/SCP/RSYNC
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
# Navigation {{{1
# Changing/making/removing directory
setopt AUTO_PUSHD
setopt PUSHD_SILENT
setopt PUSHD_MINUS
setopt PUSHD_IGNORE_DUPS
setopt EXTENDED_GLOB
setopt AUTO_NAME_DIRS
setopt AUTO_CD
setopt MULTIOS
setopt CDABLEVARS
# History {{{1
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt EXTENDED_HISTORY       # Save timestamps to commands
setopt HIST_EXPIRE_DUPS_FIRST # Expire a duplicate event first when trimming history.
setopt HIST_FIND_NO_DUPS      # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS   # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS       # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE      # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS      # Do not write a duplicate event to the history file.
setopt HIST_VERIFY            # Do not execute immediately upon history expansion.
setopt INC_APPEND_HISTORY     # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY          # Share history between all sessions.
# Prompt {{{1
# Enable substition in the prompt
setopt PROMPT_SUBST

autoload -Uz vcs_info

# Add hook for calling vcs_info before each command.
add-zsh-hook precmd vcs_info

# http://zsh.sourceforge.net/Doc/Release/User-Contributions.html#Version-Control-Information
zstyle ':vcs_info:*' enable git hg svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '%F{green}M%f'
zstyle ':vcs_info:*' unstagedstr '%F{yellow}M%f'
zstyle ':vcs_info:*' actionformats '[%F{green}%b%F{yellow}|%F{red}%a%f]'
zstyle ':vcs_info:*' formats '%F{blue}%b%m %c%u%f'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked git-aheadbehind

function +vi-git-untracked() {
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]]; then
        if [ -n "$(git ls-files --others --exclude-standard)" ]; then
            hook_com[unstaged]+='%F{red}??%f'
        fi
    fi
}

function +vi-git-aheadbehind() {
    local ahead behind
    local -a gitstatus

    ahead=$(git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l | tr -d ' ')
    (( $ahead )) && gitstatus+=( "%F{green}↑${ahead}%f" )

    behind=$(git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l | tr -d ' ')
    (( $behind )) && gitstatus+=( "%F{red}↓${behind}%f" )

    hook_com[misc]+=${(j::)gitstatus}
}

__prompt() {
    # Show exit code of last command if wasn't 0
    echo -n "$red_bold%(?..%? )$reset"

    # Show name currently active virtualenv
    if [[ -n $VIRTUAL_ENV ]]; then
        printf "%s[%s] " "$yellow" ${${VIRTUAL_ENV}:t}
    fi

    # Show name of currently active pyenv if it's not a global version.
    local pyenv_origin="$(pyenv version-origin)"
    local pyenv_root="$(pyenv root)/version"
    if [ "$pyenv_origin" != "$pyenv_root" ]; then
        echo -n "$yellow_bold$(pyenv version-name)$reset "
    fi

    # echo -n "$black_bold%2~$reset"
    echo -n "%F{8}%2~%f"
    if [[ -n $SSH_TTY ]]; then
        echo -n " $magenta_bold%m$reset"
    fi

    echo -n " $cyan_bold❯$reset "
}

__right_prompt() {
    echo -n "${vcs_info_msg_0_}"
}

PROMPT='$(__prompt)'
RPROMPT='$(__right_prompt)'
# Key bindings {{{1
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e                                            # Use emacs key bindings

bindkey '^r' history-incremental-search-backward      # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.

if [[ "${terminfo[kpp]}" != "" ]]; then
    bindkey "${terminfo[kpp]}" up-line-or-history     # [PageUp] - Up a line of history
fi

if [[ "${terminfo[knp]}" != "" ]]; then
    bindkey "${terminfo[knp]}" down-line-or-history   # [PageDown] - Down a line of history
fi

if [[ "${terminfo[khome]}" != "" ]]; then
    bindkey "${terminfo[khome]}" beginning-of-line    # [Home] - Go to beginning of line
fi

if [[ "${terminfo[kend]}" != "" ]]; then
    bindkey "${terminfo[kend]}"  end-of-line          # [End] - Go to end of line
fi

bindkey '^[[1;5C' forward-word                        # [Ctrl-RightArrow] - move forward one word
bindkey '^[[1;5D' backward-word                       # [Ctrl-LeftArrow] - move backward one word

if [[ "${terminfo[kcbt]}" != "" ]]; then
    bindkey "${terminfo[kcbt]}" reverse-menu-complete # [Shift-Tab] - move through the completion menu backwards
fi

bindkey '^?' backward-delete-char                     # [Backspace] - delete backward

if [[ "${terminfo[kdch1]}" != "" ]]; then
    bindkey "${terminfo[kdch1]}" delete-char          # [Delete] - delete forward
else
    bindkey "^[[3~" delete-char
    bindkey "^[3;5~" delete-char
    bindkey "\e[3~" delete-char
fi

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

#
# bindkey '^[[A' up-line-or-search
# bindkey '^[[B' down-line-or-search
bindkey '^[^[[C' emacs-forward-word
bindkey '^[^[[D' emacs-backward-word
#
# bindkey -s '^X^Z' '%-^M'
# bindkey '^[e' expand-cmd-path
# bindkey '^[^I' reverse-menu-complete
# bindkey '^X^N' accept-and-infer-next-history
# bindkey '^W' kill-region
# bindkey '^I' complete-word

# Search history with current text as prefix

bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

bindkey '^[[H' beginning-of-line                      # [fn-LeftArrow] - Go to beggining of line
bindkey '^[[F' end-of-line                            # [fn-RightArrow] - Go to end of line
# Aliases {{{1
# Basic directory operations
alias ...='cd ../..'
alias ....='cd ../../..'

# List direcory contents
alias l='ls -lh'
alias ll='ls -lh'
alias la='ls -lAh'
alias lsa='ls -lah'

alias tree='tree -C -I "node_modules|env|vendor"'

# History timestamps as "yyyy-mm-dd"
alias history='fc -il 1'

alias grep='grep --color'

alias colors='( x=`tput op` y=`printf %$((${COLUMNS}-6))s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done; )'

# Use Neovim if available
if command -v nvim > /dev/null; then
    alias vim='nvim'
fi
# FZF {{{1
if [ -e ~/.fzf.zsh ]; then
    . ~/.fzf.zsh
fi
# Local config {{{1
if [ -f ~/.zshrc.local ]; then
    . ~/.zshrc.local
fi
# Plugins {{{1
# Enable after source local configuration, because that's where you're supposed
# to put the list of plugins. Example:
# plugins=(golang gulp npm pyenv)
for plugin in $plugins; do
  . "$ZSH/plugins/$plugin/$plugin.plugin.zsh"
done

# vim: foldmethod=marker:
