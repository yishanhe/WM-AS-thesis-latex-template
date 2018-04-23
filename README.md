This directory contains a collection of template files that can be used with 
LaTeX to produce a PhD dissertation that conforms pretty closely to the W&M 
"Physical Standards for Theses & Dissertations".

http://www.wm.edu/as/graduate/studentresources/thesis-dissertations/physicalstandards/index.php

## Contributors

- [William L. Bynum](http://www.cs.wm.edu/~bynum/)
- Rance Necaise

> The department is indebted to Rance Necaise, who contributed the files from 
> which these files were derived.  Rance received his PhD from the department 
> in August of 1998. -- William L. Bynum


- Bob Matthews

> Updated 9/04 to conform to Arts and Science Graduate Writer's Guide of Nov. 
> 2003.  Your milege may vary. --  Bob Matthews == rem

- Ruth Lamprecht
- Andrew Pyles

> Updated 07/13 to conform to Arts and Science standards of Oct. 2012, with 
> help from Andrew Pyles -- Ruth

- David T. Nguyen

> Modifications to comply with Physical Standards set on 08/13/2015 

- Ed Novak

> Updated 06/16 to conform to the new William and Mary physical standards and 
> submission system online with ProQuest. -- Ed Novak

- Shanhe Yi

> Committed with the physical standards set on 2017 (on-going). Refactored the 
> wmthesis class to make it easier to understand and modify. 
> Maintain the first Github repository. -- Shanhe Yi

## Usage

The files used to produce the thesis.pdf file are

      ./thesis.tex                the top-level LaTeX file
      ./structure.tex             the structure of the thesis
      ./Makefile                  can be used to compile to a PDF, either 
                                  with or without also compiling the bibtex, 
                                  as well as cleaning out unnecessary files 
                                  and creating a zipped backup
      ./acknowledge.tex           the acknowledgements
      ./abstract.tex              the abstract of the thesis
      ./introduction.tex          the introduction chapter of the thesis
      ./conclusion.tex            the conclusion chapter of the thesis
      ./proj1-3 subfolders        the 1st-3rd chapters of the thesis
      ./vita.tex                  the student's vita (optional, 2018)
      ./thesis.bib                the file that BiBTeX uses to create thesis.bbl
                                   (see Lamport's LaTeX book)
      ./wmthesis.cls              defines the wmthesis class
      ./wmchapter.sty             used by ./stcy/wmthesis.cls to set the top 
                                  margin at the beginning of each chapter
      ./wmbib.bst                 the BiBTeX style file used to create the
                                  bibiliography 
                                   (see Lamport's LaTeX book)
      ./signed_approval_page.pdf  the dummy signed approval page, replace it with your scan copy
      ./uarial.sty                the style file for arial font

To compile the LaTeX files and the bibliography, type "make" on the command
line. To compile just the LaTeX files, type "make simple". You can comment the 
corresponding sections in the makefile based on your using latex or xelatex.

<!-- The other files in the directory include a "figs" folder to hold some sample
figures used for illustration, a "ThesisStandards" folder with the files
available from the above website, and some other LaTeX style files necessary
for optioning the correct formatting. -->

Feel free to contact the contributors if any you have any questions regarding the use of 
these files. And you are very welcomed for PULL REQUEST. Let's combine efforts - long 
live this template !
      



## Font problem

According to the latest feedback from Office of Graduate Studies, Arts and Sciences, accepted
font is either Arial or Computer Modern.

Given that Arial is a commericial font, not available to all platforms (link Linux), we recommand
to use Computer Modern.

To use Computer Modern, just add

```latex
\usepackage[T1]{fontenc}
```

### Ways of install Arial font

If you insist on usingf Arial font, depends on you are using pdflatex, or latex, or xelatex, and the platforms, 
there are different ways to install arial fonts, we list a few here and expect pull request to this repo for latest methods to
get the Arial font.

#### 1. MacOS or Ubuntu - Using PdfLaTeX or LaTeX

This method shows font as `A030` (tested in edit mode of PDFExpert), but it is Arial indeed. 
Might make this method less favored. Someone using this method needs to get consent from the office lady.

On Mac OS, you can install MacTex to get the Tex environment.

Add fonts using the following commands:

```bash
curl --remote-name https://www.tug.org/fonts/getnonfreefonts/install-getnonfreefonts
sudo texlua install-getnonfreefonts
sudo getnonfreefonts --sys -a
```

In you `thesis.tex`, put

```tex
\usepackage[T1]{fontenc}
\usepackage{uarial}
\renewcommand{\familydefault}{\sfdefault}
```


Then, in your `Makefile`, make sure

```
latex:
	latex thesis
	bibtex thesis
	latex thesis
	latex thesis
	dvips thesis.dvi
	ps2pdf thesis.ps
```

or

```
pdflatex:
	pdflatex thesis
	bibtex thesis
	pdflatex thesis
	pdflatex thesis
```
is uncommented

then `make latex` or `make pdflatex`to compile the latex.

#### 2. MacOS or Windows - Using XeLaTeX or LuaLaTeX

This method shows font as `Arial` (tested in edit mode of PDFExpert).

Since Mac/Win has the TrueType Arial font installed.
You can using xelatex or lualatex to do this.

in you `thesis.tex`, put

```
\usepackage{fontspec}
\setmainfont{Arial}
```


then, in your `Makefile`, make sure 

```
xelatex:
	xelatex thesis
	bibtex thesis
	xelatex thesis
	xelatex thesis
```
is uncommented

then `make xelatex` to compile the latex.

#### 3. Aria in Ubuntu using XeLaTeX - from David

> Modifications to comply with Physical Standards set on 08/13/2015 done by David T. Nguyen
>            PhD, February 2016 
>            Topic: Enhancing Mobile Device System Using Information from Users and Upper Layers
> Use PDF figures (for some reason EPS figures are not displayed correctly, 
> you can use `epspdf myfigure.eps` to convert)

Compiling in Ubuntu: use Kile as an editor, and use XeLaTeX button to compile
Need to instal MS fonts first as follows

```
sudo apt-get install ttf-mscorefonts-installer
sudo fc-cache
```

After that, check with 

```bash
fc-match Arial
```



## References
- University Brand Style Guide: Why 'College of William & Mary' is preferred. http://brand.wm.edu/index.php/editorial/