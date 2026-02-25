# Thesis Template
This is a template for a (bachelor's or master's) thesis written in LaTeX at the Institute of Flight Mechanics and Controls (iFR).

## Preparation
Students may be tempted to directly fork this repository into their own Github account.
However, by default, a forked repository is public and thus visible to everyone.
To avoid problems regarding publication rights of the thesis content, it is recommended to instead clone the repository to the local machine using the following command:
```bash
git clone --recurse-submodules https://github.com/iFR-Lehre/Thesis-Template.git
```
At the same time it is advisable to synchronize this local repository with a remote one to avoid losing work when the local machine is damaged or lost.
The iFR hosts a non-public Gitlab server that can be used for this purpose.
The students are encouraged to approach the iFR administrators to get access to this server.

## Compilation
Any text editor can be used to edit the files of this template.
One way to compile them into a PDF document is to use the commands specified in the `makefile` that is included in the repository.

The more convenient option, however, is to use the [Visual Studio Code editor](https://code.visualstudio.com/) with the [LaTeX Workshop extension](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop).
This repository comes with a pre-configured `settings.json` file that includes two recipes for compiling the document.
The recipe `quick-preview` uses `pdflatex` to quickly compile the document and is executed automatically every time a tex file is saved.
Since a single run of `pdflatex` is generally not enough to update citations, indices, table of content, and references, the recipe is only intended for a quick preview of the document and should not be used for the final compilation.
The second recipe `full-build` uses `latexmk` to compile the document into a state that is ready for submission, which usually takes a little longer.
It is necessary to install the `latexmk` tool to use this recipe (see the [latexmk documentation](
https://mgeier.github.io/latexmk.html)).

## Language
This template should work for both English and German theses.
The language is chosen in the first line of the file `thesis.tex` when the document class is specified.
By providing either `english` or `ngerman` as an argument, the template automatically takes care of switching all the necessary terms like "Abstract" to "Kurzfassung".