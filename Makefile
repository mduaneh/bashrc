SOURCES:=.bash_logout .bash_profile .bashrc .profile .profile.local .tmux.conf .bashrc_aliases .inputrc
TARGETS:=$(addprefix ~/,${SOURCES})

echo:
	echo gmake setup
	echo    Makes the following targets:  ${TARGETS}

~/.%: ${PWD}/.%
	ln -T -f -s $? $@
	

setup: ${TARGETS}
	mkdir -p ~/.terminfo/s
	ln -s -T -f ${PWD}/screen-256color-it ~/.terminfo/s/screen-256color-it

git-prompt.sh:
	wget https://raw.githubusercontent.com/git/git/master/contrib/completion/$@
	chmod a+x $@

git-completion.bash:
	wget https://raw.githubusercontent.com/git/git/master/contrib/completion/$@
	chmod a+x $@


.PHONY:  echo setup
.SILENT: echo
