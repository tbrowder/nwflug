EXE := pinpoint

MTG := mtg-2016-12-05

all: $(MTG)

$(MTG):
	$(EXE) --output=$(MTG).pdf $(MTG).pin

simple:
	(cd examples; $(EXE) --output=simple-demo.pdf simple-demo.pin)

complex:
	(cd examples; $(EXE) --output=introduction.pdf introduction.pin)
