prods := hello-world hello-world.pdf

all: $(prods)

hello-world : hello-world.c
        gcc $<  -o $@

hello-world.pdf : hello-world.ps
        ps2pdf $<

clean:
        @rm $(prods)