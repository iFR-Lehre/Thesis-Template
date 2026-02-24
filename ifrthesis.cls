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
%\RequirePackage{lmodern}  % solves pixelated font problems
%\RequirePackage{helvet}   % use helvetica font for sans serif
%\renewcommand{\familydefault}{\sfdefault}
%\RequirePackage[T1]{fontenc}
\RequirePackage{newtxtext}
\RequirePackage[varl,scaled=.9]{inconsolata}

% -----------------------------------------------------------------------------
% Page layout and typography
% -----------------------------------------------------------------------------
\RequirePackage[defaultlines=3,all]{nowidow} % no orphan or widow lines
%\RequirePackage[headings]{fullpage}
%\RequirePackage[margin=1in]{geometry}
\RequirePackage{setspace} % line spacing
\RequirePackage{multicol} % for multicols
\RequirePackage{todonotes} % for note taking

% -----------------------------------------------------------------------------
% Graphics and figures
% -----------------------------------------------------------------------------
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{pdfpages}   % insert pdfs
\RequirePackage{subcaption} % for subfigure environment
\RequirePackage{rotating}   % for sidewaysfigure environment
\RequirePackage{pgfplots}
\RequirePackage{tikz}
\RequirePackage{float}

% TikZ libraries
\usetikzlibrary{
    plotmarks,
    shapes,
    arrows.meta,
    decorations.markings,
    patterns,
    calc
}

% -----------------------------------------------------------------------------
% Mathematics
% -----------------------------------------------------------------------------
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{mathtools}
\RequirePackage{tensor}   
\RequirePackage{cancel}   
\allowdisplaybreaks

% -----------------------------------------------------------------------------
% Tables
% -----------------------------------------------------------------------------
\RequirePackage{tabularx}
\RequirePackage{booktabs}
\RequirePackage{longtable}

% Column type for title page
\newcolumntype{K}[1]{>{\centering\arraybackslash}b{#1}}

% -----------------------------------------------------------------------------
% Code listings
% -----------------------------------------------------------------------------
\RequirePackage{verbatim} % for code
\RequirePackage[numbered,framed]{matlab-prettifier} % for MATLAB code

\lstset{
    style              = Matlab-editor,
    basicstyle         = \linespread{0.9}\small\mlttfamily,
    escapechar         = ",
    mlshowsectionrules = true,
}

\lstset{literate=%
    {Ö}{{\"O}}1
    {Ä}{{\"A}}1
    {Ü}{{\"U}}1
    {ß}{{\ss}}1
    {ü}{{\"u}}1
    {ä}{{\"a}}1
    {ö}{{\"o}}1
    {~}{{\textasciitilde}}1
}

% -----------------------------------------------------------------------------
% Bibliography
% -----------------------------------------------------------------------------
\RequirePackage{csquotes}
\RequirePackage[backend=biber,style=numeric]{biblatex}


% -----------------------------------------------------------------------------
% URL handling
% -----------------------------------------------------------------------------
\RequirePackage{url}

% -----------------------------------------------------------------------------
% Headers and footers
% -----------------------------------------------------------------------------
\RequirePackage{scrlayer-scrpage} % header and footer
\pagestyle{headings}

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
    \ifthenelse{\equal{\@ifrlang}{ngerman}}%
    {Kurzfassung}%
    {Abstract}%
}
\newcommand{\MLOtherlangAbstract}[1]{%
  \ifthenelse{\equal{\@ifrlang}{ngerman}}%
  {\begin{otherlanguage}{UKenglish}\begingroup\renewcommand{\cleardoublepage}{}\renewcommand{\clearpage}{}\chapter*{\MLAbstract}\endgroup#1\end{otherlanguage}}%
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
                    {Vorgesetzter}%
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
                    {Prüfen}%
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
% Declaration page command
% -----------------------------------------------------------------------------

\newcommand{\makedeclaration}{%
    \addchap{\iflanguage{ngerman}%
        {Erklärung}%
        {Declaration}%
    }

    \addsec*{\ifdefstring{\@ifrlang}{ngerman}%
        {Urheberrecht}%
        {Copyright}%
        }

    \ifdefstring{\@ifrlang}{ngerman}{%
        Hiermit versichere ich, dass ich diese Arbeit selbständig mit Unterstützung der Betreuer angefertigt und keine anderen als die angegebenen Quellen und Hilfsmittel verwendet habe.
        Die Arbeit oder wesentliche Bestandteile davon sind weder an dieser noch an einer anderen Bildungseinrichtung bereits zur Erlangung eines Abschlusses eingereicht worden.\\
        \\
        Ich erkläre weiterhin, bei der Erstellung der Arbeit die einschlägigen Bestimmungen, insbesondere zum Urheberrechtsschutz fremder Beiträge, entsprechend den Regeln guter wissenschaftlicher Praxis\footnote{siehe \enquote{Leitlinien zur Sicherung guter wissenschaftlicher Praxis} der DFG bzw. \enquote{Satzung der Universität Stuttgart zur Sicherung der Integrität wissenschaftlicher Praxis und zum Umgang mit Fehlverhalten in der Wissenschaft}} eingehalten zu haben.
        Soweit meine Arbeit fremde Beiträge (z.B. in der Form von Bildern, Zeichnungen, Textpassagen) enthält, habe ich diese Beiträge als solche gekennzeichnet (z.B. Zitat, Quellenangabe) und eventuell erforderlich gewordene Zustimmungen der Urheber zur Nutzung dieser Beiträge in meiner Arbeit eingeholt.
        Für den Fall der Verletzung der Rechte Dritter durch meine Arbeit, erkläre ich mich bereit, der Universität Stuttgart einen daraus entstehenden Schaden zu ersetzen bzw. die Universität Stuttgart auf deren Aufforderung von eventuellen Ansprüchen Dritter freizustellen.
    }{%
        I hereby declare that I have written this thesis independently with the support of the supervisors and that I have not used any sources or aids other than those specified.
        Neither the full thesis nor any significant parts of it have already been submitted to this or any other educational institution to obtain a degree.\\
        \\
        I further declare that I have complied with the relevant provisions for the preparation of this thesis, especially regarding copyright protection of third-party contributions, in accordance with the rules of good scientific practice\footnote{cf. \enquote{Leitlinien zur Sicherung guter wissenschaftlicher Praxis} of the DFG or \enquote{Satzung der Universität Stuttgart zur Sicherung der Integrität wissenschaftlicher Praxis und zum Umgang mit Fehlverhalten in der Wissenschaft}}.
        Insofar as my work contains third-party contributions (e.g. in the form of images, drawings, text passages), I have marked these contributions as such (e.g. citation, source reference) and obtained any necessary consent from the authors to use their contributions in my work.
        In the event of infringement of the rights of third parties by my work, I declare myself willing to compensate the University of Stuttgart for any resulting damage and to indemnify the University of Stuttgart against any claims by third parties upon their request.
    }
    
    \addsec*{\ifdefstring{\@ifrlang}{ngerman}{Nutzungsrecht}{Right of Use}}
    \ifdefstring{\@ifrlang}{ngerman}{%
        Mir ist bekannt, dass die Arbeit im Online-Katalog der Bibliothek und auf der Institutswebseite erfasst wird, was eine dauerhafte, weltweite Sichtbarkeit der bibliographischen Daten der Arbeit zur Folge hat.
        \begin{itemize}
            \item[\raisebox{-3pt}{\huge$\square$}] Ich stimme der Nennung meines Namens und einer Kurzfassung der Arbeit zu diesem Zweck zu.
            \item[\raisebox{-3pt}{\huge$\square$}] Ich übertrage der Universität Stuttgart das Eigentum an einem von mir der Bibliothek des Instituts für Flugmechanik und Flugregelung kostenlos zur Verfügung gestellten Exemplars dieser Arbeit.
            Ich räume der Universität Stuttgart, Institut für Flugmechanik und Flugregelung, an dieser Arbeit und den im Rahmen dieser Arbeit entstandenen Arbeitsergebnissen ein kostenloses, zeitlich und räumlich unbeschränktes, einfaches Nutzungsrecht ein.
            Dieses erstreckt sich auf sämtliche bekannte Nutzungsarten und umfasst neben dem Recht auf Nutzung in Forschung, Lehre und Studium insbesondere das Recht der Vervielfältigung, Verbreitung und Änderung sowie das Recht der öffentlichen Zugänglichmachung.
        \end{itemize}
    }{%
        I am aware that the thesis will be recorded in the online catalog of the library and on the institute's website, which will result in permanent, worldwide visibility of the bibliographic data of the thesis.
        \begin{itemize}
            \item[\raisebox{-3pt}{\huge$\square$}] I agree to have my name and an abstract of the thesis mentioned for this purpose.
            \item[\raisebox{-3pt}{\huge$\square$}] I transfer ownership of a copy of this thesis to the University of Stuttgart, which I will provide free of charge to the library of the Institute of Flight Mechanics and Controls.
            I grant the University of Stuttgart, Institute of Flight Mechanics and Flight Control, a free, simple right of use, unlimited in time and space, to this thesis and the results produced in the course of this thesis.
            This extends to all known types of use and, in addition to the right to use in research, teaching, and study, includes in particular the right to reproduce, distribute, and modify the work, as well as the right to make it publicly available.
        \end{itemize}
    }
    
    \vspace{1cm}
    \parbox{7cm}{
        \hrule
        \strut \centering\footnotesize \ifdefstring{\@ifrlang}{ngerman}{Ort, Datum}{Place, Date}
    }
    \hfill
    \parbox{7cm}{
        \hrule
        \strut \centering\footnotesize \@ifrauthor
    }
}

% -----------------------------------------------------------------------------
% End of class
% -----------------------------------------------------------------------------
\endinput
