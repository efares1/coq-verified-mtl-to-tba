(* A proof-only instance of the verified MTL-to-TBA theorem.
   The propositional Buchi backend remains an explicit contract. *)

From Stdlib Require Import List Reals Lra.
Import ListNotations.
Require Import MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.
Require Import EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.

Open Scope R_scope.

Definition ALARM : Action := 1%nat.
Definition HANDLED : Action := 2%nat.

(* G (alarm -> F_[0,3] handled).  MUle is the derived non-strict
   bounded-until operator; its hatted primitive owns the formula-keyed clock. *)
Definition alarm_response : mtl :=
  MR MFalse
    (MOr (MNotAtom ALARM)
         (MUle 3 MTrue (MAtom HANDLED))).

Lemma alarm_response_well_formed : well_formed alarm_response.
Proof.
  unfold alarm_response, MUle.
  simpl.
  repeat split; try exact I; lra.
Qed.

Lemma alarm_response_has_one_primitive_clock :
  timed_subformulas alarm_response =
    [MUhatLe 3 MTrue (MAtom HANDLED)].
Proof.
  vm_compute.
  reflexivity.
Qed.

(* This is precisely the proposition-level backend premise required by
   MTL_to_TBA_correct_with for this formula. *)
Definition alarm_response_backend_contract
    (A : PBuchi alarm_response) : Prop :=
  forall s : pword alarm_response,
    PBA_accepts A s <-> psat s 0 (T alarm_response).

Theorem alarm_response_tba_correct_with :
  forall (A : PBuchi alarm_response) (w : timed_word),
    alarm_response_backend_contract A ->
    msat w 0 alarm_response <-> TBA_accepts (compile_with A) w.
Proof.
  intros A w HA.
  unfold alarm_response_backend_contract in HA.
  eapply MTL_to_TBA_correct_with.
  - exact HA.
  - apply alarm_response_well_formed.
Qed.
