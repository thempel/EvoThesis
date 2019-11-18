
INPUTDIR=$(CURDIR)
OUTPUTDIR=$(INPUTDIR)
BIBFILE=$(INPUTDIR)/library.bib

tmp:=$(shell readlink -fn $(INPUTDIR)/Makefile)
SRCDIR=$(dir $(tmp))

# check for index file
INDEXFILE=$(INPUTDIR)/index
ifneq ("$(wildcard $(INDEXFILE))","")
INFILES=`cat $(INDEXFILE)`
else 
INFILES=$(INPUTDIR)/*/*.md
endif

help:
	@echo ' 																	  '
	@echo 'Makefile for the Markdown thesis                                       '
	@echo '                                                                       '
	@echo 'Usage:                                                                 '
	@echo '   make pdf                         generate a PDF file  			  '
	@echo '   make tex	                       generate a Latex file 			  '
	@echo '   make update                      update local fragment folders	  '
	@echo ' 																	  '
	@echo ' 																	  '

tex:
	$(SRCDIR)/src/pandoc_tex.sh \
	--bibliography="$(BIBFILE)" \
	-s $(INFILES) \
	-o "$(OUTPUTDIR)/thesis.tex" 

pdf:
	$(SRCDIR)/src/pandoc_tex.sh \
	--bibliography="$(BIBFILE)" \
	-s $(INFILES) \
	-o "$(OUTPUTDIR)/thesis.tex" 

	pdflatex thesis.tex
	biber thesis
	pdflatex thesis.tex
	pdflatex thesis.tex
	rm thesis.log thesis.run.xml thesis.bcf thesis.out thesis.aux thesis.blg thesis.bbl thesis.tex

index:
	if [ -f $(INDEXFILE) ]; then mv $(INDEXFILE) $(INDEXFILE).bak; fi	
	touch $(INDEXFILE)
	for folder in $(INPUTDIR)/*; do \
		if [ -d $$folder ]; then \
		cd $$folder; \
		fname=$$folder/*.md; \
		echo $$fname  >> $(INDEXFILE); \
		fi; \
		done
	
update:
	for folder in $(INPUTDIR)/*; do \
		if [ -d $$folder ]; then \
		cd $$folder; \
		ln -sf ../../evothesis/localeMakefile Makefile; \
		for subfolder in ./*; do \
		if [ -d $$subfolder ]; then \
		cd $$subfolder; \
		ln -sf ../../../evothesis/localeMakefile Makefile; \
		cd ..; \
		fi ; \
		done ; \
		cd ..; \
		fi; \
		done
	git add -A

update-evothesis:
	git submodule foreach git pull

.PHONY: help tex pdf index update
