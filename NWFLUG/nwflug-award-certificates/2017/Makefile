year := 2017


award := $(year)-award-tux-0.75-grayscale

orig := $(award).ps
png  := $(award).png
jpg  := $(award).jpg

all: png pdf

all: jpg

png:
	convert  -density 150 -geometry 100% $(orig)  $(png)

jpg:
	gs -q -dNOPAUSE -dBATCH -sDEVICE=jpeg -r300 -sPAPERSIZE=letter  \
      -sOutputFile=$(jpg) $(orig)

pdf:
	ps2pdf $(orig)
