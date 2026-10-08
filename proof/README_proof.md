# Rocq source for Paper 1

The clocked-LTL translation, its semantics, relaxation, reset completion, and
correctness proof are in the first two modules below. The third module gives a
proof-only instance of the end-to-end theorem. The development imports only
Rocq standard-library modules.

| File | Role |
|---|---|
| `MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v` | MTL syntax and semantics, formula-keyed clocks, clocked-LTL translation, automata, relaxation, reset completion, and the LTL-to-Büchi correctness contract |
| `EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v` | canonical reset policy, residual obligations, soundness/completeness, `EncodingCorrect_proved`, and `MTL_to_TBA_correct_with` |
| `OverlappingResponse_Example.v` | proof-only specialization to a bounded alarm-response formula, with a fixed infinite counterexample trace and conditional TBA rejection; backend equivalence remains an explicit premise |

The development was checked with Rocq 9.0.1 (OCaml 4.14.2, Rocq Platform
2025.08). The canonical PowerShell command block, including version checking,
per-command failure checks, independent checking, and assumption capture, is
maintained in the root [README](../README.md#rocq-proof). Run it from the
repository root so the generated assumption record is written to this folder.

The convenience theorem `MTL_to_TBA_correct` uses the core axiom
`LTL_TO_BUCHI_CORRECT`. The theorem with suffix `_with`, which is the one
stated in the paper, takes backend language equivalence as an explicit
argument. `CheckAssumptions.v` prints the assumptions of the encoding
theorem, both end-to-end theorems, the example specialization, the fixed-trace
violation lemma, and its conditional rejection corollary. The captured Rocq
9.0.1 output is preserved in `ASSUMPTIONS.txt`.

The proof-only alarm-response example defines the infinite trace with alarms
at times 0 and 2 and a handled event at time 4, proves that this trace violates
the formula, and derives its rejection by any backend satisfying the stated
equivalence condition. It does not construct a backend instance or produce an
exported automaton.
