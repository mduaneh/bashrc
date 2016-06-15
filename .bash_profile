# Begin ~/.bash_profile
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
# updated by Bruce Dubbs <bdubbs@linuxfromscratch.org>

# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc.  System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.
if [ -f "$HOME/.bashrc" ] ; then
  source $HOME/.bashrc
fi
OSNAME=`uname`
export HISTSIZE=5000
export HISTCONTROL=ignoreboth
pathprepend $HOME/bin
if [[ $OSNAME == "Linux" ]]; then
	echo "Running Linux Setup"
	pathprepend /pkg/qct/software/lsf
	pathprepend /pkg/ice/sysadmin/lsf/bin

	# I'm specifically looking for the executable here because of enclaves
	if [ -e "/pkg/qct/software/gnu/tmux/1.9a/bin/tmux" ] ; then
	  	pathprepend  /pkg/qct/software/gnu/tmux/1.9a/bin/
	fi
	
	pathprepend  /prj/qct/wire/bin
	pathprepend  /pkg/ice/sysadmin/bin  # For things like v2p
	pathprepend  /pkg/sysadmin/bin      # For things like mdbrotate
	pathprepend  /pkg/hwtools/bin       # For things like lmstat
	pathprepend  /opt/quest/bin         # For things like klist/kinit
	pathprepend  /pkg/afs/bin           # For asudo
	pathprepend  /usr/atria/bin         # For cleartool
	pathprepend  /pkg/icetools/bin      # For stuff like quota.eng
	# Having . in the PATH is dangerous
	#if [ $EUID -gt 99 ]; then
	#  pathappend .
	#fi
fi
if [[ $OSNAME == "Darwin" ]]; then
	echo "Running MacOSX Setup"
	export CC=clang
	export GOPATH=~/git/go
	pathprepend ~/bin
	pathprepend /usr/local/sbin
	pathprepend /usr/local/bin
	pathprepend /usr/local/opt/ruby/bin
	pathprepend ${GOPATH}/bin
	pathappend /Applications/Splunk/bin
	pathappend  ./.
	export PYTHONPATH=/usr/local/lib/python2.7/site-packages
	export HOMEBREW_GITHUB_API_TOKEN=86d1eff6f2645f2717c3b98635194b6e5e883ed0
	export HISTCONTROL=ignoreboth
	export HISTSIZE=5000
	export PROMPT_COMMAND='echo -ne "\033]0;$(basename ${PWD}): ${PWD}\007"'
fi 

if [[ $OSNAME == "Linux" ]]; then
	pathprepend $HOME/bin
	pathprepend /usr/sbin               # For things like traceroute
	pathappend  /prj/qct/wire/bin
	pathprepend  /pkg/ice/sysadmin/bin  # For things like v2p
	pathprepend  /pkg/sysadmin/bin      # For things like mdbrotate
	pathprepend  /pkg/hwtools/bin       # For things like lmstat
	pathprepend  /opt/quest/bin         # For things like klist/kinit
	pathprepend  /pkg/afs/bin           # For asudo
	pathprepend  /usr/atria/bin         # For cleartool
	pathprepend  /pkg/icetools/bin      # For stuff like quota.eng
	export TERM=screen-256color-it
fi
# Having . in the PATH is dangerous
# Setup my aliases
if [ -e "$HOME/.bashrc_aliases" ] ; then
 	source $HOME/.bashrc_aliases
fi
	
# End ~/.bash_profile

# FIX LESS espeically with git output
export LESS="${LESS} -R"
