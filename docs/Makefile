-include dependencies.mk
DEFAULT:=html
ifneq (${USER},mhale)
DEFAULT:=all 
endif	

${DEFAULT}:

export PATH:=${HOME}/bin:${PATH}
ASCIIDOCTOR=$(shell which asciidoctor)
DECKJS_TEMPLATE=${HOME}/git/asciidoctor-backends/haml
ASCIIDOC=$(shell which asciidoc)
ifeq ($(ASCIIDOCTOR),)
	ASCIIDOCTOR:=${HOME}/bin/asciidoctor
endif
FOPUB:=fopub
export SHELL:=/bin/bash
all: html pdf shtml
ifneq (${USER},mhale)
all: slidy2
else
all: deckjs
endif	

%_deckjs.html: %_deckjs.adoc
	${ASCIIDOCTOR} -r asciidoctor-diagram -b deckjs -a data-uri -T ${DECKJS_TEMPLATE} $< -o $@
ifneq (${USER},mhale)
	open $@
endif	

%.html: %.adoc
	${ASCIIDOCTOR}  -r asciidoctor-diagram -b html5 $< -o $@

%_s.html: %.adoc
	${ASCIIDOCTOR}  -a data-uri -r asciidoctor-diagram -b html5 $< -o $@
ifneq (${USER},mhale)
	open $@
endif	

%.xml: %.adoc
	${ASCIIDOCTOR}  -r asciidoctor-diagram -b docbook5 $< -o $@

%.slidy2.html: %.adoc
	${ASCIIDOC} -a toc -a data-uri --backend slidy2 -o $@ $<
ifneq (${USER},mhale)
	open $@
endif	

%.pdf: %.adoc
	${ASCIIDOCTOR}  -r asciidoctor-diagram -b docbook5 $< -o $(basename $@).xml
	${FOPUB} $(basename $@).xml -param page.orientation landscape  &> $(basename $@).pdf.log
	@if [ -e "$(basename $@).pdf" ]; then rm -f $(basename $@).pdf.log $(basename $@).xml; else echo "$(basename $@).pdf generation error"; exit 1; fi
ifneq (${USER},mhale)
	open $@
endif	

clean:
	-rm -f ${SLIDY2_SOURCES} ${SHTML_SOURCES} ${HTML_SOURCES} \
		${PDF_SOURCES} ${XML_SOURCES} ${PDF_LOGS} ${DECKJS_SOURCES}

ADOC_SOURCES:=$(shell ls *.adoc 2> /dev/null | grep -v _deckjs.adoc)
DECKJSADOC_SOURCES:=$(shell ls *_deckjs.adoc 2> /dev/null )
SLIDY2_SOURCES:=$(patsubst %.adoc,%.slidy2.html,${ADOC_SOURCES})
DECKJS_SOURCES:=$(patsubst %.adoc,%.html,${DECKJSADOC_SOURCES})
HTML_SOURCES:=$(patsubst %.adoc,%.html,${ADOC_SOURCES})
SHTML_SOURCES:=$(patsubst %.adoc,%_s.html,${ADOC_SOURCES})
PDF_SOURCES:=$(patsubst %.adoc,%.pdf,${ADOC_SOURCES})
PDF_LOGS:=$(patsubst %.adoc,%.pdf.log,${ADOC_SOURCES})
XML_SOURCES:=$(patsubst %.adoc,%.xml,${ADOC_SOURCES})

echo:
	echo "SHELL:   ${SHELL}"
	echo "PATH:   ${PATH}"
	echo "ASCIIDOCTOR: ${ASCIIDOCTOR}"
	echo "ADOCS:  ${ADOC_SOURCES}"
	echo "HTML:   ${HTML_SOURCES}"
	echo "Standalone HTML:   ${SHTML_SOURCES}"
	echo "SLIDY2: ${SLIDY2_SOURCES}"
	echo "DECKJS: ${DECKJS_SOURCES}"
	echo "PDF:    ${PDF_SOURCES}"
	echo "XML:    ${XML_SOURCES}"

slidy2:  ${SLIDY2_SOURCES}
deckjs:  ${DECKJS_SOURCES}
pdf:     ${PDF_SOURCES}
html:    ${HTML_SOURCES}
shtml:   ${SHTML_SOURCES}

.SILENT:  echo
.PHONY:   clean html pdf all deckjs slidy2 shtml echo

GH_PAGES:= Docs

index.adoc: 
	rm -rf index.html index.pdf index_s.html
	find . -type d  -not -path "./.git*" -not -path "**images" -not -path "**/sources" | awk '{printf "\n\n== "$$0" "} {system("find "$$0" -maxdepth 1 \\( -name \"*.html\" -o -name \"*.pdf\" -o -name \"*.ppt\" -o -name \"*.pptx\" \\) -exec echo -n \" link:{}[()] \" \\;")}' | perl -p -e 's/(_(s|deckjs))+(\.\w+)(\[\()/\1\3\4\2/g; s/(.)(\w+)(\[\(\w*)(\)\])/\1\2\3\2\4/g' > $@
	perl -p -i -e 's/^== \.(\s*link)/= ${GH_PAGES} \1/; s/^== \.\//== /g' $@
	gmake index.html
	rm index.adoc
	#SKIP FOR NOW # find . -type f -not -path "./.git*" \( -name "*.html" -o -name "*.pdf" \) | xargs tar -cvf gh-pages.tar	
	
gh-pages:
	@echo "Clearing out old gh-pages branch if it exists"
	-git branch -D gh-pages
	-git push origin --delete gh-pages
	@echo "Creating fresh gh-pages branch"
	git checkout --orphan gh-pages
	@echo "Making all docs"
	for dir in `find . -name Makefile -exec  dirname {} \;` ; do echo $$dir; cd $$dir && gmake clean && gmake &&  cd ${PWD}; done
	@echo "Building an index.html file"
	gmake index.adoc
	@echo "Adding all docs to this branch"
	find . -type f -not -path "./.git*" \( -name "*.html" -o -name "*.pdf" -o -name "*.jpg" -o -name "*.png" -o -name "*.svg" \) | xargs git add -f 
	@echo "Manual intervention time....  Check if things look good then follow directions"
	git status
	@echo "Run the following commands to push to gh-pages"
	@echo "    git commit -m'Adding gh-pages pushes'"
	@echo "    git push origin gh-pages"
	@echo "    git checkout master"
	@echo " OR to perform the same steps type:"
	@echo "    gmake gh-pages-push"

gh-pages-push:	
	git commit -m'Adding gh-pages pushes'
	git push origin gh-pages
	git checkout master

