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

CTECHYEAR     = 2017
CDSADIR       = /usr/local/people/tbrowde/mydata/tbrowde-home-bzr/mydomains/domains/primary-web-servers/web-sites/computertechnwf.org/public
CTECHBASEDIR  = $(CDSADIR)/$(CTECHYEAR)/sessions

# presentations (talks)
P1_FNAME = intro-linux
P2_FNAME = getting-linux
P3_FNAME = using-linux

P1_DIR = $(CTECHBASEDIR)/0900-$(P1_FNAME)
P2_DIR = $(CTECHBASEDIR)/1000-$(P2_FNAME)
P3_DIR = $(CTECHBASEDIR)/1100-$(P3_FNAME)

SITEDIR = $(CDSADIR)/pdf

SITEPRODS  = ../CompuTech-$(CTECHYEAR)-Flyer.pdf
SITEPRODS += ../CompuTech-$(CTECHYEAR)-Schedule.pdf

P1_PRODS  = otp/$(P1_FNAME).pdf
P1_PRODS += common-handouts/toms-link-list.pdf
P1_PRODS += $(P1_FNAME)/browder-handout-computech17.pdf
P1_PRODS += $(P1_FNAME)/Questions-answered-and-Notes.txt

P2_PRODS  = otp/$(P2_FNAME).pdf
P2_PRODS += common-handouts/toms-link-list.pdf
P2_PRODS += $(P2_FNAME)/Questions-answered-and-Notes.txt

P3_PRODS  = otp/$(P3_FNAME).pdf
P3_PRODS += common-handouts/toms-link-list.pdf

TALKS  =
#TALKS += example
#TALKS += example2
TALKS += $(P1_FNAME)
TALKS += $(P2_FNAME)
TALKS += $(P3_FNAME)

COMMON +=
COMMON += src/cmn/common*md
COMMON += src/cmn/headers.md
COMMON += src/cmn/background.md
COMMON += src/cmn/closer-help.md

PDFS  = $(patsubst %, otp/%.pdf, $(TALKS))
pdocs = $(patsubst %, src/%.pdoc, $(TALKS))

.PHONY : all
all: make-dirs make-P-dirs $(PDFS) deliver list-presentations

.PHONY : make-dirs
make-dirs : otp fake-src
	  @if [ ! -d $< ] ; then -mkdir $< ; fi

.PHONY : make-P-dirs
make-P-dirs:
	@if [ ! -d $(P1_DIR) ] ; then mkdir -p $(P1_DIR) ; fi
	@if [ ! -d $(P2_DIR) ] ; then mkdir -p $(P2_DIR) ; fi
	@if [ ! -d $(P3_DIR) ] ; then mkdir -p $(P3_DIR) ; fi
	@if [ ! -d $(P1_FNAME) ] ; then mkdir -p $(P1_FNAME) ; fi
	@if [ ! -d $(P2_FNAME) ] ; then mkdir -p $(P2_FNAME) ; fi
	@if [ ! -d $(P3_FNAME) ] ; then mkdir -p $(P3_FNAME) ; fi

.PHONY : pdoc
pdoc: $(pdocs)

.PHONY : list-presentations
list-presentations:
	@echo Presentations:
	@echo -------------
	@-ls -1 otp/[fi]*pdf
	@echo

src/%.pdoc :: src/%.md $(COMMON) src/make-pdoc-from-md.p6
	cd src ; ./make-pdoc-from-md.p6 -i=$(<)

#echo "working file $(@)..."
#touch $@


fake-src/%.pdoc : src/%.pdoc
	-cp $< $@

fake-src/%.tex : fake-src/%.pdoc $(MD2TEX)
	$(PERL) $(MD2TEX) $< $@
	$(PERL) -pi.bak -e "s/\(FIXUP\)//g"   $@
	$(PERL) -i.bak $(BREAK)               $@
	-rm $(trash)

otp/%.pdf : fake-src/%.tex
	$(PDFLATEX) -output-directory=otp $<
	-rm $(trash)

.PHONY: deliver
deliver:
	@-cp $(P1_PRODS) $(P1_DIR)
	@-cp $(P2_PRODS) $(P2_DIR)
	@-cp $(P3_PRODS) $(P3_DIR)
	@-cp $(SITEPRODS) $(SITEDIR)
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
trash += fake-src/*.bak
