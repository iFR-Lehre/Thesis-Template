# ==========================================================
# LaTeX Document Compilation Makefile
# ==========================================================
# Usage:
#   Unix/Linux/Mac:    make [all|clean|clean-all|help]
#   Windows:           ./make.exe [all|clean|clean-all|help]
# ==========================================================

# Main document filename (without .tex extension)
MAIN = thesis

# Silent mode flag (set SILENT=1 for quiet compilation)
SILENT ?= 0

# Compilation tools with silent options
ifeq ($(SILENT),1)
    LATEX-FULL = latexmk -silent -quiet
    LATEX-QUICK = pdflatex -interaction=batchmode -halt-on-error
    REDIRECT = > /dev/null 2>&1
    QUIET_FLAG = --quiet
else
    LATEX-FULL = latexmk
    LATEX-QUICK = pdflatex -interaction=nonstopmode
    REDIRECT =
    QUIET_FLAG =
endif

# File extensions to clean up
AUX_EXTENSIONS = aux bbl blg glg glo gls ilg ist lof log lot nlo nls toc glsdefs acn acr alg nlg out ps xml synctex
INTERMEDIATE_EXTENSIONS = bcf dvi fdb_latexmk fls pre nav snm synctex.gz
ALL_EXTENSIONS = $(AUX_EXTENSIONS) $(INTERMEDIATE_EXTENSIONS)

# Color codes for prettier output (works on most terminals)
GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
BLUE = \033[0;34m
NC = \033[0m # No Color


# ==========================================================
# TARGETS
# ==========================================================

.PHONY: all clean clean-all help quick full

# Compiles fully and deletes the auxiliary files
all: full
	@echo "$(GREEN)✓ Compilation successful!$(NC)"
	@echo "$(BLUE)Output file:$(NC) $(MAIN).pdf"
	$(MAKE) clean

# Full build
full:
	@echo "$(BLUE)Starting LaTeX compilation...$(NC)"
	@$(LATEX-FULL) $(LATEX_OPTS) $(MAIN)

# Quick compilation (single pass, no bibliography)
quick: $(MAIN).tex
	@echo "$(BLUE)Quick compilation (single pass)...$(NC)"
	@$(LATEX-QUICK) $(LATEX_OPTS) $(MAIN) && echo "$(GREEN)✓ Quick compilation done!$(NC)"


# Clean auxiliary files
clean:
	@echo "$(YELLOW)Cleaning auxiliary files...$(NC)"
	@for ext in $(ALL_EXTENSIONS); do \
		count=$$(find . -name "*.$$ext" -type f | wc -l); \
		if [ $$count -gt 0 ]; then \
			echo "  Removing *.$$ext ($$count file(s)) from all directories"; \
			find . -name "*.$$ext" -type f -delete; \
		fi; \
	done
	@echo "$(GREEN)✓ Auxiliary files cleaned!$(NC)"

# Clean all generated files (including PDF)
clean-all: clean
	@echo "$(YELLOW)Cleaning PDFs from root directory only...$(NC)"
	@if [ -f "$(MAIN).pdf" ]; then \
		echo "  Removing $(MAIN).pdf from root directory"; \
		rm -f "$(MAIN).pdf"; \
	fi
	@echo "$(GREEN)✓ All generated files cleaned!$(NC)"

# Display help information
help:
	@echo "$(BLUE)========================================$(NC)"
	@echo "$(GREEN)LaTeX Makefile Help$(NC)"
	@echo "$(BLUE)========================================$(NC)"
	@echo ""
	@echo "$(YELLOW)Available targets:$(NC)"
	@echo "  all        : Full compilation with bibliography + auxiliary file removal"
	@echo "  full       : Full compilation with bibliography"
	@echo "  quick      : Single-pass compilation (no bibliography)"
	@echo "  clean      : Remove auxiliary files (*.aux, *.log, etc.)"
	@echo "  clean-all  : Remove ALL generated files (including PDF)"
	@echo "  help       : Show this help message"
	@echo ""
	@echo "$(YELLOW)Usage:$(NC)"
	@echo "  make [target]"
	@echo "  ./make.exe [target]  (on Windows)"
	@echo ""
	@echo "$(YELLOW)Main document:$(NC) $(MAIN).tex"
	@echo "$(BLUE)========================================$(NC)"
