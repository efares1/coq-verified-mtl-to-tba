# How to submit the two related papers

Use one cover letter per manuscript. Upload the TSE letter with the TSE paper
and the IEEE Access letter with the IEEE Access paper. Address each to that
journal's editor-in-chief. The letters are for the editor, not individual peer
reviewers. If a submission portal offers a cover-letter upload, use that. If it
offers only a confidential editor-comments box, paste the corresponding letter
there.

## What to disclose

The papers should identify their relationship openly. Paper 2 cites the TSE
manuscript. Paper 1 now cites the companion IEEE Access manuscript. Both cite
the exact shared upstream Rocq translation proof. Paper 1 claims the translation
and its correctness theorem; Paper 2 treats that theorem as a prerequisite and
claims generic TBA optimization and export proofs, an extracted implementation,
and its evaluation. This is a disclosure of two distinct companion articles,
not a claim that either article is under consideration at both journals.

The shared source files are
`proof/MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v` and
`proof/EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v`. The
additional Paper 2 pass proofs are
`proof/MTL_to_TBA_Invariants.v`, `proof/MTL_to_TBA_Optimizations.v`, and
`proof/MTL_to_TBA_Export.v`.

## What to upload

At each journal, answer the submission questions about related or concurrent
submissions accurately. If the portal has a related-manuscript or editor-only
file category, upload the complete companion paper there so the editor can
inspect the overlap. If it has no such category, disclose the companion in the
confidential editor-comments field and follow the portal's instructions for
providing the related manuscript. Do not include the other paper as public
supplementary material.

Use the same companion-paper version that is being submitted to the other
journal. Before submission, check that the portal's author list and
corresponding-author contact match the manuscript.

## Files

- `submission_letters/IEEE_TSE_Cover_Letter.pdf` and the `.tex` source are for
  the TSE submission.
- `submission_letters/IEEE_Access_Cover_Letter.pdf` and the `.tex` source are
  for the IEEE Access submission.
