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
pathprepend /pkg/qct/software/lsf
pathprepend /pkg/ice/sysadmin/lsf/bin

# I'm specifically looking for the executable here because of enclaves
if [ -e "/pkg/qct/software/gnu/tmux/1.9a/bin/tmux" ] ; then
  pathprepend  /pkg/qct/software/gnu/tmux/1.9a/bin/
fi

pathprepend $HOME/bin
pathprepend  /pkg/ice/sysadmin/bin  # For things like v2p
pathprepend  /pkg/hwtools/bin       # For things like lmstat
# Having . in the PATH is dangerous
#if [ $EUID -gt 99 ]; then
#  pathappend .
#fi

# End ~/.bash_profile
