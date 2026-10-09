# IEEE Access submission checklist — Paper 1

**Target type:** Research Article  
**Guidance checked:** October 9, 2026  
**Current source/PDF:** [`ieee_access/paper1.tex`](ieee_access/paper1.tex), [`ieee_access/paper1.pdf`](ieee_access/paper1.pdf); 14 pages after the final build.

The current IEEE Access guidelines require the Access template, a matching source and PDF, author biographies, first-use acronym definitions (including in the main text if first defined in the abstract), 3–10 portal keywords, and section-level AI citations when generated text is present. The portal requests a manuscript type and recommends **Research Article** when uncertain. It strongly recommends fewer than 20 pages. [Submission checklist and article types](https://ieeeaccess.ieee.org/authors/submission-guidelines/) · [AI and article-preparation policy](https://ieeeaccess.ieee.org/authors/preparing-your-article/).

## Completed in the local submission candidate

- [x] The main article integrates the substantive proof material from the former supplement; no repetitive proof supplement is retained.
- [x] The latest IEEE Access class and assets are used unchanged; provenance and checksums are documented in `ieee_access/README.md`.
- [x] The abstract and body define MTL, TBA, LTL, MITL, MLTL, PVS, DSL, and AST at first use in their respective text contexts.
- [x] Li et al. are credited for the established mathematical language-equivalence and best-choice reset results. The manuscript avoids Theorem 12/13 numbering because the original ACM proceedings PDF could not be directly inspected; the source limitation is recorded in the final submission report.
- [x] Chattopadhyay and Mamouras (2020) are cited for their Coq-verified past-time MTL online-monitor construction, with the discrete-time quantitative monitor scope distinguished from this TBA result.
- [x] Xu and Miao are described cautiously: the accessible publisher abstract reports a PVS implementation, and no stronger claim about proof coverage is made.
- [x] The mandatory neutral AI disclosure identifies OpenAI Codex, the affected Abstract and Sections I–VIII, the nature of prose and code assistance, and the required section-end citations. It contains no thanks or promotional language.
- [x] The exact source/proof/PDF artifact is versioned under `release/ieee-access-paper1-submission-v3/` with a ZIP and checksum manifest. Repository tracking is not a DOI, immutable release, or IEEE portal submission.
- [x] The updated Paper 1/Paper 2 disclosure identifies the non-byte-identical source variants and their measured hashes.
- [x] No public tag, GitHub release, DOI, or submission status is claimed.

## Author and portal actions

- [ ] Confirm author order, names, affiliations, email addresses, corresponding author, and biographies.
- [ ] Associate the submitting author's publicly visible, populated ORCID with the IEEE account.
- [ ] Select **Research Article** and enter 3–10 accurate keywords in the portal.
- [ ] Approve the mandatory AI acknowledgment and its section citations; confirm that the description matches the authors' account of Codex use.
- [ ] Confirm Paper 1 and Paper 2 submission statuses; update and submit the related-manuscript disclosure through the editor-facing channel if required.
- [ ] Upload the LaTeX source, matching PDF, and v3 reproducibility archive as review/supplementary material. Confirm the portal-generated submission matches the local PDF.
- [ ] Check the template's `VOLUME 11, 2023` and blank DOI placeholders against the live submission/production instructions. The official public preparation and submission pages inspected do not specify how those draft fields should appear at submission; they were not edited and no metadata was invented.
- [ ] Confirm any funding, conflict-of-interest, and other portal declarations from author-supplied facts.

## Reproduction and assurance boundary

Canonical command: `.\reproduce-ieee-access.ps1` from the `ieee_access` directory. Requirements are Rocq 9.0.1, Python 3, `pdflatex`, and BibTeX. The command does not regenerate the Spot graph. The Python Spot-record check is not a verified importer. The theorem retains its documented backend contract and Rocq logical/library assumptions, existential initial clocks, strict divergent timestamps, event-guarded TBA model, and nonmechanized zero-bound preprocessing boundary.
