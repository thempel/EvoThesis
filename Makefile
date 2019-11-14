
BASEDIR=$(CURDIR)
INPUTDIR=$(BASEDIR)
OUTPUTDIR=$(BASEDIR)
TEMPLATEDIR=$(INPUTDIR)/templates
STYLEDIR=$(BASEDIR)/style

BIBFILE=$(INPUTDIR)/library.bib
MD2TEX='pandoc --bibliography="$(BIBFILE)" \
        -V fontsize=12pt \
        -V paper=a4paper \
        -V documentclass=report \
        -N \
		--biblatex \
		-f markdown-auto_identifiers'

# check for index file
INDEXFILE=$(INPUTDIR)/index
ifneq ("$(wildcard $(INDEXFILE))","")
INFILES=`cat $(INDEXFILE)`
else 
INFILES=$(INPUTDIR)/*/*.md
endif

help:
	@echo $(INFILES)
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
	eval $(MD2TEX) \
	-s $(INFILES) \
	-o "$(OUTPUTDIR)/thesis.tex" 

pdf:
	eval $(MD2TEX) \
	-s $(INFILES) \
	-o "$(OUTPUTDIR)/thesis.tex" 

	pdflatex thesis.tex
	biber thesis
	pdflatex thesis.tex
	pdflatex thesis.tex
	rm thesis.log thesis.run.xml thesis.bcf thesis.out thesis.aux thesis.blg thesis.bbl thesis.tex

update:
	if [ -f $(INDEXFILE) ]; then mv $(INDEXFILE) $(INDEXFILE).bak; fi	
	touch $(INDEXFILE)
	for folder in $(INPUTDIR)/*; do \
		if [ -d $$folder ]; then \
		cd $$folder; \
		ln -sf ../../evothesis/localeMakefile Makefile; \
		fname=$$folder/*.md; \
		echo $$fname  >> $(INDEXFILE); \
		fi; \
		done

.PHONY: help tex pdf update
