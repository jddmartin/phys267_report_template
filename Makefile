# "Make -B" to make everything.
# based on: http://web.mit.edu/~jcrost/www/latexmake.html
# Make program: http://gnuwin32.sourceforge.net/packages/make.htm
master := phys267_report_template
TEX = pdflatex -halt-on-error
BIBTEX = bibtex
DVIPS = dvips -q*
PS2PDF = ps2pdf

# for following, see: http://stackoverflow.com/questions/11206500/compile-several-projects-with-makefile-but-stop-on-first-broken-build/11206700#11206700
#SUBDIRS := ./sections/figures/sft_and_mmft_example ./sections/figures/truncated_basis_sets_for_f1_f2
.PHONY : all $(SUBDIRS)

all : $(SUBDIRS) $(master)_generated.pdf

$(SUBDIRS) :
	$(MAKE) -C $@

$(master)_generated.pdf : $(master).tex *.tex $(SUBDIRS) #\
#                          sections/*/*.tex
	rm -rf *_generated*
	$(TEX) -jobname $(master)_generated $(master)
	$(BIBTEX) $(master)_generated
	$(TEX) -jobname $(master)_generated $(master)
	$(TEX) -jobname $(master)_generated $(master)

clean:
	rm -rf *.aux *.bbl *Notes.bib *.dvi *.log *.blg
