# Paper 1 — IEEE TSE

This is a standalone LaTeX and Rocq-source project for the MTL$_{0,\infty}$
translation paper. The main manuscript uses the IEEE Computer Society journal
layout (IEEEtran with journal,compsoc). The main PDF target is at most 12
pages including references. The detailed proof supplement is a separate PDF
and is not part of that count.

## Build the PDFs

With MiKTeX's pdflatex and bibtex on PATH, run in PowerShell:

    .\build.ps1

The script runs the LaTeX/BibTeX passes needed to settle citations and
cross-references. The final PDFs are copied to the project root as
paper1.pdf and supplement.pdf; build/paper1.pdf and build/supplement.pdf
are retained as the compiler outputs.
The project includes its IEEEtran class and bibliography style, cited
bibliography, figures, figure styles, and the small package files used by the
paper (cite, booktabs, enumitem, and mathtools).

The manuscript's proof claims and theorem names are tied to the source files
in proof/; no experiment or evaluation result is asserted in this paper.
The proof theorem assumes the LTL-to-Büchi semantic contract stated in the
paper. It does not claim that the external backend is verified.

## Intended use and artifact boundary

This is a proof artifact for developers of dense-time MTL verification tools.
It verifies the semantic translation core and the formula-keyed clock policy
under overlapping activations; it is not an executable compiler from MTL text
to a timed automaton. The theorem targets event-guarded automata without
location invariants and with existential initial clock valuations. A tool
using conventional zero-initialized clocks needs a separate adapter, and a
complete tool still needs input parsing, finite-bound encoding, a backend
whose correctness meets the stated contract, and automaton export.

## Rocq proof

The included proof was checked with Rocq 9.0.1 (OCaml 4.14.2, Rocq Platform
2025.08). In PowerShell, set `$RocqBin` to the Platform `bin` directory,
then compile and independently check both modules:

    $RocqBin = 'C:\Rocq-Platform~9.0~2025.08\bin'
    Push-Location proof
    & (Join-Path $RocqBin 'rocq.exe') --version
    & (Join-Path $RocqBin 'rocq.exe') compile MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v
    & (Join-Path $RocqBin 'rocq.exe') compile EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v
    & (Join-Path $RocqBin 'rocq.exe') check -silent MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof
    Pop-Location

Only the direct translation and correctness dependencies are included here;
the generic optimization, export, initialization, and extraction sources are
kept in the separate Paper 2 project. Standard Rocq library modules for real
arithmetic and classical reasoning are required.

The convenience theorem `MTL_to_TBA_correct` uses the core axiom
`LTL_TO_BUCHI_CORRECT`. The theorem `MTL_to_TBA_correct_with`, stated in the
paper, takes backend language equivalence as an explicit argument. To
reproduce the assumption record after compiling the two modules above, run
from `proof/`:

& (Join-Path $RocqBin 'rocq.exe') compile CheckAssumptions.v | Out-File -FilePath ASSUMPTIONS.txt -Encoding utf8
if ($LASTEXITCODE -ne 0) { throw 'Assumptions check failed' }

## Spot backend example

The left automaton in the worked example is a TikZ redraw of the Spot 2.16
output saved in `examples/spot/worked_translation.dot`. From the repository
root in WSL with Spot 2.16 installed, regenerate that output with:

    bash examples/spot/regenerate.sh

The script checks the Spot version and records the exact clocked-LTL input
and command. `worked_translation.tex` explains how the propositional cubes
are reinterpreted as timed transitions and which later simplifications are
outside the theorem. The fixed example demonstrates the propositional backend
stage; it does not run the Rocq translation or verify Spot against the backend
contract. The reset-completed TBA is shown in the paper, while general
relaxation, initialization adaptation, and export are not implemented by this
script.
