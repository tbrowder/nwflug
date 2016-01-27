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
CTECHBASEDIR  = /usr/local/people/tbrowde/mydata/tbrowde-home-bzr/mydomains/domains/primary-web-servers/web-sites/computertechnwf.org/public/$(CTECHYEAR)/sessions

TALKS  =
#TALKS += agenda-2016-01-04
#TALKS += example
#TALKS += example2
TALKS += intro-to-linux
TALKS += free-win-progs
TALKS += intro-to-perl6

PDFS = $(patsubst %, otp/%.pdf, $(TALKS))

.PHONY : all 
all: $(PDFS) list-presentations

.PHONY : list-presentations
list-presentations:
	@echo Presentations:
	@echo -------------
	@-ls -1 otp/[fi]*pdf
	@echo

src/%.pdoc :: src/%.md src/common*.md src/make-pdoc-from-md.p6
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
	( cd otp ; cp *.pdf $(CTECHDIR) );

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
