(* A proof-only instance of the verified MTL-to-TBA theorem.
   The propositional Buchi backend remains an explicit contract. *)

From Stdlib Require Import List Reals Lra Lia.
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

(* A concrete infinite timed word extending the overlapping-alarm prefix:
   alarms occur at times 0 and 2, handled occurs at time 4, and all later
   events are neutral. *)
Definition alarm_trace_action (i : nat) : Action :=
  match i with
  | O => ALARM
  | S O => ALARM
  | S (S O) => HANDLED
  | _ => 0%nat
  end.

Definition alarm_response_trace : timed_word.
Proof.
  refine {| tw_action := alarm_trace_action;
            tw_time := fun i => 2 * INR i |}.
  - intros i. induction i.
    + simpl. lra.
    + rewrite S_INR. nra.
  - intros i. rewrite S_INR. nra.
  - intros i d Hd.
    destruct (archimed (d / 2)) as [Harch _].
    assert ((0 <= up (d / 2))%Z \/ (up (d / 2) <= 0)%Z) as Hcase.
    { apply Z.le_ge_cases. }
    destruct Hcase as [Hz | Hz].
    + destruct (IZN (up (d / 2)) Hz) as [n Hn].
      exists (i + n)%nat.
      split.
      * lia.
      * rewrite plus_INR.
        replace (2 * (INR i + INR n) - 2 * INR i) with (2 * INR n) by ring.
        rewrite INR_IZR_INZ, <- Hn.
        nra.
    + assert (IZR (up (d / 2)) <= 0) as Hup_nonpos.
      { apply IZR_le. exact Hz. }
      lra.
Defined.

Lemma alarm_response_trace_violates :
  ~ msat alarm_response_trace 0 alarm_response.
Proof.
  unfold alarm_response, MUle.
  simpl.
  intros H.
  specialize (H 0%nat ltac:(lia)).
  unfold alarm_trace_action, ALARM, HANDLED in H.
  simpl in H.
  destruct H as [[Hnot_alarm | [Hhandled | [_ Hfuture]]] | Hfalse].
  - apply Hnot_alarm. reflexivity.
  - discriminate.
  - destruct Hfuture as [j [Hafter [Hwithin [Hhandled _]]]].
    destruct j as [|[|[|j]]]; simpl in *; try lia; try lra; discriminate.
  - destruct Hfalse as [k [Hk _]]. lia.
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

Corollary alarm_response_trace_rejected_by_any_correct_backend :
  forall (A : PBuchi alarm_response),
    alarm_response_backend_contract A ->
    ~ TBA_accepts (compile_with A) alarm_response_trace.
Proof.
  intros A HA Haccept.
  apply alarm_response_trace_violates.
  apply (proj2 (alarm_response_tba_correct_with A alarm_response_trace HA)).
  exact Haccept.
Qed.
