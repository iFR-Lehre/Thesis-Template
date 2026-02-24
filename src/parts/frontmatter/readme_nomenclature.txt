Hinweise zur Benutzung der automatischen Nomenklatur.

1. 	Nomenklatur Block im Dokumenten Header einkommentieren:
		%==================================================================
		%Einheiten
		\usepackage{units}
		%%Nomenklauturpaket
		\usepackage[intoc]{nomenclTRi_A4}
		\renewcommand{\nomname}{}
		%Definition der Einheitenspalte
		\newcommand{\nomenunit}[1]{\hskip-0em\parbox{4em}{$\left[ #1 \right]$}}
		
		\makenomenclature
		%==================================================================

2. 	Zeile im Dokument zum Einbinden der Nomenklatur einkommentieren:
		%\input{src/parts/frontmatter/nomenclature.tex}

3. 	Die Variablen für die Nomenklatur können irgendwo im Dokument stehen. Beispiele befinden sich in ./src/parts/frontmatter/nomenclature.tex.

4. 	Die folgende Anweisung gilt für MikTex in Kombination mit TexWorks als Editor:
	- einmal mit pdflatex.exe kompilieren
	- einmal mit makeindex.exe und folgenden Argumenten komplilieren:
		makeindex.exe
		  $basename.nlo
		  -s
		  nomencl.ist
		  -o
		  $basename.nls
	- erneut mit pdflatex.exe kompilieren
	
#### english below ####

Instructions for using the automatic nomenclature.

1. Comment out the nomenclature block in the document header:
        %==================================================================
        %Units
        \usepackage{units}
        %%Nomenclature package
        \usepackage[intoc]{nomenclTRi_A4}
        \renewcommand{\nomname} {}
        %Definition of the units column
        \newcommand{\nomenunit}[1]{\hskip-0em\parbox{4em}{$\left[ #1 \right]$}}
        
        \makenomenclature
        %==================================================================

2.  Comment out the line in the document to include the nomenclature:
		%\input{src/parts/frontmatter/nomenclature.tex}

3.	The variables for the nomenclature can be located anywhere in the document. Examples can be found in ./src/parts/frontmatter/nomenclature.tex.

4.  The following instructions apply to MikTex in combination with TexWorks as the editor:
		- Compile once with pdflatex.exe
		- Compile once with makeindex.exe and the following arguments:
			makeindex.exe
			$basename.nlo
			-s
			nomencl.ist
			-o
			$basename.nls
		- Compile again with pdflatex.exe
	