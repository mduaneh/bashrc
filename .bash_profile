# Begin ~/.bash_profile
#set -vx
export mdhDEBUG=${mdhDEBUG:-"n"}
debug () {
        # If the shell is interactive then allow echos to debug.
        # This is needed so scp will work
        [[ $- == *i* ]] && [[ $mdhDEBUG == *y* ]] && echo $@
}
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
# updated by Bruce Dubbs <bdubbs@linuxfromscratch.org>
[[ $- == *i* ]] && [[ $mdhDEBUG == *y* ]] && echo "Sourcing .bash_profile"

# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc.  System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.
OSNAME=`uname`
if [[ $OSNAME == "Darwin" ]]; then
	MHALEHOME=$(greadlink -f ~mhale)
else
	MHALEHOME=$(readlink -f ~mhale)
fi
debug "MHALEHOME=$MHALEHOME"
debug "OSNAME=$OSNAME"
debug "Checking for bashrc"
if [ -f $MHALEHOME/bashrc/bashrc ] ; then
  debug "Sourcing $MHALEHOME/bashrc/bashrc"
  source $MHALEHOME/bashrc/bashrc
fi
# GPG Agent used for pass storage
if tmux has-session 2> /dev/null  ;then
        if [ -f $MHALEHOME/bashrc/gpg-functions.sh ] ; then
          source $MHALEHOME/bashrc/gpg-functions.sh
          gpg_activate
        fi
fi
if [ -e "$MHALEHOME/bashrc/bashrc.nvidia" ] ; then
  debug "bashrc.nvidia exists, now is this Linux: $OSNAME"
  if [[  "$OSNAME" == "Linux" ]] ; then
     debug "Sourcing $MHALEHOME/bashrc/bashrc.nvidia"
     source $MHALEHOME/bashrc/bashrc.nvidia
  fi
fi
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
if [[ $OSNAME == "Linux" ]] || [[ $OSNAME == "SunOS" ]] ; then
	debug "Running $OSNAME Setup"
	# I'm specifically looking for the executable here because of enclaves
	if [ -e /home/utils/tmux-2.7/bin/tmux ] ; then
	  	pathprepend  /home/utils/tmux-2.7/bin/
		export TERM=screen-256color-it
		#export TERMINFO=/home/utils/tmux-2.7/share/terminfo
		export TERMINFO_DIRS=~/.terminfo:/usr/share/terminfo
	fi
	pathprepend $MHALEHOME/bin
	pathprepend /usr/sbin               # For things like traceroute
	export LS_COLORS=$LS_COLORS:'di=0;36:'
fi
if [[ $OSNAME == "Darwin" ]]; then
	debug "Running MacOSX Setup"
	export LSCOLORS=gxfxcxdxbxegedabagacad
	export CC=clang
	export GOPATH=~/git/go
	pathprepend ~/bin
	pathprepend /usr/local/sbin
	pathprepend /usr/local/bin
	pathprepend /usr/local/opt/ruby/bin
	pathprepend ${GOPATH}/bin
	pathappend /Applications/Splunk/bin
	pathappend "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
	pathappend  ./.
	export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home"
	export HOMEBREW_GITHUB_API_TOKEN=86d1eff6f2645f2717c3b98635194b6e5e883ed0
	# COMMENTED OUT# export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
	# OLD# export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD}): ${PWD}\007"'
	#export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
fi 
#  GLOBAL
#export PS1="\n\[$(tput setaf 2)\]\D{%F %T} $(__git_ps1)\n\[$(tput sgr0)\]\[$(tput setaf 3)\]\u\[$(tput sgr0)\]@\[$(tput setaf 1)\]\h\[$(tput sgr0)\]\${container:+-\[$(tput setaf 2)\]$container\[$(tput sgr0)\]}:\[$(tput setaf 7)\]\w\[$(tput sgr0)\]\[$(tput setaf 6)\]>\[$(tput sgr0)\]"
export PS1="\n\[$(tput setaf 2)\]\D{%F %T} \$NV_LSF_CLUSTER \[\$(__git_ps1)\]\n\[$(tput sgr0)\]\[$(tput setaf 7)\]\w\n\[$(tput sgr0)\]\[$(tput setaf 3)\]\u\[$(tput sgr0)\]@\[$(tput setaf 1)\]\h\[$(tput sgr0)\]\${container:+-\[$(tput setaf 2)\]$container\[$(tput sgr0)\]}\[$(tput sgr0)\]\[$(tput setaf 6)\]>\[$(tput sgr0)\]"
# Common additions
unset PROMPT_COMMAND
pathprepend $MHALEHOME/bin

# Having . in the PATH is dangerous
# Setup my aliases
if [ -e "$MHALEHOME/bashrc/.bashrc_aliases" ] ; then
 	source $MHALEHOME/bashrc/.bashrc_aliases
fi
	
# End ~/.bash_profile

# FIX LESS espeically with git output
export LESS="${LESS} -R"
debug "End of  .bash_profile"
