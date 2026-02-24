% -----------------------------------------------------------------------------
% ifrthesis.cls
% -----------------------------------------------------------------------------
% Custom thesis class for the Institute of Flight Research (iFR)
% Based on KOMA-Script scrbook
% -----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ifrthesis}[2026/02/14 Custom template for thesis done at the iFR]

% -----------------------------------------------------------------------------
% Class options handling
% -----------------------------------------------------------------------------
\RequirePackage{etoolbox}
\RequirePackage{ifthen}

% Default language 
\newcommand{\@ifrlang}{ngerman}

% Declare standard LaTeX options
\DeclareOption{ngerman}{\renewcommand{\@ifrlang}{ngerman}}
\DeclareOption{english}{\renewcommand{\@ifrlang}{english}}

% Pass all other options to scrbook
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}

% Process options
\ProcessOptions*\relax

% -----------------------------------------------------------------------------
% Load base class with fixed options
% -----------------------------------------------------------------------------
\LoadClass[a4paper, 11pt, DIV=14, chapterprefix=false, BCOR=5mm, twoside, openright]{scrbook}

% Load the required language package
\RequirePackage[\@ifrlang]{babel} 

% -----------------------------------------------------------------------------
% Required packages for option handling
% -----------------------------------------------------------------------------
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}

% -----------------------------------------------------------------------------
% Font configuration
% -----------------------------------------------------------------------------
%\renewcommand{\familydefault}{\sfdefault}
\RequirePackage{newtxtext}
\RequirePackage[varl,scaled=.9]{inconsolata}

% -----------------------------------------------------------------------------
% Page layout and typography
% -----------------------------------------------------------------------------
\RequirePackage[defaultlines=3,all]{nowidow} % no orphan or widow lines

% -----------------------------------------------------------------------------
% Tables
% -----------------------------------------------------------------------------
\RequirePackage{tabularx} % necessary for table on title page

% -----------------------------------------------------------------------------
% Bibliography
% -----------------------------------------------------------------------------
\RequirePackage{csquotes}
\RequirePackage[backend=biber,style=numeric]{biblatex}

% -----------------------------------------------------------------------------
% Nomenclature (commented out as per original)
% -----------------------------------------------------------------------------
\usepackage{units}

\newif\if@printeqref
\newif\if@printpageref
\newif\if@intoc
\newif\if@compatibilitymode
\DeclareOption{refeq}{\@printeqreftrue}
\DeclareOption{norefeq}{\@printeqreffalse}
\DeclareOption{refpage}{\@printpagereftrue}
\DeclareOption{norefpage}{\@printpagereffalse}
\DeclareOption{intoc}{\@intoctrue}
\DeclareOption{notintoc}{\@intocfalse}
\DeclareOption{compatible}{\@compatibilitymodetrue}
\DeclareOption{noncompatible}{\@compatibilitymodefalse}
\DeclareOption{prefix}{\def\nomprefix{a}}
\DeclareOption{noprefix}{\def\nomprefix{}}
\newif\if@loadcfg
\DeclareOption{cfg}{\@loadcfgtrue}
\DeclareOption{nocfg}{\@loadcfgfalse}
\DeclareOption{english}{%
  \def\eqdeclaration#1{, see equation\nobreakspace(#1)}%
  \def\pagedeclaration#1{, page\nobreakspace#1}%
  \def\nomname{Nomenclature}}
\DeclareOption{german}{%
  \def\eqdeclaration#1{, siehe Gleichung\nobreakspace(#1)}%
  \def\pagedeclaration#1{, Seite\nobreakspace#1}%
  \def\nomname{Symbolverzeichnis}}
\ExecuteOptions{noncompatible,notintoc,norefeq,norefpage,prefix,cfg,english}
\ProcessOptions\relax
\if@compatibilitymode%
    \def\@outputfileextension{.glo}%
    \def\@inputfileextension{.gls}%
\else%
    \def\@outputfileextension{.nlo}%
    \def\@inputfileextension{.nls}%
\fi%
\def\makenomenclature{%
  \newwrite\@nomenclaturefile
  \immediate\openout\@nomenclaturefile=\jobname\@outputfileextension
  \def\@nomenclature{%
    \@bsphack
    \begingroup
    \@sanitize
    \@ifnextchar[%
      {\@@@nomenclature}{\@@@nomenclature[\nomprefix]}}%
  \typeout{Writing nomenclature file \jobname\@outputfileextension}%
  \let\makenomenclature\@empty}
\if@compatibilitymode\let\makeglossary\makenomenclature\fi%
\def\nom@verb{\expandafter\strip@prefix\meaning}
\def\nomenclature{\protect\@nomenclature}
\def\@nomenclature{%
  \@bsphack
  \begingroup
  \@sanitize
  \@ifnextchar[%
    {\@@nomenclature}{\@@nomenclature[\nomprefix]}}
\def\@@nomenclature[#1]#2#3{\endgroup\@esphack}
\def\@@@nomenclature[#1]#2#3{%
 \def\@tempa{#2}\def\@tempb{#3}%
 \protected@write\@nomenclaturefile{}%
  {\string\nomenclatureentry{#1\nom@verb\@tempa @[{\nom@verb\@tempa}]%
      \begingroup\nom@verb\@tempb\protect\nomeqref{\theequation}%
        |nompageref}{\thepage}}%
 \endgroup
 \@esphack}

\newcommand{\pagestarted}{0}
\newsavebox\MessBox
\def\nomgroup#1{%
\ifthenelse{\not\equal{#1}{\switchnomitem}}{%
		\ifthenelse{\not\equal{\pagestarted}{1}}{%
			\renewcommand{\pagestarted}{1}%
			\begin{lrbox}{\MessBox}%
			\begin{minipage}{1\textwidth}%
		}{}%
	}{%
		\ifthenelse{\equal{\pagestarted}{1}}{%
			\end{minipage}\end{lrbox} %
			\renewcommand{\pagestarted}{0}%
		}{}%	
	}%
}

\newdimen\nomlabelwidth
\nomlabelwidth2.5cm\relax 
\newdimen\nom@tempdim
\def\printnomenclature#1{%
\def\switchnomitem{#1}
  \@ifnextchar[%
    {\@printnomenclature}{\@printnomenclature[\nomlabelwidth]}}
\def\@printnomenclature[#1]{%
  \nom@tempdim#1\relax
  \@input@{\jobname\@inputfileextension}}
\if@compatibilitymode\let\printglossary\printnomenclature\fi%
\def\nomlabel#1{#1\hfil}
\def\nompreamble{}
\def\nompostamble{}
\def\nomentryend{}
\newskip\nomitemsep
\setlength{\nomitemsep}{-0.07cm}
\def\thenomenclature{%
  \nompreamble
  \list{}{%
    \labelwidth\nom@tempdim
    \leftmargin\labelwidth
    \advance\leftmargin\labelsep
    \itemsep\nomitemsep
    \let\makelabel\nomlabel}}
\def\endthenomenclature{%
		\ifthenelse{\equal{\pagestarted}{1}}{%
			\end{minipage}\end{lrbox} %
			\renewcommand{\pagestarted}{0}%
		}{}%	
  \endlist
  \nompostamble} 
\def\nomrefeq{\@printeqreftrue}
\def\nomrefpage{\@printpagereftrue}
\def\nomrefeqpage{\@printeqreftrue\@printpagereftrue}
\def\nomnorefeq{\@printeqreffalse}
\def\nomnorefpage{\@printpagereffalse}
\def\nomnorefeqpage{\@printeqreffalse\@printpagereffalse}
\def\nomeqref#1{\if@printeqref\eqdeclaration{#1}\fi\ignorespaces}
\def\nompageref#1{\if@printpageref\pagedeclaration{#1}\fi%
  \nomentryend\endgroup}
\if@loadcfg
  \InputIfFileExists{nomencl.cfg}{%
    \typeout{Using the configuration file nomencl.cfg}}{}
\fi

\renewcommand{\nomname}{}

\newcommand{\nomenunit}[1]{\hskip-0em\parbox{4em}{$\left[ #1 \right]$}}
\makenomenclature

% -----------------------------------------------------------------------------
% Hyperref (loaded last)
% -----------------------------------------------------------------------------
\RequirePackage{hyperref}

% -----------------------------------------------------------------------------
% Thesis metadata commands
% -----------------------------------------------------------------------------
\newcommand{\ifrtitle}[1]{\def\@ifrtitle{#1}}
\newcommand{\ifrauthor}[1]{\def\@ifrauthor{#1}}
\newcommand{\ifrtype}[1]{\def\@ifrtype{#1}}
\newcommand{\ifrexaminer}[1]{\def\@ifrexaminer{#1}}

% Initialize supervisor variable as empty
\def\@ifrsupervisor{}

% Command to set supervisor(s) - can be called multiple times or with comma-separated list
\newcommand{\ifrsupervisor}[1]{%
  \ifx\@ifrsupervisor\@empty
    \def\@ifrsupervisor{#1}%
  \else
    \g@addto@macro\@ifrsupervisor{, #1}%
  \fi
}

% -----------------------------------------------------------------------------
% Configure hyperref with thesis metadata
% -----------------------------------------------------------------------------
\AtBeginDocument{%
    \hypersetup{%
        pdfauthor={\@ifrauthor},
        pdftitle={\@ifrtitle},
        pdfsubject={\@ifrtype},
        pdfkeywords={},
        pdfproducer={pdflatex},
        pdfcreator={Latex},
    }%
}

% -----------------------------------------------------------------------------
% Language-dependent commands file input
% -----------------------------------------------------------------------------

\newcommand{\MLUniversity}{%
    \ifthenelse{\equal{\@ifrlang}{ngerman}}%
    {Universität Stuttgart}%
    {University of Stuttgart}%
}
\newcommand{\MLInstitute}{%
    \ifthenelse{\equal{\@ifrlang}{ngerman}}%
    {Institut für Flugmechanik und Flugregelung}%
    {Institute of Flight Mechanics and Controls}%
}
\newcommand{\MLMastersthesis}{%
    \ifthenelse{\equal{\@ifrlang}{ngerman}}%
    {Masterarbeit}%
    {Master's Thesis}%
}
\newcommand{\MLBachelorsthesis}{%
    \ifthenelse{\equal{\@ifrlang}{ngerman}}%
    {Bachelorarbeit}%
    {Bachelor's Thesis}%
}
\newcommand{\MLAbstract}{%
    \iflanguage{ngerman}%
    {Kurzfassung}%
    {Abstract}%
}
\newcommand{\MLOtherlangAbstract}[1]{%
    \iflanguage{ngerman}%
  {\begin{otherlanguage}{english}\begingroup\renewcommand{\cleardoublepage}{}\renewcommand{\clearpage}{}\chapter*{\MLAbstract}\endgroup#1\end{otherlanguage}}%
  {\begin{otherlanguage}{ngerman}\begingroup\renewcommand{\cleardoublepage}{}\renewcommand{\clearpage}{}\chapter*{\MLAbstract}\endgroup#1\end{otherlanguage}}%
}

% -----------------------------------------------------------------------------
% Include blindtext for testing
% -----------------------------------------------------------------------------
\RequirePackage{blindtext}

% -----------------------------------------------------------------------------
% List of figures and tables
% -----------------------------------------------------------------------------

\newcommand{\makelistoffigures}{%
    \addcontentsline{toc}{chapter}{%
        \listfigurename
    }
    \listoffigures
}

\newcommand{\makelistoftables}{%
    \addcontentsline{toc}{chapter}{%
        \listtablename
    }
    \listoftables
}

% -----------------------------------------------------------------------------
% Title page creation
% -----------------------------------------------------------------------------

% Column type for title page
\newcolumntype{K}[1]{>{\centering\arraybackslash}b{#1}}

\renewcommand{\maketitle}{%
    \begin{titlepage}
        \vspace*{2cm}
        {\sffamily 
        \begin{center}
                \fboxrule1.0mm
                \fbox{%
                    \begin{minipage}{\textwidth}
                        \begin{center}
                            \vspace{0.5cm}
                            \Large \textbf{\@ifrtitle}
                            \vspace{0.5cm}
                        \end{center}
                    \end{minipage}%
                }
                
                \vspace{4cm}
                \Large\textbf{\@ifrauthor}\\
                \vspace{1cm}
                \Large\textbf{\@ifrtype}\\
                \vspace{0.5cm}
                \Large\textbf{\the\year}\\
                \vspace{3cm}
                {\large
                \begin{tabular}{@{}r l@{}}
                    \ifdefstring{\@ifrlang}{ngerman}%
                    {Betreuer}%
                    {Supervisors}: 
                    & \ifx\@ifrsupervisor\@empty
                        \textbf{No supervisors specified}%
                      \else
                        \@for\@supervisor:=\@ifrsupervisor\do{%
                            \@supervisor\@ifnotempty{\@supervisor}{\\ & }%
                        }%
                      \fi
                    \\
                    \ifdefstring{\@ifrlang}{ngerman}%
                    {Prüfer}%
                    {Examiner}: & \@ifrexaminer
                \end{tabular}
                }
        \end{center}
        }
        \vfill
        \begin{tabular}{K{2.7cm}K{13.0cm}}
            \begin{minipage}{\columnwidth}
                \includegraphics[scale=0.4, trim= -0.0cm 0.05cm 0cm 0cm]{./src/pics/logo/ifrlogo.pdf}
                \vspace{0.1cm}
            \end{minipage}
            & 
            \begin{minipage}{\columnwidth}
                \vfill
                \sffamily\large 
                \MLUniversity \\ 
                \textbf{\MLInstitute}
                \vspace{0.1cm}
            \end{minipage}\\
            \hline
        \end{tabular}
    \end{titlepage}%
}

% -----------------------------------------------------------------------------
% Declaration
% -----------------------------------------------------------------------------

\RequirePackage{cls/declaration/declaration_command}
\newcommand{\makedeclaration}{\makedeclarationwithauthor{\@ifrauthor}}

% -----------------------------------------------------------------------------
% End of class
% -----------------------------------------------------------------------------
