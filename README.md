# Paper 1 — IEEE TSE

This is a standalone LaTeX and Coq-source project for the MTL$_{0,\infty}$
translation paper. The main manuscript uses the IEEE Computer Society journal
layout (IEEEtran with journal,compsoc). The main PDF target is at most 12
pages including references. The detailed proof supplement is a separate PDF
and is not part of that count.

## Build the PDFs

With MiKTeX's pdflatex and bibtex on PATH, run in PowerShell:

    .\build.ps1

The script runs the LaTeX/BibTeX passes needed to settle citations and
cross-references. Outputs are build/paper1.pdf and build/supplement.pdf.
The project includes its IEEEtran class and bibliography style, cited
bibliography, figures, figure styles, and the small package files used by the
paper (cite, booktabs, enumitem, and mathtools).

The manuscript's proof claims and theorem names are tied to the source files
in proof/; no experiment or evaluation result is asserted in this paper.
The proof theorem assumes the LTL-to-Büchi semantic contract stated in the
paper. It does not claim that the external backend is verified.

## Coq source

The two files needed for the clock-encoding and MTL-to-TBA theorems are
included in proof/. From that directory, compile the core first, then the
proof file:

    coqc MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v
    coqc EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v

Only the direct translation and correctness dependencies are included here;
the generic optimization, export, initialization, and extraction sources are
kept in the separate Paper 2 project. Standard Coq library modules for real
arithmetic and classical reasoning are required.
