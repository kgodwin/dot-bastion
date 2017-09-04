HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
autoload -Uz compinit
compinit
typeset -F SECONDS

#exports
export VISUAL=vim
export EDITOR="$VISUAL"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:."

# autocomplete
bindkey ${terminfo[kcuu1]} history-search-backward
bindkey ${terminfo[kcud1]} history-search-forward

# Default Aliases
alias ssh-keys="ssh_add_all"
alias reload-zsh="source ~/.zshrc"
alias zsh-reload="reload-zsh"
alias ls="ls --color=auto"
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias ll='ls -lhatr --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias spectrum-ls='spectrum_ls'

# ZSH Theme - XTerm 256 Colors
autoload -U promptinit && promptinit
#export TERM=xterm-256color # might not be needed
hcolor=230 # highlight color
scolor=123 # secondary color
dcolor=225 # default color
acolor=196 # call-to-action color
#color_names=(014 015 039 051 082 111 009 112 113 114 115 116 126 013 132 133 161 134 135 160 012 136 137 141 013 142 143 144 145 146 147 117 118 119 010 120 121 152 153 154 155 122 157 159 011 191 192 193 194 195 226 227 228 )
color_names=(051 105 111 123 153 141 129 160 166 184 226 208 183 224 249 081 087 051 039 046 082)
color_names_len=$color_names[(I)$color_names[-1]]

source "$HOME/.zcustom" # load this here to allow color overrides
function colorize_string() { # hash the string argument to colorize
    local ch=$(echo $1 | sha1sum | python -c 'print(long(raw_input()[:40], 16)%'${color_names_len}')')
    echo $color_names[$((ch+1))]
}
echo $(echo $(hostname) | sha1sum | python -c 'print(long(raw_input()[:40], 16)%'${color_names_len}')') # testing color index
hostcolor=$(colorize_string $(hostname))

function ssh_add_all() {
    echo "starting ssh-agent..."
    eval `ssh-agent -s -t 3600`

    keys=("${(@f)$(ls "/home/$USERNAME/.ssh" | grep "id_*" | grep -v "\.pub")}")
    for k in $keys; do
        if [ "$k" != "" ]; then
            `ssh-add /home/$USERNAME/.ssh/$k`
        fi
    done 
}

function git_dirty() {
    changes=" %F{$acolor} ✗ commit%F{$scolor}"
    if [ "$(git status --porcelain 2> /dev/null | tail -n1)" != "" ]; then
        echo "$changes"
	    return
    fi
}

function git_push() {
    if [ "$(git rev-list HEAD...origin/master --count 2> /dev/null)" -gt 0 ]; then
        echo "%F{$acolor} ✗ push%F{$scolor}"
        return
    fi
}

function prompt_char() {
    git branch >/dev/null 2>/dev/null && git symbolic-ref --short HEAD 2>/dev/null | tr -d '\n' && \
    echo $(git_dirty) | tr -d '\n' && echo $(git_push) | tr -d '\n' && echo '' && echo 'µ' && return

    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '»'
}

function preexec() {
    timer=${timer:-$SECONDS}
    print -Pn "\e]0;@$(hostname): $1\a" # title display
}

function precmd() {
    if [ $timer ]; then
        timer_show=$(($SECONDS - $timer))
        timer_show=$(printf '%.*f\n' 3 $timer_show)
        export RPROMPT="[%F{$hcolor}%?%F{$dcolor}] : %F{$hcolor}${timer_show}s %F{$dcolor}" # Required to handle the timer
        unset timer
    fi

    if [ $USER != "root" ]; then
        user_color=$hcolor
    else
        user_color=$acolor
    fi

    export PROMPT="%F{$user_color}%n%F{$dcolor}@%F{$hostcolor}%m%F{$dcolor}[%F{$hcolor}%d%F{$dcolor}] [%F{$hcolor}%D{%K:%M:%S}%F{$dcolor}]
%F{$scolor}$(prompt_char) %F{$dcolor}" # This breaks everything unless its part of precmd

     print -Pn "\e]0;@$(hostname): $(basename $(print -P %d)) \a" # title clear
}

function spectrum_ls() {
    for code in {000..255}; do
        print -P -- "$code: %F{$code}Color%f"
    done
}
