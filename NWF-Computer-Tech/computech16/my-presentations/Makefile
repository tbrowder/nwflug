# based on code at:
#   https://github.com/edumentab/rakudo-and-nqp-internals-course

LATEX    = latex
DVIPS    = dvips
PS2PDF   = ps2pdf
MD2TEX   = tools/md2tex
BREAK    = tools/break-after-colon-in-title-slides
INSERT   = tools/insert-into-template
PERL     = perl
PANDOC   = pandoc
PDFLATEX = pdflatex

CTECHYEAR     = 2016
CDSADIR       = /usr/local/people/tbrowde/mydata/tbrowde-home-bzr/mydomains/domains/primary-web-servers/web-sites/computertechnwf.org/public
CTECHBASEDIR  = $(CDSADIR)/$(CTECHYEAR)/sessions

TFREDIR = $(CTECHBASEDIR)/0900-free-software
TLINDIR = $(CTECHBASEDIR)/1000-intro-linux
TPERDIR = $(CTECHBASEDIR)/1100-intro-perl6
SITEDIR = $(CDSADIR)/pdf

SITEPRODS  = ../CompuTech-2016-Flyer.pdf
SITEPRODS += ../CompuTech-2016-Schedule.pdf

TFREPRODS  = otp/free-win-progs.pdf 
TFREPRODS += common-handouts/toms-link-list.pdf
TFREPRODS += free-win-progs/browder-handout-computech16.pdf

TLINPRODS  = otp/intro-to-linux.pdf 
TLINPRODS += common-handouts/toms-link-list.pdf

TPERPRODS  = otp/intro-to-perl6.pdf
TPERPRODS += common-handouts/toms-link-list.pdf

TALKS  =
#TALKS += agenda-2016-01-04
#TALKS += example
#TALKS += example2
TALKS += intro-to-linux
TALKS += free-win-progs
TALKS += intro-to-perl6

COMMON +=
COMMON += src/common*md
COMMON += src/headers.md
COMMON += src/background.md

PDFS = $(patsubst %, otp/%.pdf, $(TALKS))
pdocs = $(patsubst %, src/%.pdoc, $(TALKS))

.PHONY : all 
all: $(PDFS) deliver list-presentations

.PHONY : pdoc
pdoc: $(pdocs)

.PHONY : list-presentations
list-presentations:
	@echo Presentations:
	@echo -------------
	@-ls -1 otp/[fi]*pdf
	@echo

src/%.pdoc :: src/%.md $(COMMON) src/headers.md src/make-pdoc-from-md.p6
	cd src ; ./make-pdoc-from-md.p6 -i=$(<)

#echo "working file $(@)..."
#touch $@


fake-src/%.pdoc : src/%.pdoc
	-cp $< $@

fake-src/%.tex : fake-src/%.pdoc $(MD2TEX)
	$(PERL) $(MD2TEX) $< $@
	$(PERL) -pi.bak -e "s/\(FIXUP\)//g"   $@
	$(PERL) -i.bak $(BREAK)               $@

otp/%.pdf : fake-src/%.tex
	$(PDFLATEX) -output-directory=otp $<
	-rm $(trash)

.PHONY: deliver
deliver:
	cp $(TFREPRODS) $(TFREDIR)
	cp $(TLINPRODS) $(TLINDIR)
	cp $(TPERPRODS) $(TPERDIR)
	cp $(SITEPRODS) $(SITEDIR)
	@echo "Website updated\n"

.PHONY: clean
clean:
	(cd otp; rm -f *.dvi ; rm -f *.aux ; rm -f *.out ; \
	            rm -f *.nav ; rm -f *.snm ; rm -f *.ps ;  \
	            rm -f *.bak ; rm -f *.vrb ; rm -f *.tex ; \
	            rm -f *.toc ; rm -f *.html ; rm -f *.log )
	(cd src; rm -f *.dvi ; rm -f *.aux ; rm -f *.out ; \
	            rm -f *.nav ; rm -f *.snm ; rm -f *.ps ;  \
	            rm -f *.bak ; rm -f *.vrb ; rm -f *.tex ; \
	            rm -f *.toc ; rm -f *.html ; rm -f *.log )

realclean: clean
	(cd otp; rm -f *.log ; rm -f *.pdf )


trash  = $(patsubst %, otp/%.log, $(TALKS))
trash += $(patsubst %, otp/%.aux, $(TALKS))
trash += $(patsubst %, otp/%.dvi, $(TALKS))
trash += $(patsubst %, otp/%.snm, $(TALKS))
trash += $(patsubst %, otp/%.out, $(TALKS))
trash += $(patsubst %, otp/%.nav, $(TALKS))
trash += $(patsubst %, otp/%.vrb, $(TALKS))
trash += $(patsubst %, otp/%.toc, $(TALKS))
trash += src/*.bak src/*~
