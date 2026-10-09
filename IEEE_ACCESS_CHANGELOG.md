# IEEE Access preparation changelog — Paper 1

**Date:** 2026-10-09  
**Scope:** local preparation of `ieee_access/` and root submission-support documents. No changes were made to the existing Rocq correctness results.

## Manuscript and proof presentation

- Created an Access-specific source and PDF under `ieee_access/`; retained the root TSE-formatted manuscript and its files for recovery.
- Converted the draft's document structure to the local IEEE Access class and added required keywords, acknowledgments/disclosure, biographies already present in the related project, and article-level sources.
- Corrected IEEE Access top-matter ordering so the abstract and index terms are rendered in the compiled article, and expanded technical abbreviations at first body use as required by the current submission checklist.
- Integrated the mathematically substantive former supplement into the main paper: reset completion, relaxation, eight primitive soundness families, canonical completeness under repeated activations, path-indexed structural equivalence, full correctness composition, the Rocq result map, and the alarm TBA listing.
- Consolidated overlapping explanations after integration. The old supplement is not retained because it would duplicate the main article; no essential proof argument was moved out of the main paper.
- Kept the claim limited to formalizing an established translation. No new algorithm, optimized clock policy, verified parser/compiler, verified Spot executable/importer, or performance result is claimed.
- Preserved the manual Rocq alarm-record contract and distinguished it from the external Spot graph and DOT transcription.

## Artifact and reproduction

- Added `ieee_access/reproduce-ieee-access.ps1` as the canonical replay entry point. It compiles Rocq modules from `.v` sources in a fresh temporary directory, independently checks compiled proof objects, regenerates and compares the assumptions report without overwriting it, runs available Python checks, and builds the article.
- Updated `CheckAssumptions.v` to print assumptions for `canonical_encoding_all` alongside the designated theorem families; regenerated and checked `ASSUMPTIONS.txt`.
- Added the Access build script, build README and source/boundary documentation. Spot regeneration is not run and is not claimed.
- Replayed the package in an isolated candidate copy. Rocq source compilation, independent `rocq check`, assumptions comparison, the available Python assurance checks, and LaTeX/BibTeX build passed. The reproduction driver reports the Spot regeneration boundary.
- Re-extracted the final ZIP into a clean temporary location, verified all 77 manifest entries, and ran the same complete reproduction entry point successfully from that extracted package.
- Local release candidate: `release/ieee-access-paper1-submission-v1/` (78 files including manifest); ZIP size 1,797,976 bytes. Candidate PDF SHA-256: `ACB7D961D603E1C58E3BC915B2F3C10EA2BFF382E1194784D682B779C5C27ACD`; manifest SHA-256: `533B3B6B4FE4F54C53DC32179172FD780F8ACBB1FA22F0307E92A526A3261EB1`; ZIP SHA-256: `1782198D8359B967D403A5FE065D97925B09E173459687974499A2D459832EE7`.
- Access PDF: 13 pages. After the abstract/top-matter correction, all 13 final pages were rendered and visually inspected; no clipped formulas, figures, tables, or proof text were found. Final log has no unresolved citation/reference warning; two small line overfulls and local class output-routine width warnings remain. The class produces no visible page overflow in the rendered PDF.
- No supplemental manuscript remains. Spot regeneration, external replay, and paper upload/publication were not performed.

## IEEE Access template limitation

The live IEEE Access preparation page was checked and its current IEEE-hosted May 2026 LaTeX archive was identified. Downloading the archive failed in this environment. The buildable local `ieeeaccess.cls` and its assets were copied unchanged from the companion Paper 2 workspace; that class contains project-specific modifications documented there and is not verified byte-identical to the current IEEE archive. The class itself was not edited. This is a mandatory pre-submission replacement/rebuild item. Consequently, the local PDF is an integrated, visually checked draft, not yet an officially template-verified final portal PDF.

## Final expansion and official-template update (2026-10-09)

- Retrieved the official IEEE Access May 13, 2026 LaTeX archive linked by IEEE Access. Replaced the local modified class with the archive's unmodified class and `spotcolor.sty`; SHA-256 provenance is recorded in `ieee_access/README.md` and `IEEE_ACCESS_SUBMISSION_CHECKLIST.md`. This resolves the template limitation stated above.
- Clarified the introduction's assurance contribution without attributing a new construction or reset principle. The existing supplement's substantive arguments remain integrated in the main article; reset completion, relaxation, all eight primitive cases, canonical residual invariants, occurrence-indexed induction, theorem composition, Rocq map, and alarm record are presented once at their proof locations.
- Added and checked `alarm_overlap_trace_satisfies` and `alarm_overlap_trace_accepted_by_spot_tba`, an accepted overlapping-request trace for the existing one-clock alarm instance. The new corollaries are derived through the proved MTL theorem and concrete Rocq-record backend contract. Existing violating-trace results remain unchanged. No two-clock formal backend example or Spot regeneration is claimed.
- Improved the Spot illustration with edge IDs and an edge-key table, and added a two-direction proof-dependency diagram. Shortened the optional Spot-replay note and the proof diagram caption after inspecting the rendered PDF.
- Updated the Access reproduction documentation, disclosed AI-assisted text and trace-code support with section-level Codex citations, and corrected bibliographic status: the QEST+FORMATS work is cited at its September 2026 preprint, while the Science of Computer Programming paper scheduled for January 2027 is explicitly described as forthcoming.
- The complete `reproduce-ieee-access.ps1` replay passed with Rocq 9.0.1, including compilation, independent proof-object checking, assumptions comparison, both Python assurance checks, and LaTeX/BibTeX build. Spot graph regeneration was not run. The official-class PDF has 14 pages; it was rendered for visual inspection. The page count is higher than the prior 13-page candidate because the proof presentation and required source/bibliographic matter have expanded; no filler was added.
- New local snapshot: `release/ieee-access-paper1-submission-v2/` plus matching ZIP. The v1 snapshot and historical TSE artifact are preserved. No public release, remote tag, upload, or DOI was created.
- The final PDF visibly inherits the official template's default `VOLUME 11, 2023` footer and blank DOI label. No class override or invented publication metadata was added; authors should confirm the submission-stage treatment.

## Related manuscript

- Updated `RELATED_SUBMISSION_DISCLOSURE.md` to identify shared Rocq modules, results exclusive to each paper, and an accurate disclosure text without asserting an undocumented submission status.
- Corrected Paper 2's stale description of Paper 1 as a TSE companion, in the two writable companion-project files, without modifying Paper 2's scientific claims or PDF.

## Changes intentionally not made

- No source proof term, theorem statement, or mathematical result was changed to alter correctness.
- No changes were made to the original root TSE manuscript, supplement, proof-detail source, or root compiled PDFs as part of Access conversion.
- No Paper 2 scientific content, proof, or compiled PDF was altered.
- No commit, remote tag, public GitHub release, upload, DOI, or external publication was created.
- No author ORCID, biography fact, photo, IEEE membership grade, funding, conflict, or submission status was invented.

## Final targeted submission cleanup (2026-10-09)

- Preserved the qualified first-mechanization positioning for this specified construction and semantic model; retained the prior technical proof expansion and did not alter theorem statements or proof sources.
- Cited the already-bibliographed Chattopadhyay--Mamouras RV 2020 paper in the related-work comparison, based its description on the full author-hosted paper, and avoided a claim about Xu--Miao proof coverage that could not be confirmed from the accessible publisher abstract.
- Removed Li et al.'s Theorem 12/13 numbering from the manuscript because the original ACM proceedings PDF was not directly inspected. The general mathematical language-equality and best-choice reset claims remain.
- Corrected the article organization reference to Section V-G, fixed the worked-example heading, checked abstract/body acronym first-use definitions, and retained the accepted and rejected verified alarm traces.
- Reproduced and visually rechecked the PDF with Poppler and MuPDF. The title/heading rendering is legible on all 14 pages after the process-CMYK color mapping; the official class remains unmodified. Nonfatal xcolor/template log warnings remain documented.
- Defined higher-order logic (HOL) at first use, and AI at first use in the required disclosure. Condensed the disclosure after visual inspection caught the last biography spilling to a fifteenth page; all biographies now fit on page 14.
- Prepared `release/ieee-access-paper1-submission-v3/` and its ZIP from the final Access source. The full reproduction entry point passed both in that candidate and from a fresh ZIP extraction; all 79 manifested files passed SHA-256 comparison. Spot graph regeneration was not run.
- Compared Paper 1/Paper 2 upstream sources and theorem assumptions without editing Paper 2. The updated disclosure records the nonidentical source snapshots, matching inspected declaration signatures, and the Paper 2 selector variant's smaller assumption set for the conditional theorem.
- Added `IEEE_ACCESS_FINAL_SUBMISSION_REPORT.md` and `IEEE_ACCESS_AUTHOR_ACTION_CHECKLIST.md`. At the end of that submission-preparation pass, the local artifact had not been pushed, tagged, uploaded, or given a DOI.

## Workspace organization and final package sync (2026-10-09)

- Moved the former root-level TSE working tree, including its LaTeX source, supplement, bibliography, figures, proof snapshot, examples, and build scripts, into `archive/tse-workspace/`. Added an archive README and made the root README identify `ieee_access/paper1.tex` as the canonical editable Access source and the v3 copy as a frozen release snapshot.
- Rechecked the current Access source and v3 package. Their `paper1.tex` files are byte-identical. The older v3 package PDF had stale unresolved citation markers and leftover LaTeX build intermediates, despite the manifest naming the current PDF hash. Replaced the package PDF with the exact current 14-page PDF, moved the auxiliary files to `tmp/`, regenerated the manifest and ZIP, and verified all 79 manifest entries against the ZIP contents.
- Current SHA-256 values: manuscript PDF `7BBD83DCCEB7C8CF8DC6A3F5F0646D4D34737A23C85D7D489424D5815C613B76`; manifest `E1FF120A9E2D28C313752BE98D5C06040CAEAB58ABECADB2CC90EF58C4C1F5E4`; ZIP `46C9875EF1B49839AAFE80A8CF204C0AA39F9B2DE957EEDA603946026875D125`.
- Added .gitattributes to prevent line-ending conversion from invalidating the checksummed v3 directory on Windows checkouts; the ZIP is also included as the portable exact package.
- This organizational pass did not change Rocq sources or theorem statements and did not rerun Rocq. The prior replay outcomes remain documented in the final submission report; Spot regeneration remains unclaimed.
