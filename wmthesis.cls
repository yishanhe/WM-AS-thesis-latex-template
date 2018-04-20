\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{wmthesis}

%%---------------------------------------------------
%%-- Helper. Credit to the sigplanconf.cls  -- Shanhe
%%---------------------------------------------------

\def \@true {TT} % boolean - true
\def \@false {FL} % boolean - false
\def \@setflag #1=#2{\edef #1{#2}} % \flag = boolean

\def \@notp #1{\if #1\@false \else \@true \fi}

\def \@andp #1#2{\if #1%
                  \if #2\@true \else \@false \fi
                \else
                  \@false
                \fi}

\def \@orp #1#2{\if #1%
                 \@true
               \else
                 \if #2\@true \else \@false \fi
               \fi}

\def \@xorp #1#2{\if #1%
                  \if #2\@false \else \@true \fi
                \else
                  \if #2\@true \else \@false \fi
                \fi}

%%---------------------------------------------------
%%-- Options, fully customize the template -- Shanhe
%%---------------------------------------------------
\@setflag \@thesis = \@true
% \@setfalg \@dissertation = \@true
\@setflag \@proposal = \@true
\@setflag \@draft = \@true
\@setflag \@final = \@true

\DeclareOption{proposal}{\@setflag \@proposal = \@true%
                        \@setflag \@draft = \@false%
                        \@setflag \@final = \@false}

\DeclareOption{draft}{\@setflag \@proposal = \@false%
                        \@setflag \@draft = \@true%
                        \@setflag \@final = \@false}

\DeclareOption{final}{\@setflag \@proposal = \@true%
                        \@setflag \@draft = \@false%
                        \@setflag \@final = \@false}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{report}}
\ProcessOptions\relax
\LoadClass{report}

%%---------------------------------------------------
%%-- Layout parameters
%%---------------------------------------------------

\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{4}
\setcounter{page}{2}

%%--Create a vertical skip for the distance between the title and
%%--the first line of text on the prolog pages.
\newskip\thesisvskip
\thesisvskip 36pt

%%--Set the margins.
%\headheight6pt \headsep12pt
%\marginparwidth 1in
%\marginparsep 6pt
\oddsidemargin 0.5in%38pt %36pt
%\evensidemargin 38pt %36pt
\topmargin  0.25in
\rightmargin 0.25pt
\textwidth  5.9in
\textheight 8.4in
\footskip   24pt  %%check this


%%---------------------------------------------------
%%-- Required pacakges
%%---------------------------------------------------

\RequirePackage{amsmath}
\RequirePackage{amssymb}
\RequirePackage{setspace}
\RequirePackage{float}

%%--Must change the margin above the Chapter heading to 2 inches
\RequirePackage{wmchapter} % defined in wmchapter.sty



%%--Set the pagestyle to headings.
\pagestyle{headings} % NOTE: need to check

%%---------------------------------------------------
%%--Change the marginpar.
%\reversemarginpar
%\let\old@marginpar=\marginpar
%\def\marginpar#1{
%       \old@marginpar{\def\baselinestretch{1}\em\small #1}}

%%--------------------------------------------
%%-- Meta data.
%%--------------------------------------------
% TODO: unify naming conventions.

% 
% \def\thesis@abstract{\empty}
% \def\thesis@ack{\empty}
% \def\thesis@vita{\empty}
% \def\thesis@bib{\empty}
% \def\thesis@dedication{\empty}

\newcommand{\thesisTitle}[1]{\gdef\thesis@title{#1}}
\newcommand{\thesisYear}[1]{\gdef\thesis@year{#1}}
\newcommand{\thesisMonth}[1]{\gdef\thesis@month{#1}}
\newcommand{\thesisAbstract}[1]{\gdef\thesis@abstract{#1}}
\newcommand{\thesisAcknowledge}[1]{\gdef\thesis@ack{#1}}
\newcommand{\thesisDedication}[1]{\gdef\thesis@dedication{#1}}
\newcommand{\thesisVita}[1]{\gdef\thesis@vita{#1}}
\newcommand{\thesisBib}[1]{\gdef\thesis@bib{#1}}
\newcommand{\thesisAdvisor}[1]{\gdef\thesis@advisor{#1}}

\newcommand{\thesisLocation}[1]{\gdef\thesis@location{#1}} 
\newcommand{\thesisHometown}[1]{\gdef\ThesisHometown{#1}}

\newcommand{\thesisDegreeOne}[1]{\gdef\ThesisDegreeOne{#1}}
\newcommand{\thesisDegreeTwo}[1]{\gdef\ThesisDegreeTwo{#1}}
\newcommand{\thesisDegreeThree}[1]{\gdef\ThesisDegreeThree{#1}}

\newcommand{\thesisDepartment}[1]{\gdef\ThesisDepartment{#1}}

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

\newcounter{thesis@members}
\setcounter{thesis@members}{1}
\newcommand{\thesisCommittee}[3][\mbox{\hspace*{1ex}}]{
   \edef\thesis@ctr{\romannumeral\value{thesis@members}}
   \expandafter\def\csname thesis@org\thesis@ctr\endcsname{#3}
   \expandafter\def\csname thesis@member\thesis@ctr\endcsname{#2}
   \expandafter\def\csname thesis@dept\thesis@ctr\endcsname{#1}
   \addtocounter{thesis@members}{1}}

%%--------------------------------------------
%%-- Prolog pages construction.
%%--------------------------------------------


\newcommand{\makeProlog}{

    \bigskip
    % \setcounter{page}{1}
    % \renewcommand{\thepage}{\roman{page}}
    \pagestyle{plain}
    \thispagestyle{empty}


    \maketitlepage % required

    \if \@orp \@draft \@final
      \makecopyrightpage
      \makeapprovalpage
    \fi

	  \makeabstractpage % required

    \maketocpage % required

    \if \@orp \@draft \@final
      \makeacknowledgepage
      \makededicationpage
    \fi

    \maketablespage

    \makefigurespage

    % \newcommand{\makehalftitlepage}{
    %   \newpage
    %   % \setcounter{page}{1}
    %   \pagestyle{empty}
    %   \begin{center}
    %     \vspace*{3in}
    %     {\Large \thesis@title}
    %   \end{center}
    % }

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
          \ifdefined\thesis@location \thesis@location \\ \else \ifdefined\ThesisHometown \ThesisHometown \\ \fi \fi % adding condition statements for flexibility -- Shanhe
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
          {A \if \@thesis Dissertation \else Thesis \fi presented to the Graduate Faculty\\
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
          {College of William \& Mary\\
            \thesis@month, \thesis@year}
          }
      \end{center}
    \end{singlespace}
  \end{titlepage}
 }

%%--------------------------------------------
%%--The copyright page.
\newcommand{\makecopyrightpage}{
  \newpage\pagestyle{empty}
  \begin{center}
    \begin{singlespace}
    \vspace*{\fill}
    \fontsize{12}{12}\selectfont
    \textcopyright~Copyright by~\thesis@author~\thesis@year
    \end{singlespace}
  \end{center}
}

%%--------------------------------------------
%%--The approval page.
\newcommand{\thesisapprovalwidth}{3in}
\newcommand{\makeapprovalpage}{
  \newpage
  \pagestyle{empty}
  \begin{singlespace}
    \begin{center}
        \if \@thesis {\Large APPROVAL PAGE} \else {\Large Oral Exam Committee} \fi\\
          {\large \hspace{.1in} } \\
          {\large \hspace{.1in} } \\
          {\large \hspace{.1in} } \\ % 3 lines between title and statement -- Ruth
        {\large This \if \@thesis Dissertation \else Proposal \fi is submitted in partial fulfillment of \\
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
        {\large \if \@thesis Approved \else Reviewed \fi by the Committee, \thesis@month~\thesis@year}\\
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
        \if \@thesis
          \underline{\hspace*{\thesisapprovalwidth}}\\
          {\small\thesis@memberv, \thesis@deptv\\
          \thesis@orgv} 
        \fi
    \end{center}
  \end{singlespace}
}


%%--------------------------------------------
%%--The abstract page
%%--Title 14 and content 12, single space between 
% title and content.  -- Shanhe
%%-- @see https://en.wikibooks.org/wiki/LaTeX/Fonts
%%-- 11pt documentclass:
%%-- Large is 14.4pt and large is 12pt.
\newcommand{\makeabstractpage}{
  \newpage
  \pagestyle{empty}
  \begin{singlespace}
    \begin{center}
      \Large\abstractName
    \end{center}
    \begin{flushleft}
      \large{\parindent0pt \input{\thesis@abstract}}
    \end{flushleft}
  \end{singlespace}
}

%%--------------------------------------------
%%--The toc page
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
\newcommand{\makeacknowledgepage}{
  \newpage
  \begin{center}
    \addcontentsline{toc}{chapter}{Acknowledgments}
    \Large\acknowledgeName
  \end{center}
  \begin{singlespace}
  \begin{flushleft}
    \input{\thesis@ack}
  \end{flushleft}
  \end{singlespace}
}

%%--------------------------------------------
%%--The dedication page
\newcommand{\makededicationpage}{
  \newpage
  \begin{center}
    \addcontentsline{toc}{chapter}{Dedication}
    \vspace*{3in}
    {\large \thesis@dedication}
  \end{center}
}


%%--------------------------------------------
%%--The tables pages
\newcommand{\maketablespage}{%
  \newpage
  %\begin{singlespace}
  \addcontentsline{toc}{chapter}{List of Tables}
  {\large	\listoftables	}
  %\end{singlespace}
}

%%--------------------------------------------
%%--The figures pages
\newcommand{\makefigurespage}{%
  \newpage
  %\begin{singlespace}
  \addcontentsline{toc}{chapter}{List of Figures}
  {\large	\listoffigures	}
  %\end{singlespace}
}

% TODO: compliance page
% http://www.wm.edu/as/graduate/_forms/physicalstandardsforms/use-this-compliancepagetemplate-9-16-16.pdf


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

%%--------------------------------------------
%%-- Vita
%%--------------------------------------------
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
% \newcommand{\sfup}{\sffamily\mdseries\upshape}
% \newcommand{\sfsc}{\ttfamily\mdseries\scshape}
% \newcommand{\sfit}{\sffamily\mdseries\itshape}
% \newcommand{\rmup}{\rmfamily\mdseries\upshape}
% \newcommand{\rmbf}{\rmfamily\bfseries\upshape}
% \newcommand{\rmit}{\rmfamily\mdseries\itshape}
% \newcommand{\ttup}{\ttfamily\mdseries\upshape}


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
