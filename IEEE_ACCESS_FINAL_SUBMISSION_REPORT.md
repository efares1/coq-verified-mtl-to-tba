# IEEE Access final submission preparation report

**Date:** 2026-10-09  
**Manuscript:** “A Mechanically Verified Translation of MTL$_{0,\infty}$ into Timed Büchi Automata”  
**Target article type:** Research Article

## Work completed

The latest Access manuscript in `ieee_access/` was treated as authoritative. The existing technical development and theorem statements were preserved; this was a targeted positioning, citation, formatting, and artifact pass, not a new mathematical revision. The former TSE files at the project root remain available as historical sources.

The final candidate is `release/ieee-access-paper1-submission-v3/`, with the distributable archive `release/ieee-access-paper1-submission-v3.zip`. The package contains the Access LaTeX source and matching build PDF, bibliography, template assets, figures, the three Rocq source modules plus the assumption checker and audit, Spot examples, assurance scripts, README, and SHA-256 manifest. `ieee_access/paper1.tex` is byte-identical to the packaged source, and `ieee_access/paper1.pdf` is byte-identical to the packaged PDF. The package contains no Paper 2 files or review reports. Its source and ZIP are tracked in the repository; no public release/tag, DOI, or journal upload has been made.

## Scientific positioning and manuscript changes

- The abstract and introduction retain the positive central result: earlier work established the mathematical translation, and this article supplies Rocq-checked correctness for the particular pointwise semantics and construction formalized here. The qualified sentence now says that, to the best of our knowledge, no previous published machine-checked soundness-and-completeness development has been identified for this particular construction and semantic model.
- The paper continues to credit Bulychev et al. and Li et al. for mathematical results. It does not claim a new algorithm, reset principle, or language-equivalence theorem, and it does not imply that Li et al. failed to handle overlapping obligations.
- The abstract/introduction contribution statements remain tied to the audited proof sources: eight primitive strict/non-strict cases; arbitrary consistent-reset soundness; canonical completeness for shared formula-indexed clocks under overlapping activations; occurrence-indexed structural correctness; mechanized relaxation/reset completion; and composition under an explicit backend contract.
- Section organization now correctly locates the alarm-response instance in Section V-G. The worked-example heading is a properly formatted subsection, replacing the malformed “a:” paragraph heading.
- First-use acronym expansions were checked separately in the abstract and main body for MTL, TBA, LTL, MITL, MLTL, PVS, DSL, AST, and higher-order logic (HOL); the acknowledgment defines artificial intelligence (AI) at first use. Citations and cross-references resolve in the final build.
- The conclusion describes both proved alarm trace outcomes: the accepted trace with overlapping alarms and the rejected trace that violates the deadline. It maintains the distinction between the proved contract for the manually transcribed Rocq record and the unverified Spot graph transcription.

### Related work and claim support

Chattopadhyay and Mamouras (2020) was already in `references.bib` but was not cited in the article; it is now cited in the introduction and related-work discussion. The comparison is based on the [author-hosted paper](https://kmamouras.github.io/papers/monitoring-RV%2720.pdf): their Coq development concerns online monitoring for past-time MTL with quantitative semantics over a discrete temporal domain and constructs Moore-style monitors, rather than the infinite-word MTL$_{0,\infty}$-to-TBA translation formalized here. The citation retains the existing verified publication metadata and DOI.

Xu and Miao's PVS-based MITL-to-fair-timed-automata work is included in the comparison. Only the publisher abstract was available for this review; the manuscript therefore reports the PVS implementation and construction scope described there, and makes no claim that a machine-checked correctness theorem is absent. Roohi and Viswanathan, Schimpf et al., and Wang et al. remain acknowledged as proof-assistant work on related MITL, LTL-to-Büchi, and MLTL transformations.

The manuscript no longer prints Li et al.'s Theorem 12/13 numbering. The analysis document reports those numbers in a dissertation reproduction, but the original ACM proceedings text could not be directly inspected during this pass; removing the numbers avoids overstating direct verification. The manuscript retains only the supported general description of Li et al.'s mathematical language equality and best-choice reset preservation. No claim is made that their result is a verbatim formalization target: the present Rocq model has distinct timestamp and initial-clock assumptions.

## IEEE Access formatting and PDF validation

The article builds to **14 pages**, including references and biographies. The first expanded AI definition pushed the last biography onto a fifteenth page; the final disclosure was shortened while retaining the system, affected sections, assistance types, and required citation statement. The end-of-document marker remains inside the last biography environment, and all biographies now fit on page 14. The article uses the unmodified official IEEE Access class/assets identified in `ieee_access/README.md`; no DOI or publication metadata was invented. The default `VOLUME 11, 2023` footer and blank DOI field remain because the public IEEE Access submission/preparation instructions reviewed do not state how these sample fields should be treated in an author-submitted draft.

The known white-on-white rendering issue was reproduced in prior output and traced to the template's named Pantone spot-color handling. The article preamble maps the accent color to the process CMYK alternate values declared by the class; the official class was not edited. The final package PDF was rendered page-by-page by **Poppler (`pdftoppm`) and MuPDF/PyMuPDF** (14 pages each). All pages were inspected in contact sheets from both engines, including title, abstract/index labels, numbered headings, figures, tables, theorem/proof content, references, and biographies. The title and headings are visible; no visible clipping, overlap, or hidden text was found. The LaTeX log still contains nonfatal `xcolor` compatibility and template output-routine/layout warnings; these did not correspond to visible rendering defects in either engine. The build has no unresolved citation/reference warning.

## Artifact and verification results

The canonical entry point was run from the candidate and again from a fresh extraction of the ZIP:

```powershell
Set-Location .\release\ieee-access-paper1-submission-v3
.\reproduce-ieee-access.ps1
```

Both replays completed successfully with Rocq 9.0.1. They compiled the packaged core, encoding proof, and alarm example; independently checked the compiled proof objects; regenerated the assumption report and compared it with the checked-in `proof/ASSUMPTIONS.txt` without overwriting that file; ran both available Python assurance checks; and compiled the Access manuscript and bibliography. The extracted-ZIP replay is the clean-package check. Spot graph regeneration was **not** run; the Python graph-record check is a consistency check, not a verified Spot importer. No Spot result beyond the saved examples and the proved Rocq record contract is claimed.

The checked declaration families include `EncodingCorrect_proved`, `canonical_encoding_all`, `MTL_to_TBA_correct_with`, `MTL_to_TBA_correct`, `alarm_response_spot_tba_correct`, and the accepted/rejected alarm trace results. The generic `MTL_to_TBA_correct_with` theorem carries its explicit propositional backend equivalence premise and Rocq library assumptions. The convenience `MTL_to_TBA_correct` additionally depends on the project axiom `LTL_TO_BUCHI_CORRECT`. The alarm backend contract is proved for the manually transcribed Rocq record. The artifact does not verify Spot, the graph-to-record path, an executable compiler, parsing, or zero-bound preprocessing.

The ZIP's **79 manifested files** were checked against `SHA256SUMS.txt`; every archived file matched. Key hashes:

| Item | SHA-256 |
|---|---|
| `paper1.pdf` | `7BBD83DCCEB7C8CF8DC6A3F5F0646D4D34737A23C85D7D489424D5815C613B76` |
| `paper1.tex` | `DF4928CC686B2DF1C2E238E872DF2A4C83172138A37EEC6A24CCEAF008FC805B` |
| `SHA256SUMS.txt` | `E1FF120A9E2D28C313752BE98D5C06040CAEAB58ABECADB2CC90EF58C4C1F5E4` |
| `ieee-access-paper1-submission-v3.zip` | `46C9875EF1B49839AAFE80A8CF204C0AA39F9B2DE957EEDA603946026875D125` |

During the final repository organization, a direct check found that the earlier v3 directory and ZIP contained a PDF with unresolved citation markers, even though the manifest listed the hash of the designated current PDF. The PDF was replaced by the byte-identical 14-page `ieee_access/paper1.pdf`; the leftover LaTeX auxiliary files were moved out of the package and preserved under `tmp/`; the manifest and portable ZIP were regenerated. The final ZIP's 79 manifest entries were checked against their archived bytes. No Rocq source or theorem was changed, and the full Rocq replay was not rerun during this filesystem reorganization; the earlier clean replay result above applies to the unchanged source and proof snapshot.

## Paper 1 / Paper 2 source provenance

`RELATED_SUBMISSION_DISCLOSURE.md` now distinguishes the papers' results and records each source snapshot. The two pairs of upstream modules are not byte-identical. Paper 2 has extra proof-side boolean and finite-selection helpers and replaces Paper 1's choice-based transition witness with an explicit `first_such` selector. A comparison found matching statements for 38 common core declarations and 74 encoding-proof declarations; this source inspection is not a formal equivalence proof of the modules.

The upstream Paper 2 modules were copied to an isolated temporary directory, compiled there with Rocq 9.0.1, and queried with `Print Assumptions`; the Paper 2 workspace was not changed. `canonical_encoding_all` and `EncodingCorrect_proved` report the same library-assumption families in the two snapshots. Paper 1's `MTL_to_TBA_correct_with` reports the additional `IndefiniteDescription.constructive_indefinite_description`; Paper 2's selector variant avoids it. Neither conditional theorem reports `LTL_TO_BUCHI_CORRECT`, while each convenience theorem does. Paper 2's checked-in `ASSUMPTIONS_GENERIC.txt` concerns downstream optimization/export theorems and is not a like-for-like upstream audit. The disclosure recommends that Paper 2 identify or regenerate its own upstream audit before making comparative assurance claims.

Paper 1 remains about the specified semantic correctness development and its composition. Paper 2 remains about generic downstream TBA transformations, UPPAAL-oriented export, extraction, and evaluation. No Paper 2 manuscript or proof was edited. The suggested editor disclosure leaves the actual portal status of both papers for the authors to fill in.

## AI-use disclosure

The current IEEE Access [submission guidelines](https://ieeeaccess.ieee.org/authors/submission-guidelines/) and [article-preparation instructions](https://ieeeaccess.ieee.org/authors/preparing-your-article/) require disclosure and citation of AI-generated manuscript content and require the acknowledgment to identify the system and the nature/location/extent of its use. The project's actual assistance was broader than copyediting: Codex drafted/edited explanatory prose, integrated proof explanations from the existing supplement, assisted with Rocq code for the accepted overlapping alarm trace, and assisted with LaTeX and reproduction-script changes. No AI-generated figure was identified. Accordingly, the manuscript keeps a short factual acknowledgment and section-end OpenAI Codex citations for the Abstract and Sections I–VIII. It contains no thanks or promotional claim and does not use the tool as evidence of a result. The authors remain responsible for checking and approving all content. The author's preference to omit an optional acknowledgment does not remove the disclosure requirement for this substantive use.

## Remaining author actions

See [`IEEE_ACCESS_AUTHOR_ACTION_CHECKLIST.md`](IEEE_ACCESS_AUTHOR_ACTION_CHECKLIST.md). Author-supplied facts and portal actions remain: verify author metadata/biographies and ORCID, confirm the actual status of Paper 1 and Paper 2, approve the factual AI disclosure and editor disclosure, provide funding/conflict declarations, enter final keywords and choose Research Article, and upload the matched source/PDF plus artifact through the portal. Authors should also confirm the treatment of the class's sample volume/DOI fields against submission-stage instructions and inspect the portal-rendered PDF. The artifact has not been submitted through the IEEE portal or published as a GitHub Release/tag.
