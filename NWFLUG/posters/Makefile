year := 2017


poster := $(year)-ctech-poster

orig := $(poster).ps
png  := $(poster).png
jpg  := $(poster).jpg

all: png pdf

all: jpg

png:
	convert  -density 150 -geometry 100% $(orig)  $(png)

jpg:
	gs -q -dNOPAUSE -dBATCH -sDEVICE=jpeg -r300 -sPAPERSIZE=letter  \
      -sOutputFile=$(jpg) $(orig)

pdf:
	ps2pdf $(orig)
