# Coq source for Paper 1

The clocked-LTL translation, its semantics, relaxation, reset completion, and
correctness proof are in the two direct dependency files below. They import
only Coq standard-library modules.

| File | Role |
|---|---|
| `MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v` | MTL syntax and semantics, formula-keyed clocks, clocked-LTL translation, automata, relaxation, reset completion, and the LTL-to-Büchi correctness contract |
| `EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v` | canonical reset policy, residual obligations, soundness/completeness, `EncodingCorrect_proved`, and `MTL_to_TBA_correct_with` |

The development was checked with Rocq 9.0.1 (OCaml 4.14.2, Rocq Platform
2025.08). From PowerShell, set `$RocqBin` to the Platform `bin` directory and
run:

```powershell
$RocqBin = 'C:\Rocq-Platform~9.0~2025.08\bin'
Push-Location proof
& (Join-Path $RocqBin 'rocq.exe') compile MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v
& (Join-Path $RocqBin 'rocq.exe') compile EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v
& (Join-Path $RocqBin 'rocq.exe') check -silent MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof
Pop-Location
```

The Rocq theorem with suffix `_with` takes backend correctness as an explicit
argument. The theorem does not use a project-specific axiom beyond that
contract; its standard-library assumptions are reported by the `Print
Assumptions` command in the proof source.
