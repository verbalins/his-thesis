PROJNAME=example-thesis

all: thesis.pdf

# CUSTOM BUILD RULES

# In case you didn't know, '$@' is a variable holding the name of the target,
# and '$<' is a variable holding the (first) dependency of a rule.
# "raw2tex" and "dat2tex" are just placeholders for whatever custom steps
# you might have.

%.tex: %.raw
	./raw2tex $< > $@

%.tex: %.dat
	./dat2tex $< > $@

thesis.pdf: $(PROJNAME).tex
	latexmk -pdf -use-make $<

preview:
	latexmk -pvc $(PROJNAME).tex

clean:
	latexmk -c

cleanall:
	latexmk -C
