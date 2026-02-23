# LaTeXmk configuration for modern LaTeX workflows

# Engine configuration with better defaults
$pdflatex = 'pdflatex --shell-escape --file-line-error --synctex=-1 --interaction=nonstopmode %O %S';
$lualatex = 'lualatex --shell-escape --file-line-error --synctex=-1 --interaction=nonstopmode %O %S';

# Preferred PDF engine (1 = pdflatex, 2 = lualatex, 3 = xelatex)
$pdf_mode = 1;

# Clean up intermediate files more thoroughly
$clean_ext = 'aux bbl blg brf idx ilg ind lof log lot out toc synctex.gz fls fdb_latexmk run.xml bcf';
$bibtex_use = 2;  # Enable automatic .bbl cleanup

# Force recompilation when these files change
$force_mode = 1;

# Enable preview of PDF after compilation
$pvc_view_file_via_temporary = 0;  # Use actual PDF for preview

# Glossaries and acronyms processing
add_cus_dep('glo', 'gls', 0, 'run_makeglossaries');
add_cus_dep('acn', 'acr', 0, 'run_makeglossaries');

sub run_makeglossaries {
    my $base = $_[0];
    my $quiet = $silent ? '-q' : '';
    
    # Try makeglossaries-lite first (no Perl dependency), fall back to full makeglossaries
    if (system("which makeglossaries-lite > /dev/null 2>&1") == 0) {
        system("makeglossaries-lite", $quiet, $base);
    } else {
        system("makeglossaries", $quiet, $base);
    }
}

# Nomenclature/index processing
add_cus_dep('nlo', 'nls', 0, 'run_makeindex_nlo');

sub run_makeindex_nlo {
    my $base = $_[0];
    my $quiet = $silent ? '-q' : '';
    
    if ($silent) {
        system("makeindex $quiet $base.nlo -s nomencl.ist -o $base.nls -t $base.nlg");
    } else {
        system("makeindex $base.nlo -s nomencl.ist -o $base.nls -t $base.nlg");
    }
}

# Bibliography processing with biber support
add_cus_dep('aux', 'bbl', 0, 'run_biber');

sub run_biber {
    my $base = $_[0];
    my $quiet = $silent ? '--quiet' : '';
    
    if (-e "$base.bcf") {
        # biber is used
        if ($silent) {
            system("biber", $quiet, $base);
        } else {
            system("biber", $base);
        }
        return 0;  # Success
    }
    return 1;  # No biber run needed
}

# Index processing
add_cus_dep('idx', 'ind', 0, 'run_makeindex');

sub run_makeindex {
    my $base = $_[0];
    my $quiet = $silent ? '-q' : '';
    
    if (-e "$base.idx") {
        system("makeindex $quiet $base.idx");
    }
}

# Additional dependency for custom glossary styles
add_cus_dep('glg', 'gls', 0, 'run_makeglossaries');

# Error handling and diagnostics
$warning_level = 1;  # Show all warnings
$recorder = 1;       # Enable file recorder
$max_repeat = 5;     # Maximum number of compilation cycles

# Custom rules for specific file types
push @generated_exts, 'glo', 'gls', 'glg', 'acn', 'acr', 'alg', 'nlo', 'nls', 'nlg';

# Precompile preamble for faster compilation (for large documents)
$preamble = 'myformat.fmt';
$do_cd = 1;  # Change to source file directory

# Progress display
$display_time = 1;  # Show compilation time
$show_time = 1;     # Show time information

# Custom commands for common workflows
$latex = 'latex --interaction=nonstopmode %O %S';
$dvipdf = 'dvipdf %O %S';

# End of configuration