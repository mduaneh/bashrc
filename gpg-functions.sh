debug "Sourcing gpg-functions"
export GPG_TTY=$(tty)
function gpg_setup_env () {
	debug "Configuring GPG Agent Environment"
	if [ -f "${HOME}/.gpg-agent-info" ]; then
	  	. "${HOME}/.gpg-agent-info"
  		export GPG_AGENT_INFO
  		export SSH_AUTH_SOCK
  		export SSH_AGENT_PID
	else
		debug "No ${HOME}/.gpg-agent-info file found"
		return 1
	fi
	
}
function gpg_kill_agent () {
	gpg_setup_env
	kill $SSH_AGENT_PID
}

function gpg_check_agent () {
	local result
	gpg_setup_env
	debug "Checking GPG Agent"
	echo "/bye" | tail -n +1 | gpg-connect-agent &>/dev/null
	result=$?
	return $result
}
function gpg_start_agent () {
	local result
	local umaskSet=`umask`
	umask 0077
	chmod 0700 ~/.gnupg
	gpg-agent --daemon --enable-ssh-support           --write-env-file "${HOME}/.gpg-agent-info"  2> /dev/null &
	result=$?
	debug "Starting GPG Agent"
	gpg_setup_env
	umask $umaskSet
	return  $result
}

function gpg_activate () {
	gpg_check_agent || \
	gpg_start_agent
}

function gpg_restart () {
	gpg_kill_agent
	sleep 1
	gpg_activate
}

debug "End of gpg-functions"
