# Commands
TEX=pdflatex --interaction=nonstopmode
MKDIR=mkdir -p
MV=mv
CP=cp -R
RM=rm -rf

# Sources and target files
NAME=tilatex
DOC=$(NAME).pdf
STYBASE=tidatetime \
		tienv \
		tiinternal \
		timath \
		tiproblem
STY=$(addsuffix .sty, $(STYBASE))
CLSBASE=tiarticle \
		tiexam \
		tiproblemcollection \
		titutorial \
		tithesisnotice
CLS=$(addsuffix .cls, $(CLSBASE))
STYCLS=$(STY) $(CLS)
DTX=$(wildcard *.dtx)
CTAN=../tds
CTANSRC=$(NAME).ins $(NAME).pdf $(DTX)
CTAN_FILESPEC={Makefile,ltxdoc.cfg,$(NAME).tex}

# Targets
all: stycls doc

stycls: $(STYCLS)

doc: $(DOC)

$(STYCLS): $(NAME).ins $(DTX)
	$(TEX) $<

$(DOC): $(NAME).tex $(STYCLS)
	$(TEX) $<
	$(TEX) $<

ctan: stycls doc
	ctanify --tdsdir=../tds \
		$(CTANSRC) \
		$(CTAN_FILESPEC)=source/latex/$(NAME) \
		art/*.pdf=tex/latex/tilatex/art/

clean:
	-$(RM) *.log *.aux *.out *.glo *.idx *.fls *.ilg *.ind *.toc *.fdb_latexmk

distclean: clean
	-$(RM) *.sty *.cls *.pdf $(CTAN)

.PHONY: ctan clean distclean

