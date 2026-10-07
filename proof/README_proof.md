# Coq source for Paper 1

The clocked-LTL translation, its semantics, relaxation, reset completion, and
correctness proof are in the two direct dependency files below. They import
only Coq standard-library modules.

| File | Role |
|---|---|
| `MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v` | MTL syntax and semantics, formula-keyed clocks, clocked-LTL translation, automata, relaxation, reset completion, and the LTL-to-Büchi correctness contract |
| `EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v` | canonical reset policy, residual obligations, soundness/completeness, `EncodingCorrect_proved`, and `MTL_to_TBA_correct_with` |

From this directory, `make` compiles the core and then the main proof. The
Coq theorem with suffix `_with` takes backend correctness as an explicit
argument. The theorem does not use a project-specific axiom beyond that
contract; its standard-library assumptions are reported by `Print Assumptions`
in the source file.
