# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for moreps2 options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

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

# --- CUSTOM PART

# Set to 256 colors
export TERM=xterm-256color

# CD to ~ from everywhere
CDPATH=~

# Composer bin
PATH=.:vendor/bin:~/.composer/vendor/bin:$PATH

# Colors
black="\[\033[30m\]"
red="\[\033[31m\]"
green="\[\033[32m\]"
yellow="\[\033[33m\]"
blue="\[\033[34m\]"
magenta="\[\033[35m\]"
white="\[\033[37m\]"
reset="\[\033[00m\]"
# Highlighted colors
h_black="\[\033[1;30m\]"
h_red="\[\033[1;31m\]"
h_green="\[\033[1;32m\]"
h_yellow="\[\033[1;33m\]"
h_blue="\[\033[1;34m\]"
h_magenta="\[\033[1;35m\]"
h_white="\[\033[1;37m\]"
h_reset="\[\033[1;00m\]"
# Underlined colors
u_black="\[\033[4;30m\]"
u_red="\[\033[4;31m\]"
u_green="\[\033[4;32m\]"
u_yellow="\[\033[4;33m\]"
u_blue="\[\033[4;34m\]"
u_magenta="\[\033[4;35m\]"
u_white="\[\033[4;37m\]"
u_reset="\[\033[4;00m\]"
# Background colors
bg_black="\[\033[7;30m\]"
bg_red="\[\033[7;31m\]"
bg_green="\[\033[7;32m\]"
bg_yellow="\[\033[7;33m\]"
bg_blue="\[\033[7;34m\]"
bg_magenta="\[\033[7;35m\]"
bg_white="\[\033[7;37m\]"
bg_reset="\[\033[7;00m\]"

git_prompt ()
{
    c_git_clean="\033[1;37m↯\033[1;00m"
    c_git_changed="\033[1;31m↯\033[1;00m"
    git_status="${c_git_clean}"

    # Checking GIT directory
    git_dir=`git rev-parse --git-dir 2>/dev/null`
    if [ -z "$git_dir" ]; then
        return 0
    fi

    # Git current branch
    git_head=`cat $git_dir/HEAD`
    git_branch=${git_head##*/}
    if [ ${#git_branch} -eq 40 ]; then
        git_branch="?"
    fi

    # Git status
    git_status=`git status --porcelain`
    if [ -z "$git_status" ]; then
        git_status="${c_git_clean}"
    else
        git_status="${c_git_changed}"
    fi

    # Final output
    echo -e "$git_status \033[1;30m$git_branch"
}

# Thy holy prompt.
PS1="$reset[$magenta\t$reset] $h_green\u@$u_green\h$u_reset$white: $h_blue\w $black\$(git_prompt)\n$white$ $reset"
PS2="$white↳ $reset"

clear

if [ -f ~/.bashrc.local ]; then
    . ~/.bashrc.local
fi
