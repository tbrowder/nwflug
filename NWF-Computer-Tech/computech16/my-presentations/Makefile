# based on code at:
#   https://github.com/edumentab/rakudo-and-nqp-internals-course

LATEX = latex
DVIPS = dvips
PS2PDF = ps2pdf
MD2TEX = tools/md2tex
BREAK = tools/break-after-colon-in-title-slides
INSERT = tools/insert-into-template
PERL = perl
PANDOC = pandoc
PDFLATEX = pdflatex

DIRS = intro-to-linux free-win-progs intro-to-perl6 nwflug-2016-01-04 otp

TALKS  =
#TALKS += intro-to-linux
#TALKS += free-win-progs
#TALKS += intro-to-perl6
TALKS += agenda
TALKS += example

all: $(TALKS)

otp/%.pdf: src/%.pdoc pics/* $(MD2TEX)
	$(PERL) $(MD2TEX) src/%.pdoc  src/%.tex
	$(PERL) -pi.bak -e "s/\(FIXUP\)//g" src/%.tex
	$(PERL) -i.bak $(BREAK)             src/%.tex
	$(PDFLATEX) -output-directory=otp   src/%.tex

clean:
	(cd otp; rm -f *.dvi ; rm -f *.aux ; rm -f *.out ; \
	            rm -f *.nav ; rm -f *.snm ; rm -f *.ps ;  \
	            rm -f *.bak ; rm -f *.vrb ; rm -f *.tex ; \
	            rm -f *.toc ; rm -f *.html ) \
