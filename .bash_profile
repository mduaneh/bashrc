# Begin ~/.bash_profile
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
# updated by Bruce Dubbs <bdubbs@linuxfromscratch.org>

# Personal environment variables and startup programs.

# Personal aliases and functions should go in ~/.bashrc.  System wide
# environment variables and startup programs are in /etc/profile.
# System wide aliases and functions are in /etc/bashrc.
export DRM_PROJECT=`/pkg/icetools/bin/ptagger -f 33193  -t 00 -g wire`
if [ -f "$HOME/.bashrc" ] ; then
  source $HOME/.bashrc
fi

# If you source a SITE profile then you will get set to that cluster
#if [ -f "/pkg/qct/software/platform/lsf/9.1/GBC/conf/profile.lsf" ] ; then
#  source /pkg/qct/software/platform/lsf/9.1/GBC/conf/profile.lsf
#fi
# Added above per Jay Lavine to get manpath added, but this causes issues when logged into
#  other lsf cluster login machines that share the same homedir.  Instead just add to the 
#  MANPATH
pathprepend /pkg/qct/software/platform/lsf/9.1/GBC/9.1/man MANPATH

pathprepend /pkg/qct/software/lsf
pathprepend /pkg/ice/sysadmin/lsf/bin
#pathprepend /usr/local/sbin

# I'm specifically looking for the executable here because of enclaves
if [ -e "/pkg/qct/software/gnu/tmux/1.9a/bin/tmux" ] ; then
  pathprepend  /pkg/qct/software/gnu/tmux/1.9a/bin/
fi

pathprepend $HOME/bin
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
# Setup my aliases
if [ -f "$HOME/.bashrc_aliases" ] ; then
  source $HOME/.bashrc_aliases
fi

# End ~/.bash_profile

# FIX LESS espeically with git output
export LESS="${LESS} -R"
