# Related manuscript disclosure

Customize the bracketed submission-status sentence in each cover letter and
attach the complete companion manuscript. The two papers share the same Rocq
translation proof modules; Paper 2 extends the pipeline after TBA construction.

The shared proof sources are `proof/MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v`
and `proof/EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v` in both
repositories. Paper 2's additional generic pass proofs are in
`proof/MTL_to_TBA_Invariants.v`, `proof/MTL_to_TBA_Optimizations.v`, and
`proof/MTL_to_TBA_Export.v`.

## Cover letter for Paper 1 (IEEE TSE)

Our related manuscript, “Mechanically Verified Optimization and UPPAAL Export
for Timed Büchi Automata,” is [submitted to / under consideration at / being
prepared for] IEEE Access. The manuscripts share the Rocq development for the
upstream MTL-to-TBA translation, including the shared-clock correctness proof.
This TSE submission presents that translation result, particularly its
completeness argument under overlapping activations. The IEEE Access
manuscript reuses the same proof as its upstream component and adds distinct
generic TBA optimization and export proofs, an extracted implementation, and
benchmark and UPPAAL case-study evaluation. This TSE submission does not claim
those downstream results. We provide both manuscripts so the editor can assess
the overlap and the separate contributions.

## Cover letter for Paper 2 (IEEE Access)

Our related manuscript, “A Mechanically Verified Translation of
MTL$_{0,\infty}$ into Timed Büchi Automata,” is [submitted to / under
consideration at / being prepared for] IEEE Transactions on Software
Engineering. The manuscripts share the Rocq development for the upstream
MTL-to-TBA translation, including the shared-clock correctness proof. This
IEEE Access submission reuses that proof as the upstream component of the
integrated tool; it does not present the translation proof as a new result.
Its distinct contributions are generic language-preservation proofs for TBA
optimization and UPPAAL-oriented export, the extracted implementation, and the
evaluation. We provide both manuscripts so the editor can assess the overlap
and the separate contributions.

Before sending, replace the bracketed status with the actual status and confirm
that the attached manuscripts and included Rocq proof modules match the
versions submitted to each journal.
