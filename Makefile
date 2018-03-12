## XELATEX
# all:
# 	xelatex thesis
# 	bibtex thesis
# 	xelatex thesis
# 	xelatex thesis

# simple:
# 	xelatex thesis

## PDFLATEX
all:
	pdflatex thesis
	bibtex thesis
	pdflatex thesis
	pdflatex thesis

simple:
	pdflatex thesis

## LATEX
# all:
# 	latex thesis
# 	bibtex thesis
# 	latex thesis
# 	latex thesis
# 	dvips thesis.dvi
# 	ps2pdf thesis.ps

# simple:
# 	latex thesis
# 	latex thesis
# 	dvips thesis.dvi
# 	ps2pdf thesis.ps

clean:
	rm -f *aux
	rm -f *bbl
	rm -f *blg
	rm -f *dvi
	rm -f *log
	rm -f *ps
	rm -f *toc
	rm -f *.lot
	rm -f *.lof
	rm -f *.fdb_latexmk
	rm -f *.fls
	rm -f *.synctex.gz



