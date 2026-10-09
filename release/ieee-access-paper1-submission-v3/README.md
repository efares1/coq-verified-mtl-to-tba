# Paper 1: IEEE Access submission workspace

This directory contains the unified IEEE Access article source, its Rocq sources and examples, and the canonical reproduction entry point. The earlier TSE-formatted source is preserved outside this directory. The scientifically important arguments from the former supplement are integrated into `paper1.tex`; no separate supplement is currently needed.

## Build and reproduce

Requirements:

- Rocq 9.0.1 (the script's default is `C:\Rocq-Platform~9.0~2025.08\bin\rocq.exe`)
- Python 3 for the executable assurance checks
- MiKTeX or TeX Live with `pdflatex` and BibTeX
- The checked-in LaTeX source, figures, bibliography, and template assets

From PowerShell in this directory, run:

```powershell
.\reproduce-ieee-access.ps1
```

If the tools are elsewhere, pass explicit executable names or paths:

```powershell
.\reproduce-ieee-access.ps1 -RocqExe 'C:\path\to\rocq.exe' -PythonExe 'C:\path\to\python.exe'
```

The entry point copies the `.v` sources to a fresh temporary directory, compiles the core, correctness proof, and alarm example, independently checks the proof objects, regenerates the assumptions report and compares it with `proof/ASSUMPTIONS.txt` without overwriting that audit, runs the Spot-record consistency self-test and illustrative reset-policy scenarios, then compiles the article and bibliography. It stops on a failed stage. The checked declarations for major results are listed in the article's Rocq result map.

Spot graph regeneration is separate. `examples/spot/regenerate.sh` requires Spot 2.16 and may rewrite generated graph files; the canonical replay does not invoke it, and no regeneration result is claimed. The Python graph checker compares saved graph data with the Rocq record up to state renaming, but it is not a verified importer and does not prove Spot's semantics.

## Official IEEE Access template

The article uses the class and `spotcolor.sty` from the current IEEE Access LaTeX template archive linked by the [official article-preparation page](https://ieeeaccess.ieee.org/authors/preparing-your-article/). The archive is dated May 13, 2026; its SHA-256 is `60C7EFC9DB8AC9E8BDB31C550AD4E03CB6F258A878ECECC0BC690B6203E45A67`. The unmodified class SHA-256 is `67B73C4DA05479D592A9449C38A81FCC7779D78753085BB44199E7F2746B757D`. Its official template defaults print `VOLUME 11, 2023` and a blank DOI label in the draft PDF; no publication metadata has been invented. The publisher-assigned fields must be checked in the final submission output. The official class file was not modified.

The class's Pantone spot-color declaration caused the title and colored labels to render white in Poppler and MuPDF because the emitted named color resource could not be resolved. The article preamble now renders `accessblue` as a process CMYK color using the class's declared alternate values; the official class remains unmodified. The final 14-page PDF was rendered in both Poppler and MuPDF, and the title, abstract/index labels, section headings, figures, tables, and page content were visually inspected. The LaTeX log retains nonfatal `xcolor` compatibility warnings from the legacy spot-color state; neither PDF renderer reports an unresolved Pantone color-space error.

IEEE Access currently requires a double-column, single-spaced manuscript in its template, source/PDF agreement, biographies for all authors, 3--10 submission keywords, first-use acronym definitions, and section-level citations when AI-generated text is used. It strongly recommends fewer than 20 pages. The current source builds to 14 pages, including references and biographies. See the [official submission guidelines](https://ieeeaccess.ieee.org/authors/submission-guidelines/) and [AI disclosure policy](https://ieeeaccess.ieee.org/authors/preparing-your-article/).

## Assurance boundary

`MTL_to_TBA_correct_with` takes all-propositional-words backend language equivalence as an explicit premise. The convenience theorem `MTL_to_TBA_correct` also depends on the project axiom `LTL_TO_BUCHI_CORRECT`. The alarm example proves the backend contract for a manually transcribed Rocq record; it does not verify Spot or the graph-to-record conversion. Classical/library assumptions are recorded in `proof/ASSUMPTIONS.txt`. Zero-bound preprocessing, parsing, a concrete executable LTL backend, an executable MTL compiler, automaton export, and adaptation to zero-initialized clocks remain outside the verified result.

## Snapshot and publication status

The v3 directory and ZIP form the versioned IEEE Access package, with the exact source snapshot, matching PDF, proof sources, and SHA-256 manifest. It is prepared for submission as supplementary material. Repository availability does not constitute a public GitHub Release or tag, and no DOI or third-party replay is claimed. Rebuilds need not be byte-identical at the PDF level; the packaged PDF is the designated build.
