# Begin ~/.bash_profile
export DEBUG=${DEBUG:-"n"}
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
# updated by Bruce Dubbs <bdubbs@linuxfromscratch.org>
[[ $- == *i* ]] && [[ $DEBUG == *y* ]] && echo "Sourcing .bash_profile"

# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc.  System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.
if [ -f $HOME/bashrc/bashrc ] ; then
  source $HOME/bashrc/bashrc
fi
OSNAME=`uname`
export HISTSIZE=50000
export HISTFILESIZE=50000
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
if [ $OSNAME == "Linux" ] || [ $OSNAME == "SunOS" ] ; then
	debug "Running $OSNAME Setup"
	pathprepend /pkg/qct/software/lsf
	pathprepend /pkg/ice/sysadmin/lsf/bin
	# This allows the LSF man pages to get added 
        if [ -e "/pkg/ice/sysadmin/lsf/bin/lsfconf" ]; then
             eval `/pkg/ice/sysadmin/lsf/bin/lsfconf | grep LSF_MANDIR`
             pathappend      ${LSF_MANDIR} MANPATH
        fi

	# I'm specifically looking for the executable here because of enclaves
	if [ -e /pkg/qct/software/gnu/tmux/1.9a/bin/tmux ] ; then
	  	pathprepend  /pkg/qct/software/gnu/tmux/1.9a/bin/
	fi
	
	pathprepend  /pkg/ice/sysadmin/bin  # For things like v2p
	pathprepend  /pkg/sysadmin/bin      # For things like mdbrotate
	pathprepend  /pkg/hwtools/bin       # For things like lmstat
	pathprepend  /opt/quest/bin         # For things like klist/kinit
	pathprepend  /pkg/afs/bin           # For asudo
	pathprepend  /usr/atria/bin         # For cleartool
	pathprepend  /pkg/icetools/bin      # For stuff like quota.eng
	pathprepend  /pkg/ice/sysadmin/bin  # For things like v2p
	pathprepend  /pkg/sysadmin/bin      # For things like mdbrotate
	pathprepend  /pkg/hwtools/bin       # For things like lmstat
	pathprepend  /opt/quest/bin         # For things like klist/kinit
	pathprepend  /pkg/afs/bin           # For asudo
	pathprepend  /usr/atria/bin         # For cleartool
	pathprepend  /pkg/icetools/bin      # For stuff like quota.eng
	pathprepend $HOME/bin
	pathprepend /usr/sbin               # For things like traceroute
	# Last thing on the path
	pathappend  /prj/qct/wire/bin
	export TERM=screen-256color-it
	export LSF_JOB_TAG=`/pkg/icetools/bin/ptagger -f 33193 -t 00 -g wire`
	export DRM_PROJECT=$LSF_JOB_TAG
	# Having . in the PATH is dangerous
	#if [ $EUID -gt 99 ]; then
	#  pathappend .
	#fi
fi
if [[ $OSNAME == "Darwin" ]]; then
	debug "Running MacOSX Setup"
	export CC=clang
	export GOPATH=~/git/go
	pathprepend ~/bin
	pathprepend /usr/local/sbin
	pathprepend /usr/local/bin
	pathprepend /usr/local/opt/ruby/bin
	pathprepend ${GOPATH}/bin
	pathappend /Applications/Splunk/bin
	pathappend  ./.
	export JAVA_HOME="/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/bin/java"
	export PYTHONPATH=/usr/local/lib/python2.7/site-packages
	export HOMEBREW_GITHUB_API_TOKEN=86d1eff6f2645f2717c3b98635194b6e5e883ed0
	# COMMENTED OUT# export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
	# OLD# export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD}): ${PWD}\007"'
	export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
fi 
# Common additions
pathprepend $HOME/bin

# Having . in the PATH is dangerous
# Setup my aliases
if [ -e "$HOME/bashrc/.bashrc_aliases" ] ; then
 	source $HOME/bashrc/.bashrc_aliases
fi
	
# End ~/.bash_profile

# FIX LESS espeically with git output
export LESS="${LESS} -R"
[[ $- == *i* ]] && [[ $DEBUG == *y* ]] && echo "End of  .bash_profile"
