# Pre-submission review: A Mechanically Verified Translation of MTL₀,∞ into Timed Büchi Automata

**Authors:** Elie Fares, Jean-Paul Bodeveix, Hussain Al-Aqrabi, and Azar Salami
**Review date:** 2026-10-08
**Target:** IEEE Transactions on Software Engineering (TSE)
**Recommendation:** **Major Revision**
**Confidence:** **Moderate**

## Executive assessment

The paper presents a Rocq-mechanized semantic translation from pointwise MTL₀,∞ to event-guarded timed Büchi automata. Its strongest result is a correctness theorem for a particular clocked-LTL factorization, with one clock per distinct primitive timed subformula even when that formula has arbitrarily many overlapping activations. The theorem covers eight strict and non-strict primitive cases and takes the propositional Büchi backend’s language-equivalence property as an explicit premise. The formal review found **no confirmed defect in the central theorem or its eight cases**.

Three issues materially affect the paper’s credibility and TSE case:

1. The relaxation explanation at paper1.tex:663–668 gives an invalid direction for the argument. The later text and Rocq proof use the valid construction. This is an exposition defect, not evidence that the theorem is false.
2. The related-work discussion does not directly engage two close prior clock/reset constructions: Bulychev et al. (Acta Informatica, 2014) and CASAAL (SPIN 2017). Both report clocks indexed by timed subformulas and explicit reset policies; both provide mathematical language-correctness results for their stated scopes. The draft should distinguish those results from its Rocq mechanization and establish the precise coverage delta.
3. The software impact is credible but prospective. The theorem gives a useful assurance component to a tool builder, but the artifact is not an integrated compiler and does not demonstrate a path through parsing, backend-contract discharge, export, and checker consumption. This is an acceptance risk for TSE, whose scope includes theoretical results with potential software impact. It does not, under the paper’s current claims, require a benchmark or Paper 2’s downstream tool evaluation.

The existing main PDF is **11 pages** against the README’s 12-page maximum, and the supplement is **3 pages**. The supplement’s length is reasonable for the case-specific proof details and result map. Do not add material just to reach 12 pages or enlarge the supplement to meet an arbitrary page count. Add a page only if it makes the prior-work delta or software-assurance argument materially clearer without repeating the supplement or Paper 2.

## Major findings

### 1. Correct the relaxation explanation

At paper1.tex:663–668, the prose says a satisfying assignment can be adjusted to the original backend cube “while remaining a model of the positive formula.” That does not follow: changing a deleted negative extended atom from true to false may falsify a positive formula.

The valid direction is already described later at paper1.tex:701–710 and implemented by relax_sound in proof/MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v (around lines 1420–1479): reconstruct an assignment satisfying the selected original cube; apply the backend contract to that reconstructed word; then use upward closure to infer satisfaction on the relaxed word, which can only add truth on relevant extended atoms. Rewrite the earlier paragraph to match this proof. The inconsistency is localized; reviewers found no corresponding theorem defect.

### 2. Establish the novelty delta against Bulychev et al. and CASAAL

The current text calls CASAAL’s construction a “dedicated tableau-style method” and describes Bulychev et al. mainly as controller-synthesis work (paper1.tex:974–978, 997–1002). That is too general for assessing the paper’s clock-sharing contribution.

Bulychev et al.’s Acta Informatica paper describes auxiliary clocks for timed temporal subformulas, residual timed formulas, reset/unchanged markers, and a clock-update policy, with language-equivalence results for safety and co-safety fragments of MTL₀,∞. See the [author-hosted paper](https://homes.cs.aau.dk/~adavid/publications/73-acta.pdf), especially §4, Definitions 5–6, and Theorems 1–2; the publication DOI is [10.1007/s00236-013-0189-z](https://doi.org/10.1007/s00236-013-0189-z).

CASAAL’s SPIN 2017 construction also assigns a clock to each timed subformula, uses reset/unchanged markers and a reset policy, and states language equivalence for its nondeterministic TBA before deriving deterministic approximations. See [Li et al., SPIN 2017](https://doi.org/10.1145/3092282.3092303) and the [CASAAL project page](https://lcs.ios.ac.cn/~ligy/tools/CASAAL/). The direct ACM full text was inaccessible in this review; the detailed construction check used the authors’ reproduced version, cross-checked against the DOI and official tool page.

These sources do **not** establish that either prior result proves the same full theorem as this paper. They do establish that clocks per timed subformula and correctness reasoning for reset policies are not new in themselves. The related-work section and comparison table should state, for each closest construction, its supported fragment and timed-word assumptions, clock identity, reset/preserve policy, output automaton and language result, and proof/implementation evidence. Then narrow the present contribution to the supported delta—most plausibly the Rocq mechanization of this clocked-LTL factorization and relaxation/reset-completion pipeline, with its stated strict/non-strict coverage and overlapping-activation proof under an explicit backend contract. Do not imply that prior work lacks correctness proofs, that the toy trace identifies a defect in CASAAL, or that this paper uses fewer clocks.

This is the most consequential contribution issue. A precise comparison may make the theorem a defensible TSE contribution; without it, readers may regard the core clocking idea as an insufficiently differentiated re-presentation.

### 3. Make the software-assurance value explicit and bounded

The paper’s strongest software-facing example is the overlapping-response trace (paper1.tex:91–96, 146–160, 469–499): resetting a shared clock at a newer request can hide an older missed deadline. State this as the software risk the theorem rules out for **this construction**. Then say exactly what a tool builder can rely on: a formula-keyed clock may represent repeated activations when the translation and canonical reset policy are used, provided the propositional backend meets the stated language-equivalence contract and the consumer implements the target’s event guards and existential initial clock values.

Keep the boundary equally concrete. The theorem starts from a Rocq-level formula with real-valued bounds; it does not verify parsing, finite textual bound encoding, invoking or validating an external backend, exporting an automaton, adapting to zero-initialized clock semantics, or checker consumption (paper1.tex:163–177, 926–956). The Spot script regenerates only the propositional graph; the shown reset-completed TBA is hand-derived. Do not call this a validated compiler or demonstrated deployment.

The [IEEE TSE scope](https://www.computer.org/digital-library/journals/ts/cfp-ieee-transactions-on-software-engineering) includes theoretical results with potential impact on software construction and analysis. This gives the paper a plausible, but borderline, venue fit. An end-to-end demonstration could strengthen the case, but is **not a prerequisite** under the current no-performance/no-deployment claims, and importing Paper 2’s UPPAAL export or evaluation risks obscuring the papers’ separate contributions. The paper should explain why the formal assurance component is useful even without claiming an operational benefit.

## Technical correctness and scope

### What is supported

- No reviewer confirmed a defect in the central semantic theorem or the eight primitive strict/non-strict cases.
- The backend correctness assumption is explicit, and the paper distinguishes the theorem parameterized by that contract from the convenience theorem using LTL_TO_BUCHI_CORRECT.
- The reset-completion explanation and proof account for the asymmetric treatment of preservation and restart clocks.
- The source and artifact descriptions correctly disclose that Spot is illustrative and that there is no integrated frontend-to-checker run.

### Boundary and assumption clarifications

The text explains zero lower-bound and strict-upper-bound reductions at paper1.tex:243–285, including that the reductions rely on strictly increasing event times and must be applied before constructing the Rocq formula. The well-formedness condition still excludes zero lower bounds and zero strict upper bounds; this preprocessing equivalence is not itself the theorem’s mechanized input step. State prominently that the theorem applies to formulas after these reductions, or mechanize the normalization if the paper intends the theorem to cover raw source formulas.

For non-strict upper bound zero, the manuscript says only that it is in the mechanized domain (paper1.tex:285). Add the simple reductions readers need to understand the boundary: ordinary U≤0 and R≤0 reduce to their right operand at the current position; the hatted U≤0 and R≤0 reduce to false and true, respectively, under strictly increasing timestamps. This also makes the later QEST+FORMATS syntax-containment statement easier to verify.

The manuscript should summarize the standard Rocq assumptions recorded in proof/ASSUMPTIONS.txt separately from the backend premise—classical real-number reasoning, dependent functional extensionality, definite description, and classical propositions. These assumptions do not invalidate the result, but readers should see the proof’s full assumption boundary in the paper or a clearly referenced supplement note.

## Related work and evaluation

The MightyPPL discussion is broadly careful and distinguishes the two 2026 papers. The TACAS paper gives mathematical construction results and proof sketches as well as an implementation; make its handling of overlapping obligations and one-clock testers more directly comparable to this paper’s reset-reuse story. See [MightyPPL, TACAS 2026](https://link.springer.com/chapter/10.1007/978-3-032-22752-2_24).

The QEST+FORMATS paper reports an existentially punctual MTLPPL class, including a one-sided MTL fragment; it should not be characterized mainly by its punctual response example. The current draft already describes the designated punctual positions and the distinction between its “one-sided MTL” and MTL₀,∞ interval shapes (paper1.tex:1052–1068). Tighten two details: attribute “one-sided MTL” to the cited predecessor’s definition, and state that the claimed containment is about conventional source operators after zero-bound reductions. The formal Rocq AST also has hatted timed constructors, which do not appear in QEST’s grammar. Preserve the existing caveat that this is a syntactic relationship, not a shared-input or semantic comparison; the papers use different timed-word conventions. Primary sources: [QEST+FORMATS chapter](https://link.springer.com/chapter/10.1007/978-3-032-35298-9_12) and the [author manuscript](https://arxiv.org/abs/2609.19073).

No performance or relative clock-count experiment is necessary for the present claims: the paper explicitly disclaims those comparisons (paper1.tex:1075–1081, 1104–1110). The overlapping-request trace is an illustration, not an evaluation of CASAAL or another tool. A small integrated path could improve the TSE impact case, but should remain optional unless the authors change the claim to demonstrated deployment.

The three-page supplement is suitable. Keep the main paper self-contained about the reset-policy intuition and theorem invariant; make the supplement handoff point to its additional case-specific proof rather than restating the same overview (paper1.tex:516–619; proof_details.tex:86–163). The README states the main-paper 12-page maximum, not a minimum. The current 11-page paper is within that limit.

## Prioritized revision plan

1. **Rewrite paper1.tex:663–668** to follow the valid reconstruction-then-upward-closure proof direction. Keep the later proof explanation and Rocq lemma aligned.
2. **Revise the related-work section and CASAAL table** (paper1.tex:963–1010, 1023–1029) to compare Bulychev et al. and CASAAL’s clock/reset constructions, exact supported fragments, language results, and assurance evidence. State a bounded and evidenced novelty claim.
3. **Strengthen the software-impact paragraph** (paper1.tex:91–96, 146–177, 926–956) with the concrete design guarantee and a direct sentence delimiting what the theorem does not establish. Do not imply end-to-end deployment.
4. **Clarify the theorem’s normalized-input boundary and assumptions** (paper1.tex:243–285, 900–956; proof/ASSUMPTIONS.txt): include the non-strict upper-zero reductions; distinguish the theorem from any preprocessing step; summarize standard Rocq assumptions separately from the backend premise.
5. **Tighten the QEST+FORMATS and MightyPPL comparison** (paper1.tex:1045–1081), including hats/source syntax and the predecessor’s use of “one-sided MTL.”
6. **Label the overlap table as a finite prefix** (paper1.tex:472–499), since the semantics is over infinite timed words. Explain that every infinite continuation still violates the older deadline.
7. **Improve visual density**: Figure 4 on PDF p. 8 has small transition labels; the proof-boundary table and comparison Table 6 on p. 9 are dense. Simplify or split labels and preserve readable body-size type. Explain the distinction between !p (literal negation) and ¬p (independent action proposition) at first use in worked_translation.tex:80–87.
8. **Resolve pre-submission housekeeping**: replace the bracketed status alternatives in RELATED_SUBMISSION_DISCLOSURE.md:16,30,41 with actual statuses and submit both manuscripts for editor disclosure; keep the proof README’s duplicated command sequence synchronized with the robust root README; correct the stale source filename in the opening comment of proof/EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v:2. Reduce repeated scope qualifications across the introduction, related work, and conclusion where possible.

The worked-example heading is already corrected in the current source: worked_translation.tex:1 now describes a bounded eventuality with an exclusion window. The root README also now says the Spot script does not create a separate invocation log. Keep these fixes.

## Specialist reports

### Reviewer 1 — Language and presentation

No critical or major language defect was found. The paper is readable and its terminology is generally consistent. Minor presentation issues are repeated scope qualifications (paper1.tex:117–122, 163–185, 1075–1110, 1123–1134) and a dense Figure 4 caption (worked_translation.tex:80–87) combining source, proposition notation, timed interpretation, and edge-label conventions. A compact notation legend or split caption would reduce load. The review was a prose/source audit, not an independent raster and citation audit.

### Reviewer 2 — Internal consistency and claims

The core claims and version metadata were generally consistent with the inspected artifact. Confirmed administrative issue: RELATED_SUBMISSION_DISCLOSURE.md:16,30,41 retains bracketed submission-status alternatives and an instruction to replace them before sending; actual status was not independently known. Minor issue: the opening comment in proof/EncodingCorrect_Shared_Clock_Derived_Strict_Direct_Proof.v:2 names an obsolete filename. The manuscript explains most zero-bound reductions, but should add the reductions for non-strict upper bound zero and make the normalization boundary explicit. This reviewer did not recompile the project.

### Reviewer 3 — Technical correctness

No confirmed technical defect was found in the translation narrative, reset/completion argument, or examples. The main technical presentation issue is that paper1.tex:472–499 uses a three-event table while discussing an infinite-word property. Label the table as a finite prefix and state why every infinite continuation still fails once the first deadline has expired. No build was run.

### Reviewer 4 — Mathematical and formal correctness

No confirmed defect was found in the theorem or eight strict/non-strict cases. The major finding is the reversed relaxation explanation at paper1.tex:663–668; the later proof at 701–710 and relax_sound use the valid direction. The zero-bound discussion is mostly present, but the theorem’s mechanized well-formed domain excludes zero lower bounds and strict upper bounds; the reductions are not a verified preprocessing step. The proof’s assumptions are transparent in the artifact, though the standard Rocq assumptions should be summarized separately from the backend premise. No Admitted, admit, or Abort was found in the checked proof source. No Rocq compile was run for this review.

### Reviewer 5 — Figures, tables, and reporting

Figures 1–3 and the trace/table presentation are clear. Figure 4 on PDF p. 8 is cramped and has very small transition labels, though nothing appears clipped. The proof-boundary table and comparison Table 6 on p. 9 are dense and narrow. The comparisons are explicitly qualitative and do not make rankings or clock-count claims. No numerical performance evaluation is claimed or required for the paper’s present scope.

### Reviewer 6 — Methodology and reproducibility

The methodology matches the stated theorem-focused claims. An end-to-end benchmark is not necessary without a performance or deployment claim. The artifact boundary and Spot example are substantially documented, and the three-page supplement is adequate. Minor maintenance concern: proof/README_proof.md duplicates the Rocq command recipe from the root README and may drift. No commands were run; the assessment was of documentation, not reproduced execution.

### Reviewer 7 — Contribution advocate

The strongest defensible contribution is a Rocq-checked semantic result for a specific clocked-LTL translation, including a formula-keyed clock invariant under arbitrarily repeated overlapping activations, eight strict/non-strict primitive cases, and an explicit backend contract. This offers a reusable assurance component and a design invariant to tool builders. The paper does not establish clock minimality, performance superiority, or operational deployment. The Paper 1/Paper 2 boundary is coherent if both manuscripts are disclosed and Paper 1 does not claim Paper 2’s optimization/export/evaluation results. TSE fit is plausible but borderline.

### Reviewer 8 — Contribution skeptic

This reviewer’s recommendation was borderline reject for TSE as currently evidenced (moderate confidence), while acknowledging the formal result and the venue’s allowance for theory with software impact. The concern is that the paper’s incremental value to tool builders is not yet clear against prior clock/reset constructions, especially Bulychev et al. and CASAAL. The trace is illustrative and does not show that an existing tool has a reset defect. A focused prior-work comparison and sharper assurance argument could resolve much of the concern. An artifact-level integrated path might strengthen the case, but the reviewer did not require Paper 2’s downstream results or a benchmark.

### Reviewer 9 — Related work and novelty

The CASAAL comparison is too abstract: CASAAL’s cited construction already has clocks indexed by timed subformulas, reset/unchanged markers, a reset policy, and an exact language result. The discussion should credit this and compare the construction precisely. The reviewer also recommends directly comparing MightyPPL’s one-clock testers and overlapping-obligation treatment, and limiting the QEST+FORMATS containment statement to conventional source syntax because the Rocq AST includes hatted constructors. The ACM article’s direct full text was inaccessible; the CASAAL construction detail was checked through the authors’ reproduced paper and cross-checked with the publication DOI and official tool page.

## Reviewer 10 — Senior meta-review

**Recommendation: Major Revision. Confidence: Moderate.**

The Rocq development appears to establish a real assurance result, and no specialist found a defect in the central theorem. The main issue is a substantial novelty and positioning gap. CASAAL and Bulychev et al. overlap with the construction’s clock-sharing and reset policy more closely than the manuscript explains. The paper may still make a valuable contribution through mechanization, but it must establish that increment against the primary prior constructions.

Compare prior work’s syntax and timed-word assumptions, clock identity, reset/preserve policy, output automata and language results, and proof evidence. State what the present paper adopts, what it changes, and what its mechanization proves. Do not imply that earlier papers lack correctness reasoning or that the overlap trace identifies a defect in their tools.

The software-impact concern is disputed but does not make a benchmark mandatory: the manuscript disclaims performance and relative clock-count claims. The remaining TSE question is whether mechanizing this architecture changes what a tool developer can trust. Explain the reset failure the theorem rules out, and delimit that assurance by the backend-equivalence premise, unverified frontend, and consumer-integration boundary. Avoid claiming a completed toolchain or importing Paper 2’s downstream evaluation.

The relaxation prose should be corrected, and the zero-bound, visual, and artifact-documentation issues should be cleaned up. The three-page supplement is adequate and the 11-page main paper is already within its stated limit. A focused revision can make the contribution defensible without adding a benchmark or filling a page quota. The borderline-reject concern remains material if the prior-work delta and TSE impact argument remain vague.

## Review scope and limitations

The review covered the live main LaTeX source and its included material, supplement and proof details, bibliography, referenced figures/tables, Rocq sources and assumption record, root/proof READMEs, Spot input/script/output, and existing main/supplement PDFs. It also selectively inspected Paper 2’s abstract/introduction and the two shared translation proof modules to assess the stated manuscript boundary; this was not a full review of Paper 2. The two Rocq source files were not byte-identical; visible differences were imports and comments, and no theorem/proof-body difference was apparent in the diff. No compile equivalence is claimed.

The existing PDFs were visually inspected; they were not rebuilt. No LaTeX, Rocq, Spot, or experiment command was run for this review, consistent with the review-only workflow. The primary sources checked for close work and venue scope are linked above. No priority claim beyond those sources was treated as established.

## Post-review correction record — 2026-10-08

The recommendation above assessed the pre-correction manuscript. After that review, the authors' requested changes were applied: the relaxation explanation now follows the proof direction; the related-work section and a full-width table compare Bulychev et al., CASAAL, and this Rocq result; the software-assurance claim and its limits were made explicit; zero-bound reductions and the overlap-prefix semantics were clarified; Figure 4 labels were enlarged; and the proof README and related-manuscript disclosure were synchronized.

Validation of the corrected source: the LaTeX build succeeded, producing a 12-page main paper and a 3-page supplement; Rocq 9.0.1 compilation, independent checking, and assumption capture succeeded; no unresolved citation or reference warnings were found. Spot regeneration was attempted but WSL returned ACCESS_DENIED; the Spot input and script were unchanged. This correction record is not a new independent review, so the recommendation above should not be read as an assessment of the corrected manuscript.
