# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# History
export HISTTIMEFORMAT='%F, %T '
shopt -s histappend
PROMPT_COMMAND='history -a'
export HISTCONTROL=ignorespace:ignoredups
export HISTIGNORE="history:ls:pwd:"

# History length
export HISTSIZE=10000
export HISTFILESIZE=16000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize


# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
# else
#     export EDITOR='vim'
# fi

# force wine to 32bits
# export WINEARCH=win32;

# force term for unknown terminals
# export TERM=xterm-256color

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|kitty) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

# Prompt styles
if [ "$color_prompt" = yes ]; then
    export GREP_OPTIONS='--color=auto'

    if [[ 0 -eq $UID ]]; then
        # for root user
        PS1="\[\e[1;32m\][\[\e[31m\]\u\[\e[37m\]@\[\e[32m\]\h]-[\w]#\[\e[0m\] "
        # red variant (comment above)
        # PS1="\[\033[0;1;31m\]┌[\u@\h]─[\[\033[1;32m\]\w\[\033[1;31m\]]\[\033[0m\]\n"
        # PS1="$PS1\[\033[1;31m\]└\\$\[\033[0m\] "
    else
        # for standard user
        PS1="\[\e[36;1m\]┌─\[\e[37;1m\][\u@\h]\[\e[36;1m\]─\[\e[33;1m\](\w)\n"
        PS1="$PS1\[\e[36;1m\]└─[\[\e[0;32m\]\[\e[32;1m\]\\$\[\e[36;1m\]]\[\e[0;32m\]\[\e[39m\] "
    fi
else
    # no color
    if [[ 0 -eq $UID ]]; then
        # for root user
        PS1="[\u@\h]-[\w]# "
    else
        # for standard user
        PS1="┌[\u@\h]─(\w)\n"
        PS1="$PS1└[\\$] "
    fi
fi
unset color_prompt force_color_prompt


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto --group-directories-first -t'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
else
    alias ls='ls --group-directories-first -tF'
fi

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias la='ls -a'
alias ll='ls -lh'
alias l='ls -C -1'

#export LANG=en_US.UTF-8
#export LC_ALL=en_GB.UTF-8

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
