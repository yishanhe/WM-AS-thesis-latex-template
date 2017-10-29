
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmthesis}

%%---------------------------------------------------
%%-- Helper. Credit to the sigplanconf.cls  -- Shanhe
%%---------------------------------------------------

% boolean
\def \@true {TT}
\def \@false {FL}
\def \@setflag #1=#2{\edef #1{#2}}%              \flag = boolean

% handler for unsupported options
\def \@unsupportedoption #1{%
\ClassError{proc}{The standard '#1' option is not supported.}}


%%---------------------------------------------------
%%-- Options, fully customize the template -- Shanhe
%%---------------------------------------------------

%-- default high level options
% current we support only two types: proposal, dissertation.
\@setflag \@proposal = \@false
\@setflag \@dissertation = \@true

%-- default low level options
% high level options is the orchestration of low level options.
\@setflag \@tablelist = \@true
\@setflag \@figurelist = \@true

\@setflag \@title = \@true
\@setflag \@copyright = \@true
\@setflag \@approval = \@true
\@setflag \@acknowledgement= \@true

% high level option configurations
\DeclareOption{proposal}{%
  \@setflag \@proposal = \@true
  \@setflag \@dissertation = \@false
  \@setflag \@tablelist = \@false
  \@setflag \@figurelist = \@false
  }

\DeclareOption{dissertation}{%
  \@setflag \@proposal = \@false
  \@setflag \@dissertation = \@true
  }

% low level options
\DeclareOption{notablelist}{\@setflag \@tablelist = \@false}
\DeclareOption{nofigurelist}{\@setflag \@figurelist = \@false}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

%%---------------------------------------------------
%%--Set the section number depth.
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{4}
\setcounter{page}{2}

%%---------------------------------------------------
%%--Include some required packages.
\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{setspace}
\RequirePackage{float}
\RequirePackage{citesort}

%%---------------------------------------------------
%%--Must change the margin above the Chapter heading to 2 inches
\RequirePackage{wmchapter}


%%---------------------------------------------------
%%--Create a vertical skip for the distance between the title and
%%--the first line of text on the prolog pages.
\newskip\thesisvskip
\thesisvskip 36pt

%%---------------------------------------------------
%%--Set the margins.
%\headheight6pt \headsep12pt
%\marginparwidth 1in
%\marginparsep 6pt
\oddsidemargin 0.5in%38pt %36pt
%\evensidemargin 38pt %36pt
\topmargin  0.25in
\rightmargin 0.25pt
\textwidth  5.9 in
\textheight 8.4 in
\footskip   24pt  %%check this

%%---------------------------------------------------
%%--Set the pagestyle to headings.
\pagestyle{headings}

%%---------------------------------------------------
%%--Change the marginpar.
%\reversemarginpar
%\let\old@marginpar=\marginpar
%\def\marginpar#1{
%       \old@marginpar{\def\baselinestretch{1}\em\small #1}}

%%---------------------------------------------------
%%--Parameters that can be set by the user.


%%--------------------------------------------
%%-- Prolog pages construction.
%%--------------------------------------------

%%--Macros used for the construction of the title page.

%%--Meta
\newcommand{\thesisTitle}[1]{\gdef\thesis@title{#1}}
\newcommand{\thesisYear}[1]{\gdef\thesis@year{#1}}
\newcommand{\thesisMonth}[1]{\gdef\thesis@month{#1}}
\newcommand{\thesisAbstract}[1]{\gdef\thesis@abstract{#1}}
\newcommand{\thesisAcknowledge}[1]{\gdef\thesis@ack{#1}}
\newcommand{\thesisDedication}[1]{\gdef\thesis@Dedication{#1}}
\newcommand{\thesisVita}[1]{\gdef\thesis@vita{#1}}
\newcommand{\thesisBib}[1]{\gdef\thesis@bib{#1}}
\newcommand{\thesisAdvisor}[1]{\gdef\thesis@advisor{#1}}

%%--Location and Degrees added -- Ruth
% @deprecated, using ThesisHometown to avoid ambiguity
% NOTE: do we need gdef here?
\newcommand{\thesisLocation}[1]{\gdef\ThesisLocation{#1}}  
\newcommand{\thesisDegreeOne}[1]{\gdef\ThesisDegreeOne{#1}}
\newcommand{\thesisDegreeTwo}[1]{\gdef\ThesisDegreeTwo{#1}}
\newcommand{\thesisDegreeThree}[1]{\gdef\ThesisDegreeThree{#1}}
%%--Hometown, Deparment added -- Shanhe
\newcommand{\thesisHometown}[1]{\gdef\ThesisHometown{#1}}
\newcommand{\thesisType}[1]{\gdef\ThesisType{#1}}
\newcommand{\thesisDepartment}[1]{\gdef\ThesisDepartment{#1}}

% TODO: unify naming conventions.

%  \thesisAuthor macro
%     defines two TeX variables (only usable in this file)
%  \thesis@author  is assumed to be a "short" version of the author's name
%        used on the title page
%  \thesis@authorx is assumed to be the full name of the author
%        used on the approval, the UMI abstract, and the vita pages
%  For example
%     \thesisAuthor{A. Goode Student}
%        sets both \thesis@author and \ thesis@authorx to
%        "A. Goode Student"
%     \thesisAuthor[Aloysius Goode Student]{A. Goode Student}
%        sets \thesis@author  to "A. Goode Student" and
%             \thesis@authorx to "Aloysius Goode Student"
%
\newcommand{\thesisAuthor}[2][\empty]{
   \gdef\thesis@author{#2}
   \ifx#1\empty \let\thesis@authorx\thesis@author
   \else \gdef\thesis@authorx{#1}\fi}

\def\thesis@abstract{\empty}
\def\thesis@ack{\empty}
\def\thesis@vita{\empty}
\def\thesis@bib{\empty}

%%--Macro used to specify the committee.
\newcounter{thesis@members}
\setcounter{thesis@members}{1}

\newcommand{\thesisCommittee}[3][\mbox{\hspace*{1ex}}]{
   \edef\thesis@ctr{\romannumeral\value{thesis@members}}
   \expandafter\def\csname thesis@org\thesis@ctr\endcsname{#3}
   \expandafter\def\csname thesis@member\thesis@ctr\endcsname{#2}
   \expandafter\def\csname thesis@dept\thesis@ctr\endcsname{#1}
   \addtocounter{thesis@members}{1}}

%%--The prolog pages for thesie
\newcommand{\makeProlog}{

    \bigskip
    % \setcounter{page}{1}
    % \renewcommand{\thepage}{\roman{page}}
    \pagestyle{plain}
    \thispagestyle{empty}


    \maketitlepage % required

    \makecopyrightpage

	  \makeapprovalpage

	  \makeabstractpage

    \maketocpage % required

	  \makeacknowledgepage
%%--------------------------------------------
%%-- dedication page
	\makededicationpage
%%--------------------------------------------
%%-- List of tables and/or figures.
	\maketablesfigurespage
%%--------------------------------------------
% %%-- half-title page
% 	\makehalftitlepage
%%--------------------------------------------
%%-- end of prolog, start of thesis
  \newpage
  \setcounter{page}{1}
	\pagestyle{plain}
	\renewcommand{\thepage}{\arabic{page}}
}


\def\acknowledgeName{ACKNOWLEDGMENTS}
\def\abstractName{ABSTRACT}

%%--------------------------------------------
%%--The title page.
\newcommand{\maketitlepage}{
  \if \@title
    \begin{titlepage}
      \begin{singlespace}
        \begin{center}{\large
            \thesis@title \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ %8 lines between title and author name -- Ruth
            \thesis@authorx \\
                \hspace{.1in}  \\ %1 line between name and hometown -- Ruth
            \ifdefined\ThesisLocation \ThesisLocation \\ \else \ifdefined\ThesisHometown \ThesisHometown \\ \fi \fi % adding condition statements for flexibility -- Shanhe
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\ % 4 lines between hometown and prior degrees -- Ruth
            \ifdefined\ThesisDegreeOne \ThesisDegreeOne \\ \fi 
            \ifdefined\ThesisDegreeTwo \ThesisDegreeTwo \\ \fi
            \ifdefined\ThesisDegreeThree \ThesisDegreeThree \\ \fi
            % Support at most 3 previous degrees if there are more degrees, you have to manually add them. -- Shanhe
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\ % 4 lines between prior degrees and purpose statement -- Ruth
            {A Dissertation presented to the Graduate Faculty\\
                of the College of William and Mary in Candidacy for the Degree of\\
                Doctor of Philosophy}\\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\ % 7 lines between purpose statement and department -- Ruth
            {\ifdefined\ThesisDepartment \ThesisDepartment \else Department of Computer Science \fi}
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\
                \hspace{.1in}  \\ % 5 lines between department and college -- Ruth
            {The College of William and Mary\\
              \thesis@month\ \thesis@year}
            }
        \end{center}
      \end{singlespace}
    \end{titlepage}
  \fi
 }

%%--------------------------------------------
%%--The copyright page.
\newcommand{\makecopyrightpage}{
  \if \@copyright
    \newpage\pagestyle{empty} % no page number on copyright page -- Ed
    \begin{center}
      \begin{singlespace}
      \vspace*{\fill}
      \fontsize{12}{12}\selectfont
      \textcopyright~Copyright by~\thesis@author~\thesis@year
      \end{singlespace}
    \end{center}
  \fi
}

%%--------------------------------------------
%%--The approval page.
\newcommand{\thesisapprovalwidth}{3in}

\newcommand{\makeapprovalpage}{
  \if \@approval
    \newpage
    \pagestyle{empty} % no page number on approval page -- Ruth
    \begin{singlespace}
      \begin{center}
          {\Large APPROVAL PAGE}\\
            {\large \hspace{.1in} } \\
            {\large \hspace{.1in} } \\
            {\large \hspace{.1in} } \\ % 3 lines between title and statement -- Ruth
          {\large This Dissertation is submitted in partial fulfillment of \\
              the requirements for the degree of}\\
              \hspace{.1in}  \\ % 1 lines between statements
          {\large Doctor of Philosophy}\\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ % 3 lines between statement and signature line -- Ruth
          \underline{\hspace*{\thesisapprovalwidth}}\\
          {\small \thesis@author}\\
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ % 3 lines between signature line and approved -- Ruth
          {\large Approved by the Committee, \thesis@month~\thesis@year}\\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ % 2 lines between approved and signature line -- Ruth
          \underline{\hspace*{\thesisapprovalwidth}}\\
          {\small Committee Chair\\
          \thesis@memberi, \thesis@depti\\
          \thesis@orgi}
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
          \underline{\hspace*{\thesisapprovalwidth}}\\
          {\small\thesis@memberii, \thesis@deptii\\
          \thesis@orgii}
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
          \underline{\hspace*{\thesisapprovalwidth}}\\
          {\small\thesis@memberiii, \thesis@deptiii\\
          \thesis@orgiii}
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
          \underline{\hspace*{\thesisapprovalwidth}}\\
          {\small\thesis@memberiv, \thesis@deptiv\\
          \thesis@orgiv}
              \hspace{.1in}  \\
              \hspace{.1in}  \\
              \hspace{.1in}  \\ % 3 lines between signatures -- Ruth
          \underline{\hspace*{\thesisapprovalwidth}}\\
          {\small\thesis@memberv, \thesis@deptv\\
          \thesis@orgv} % change this if your outside member is from outside the College
      \end{center}
    \end{singlespace}
  \fi
}

%%--------------------------------------------
%%--The abstract page
%%  requried, not numbered
\newcommand{\makeabstractpage}{
  \if \@abstract
    \newpage
    \pagestyle{empty} % no page number on abstract page -- Ruth
    \begin{center}
      \Large\abstractName
    \end{center}
    \begin{singlespace}
      \begin{flushleft}
        \input{\thesis@abstract}
      \end{flushleft}
    \end{singlespace}
  \fi
}

%%--------------------------------------------
%%--The toc page
%% required, numbered with Roman number i
\newcommand{\maketocpage}{
  \newpage
  \pagestyle{plain}
  \setcounter{page}{1}
  \renewcommand{\thepage}{\roman{page}}
  \begingroup%
  \renewcommand{\bfseries}{\relax}% %prevent TOC from being bold
  {\large \tableofcontents }
  \endgroup%    
}

%%--------------------------------------------
%%--The acknowledgement page
%% required in thesie, not in proposal
\newcommand{\makeacknowledgepage}{
  \if \@acknowledgement
    \newpage
    \begin{center}
      \addcontentsline{toc}{chapter}{\rm Acknowledgments}
      \Large\acknowledgeName
    \end{center}
    \begin{singlespace}
    \begin{flushleft}
      \input{\thesis@ack}
    \end{flushleft}
    \end{singlespace}
  \fi
}

%%--------------------------------------------
%%--The dedication page
% This is to be "whole page" justified, so if your dedication is more than
% one line, the amount of vspace will need to be adjusted. -- Ruth
\newcommand{\makededicationpage}{
	\newpage
	\begin{center}
		\addcontentsline{toc}{chapter}{\rm Dedication}
		\vspace*{3in}
		{\large \thesis@Dedication}
	\end{center}
}

%%--------------------------------------------
%%--The approval page.


%%--------------------------------------------
%%--The tables pages
\newcommand{\maketablespage}{%
  \if \@tablelist
    \newpage
    %\begin{singlespace}
	  \addcontentsline{toc}{chapter}{\rm List of Tables}
		{\large	\listoftables	}
    %\end{singlespace}
  \fi
}

%%--------------------------------------------
%%--The figures pages
\newcommand{\makefigurespage}{%
  \if \@figurelist
	  \newpage
    %\begin{singlespace}
	  \addcontentsline{toc}{chapter}{\rm List of Figures}
		{\large	\listoffigures	}
    %\end{singlespace}
  \fi
}

% TODO: compliance page
% http://www.wm.edu/as/graduate/_forms/physicalstandardsforms/use-this-compliancepagetemplate-9-16-16.pdf

%%--------------------------------------------
%%--The half-title page
% This page is not necessary. If you do not include it, be sure to
% still include the setcounter command to get the first page
% numbered as such.
\newcommand{\makehalftitlepage}{
	\newpage
	% \setcounter{page}{1}
	\pagestyle{empty}
	\begin{center}
		\vspace*{3in}
		{\Large \thesis@title}
	\end{center}
}

%%--------------------------------------------
%%-- Bibliography related commands.
%%--------------------------------------------


%%--Set the bib style
\def\thesisBibStyle{wmbib}

%%--Define a single command for making the bibliography.
\newcommand{\makeThesisBib}[1]{
  \bibliographystyle{\thesisBibStyle}
  \bibliography{#1}}

%%--Redefine the thebibliography environment
\let\wm@thebibliography\thebibliography
\let\wm@endthebibliography\endthebibliography

\def\thebibliography#1{\begin{spacing}{1}\wm@thebibliography{#1}
       \addcontentsline{toc}{chapter}{Bibliography}}
\def\endthebibliography{\wm@endthebibliography\end{spacing}}

\newcommand{\makeThesisVita}[1]{
         \newpage
         \pagestyle{headings}\markright{}
         \begin{center}
            \addcontentsline{toc}{chapter}{Vita}
           \Large VITA
      \vskip\thesisvskip
      \thesis@authorx
      \vskip\thesisvskip
         \end{center}
         \input{#1}
}

% I did not write this or use this, so I do not know if it is compliant. -- Ruth
\newcommand{\makeUMIAbstract}[1]{
         \newpage
         \pagestyle{empty}
\thispagestyle{empty}
         \begin{center}
     \Large \thesis@title \\
        \parbox{1in}{   ABSTRACT } \vskip\thesisvskip
        \end{center}
         \input{#1}
     \vfill
     \begin{center}
     \large \thesis@authorx \\
     Department of Computer Science \\
     The College of William and Mary in Virginia \\
     Advisor: \thesis@advisor  \\
     \thesis@title
     \end{center}
}

%%--------------------------------------------
%%-- Definition and Quotation commands.
%%--------------------------------------------

\newtheorem{define}{Definition}[chapter]
\newtheorem{theorem}{Theorem}[chapter]
\newtheorem{lemma}{Lemma}[chapter]
\newtheorem{notate}{Notation}[chapter]
\newtheorem{axiom}{Axiom}[chapter]

\newenvironment{proof}[1][Proof]
{\noindent {\bf #1: }}{\hfill $\blacksquare$}

%%-----------------------------------------------
%%-- Float related environments and commands.
%%-----------------------------------------------

%%--Modify behavior of the figure and table environment.
\def\fps@figure{hbt}
\def\fnum@figure{{\bf \figurename~\thefigure}}
\def\fps@table{htb}
\def\fnum@table{{\bf \tablename~\thetable}}

\def\mathfigure{\thesisfiguretrue\figure}
\def\endmathfigure{\endfigure\thesisfigurefalse}

%%--Redefine the @makecaption command so \small can be used.
\long\def\@makecaption#1#2{%
 \vskip\abovecaptionskip
 \sbox\@tempboxa{{\small #1: #2}}%
 \def\baselinestretch{1}\small%\@newbaseline
 \ifdim \wd\@tempboxa >\hsize
   #1: #2\par
 \else
   \global \@minipagefalse
   \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
 \fi
 \vskip\belowcaptionskip}



%%--This allows for the correct setting of \arraystrecth in the
%%--math environments when used within a figure.
%\let\old@figure=\figure
%\let\old@endfigure=\endfigure
%\renewenvironment{figure}[1][\empty]{
%  \ifx\empty \begin{old@figure}
%\def\figure{\thesisFiguretrue\old@figure}
%\def\endfigure{\global\thesisFigurefalse\old@endfigure}


%%-----------------------------------------------
%%-- Modify the displayed math environments.
%%-----------------------------------------------

\newif\ifthesisfigure
\thesisfigurefalse

%%--Set the arraystretch for math display.
\everydisplay{
  \abovedisplayskip \baselinestretch\abovedisplayskip %plus 0.0pt minus 10pt%
  \belowdisplayskip \abovedisplayskip%
  \abovedisplayshortskip \abovedisplayshortskip%
  \belowdisplayshortskip \belowdisplayshortskip%
  \ifthesisfigure\def\arraystretch{1}\else\def\arraystretch{0.5}\fi}

\def\@setsize#1#2#3#4{%\@nomath#1%-KPC
  \let\@currsize#1\baselineskip
  #2\baselineskip\baselinestretch\baselineskip
  \parskip\baselinestretch\parskip
  \setbox\strutbox\hbox{\vrule height.7\baselineskip
     depth.3\baselineskip width\z@}%-KPC
  \normalbaselineskip\baselineskip#3#4}



%%--------------------------------------------
%%-- Miscellaneous commands.
%%--------------------------------------------

%%--Commands to simplify font changing.
\newcommand{\sfup}{\sffamily\mdseries\upshape}
\newcommand{\sfsc}{\ttfamily\mdseries\scshape}
\newcommand{\sfit}{\sffamily\mdseries\itshape}
\newcommand{\rmup}{\rmfamily\mdseries\upshape}
\newcommand{\rmbf}{\rmfamily\bfseries\upshape}
\newcommand{\rmit}{\rmfamily\mdseries\itshape}
\newcommand{\ttup}{\ttfamily\mdseries\upshape}


\endinput

%%--The \tableofcontents.
%%%%% code removed REL

%%--The \listoffigures command.
\renewcommand\listoffigures{%
   \if@twocolumn
     \@restonecoltrue\onecolumn
   \else
     \@restonecolfalse
   \fi
   \oldchapter*{\listfigurename
     \@mkboth{\uppercase{\listfigurename}}{\uppercase{\listfigurename}}}%
   \@starttoc{lof}%
   \if@restonecol\twocolumn\fi}

%%--The \listoftables command.
\renewcommand\listoftables{%
   \if@twocolumn%
     \@restonecoltrue\onecolumn%
   \else%
     \@restonecolfalse%
   \fi%
   \oldchapter*{\listtablename%
     \@mkboth{\uppercase{\listtablename}}{\uppercase{\listtablename}}}%
   \@starttoc{lot}%
   \if@restonecol\twocolumn\fi}

\usepackage{wmchap}
\endinput
