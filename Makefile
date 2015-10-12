SOURCES:=.bash_logout .bash_profile .bashrc .profile .profile.local .tmux.conf
TARGETS:=$(addprefix ~/,${SOURCES})

echo:
	echo gmake setup
	echo    Makes the following targets:  ${TARGETS}

~/.%: ${PWD}/.%
	ln -T -f -s $? $@
	

setup: ${TARGETS}


.PHONY:  echo setup
.SILENT: echo
