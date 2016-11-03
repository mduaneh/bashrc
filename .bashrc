# Begin ~/.bashrc
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
debug () {
	# If the shell is interactive then allow echos to debug.
	# This is needed so scp will work
	[[ $- == *i* ]] && [[ $DEBUG == *y* ]] && echo $@
}
debug "Sourcing bashrc/bashrc"
if [ -f $HOME/bashrc/gpg-functions.sh ] ; then
  source $HOME/bashrc/gpg-functions.sh
  gpg_activate
fi
# Personal aliases and functions.

# Personal environment variables and startup programs should go in
# ~/.bash_profile.  System wide environment variables and startup
# programs are in /etc/profile.  System wide aliases and functions are
# in /etc/bashrc.
# Functions to help us manage paths.  Second argument is the name of the
# path variable to be modified (default: PATH)
pathremove () {
        local IFS=':'
        local NEWPATH
        local DIR
        local PATHVARIABLE=${2:-PATH}
        for DIR in ${!PATHVARIABLE} ; do
                if [ "$DIR" != "$1" ] ; then
                  NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
                fi
        done
        export $PATHVARIABLE="$NEWPATH"
}


if [ -f /etc/bashrc ] ; then
  source /etc/bashrc
fi
pathprepend () {
        pathremove $1 $2
	if [ -d $1 ] ; then
	        local PATHVARIABLE=${2:-PATH}
	        export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
	fi
}

pathappend () {
        pathremove $1 $2
	if [ -d $1 ] ; then
        	local PATHVARIABLE=${2:-PATH}
        	export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
	fi
}

LAST_HISTORY_WRITE=$SECONDS
function refresh_history () {
	if [ $(($SECONDS - $LAST_HISTORY_WRITE)) -gt 60 ]; then
		history -a && history -c && history -r
		LAST_HISTORY_WRITE=$SECONDS
	fi
}
settitle () {
	local    host=$(hostname)
	local    name=${1:-"${host}"}
	if [[ "$OSNAME" == "Darwin" ]]; 
	then
        	echo -n -e "\033]0;${name}\007"
	else
        	local cluster=`lsid | grep 'My cluster' | awk '{print $NF}'`||`echo -n ""`
        	name=${1:-"${host}:${cluster}"}
        	tmux rename-window  "${name}"
	fi
}
OSNAME=`uname`
if [ $OSNAME != "SunOS" ] ; then
	if [ -f ~/bashrc/git-completion.bash ] ; then
	   source ~/bashrc/git-completion.bash
	fi
	if [ -f ~/bashrc/git-prompt.sh ] ; then
	   source ~/bashrc/git-prompt.sh
	fi
fi
unset OSNAME
debug  "End of ~/bashrc/bashrc"

# End ~/.bashrc
