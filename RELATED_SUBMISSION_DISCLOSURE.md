# Related-submission disclosure: Paper 1 and Paper 2

**Prepared:** 2026-10-09  
**Purpose:** describe the distinct scientific scopes and source lineage of the two IEEE Access manuscript drafts.  
**Status limitation:** the workspace does not establish the live submission status of either manuscript. Do not infer submission, acceptance, rejection, or concurrent consideration from this file.

## Manuscript scopes

**Paper 1**, “A Mechanically Verified Translation of MTL$_{0,\infty}$ into Timed Büchi Automata,” establishes Rocq-checked soundness and completeness for the specified MTL-to-clocked-LTL encoding, including canonical completeness for formula-keyed shared clocks under repeated activations. It also proves relaxation and reset completion and states the explicit all-propositional-words backend contract. Its concrete alarm result proves that contract for a Rocq automaton record manually transcribed from a Spot graph. Paper 1 does not claim a new translation algorithm, a verified Spot implementation or importer, an integrated executable compiler, or performance results.

**Paper 2**, “Mechanically Verified Optimization and UPPAAL Export for Timed Büchi Automata,” studies downstream language-preserving TBA transformations, an extracted implementation, and an evaluation. Its generic transformation theorems apply to arbitrary input TBAs; it retains an upstream MTL-to-TBA development as a tool-chain dependency and treats Paper 1's formula-level correctness result as a prerequisite rather than a new Paper 2 result.

## Rocq source provenance

The current Paper 1 sources are under `Paper1_TSE/ieee_access/proof/`:

- `MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v` — SHA-256 `f0c8c308e61aaab12f5dc1efc6607860fa1d5fba963298436e51ef1f0be7848d`.
- `EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v` — SHA-256 `032e28bc3ebcf0bdbadbc7f58b9d5cbd6d39a4c66dd4dfeaa40ce5a3d77b1c66`.
- `OverlappingResponse_Example.v` — Paper 1's alarm backend instance and accepted/rejected trace results.

Paper 2 contains corresponding upstream files under `Paper2_Access/proof/`. The two pairs are **not byte-identical**:

| Module | Paper 1 SHA-256 | Paper 2 SHA-256 | Observed difference |
|---|---|---|---|
| Core | `f0c8c308e61aaab12f5dc1efc6607860fa1d5fba963298436e51ef1f0be7848d` | `21a7e0f9104fa6ad812657dd61e50b867c491b787adaa875cd75bbcb73fb9b37` | Paper 2 adds proof-side classical boolean/finite-selection helpers and uses an explicit `first_such` transition selector where Paper 1's completeness proof uses functional choice. The common theorem and lemma signatures compared in the files match; Paper 2 adds two helper lemmas. Imports, comments, and proof terms also differ. |
| Encoding proof | `032e28bc3ebcf0bdbadbc7f58b9d5cbd6d39a4c66dd4dfeaa40ce5a3d77b1c66` | `44c8458a079f70f1801f3e02009bd6deceb1e4ef5f4e02a16433461461422531` | The files have the same 74 lemma/theorem declarations with matching statements; Paper 2 routes its decision helper through the core's `decide_b` and has different proof scripts/imports. |

This is common source lineage with a Paper 2 variant, not reuse of a single bit-identical source snapshot. The differences are not merely organizational: Paper 2 adds proof-side boolean and finite-selection helpers and replaces Paper 1's choice-based transition witness with an explicit `first_such` selector. The common theorem/lemma signatures compared in the two upstream modules match (38 common core declarations and 74 encoding-proof declarations); no changed statement was found among those declarations. This is a source comparison, not a formal equivalence proof between the module versions.

The upstream assumptions were also compared by compiling copies of the two Paper 2 upstream modules and running `Print Assumptions` in an isolated temporary directory; the Paper 2 project files were not modified. `canonical_encoding_all` and `EncodingCorrect_proved` have matching reported library assumptions in the two snapshots. Paper 1's `MTL_to_TBA_correct_with` additionally depends on `IndefiniteDescription.constructive_indefinite_description`; the Paper 2 variant avoids that dependency through its explicit selector. In both snapshots, the conditional theorem does not depend on `LTL_TO_BUCHI_CORRECT`, while the convenience theorem `MTL_to_TBA_correct` does. The Paper 2 checked-in `ASSUMPTIONS_GENERIC.txt` covers downstream optimization/export results rather than this upstream comparison, so Paper 2 should retain or regenerate its own upstream assumptions report. The Paper 1 package identifies and hashes its exact Rocq snapshot; this disclosure does not certify Paper 2's full artifact.

## Exclusive results and overlap

Paper 1's exclusive result is the specified pointwise MTL$_{0,\infty}$ semantic-correctness development, including occurrence-indexed encoding correctness, one canonical reset trace for overlapping activations, relaxation, reset completion, and its conditional TBA composition. Paper 2's exclusive results begin with the generic downstream TBA transformations, their preservation proofs, extraction, and evaluation. The shared upstream formalization is a prerequisite in Paper 2's tool chain; it does not make the two manuscripts' contributions interchangeable. Neither manuscript should claim the other's exclusive results.

## Suggested editor disclosure

Update the bracketed statuses from the actual submission portal before sending:

> We are preparing two related but distinct manuscripts for IEEE Access. Paper 1 presents Rocq-checked semantic correctness for the specified MTL-to-TBA construction. Paper 2 presents generic TBA optimization and export proofs, an extracted implementation, and an evaluation. Paper 2 contains a non-byte-identical variant of the upstream MTL core and encoding proof used in Paper 1; the common theorem and lemma statements inspected match, while proof-side selector definitions and proof scripts differ. In the inspected Paper 2 variant, the explicit selector also avoids the indefinite-description assumption used by Paper 1's conditional theorem. Paper 2 treats the upstream result as a tool-chain prerequisite and does not claim it as a new Paper 2 result. Current status: Paper 1 [insert status] and Paper 2 [insert status]. We can provide both manuscripts and their source snapshots for editorial overlap assessment.

Do not upload the companion manuscript as public supplementary material. Provide it through the editor-only related-manuscript channel if requested. The actual portal questions and journal policies take precedence over this suggested wording.
