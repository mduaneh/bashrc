SOURCES:=.bash_logout .bash_profile .tmux.conf .inputrc
TARGETS:=$(addprefix ~/,${SOURCES})
OSName:=$(shell uname)
ln:=ln
ifeq (${OSName},Darwin)
  ln:=gln
endif

echo:
	echo ln=${ln}
	echo gmake setup
	echo    Makes the following targets:  ${TARGETS}

~/.%: ${PWD}/.%
	${ln} -T -f -s $? $@
	

setup: ${TARGETS}
	mkdir -p ~/.terminfo/s
	uudecode -o ~/.terminfo/s/screen-256color-it screen-256color-it.uuencode
	mkdir -p ~/.gnupg
	${ln} -s -T -f ${PWD}/gpg-agent.conf ~/.gnupg/gpg-agent.conf
	if [ -e ${PWD}/gpg-agent.${OSName}.conf ]; then ${ln} -s -T -f ${PWD}/gpg-agent.${OSName}.conf ~/.gnupg/gpg-agent.conf; fi
	mkdir -p ~/bin
	${ln} -s -T -f ${PWD}/ssh-ident ~/bin/ssh
	${ln} -s -T -f ${PWD}/ssh-ident ~/bin/scp
	${ln} -s -T -f ${PWD}/pass ~/bin/pass
	mkdir -p ~/.ssh/identities
	chmod u=rwX,go= -R ~/.ssh
	${ln} -s -T -f ${PWD}/ssh/config ~/.ssh/config
	${ln} -s -T -f ${PWD}/ssh/ssh-ident.conf ~/.ssh-ident
	${ln} -s -T -f ${PWD}/ssh/id_rsa* ~/.ssh/identities/work

git-prompt.sh:
	wget https://raw.githubusercontent.com/git/git/master/contrib/completion/$@
	chmod a+x $@

git-completion.bash:
	wget https://raw.githubusercontent.com/git/git/master/contrib/completion/$@
	chmod a+x $@


.PHONY:  echo setup
.SILENT: echo
