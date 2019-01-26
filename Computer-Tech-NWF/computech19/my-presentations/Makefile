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

CTECHYEAR     = 2019
CDSADIR       = /usr/local/people/tbrowde/mydata/tbrowde-home-bzr/mydomains/domains/primary-web-servers/web-sites/computertechnwf.org/public
TPCDIR        = /usr/local/people/tbrowde/mydata/tbrowde-home-bzr/mydomains/domains/primary-web-servers/web-sites/niceville.pm.org/public
CTECHBASEDIR  = $(CDSADIR)/$(CTECHYEAR)
TPCBASEDIR    = $(TPCDIR)/talks/2019

# presentations (talks)
#P00_FNAME = 00-exercises
P1_FNAME = 01-free-progs
P2_FNAME = 02-intro2linux
P3_FNAME = 03-intro2coding
P4_FNAME = 04-linux-q-and-a

#P0_DIR = $(CTECHBASEDIR)/0730-$(P0_FNAME)
P1_DIR = $(CTECHBASEDIR)/0900-$(P1_FNAME)
P2_DIR = $(CTECHBASEDIR)/1000-$(P2_FNAME)
P3_DIR = $(CTECHBASEDIR)/1100-$(P3_FNAME)
P4_DIR = $(CTECHBASEDIR)/1300-$(P4_FNAME)
P5_DIR = $(CTECHBASEDIR)/1415-$(P4_FNAME)

SITEDIR = $(CDSADIR)/pdf

SITEPRODS  = ../CTech-$(CTECHYEAR)-Flyer.pdf
SITEPRODS += ../CTech-$(CTECHYEAR)-Windows-Misc.pdf
SITEPRODS += ../CTech-$(CTECHYEAR)-Apple-Mac-Linux.pdf
SITEPRODS += ../CTech-$(CTECHYEAR)-NWFSC-Niceville-Campus.pdf

CMN_PRODS  =
CMN_PRODS += common-handouts/common-link-list-handout-ctech19.pdf
CMN_PRODS += common-handouts/foss-handout-ctech19.pdf
CMN_PRODS += otp/00-exercises.pdf

P0_PRODS  =
P0_PRODS +=  $(CMN_PRODS)
#P1_PRODS += $(P1_FNAME)/Questions-answered-and-Notes.txt

P1_PRODS  = otp/$(P1_FNAME).pdf
P1_PRODS +=  $(CMN_PRODS)
#P1_PRODS += $(P1_FNAME)/Questions-answered-and-Notes.txt

P2_PRODS  = otp/$(P2_FNAME).pdf
P2_PRODS +=  $(CMN_PRODS)
#P2_PRODS += $(P2_FNAME)/Questions-answered-and-Notes.txt

P3_PRODS  = otp/$(P3_FNAME).pdf
P3_PRODS +=  $(CMN_PRODS)
#P3_PRODS += $(P3_FNAME)/Questions-answered-and-Notes.txt

P4_PRODS  = otp/$(P4_FNAME).pdf
P4_PRODS +=  $(CMN_PRODS)
#P4_PRODS +=  $(P4_FNAME)/wall-calendar-2018-missy.pdf

P5_PRODS  = otp/$(P4_FNAME).pdf
P5_PRODS +=  $(CMN_PRODS)
#P4_PRODS +=  $(P4_FNAME)/wall-calendar-2018-missy.pdf

TBZRHDIR = /usr/local/people/tbrowde/mydata/tbrowde-home-bzr
P3_PRODS_XDIR = $(TBZRHDIR)/myps/xmas/example
P3_PRODS_CDIR = /usr/local/bzr-repos/calendar/example

TALKS  =
#TALKS += example
#TALKS += example2
TALKS += $(P00_FNAME)
TALKS += $(P0_FNAME)
TALKS += $(P1_FNAME)
TALKS += $(P2_FNAME)
TALKS += $(P3_FNAME)
TALKS += $(P4_FNAME)

#COMMON += src/cmn/prelims2.md
#COMMON += src/cmn/headers2.md
#COMMON += src/cmn/closer-help2.md
#COMMON += src/cmn/common*md

COMMON +=
COMMON += src/cmn/background.md
COMMON += src/cmn/closer-help.md
COMMON += src/cmn/headers.md
COMMON += src/cmn/my-sessions.md
COMMON += src/cmn/my-views.md
COMMON += src/cmn/prelims.md

PDFS  = $(patsubst %, otp/%.pdf, $(TALKS))
pdocs = $(patsubst %, src/%.pdoc, $(TALKS))

.PHONY : all
all: make-dirs make-P-dirs $(PDFS) deliver list-presentations
#all: make-dirs make-P-dirs $(PDFS) list-presentations

.PHONY : make-dirs
make-dirs : otp fake-src
	  @if [ ! -d $< ] ; then -mkdir $< ; fi

.PHONY : make-P-dirs
make-P-dirs:
	@if [ ! -d $(P0_DIR) ] ; then mkdir -p $(P0_DIR) ; fi
	@if [ ! -d $(P1_DIR) ] ; then mkdir -p $(P1_DIR) ; fi
	@if [ ! -d $(P2_DIR) ] ; then mkdir -p $(P2_DIR) ; fi
	@if [ ! -d $(P3_DIR) ] ; then mkdir -p $(P3_DIR) ; fi
	@if [ ! -d $(P4_DIR) ] ; then mkdir -p $(P4_DIR) ; fi
	@if [ ! -d $(P5_DIR) ] ; then mkdir -p $(P5_DIR) ; fi

.PHONY : pdoc
pdoc: $(pdocs)

.PHONY : list list-presentations
list: list-presentations

list-presentations:
	@echo Presentations:
	@echo -------------
	@-ls -1 otp/$(P00_FNAME).pdf
	@-ls -1 otp/$(P0_FNAME).pdf
	@-ls -1 otp/$(P1_FNAME).pdf
	@-ls -1 otp/$(P2_FNAME).pdf
	@-ls -1 otp/$(P3_FNAME).pdf
	@-ls -1 otp/$(P4_FNAME).pdf
	@echo

src/%.pdoc :: src/%.md $(COMMON) src/make-pdoc-from-md.p6
#src/%.pdoc : src/%.md
	( cd src ; ./make-pdoc-from-md.p6 -i=$(<) )

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
	@-cp $(P0_PRODS) $(P0_DIR)
	@-cp $(P1_PRODS) $(P1_DIR)
	@-cp $(P2_PRODS) $(P2_DIR)
	@-cp $(P3_PRODS) $(P3_DIR)
	@-cp $(P4_PRODS) $(P4_DIR)
	@-cp $(P5_PRODS) $(P5_DIR)
	@-cp $(SITEPRODS) $(SITEDIR)
	#@echo "Website updated\n"

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
	(cd src; rm -f *.pdoc )


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
