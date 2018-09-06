# Begin ~/.bashrc
# Written for Beyond Linux From Scratch
# by James Robertson <jameswrobertson@earthlink.net>
debug () {
	# If the shell is interactive then allow echos to debug.
	# This is needed so scp will work
	[[ $- == *i* ]] && [[ $DEBUG == *y* ]] && echo $@
}
debug "Sourcing bashrc/bashrc"
hostname=`hostname`
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
        local PATHVARIABLE="${2:-PATH}"
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
	if [ -d "$1" ] ; then
	        local PATHVARIABLE="${2:-PATH}"
	        export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
	fi
}

pathappend () {
        pathremove "$1" "$2"
	if [ -d "$1" ] ; then
        	local PATHVARIABLE="${2:-PATH}"
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
scp-vl () {
	local file=$1
	local destination=${2:-/prj/qct/wire/users/mhale/scratch}
	scp $1 vl-mhale-gridsdca:${destination}
}
scp-breeze () {
	scp-vl $1 /prj/qct/wire/users/mhale/breeze/downloads/.
}
settitle () {
	local    host=$(hostname)
	local    name=${1:-"${host}"}
	local    cluster="NA"
	if [[ "$OSNAME" == "Darwin" ]]; 
	then
        	echo -n -e "\033]0;${name}\007"
	else
		if [ -e /pkg/icetools/bin/lsid ]; then
        		cluster=`lsid | grep 'My cluster' | awk '{print $NF}'`||`echo -n ""`
		fi
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

# tabtab source for electron-forge package
# uninstall by removing these lines or running `tabtab uninstall electron-forge`
#[ -f /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.bash ] && . /usr/local/lib/node_modules/electron-forge/node_modules/tabtab/.completions/electron-forge.bash
