This directory contains a collection of template files that can be used with 
LaTeX to produce a PhD dissertation that conforms pretty closely to the W&M 
"Physical Standards for Theses & Dissertations".

The files used to produce the thesis.pdf file are

      ./thesis.tex                the top-level LaTeX file
      ./Makefile                  can be used to compile to a PDF, either 
                                  with or without also compiling the bibtex, 
                                  as well as cleaning out unnecessary files 
                                  and creating a zipped backup
      ./acknowledge.tex           the acknowledgements
      ./abstract.tex              the abstract of the thesis
      ./chapterIntroduction.tex   the introduction chapter of the thesis
      ./chapter_Topic{1-3}.tex    the 1st-3rd chapters of the thesis
      ./chapterConclusion.tex     the conclusion chapter of the thesis
      ./vita.tex                  the student's vita 
                                   (unconfirmed to match 2012 standards)
      ./thesis.bib                the file that BiBTeX uses to create thesis.bbl
                                   (see Lamport's LaTeX book)
      ./wmthesis.cls              defines the wmthesis class
      ./wmchapter.sty             used by ./stcy/wmthesis.cls to set the top 
                                  margin at the beginning of each chapter
      ./wmbib.bst                 the BiBTeX style file used to create the
                                  bibiliography 
                                   (see Lamport's LaTeX book)

To compile the LaTeX files and the bibliography, type "make" on the command
line. To compile just the LaTeX files, type "make simple".

The other files in the directory include a "figs" folder to hold some sample
figures used for illustration, a "ThesisStandards" folder with the files
available from the above website, and some other LaTeX style files necessary
for optioning the correct formatting.


