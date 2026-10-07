(* Reproduce the global assumptions recorded in ASSUMPTIONS.txt. *)
Require Import MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.
Require Import EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.

Check EncodingCorrect_proved.
Print Assumptions EncodingCorrect_proved.
Check MTL_to_TBA_correct.
Print Assumptions MTL_to_TBA_correct.
Check MTL_to_TBA_correct_with.
Print Assumptions MTL_to_TBA_correct_with.
