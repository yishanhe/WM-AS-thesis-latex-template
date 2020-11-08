# TeX Template of Physical Standards for Theses & Dissertations for College of William & Mary, Arts & Sciences

This directory contains a collection of template files that can be used with
LaTeX to produce a PhD dissertation that conforms pretty closely to the W&M
"Physical Standards for Theses & Dissertations".

http://www.wm.edu/as/graduate/studentresources/thesis-dissertations/physicalstandards/index.php

## Contributors

- [William L. Bynum](http://www.cs.wm.edu/~bynum/)
- [Rance Necaise](http://necaiseweb.org/)

> The department is indebted to Rance Necaise, who contributed the files from
> which these files were derived.  Rance received his PhD from the department
> in August of 1998. -- William L. Bynum


- [Bob Matthews](http://matthews.sites.truman.edu/)

> Updated 9/04 to conform to Arts and Science Graduate Writer's Guide of Nov.
> 2003.  Your milege may vary. --  Bob Matthews == rem

- [Ruth Lamprecht](https://www.linkedin.com/in/ruthlamprecht/)
- [Andrew Pyles](https://www.linkedin.com/in/andrew-j-pyles-b44909/)

> Updated 07/13 to conform to Arts and Science standards of Oct. 2012, with
> help from Andrew Pyles -- Ruth

- [David T. Nguyen](http://davidnguyen.cz/)

> Modifications to comply with Physical Standards set on 08/13/2015

- [Ed Novak](https://www.fandm.edu/ed-novak)

> Updated 06/16 to conform to the new William and Mary physical standards and
> submission system online with ProQuest. -- Ed Novak

- Shanhe Yi

> Committed with the physical standards set on May 2018. Refactored the
> wmthesis class to make it easier to understand and modify.
> Maintain the first Github repository. -- Shanhe Yi

- [Seth Goodman](https://github.com/sgoodm)

> Updated 11/20 to compile in Overleaf and meet current standards


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
line.
To compile just the LaTeX files, type `make latex` , `make pdflatex` or `make xelatex`.

If you are writing a thesis other than a dissertation, adding `thesis` to the document class option

```tex
\documentclass[11pt, draft, thesis]{wmthesis}
```

Adding `proposal`, `draft`, or `final` based on your pace.


```tex
\documentclass[11pt, proposal]{wmthesis}
% with no approval, acknowledge, dedicate pages.
```


```tex
\documentclass[11pt, draft]{wmthesis}
% has all required pages and a blank approval page.
```


```tex
\documentclass[11pt, final]{wmthesis}
% includes all required pages.
% It will also replace the blank approval pages with a signed pdf
% - rename your scann copy as 'signed_approval_page.pdf'.
```


Feel free to contact the contributors or open an issue if any you have any questions regarding the use of these files.
And you are very welcomed for **PULL REQUEST**.
Let's combine efforts - long live this template !




## Font problem

According to the latest feedback from Office of Graduate Studies, Arts and Sciences, accepted
font is either **Arial** or **Computer Modern**.

Given that Arial is a commericial font, not available to all platforms (e.g., Linux), we recommand
to use Computer Modern (which is defined as default in `wmthesis.cls`).

However, you can follow the instrcutures below to setup Arial if you like to use Arial font for you thesis/dissertation.

### Ways of install Arial font

If you insist on usingf Arial font, depends on you are using pdflatex, or latex, or xelatex, and the platforms,
there are different ways to install arial fonts, we list a few here and expect pull request to this repo for latest methods to
get the Arial font.

#### 1. MacOS or Ubuntu - Using PdfLaTeX or LaTeX

This method shows font as `A030` (tested in edit mode of PDFExpert), but it is Arial indeed.
Might make this method less favored. Someone using this method needs to get consent from the office lady.

On Mac OS, you can install MacTex to get the Tex environment.

Add fonts using the following commands:

```shell
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

```makefile
latex:
	latex thesis
	bibtex thesis
	latex thesis
	latex thesis
	dvips thesis.dvi
	ps2pdf thesis.ps
```

or

```makefile
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

```tex
\usepackage{fontspec}
\setmainfont{Arial}
```


then, in your `Makefile`, make sure

```makefile
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

```shell
sudo apt-get install ttf-mscorefonts-installer
sudo fc-cache
```

After that, check with

```shell
fc-match Arial
```



## References
- University Brand Style Guide: Why 'College of William & Mary' is preferred. http://brand.wm.edu/index.php/editorial/
