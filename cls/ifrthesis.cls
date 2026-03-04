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
\LoadClass[a4paper,
            11pt,
            DIV=14, % divisor for construction of type area
            BCOR=5mm, % binding correction
            twoside,
            openright,
            bibliography=totoc % include bibliography in table of contents
            ]{scrbook}

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
\RequirePackage[backend=biber,
                style=numeric,
                sorting=none]{biblatex}

% -----------------------------------------------------------------------------
% Nomenclature
% -----------------------------------------------------------------------------
%%% Nomenclature
\usepackage[intoc]{nomencl}
\makenomenclature
\renewcommand{\nomgroup}[1]{
  \item[\bfseries
  \ifstrequal{#1}{A}{\iflanguage{ngerman}{Abkürzungen}{Abbreviations}}{%
    \ifstrequal{#1}{B}{\iflanguage{ngerman}{Lateinische Buchstaben}{Latin Letters}}{%
      \ifstrequal{#1}{C}{\iflanguage{ngerman}{Griechische Buchstaben}{Greek Letters}}{%
        \ifstrequal{#1}{D}{\iflanguage{ngerman}{Indizes}{Indices}}{%
          }}}}
  ]
}
\renewcommand{\nomname}{\iflanguage{ngerman}{Nomenklatur}{Nomenclature}}


% -----------------------------------------------------------------------------
% Hyperref (loaded last)
% -----------------------------------------------------------------------------
\RequirePackage{hyperref}

% -----------------------------------------------------------------------------
% Thesis metadata commands
% -----------------------------------------------------------------------------
\newcommand{\ifrtitle}[1]{\def\@ifrtitle{#1}}
\newcommand{\ifrauthor}[1]{\def\@ifrauthor{#1}}
\def\@ifrtype{\MLBachelorsthesis} % Default to Bachelor's thesis if not specified
\newcommand{\ifrtype}[1]{%
  \ifthenelse{\equal{#1}{B}}{%
    \def\@ifrtype{\MLBachelorsthesis}%
  }{%
    \ifthenelse{\equal{#1}{M}}{%
      \def\@ifrtype{\MLMastersthesis}%
    }{%
      \def\@ifrtype{#1}%
    }%
  }%
}
\def\@ifryear{\the\year} % Default to current year if not specified
\newcommand{\ifryear}[1]{\def\@ifryear{#1}}
\newcommand{\ifrexaminer}[1]{\def\@ifrexaminer{#1}}

% Initialize supervisor variable as empty
\def\@ifrsupervisor{}

% Command to set supervisor(s) - can be called multiple times or with comma-separated list
\newcommand{\ifrsupervisor}[1]{%
  \ifx\@ifrsupervisor\@empty
    \def\@ifrsupervisor{#1}%
  \else
    \g@addto@macro\@ifrsupervisor{,#1}%
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
    \iflanguage{ngerman}%
    {Universität Stuttgart}%
    {University of Stuttgart}%
}
\newcommand{\MLInstitute}{%
    \iflanguage{ngerman}%
    {Institut für Flugmechanik und Flugregelung}%
    {Institute of Flight Mechanics and Controls}%
}
\newcommand{\MLMastersthesis}{%
    \iflanguage{ngerman}%
    {Masterarbeit}%
    {Master's Thesis}%
}
\newcommand{\MLBachelorsthesis}{%
    \iflanguage{ngerman}%
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
                \Large\textbf{\@ifryear}\\
                \vspace{3cm}
                {\large
                \begin{tabular}{@{}r l@{}}
                    \iflanguage{ngerman}
                    {Betreuer/Betreuerin}%
                    {Supervisor}: 
                    & \ifx\@ifrsupervisor\@empty
                        \textbf{No supervisors specified}%
                      \else
                        \@for\@supervisor:=\@ifrsupervisor\do{%
                            \@supervisor\@ifnotempty{\@supervisor}{\\ & }%
                        }%
                      \fi
                    \\
                    \iflanguage{ngerman}
                    {Prüfer/Prüferin}%
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
