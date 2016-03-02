# Begin ~/.bashrc
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>

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


if [ -f "/etc/bashrc" ] ; then
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

settitle (){
	local cluster=`lsid | grep 'My cluster' | awk '{print $NF}'`
	local    host=$(hostname)
	local name=${1:-"${host}:${cluster}"}
	tmux rename-window  "${name}"
	echo -n -e "\033]0;${name}\007"
}

# End ~/.bashrc
