# Pre-submission review: A Mechanically Verified Translation of MTL₀,∞ into Timed Büchi Automata

**Date:** 2026-10-07  
**Venue:** IEEE Transactions on Software Engineering (TSE)  
**Recommendation:** Major Revision  
**Confidence:** Moderate

## Manuscript and scope

**Title:** A Mechanically Verified Translation of MTL₀,∞ into Timed Büchi Automata  
**Authors:** Elie Fares, Jean-Paul Bodeveix, Hussain Al-Aqrabi, and Azar Salami  
**Primary source:** paper1.tex, with included figures, worked translation, and proof-source sections.  
**Supplement:** supplement.tex and proof_details.tex.

The abstract presents a Coq-verified translation from pointwise dense-time MTL₀,∞ to timed Büchi automata. It reduces timed operators to strict hatted primitives, encodes timing constraints in clocked LTL, uses an LTL-to-Büchi backend under an explicit semantic contract, and completes the construction with relaxation and reset operations. The central argument is that one clock per distinct timed subformula suffices even when obligations for that subformula overlap. The end-to-end correctness theorem is conditional on the backend contract.

I reviewed the manuscript and supplement sources, their included figures and proof sections, the proof README and Makefile, and the two central Coq source files. I inspected the supplied PDFs: the main paper is 12 pages and the supplement is 6 pages. The main paper length matches current IEEE Computer Society Transactions guidance. TSE’s stated scope makes the formal verification contribution potentially relevant, but the paper needs to explain its software-engineering impact more concretely. Sources: [TSE scope](https://www.computer.org/digital-library/journals/ts/cfp-ieee-transactions-on-software-engineering) and [IEEE Computer Society author resources](https://www.computer.org/publications/author-resources).

This is a source-level and visual review, not a reproduced proof audit. I did not compile the Coq development, build the LaTeX, run Spot, or independently verify the generated automata. The findings below distinguish confirmed inconsistencies in the supplied text from questions that require execution or further artifact evidence.

## Overall assessment

The paper develops a substantive formal result: it gives a mechanized account of formula-keyed clock reuse and argues completeness through a canonical reset policy and residual obligations. The proof architecture is promising, and the paper is candid that its end-to-end theorem assumes a semantic contract for an LTL-to-Büchi backend.

A major revision is warranted. The worked TBA example appears to accept a trace that violates its stated MTL formula under the paper’s own initial-clock semantics. The paper also needs to make its nonstandard existential initial-clock convention, the Coq automaton model’s treatment of invariants, and the conditional nature of the backend result easier to assess. Finally, the novelty should be framed against existing MTL-to-automata tooling, especially CASAAL, and against recent adjacent formal work. These issues are addressable, but they affect the reader’s understanding of what has been proved and what practical translation is delivered.

No defect in the central theorem was established by this static review. The formal-definition and derived-operator checks did not reveal a counterexample, but they are not a substitute for rebuilding and checking the Coq development.

## Findings ranked by priority

### Major findings

#### 1. The bounded-response worked example conflicts with the stated formula semantics

In worked_translation.tex (around lines 5–18) and figures/fig_tba_example.tex (around lines 1–6), the displayed automaton has an initial location q0 with invariant x ≤ 5 and an edge guarded by x ≥ 2 and p to accepting q1. The associated formula is (F≤5 p) ∧ (G<2 ¬p).

The paper defines initial clock values existentially rather than requiring all clocks to start at zero (paper1.tex, around lines 235–253, and again around lines 627–634). Under that definition, take an initial event at time 0 with p true and choose initial x = 2. The edge is enabled immediately, and the automaton reaches its accepting location. Yet the formula is false: G<2 ¬p includes the current event, where p holds. This is a counterexample to the displayed example’s claimed correspondence under the stated semantics.

**Priority:** Resolve before submission. Either modify the automaton or formula so they agree under the existing semantics, or define and prove an initialization convention that makes the example valid. State explicitly whether the first event is checked before or after a reset, whether its action is constrained on entry, and how clocks are initialized. Add a short trace demonstrating the corrected correspondence. This example is central to explaining the construction.

#### 2. Make the initial-clock convention and invariant model explicit across the paper and Coq development

The paper’s timed-automaton definition permits location invariants and existential initial clock valuations. Both choices can be mathematically legitimate, but readers may expect clocks to start at zero, and the Coq TBA record in MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v (around lines 1111–1143) does not contain an invariant field or an invariant satisfaction check. The paper should identify the automaton model actually produced by the Coq translation and explain how it relates to the more general definition.

**Priority:** State the chosen semantics at the first definition and keep it consistent in the example, theorem, and implementation description. If generated automata are invariant-free, say so and explain whether the general invariant definition is only background notation. If invariants are part of the formal target, show where they are represented and checked. Also explain whether a standard zero-initialization wrapper can be constructed and whether it preserves the theorem.

#### 3. Sharpen the result’s practical scope and its distinction from existing translators

The result’s strongest novelty is the mechanized proof architecture for reusing one clock per syntactically distinct primitive timed subformula despite repeated, overlapping activations, including its canonical reset and residual-obligation completeness argument. The broad capability of translating MTL₀,∞ to timed automata is not new: CASAAL is an existing MTL-to-TBA tool. The paper needs a more precise comparison of the guarantees and construction choices.

The end-to-end theorem also depends on an abstract LTL-to-Büchi semantic contract. The Coq source includes LTL_TO_BUCHI_CORRECT as an axiom in the shared core (around line 1829), while MTL_to_TBA_correct_with exposes the contract as a theorem parameter (around lines 4127–4137). The paper discloses that backend parsing, invocation, and output printing are outside the theorem, but the reader cannot yet tell whether a concrete backend adapter and a fully replayable end-to-end pipeline are supplied.

The Coq bound type is the arbitrary real type R (shared core, around line 107). The manuscript should distinguish a semantic translation theorem from an executable compiler for finitely represented constants. The current representation alone does not establish an effective encoding or decision procedure for arbitrary real bounds.

**Priority:** Recast the contribution around what is proved: the formal translation architecture and the clock-reuse correctness argument. Add a comparison table or paragraph covering target semantics, clock policy, proof status, supported bounds, and backend assumptions. Identify any concrete backend adapter and its version, input, output, and proof boundary. If executable support for finite bounds is not provided, state that limitation plainly. Avoid implying a practical compiler pipeline beyond the supplied artifact.

#### 4. Update and focus the related-work discussion

The related-work section should cover recent adjacent work and say precisely how it differs:

- Bouyer et al., FoSSaCS 2025, study MTL translation to one-clock alternating timed automata with deactivation, bounded width, and zone emptiness. Their finite-word and alternating-automaton setting differs from this paper’s infinite-word TBA target, but the overlap in clock and obligation management merits discussion: [FoSSaCS 2025 paper](https://link.springer.com/chapter/10.1007/978-3-031-90897-2_19).
- Wang et al., TACAS 2025, give a formally verified finite/discrete-time MLTL-to-regex translation. The manuscript already has a bibliography entry for this work, but it appears unused. Cite it with the setting and target distinction, or remove the unused entry: [TACAS 2025 paper](https://doi.org/10.1007/978-3-031-90643-5_13).
- TEMPORA, TACAS 2026, is a pointwise MITL model checker for past and future operators using timed-automaton architectures. It is adjacent rather than a direct equivalent and can help position the verification-tool context: [TEMPORA paper](https://link.springer.com/chapter/10.1007/978-3-032-22752-2_33).
- CASAAL’s published description supports the claim that MTL-to-TBA tooling predates this paper. Compare the precise capabilities and proof guarantees without making unverified claims about CASAAL’s internal clock allocation: [CASAAL](https://lcs.ios.ac.cn/~ligy/tools/CASAAL/).

**Priority:** Add these distinctions and state the contribution relative to existing tools in the introduction as well as related work. A precise, limited novelty claim is stronger than a broad claim to the first translation.

### Minor findings

#### 5. Consolidate the proof exposition

The main paper says the full case proof is in the supplement (paper1.tex, around lines 720–727), but later inputs detailed soundness, completeness, and composition proof sections (around lines 840–842) that substantially repeat proof_details.tex (around lines 342–592). Arithmetic material is repeated as well. This makes it unclear which proof text is authoritative and costs scarce main-paper space.

**Suggested change:** Keep the main paper’s proof roadmap, central invariants, and key argument; place detailed cases in one supplementary source. Remove duplicate inputs or replace them with concise summaries.

#### 6. Clarify action and negated-action notation in the Spot figure

The Spot output appears to use p, !p, and ¬p for action and negated-action labels, while the Coq development distinguishes LAct from LNAct. A reader cannot tell whether !p and ¬p are distinct alphabet symbols or two spellings for the same proposition’s negation.

**Suggested change:** Define the alphabet and mapping between action literals and Spot labels in the figure caption or nearby text. Use one consistent notation. This is a presentation ambiguity, not evidence of a semantic defect in the Coq clauses.

#### 7. Add enough provenance to reproduce the displayed automaton and artifact

The reported Spot automaton counts (five states and eleven transitions) are not accompanied by a version, exact command, or complete input/output. The paper and supplement also omit a clear Coq version/build record and exact supported invocation. Some supplement references to proof-source files omit the proof/ directory. Several bibliography entries have incomplete publication metadata.

**Suggested change:** Add a compact artifact paragraph with tool versions, commands, paths, and backend input/output needed to regenerate the figure. Include the Coq version and a reproducible build or CI command, and report assumptions if available. Fix source paths and bibliographic metadata. The review did not execute these commands, so the counts and build status remain unverified.

#### 8. Tighten terminology and notation

The abstract’s phrase “strict hatted primitives” is difficult to parse without an immediate definition. The text alternates between finite action alphabets and a Coq Action type represented by nat; clarify the relationship. Define hatted notation consistently and avoid implying that arbitrary real bounds have a finite executable representation.

## Points that do not require a new experiment

The manuscript makes no empirical performance claim, so a broad benchmark study is not necessary for acceptance of the stated formal contribution. A small replayable backend example would nevertheless help establish how the semantic contract connects to a usable translation. Any comparison should stay commensurate with the claims made.

The main paper occupies 12 pages, consistent with the current IEEE Computer Society Transactions page guidance; the separate supplement is 6 pages. The supplied PDFs were generally legible and showed no obvious clipping.

## Specialist reports

These are synthesized independent reports from reviewers 1–9. The final meta-review follows afterward. All nine specialist reviews completed; none failed. Findings are preserved below, with overlapping points grouped and severity reconciled in the meta-review.

### Reviewer 1 — Language and presentation

**Major:** The paper says the full proof cases are in the supplement but appears to include detailed proof files in the main source as well. The duplication and description should be reconciled.

**Minor:** “Strict hatted primitives” is ambiguous in the abstract. A sentence in proof_details.tex around lines 296–306 is awkward, as is the supplement’s opening description of the full reset-policy and residual-obligation proof. Most prose is grammatical.

### Reviewer 2 — Consistency and references

**Minor:** Clarify the finite action alphabet versus the Coq nat representation, action and negated-action encoding in the Spot output, Spot counts and provenance, and supplement proof-source paths. Some bibliography records have sparse metadata. The reviewer found that 23 unique citation keys and internal references resolve; no unresolved labels were reported.

### Reviewer 3 — Technical example and translation clauses

**Major:** Identified the accepting trace for the bounded-response example described in Finding 1.

**Minor:** The Spot counts lack reproduction details. The static review found the eight translation clauses and ordinary derived-operator identities consistent with the stated definitions; the reviewer did not identify a theorem-level counterexample. The paper’s disclosure of backend scope was judged accurate.

### Reviewer 4 — Formal semantics and proof structure

No confirmed defect was found in the semantic definition, derived identities, or eight clauses under the paper’s assumptions of strictly increasing, divergent timestamps and well-formed bounds. The reviewer noted the difference between the general paper definition with invariants and the Coq TBA record. The backend axiom and contract-parameterized theorem are disclosed. This was a static audit only; no Coq build was performed.

### Reviewer 5 — Figures and visual consistency

**Major:** The worked TBA example has the mismatch described in Finding 1.

**Presentation issue:** The figure’s p, !p, and ¬p labels are unclear. The reviewer initially rated this major; the meta-review treats it as minor because the Coq source distinguishes action and negated-action constructors, and the concern is notation clarity rather than a demonstrated semantic flaw. Other figures and tables appeared consistent with the text. The specialist did not render the PDFs; the primary review did.

### Reviewer 6 — Methodology and reproducibility

**Major:** Existential initial clock values are nonstandard for many timed-automaton tool workflows. The paper should either provide and prove a zero-initialization adapter or keep the convention prominent and explain interoperability.

**Minor:** Add a Coq version/build record and Spot provenance. A replayable backend run would help, but the reviewer did not consider broad benchmarks necessary absent performance claims.

### Reviewer 7 — Advocate’s assessment

The strongest contribution is a mechanized proof of a formula-keyed clock policy for repeated, overlapping timed obligations, with a canonical reset policy and residual-obligation completeness argument. The paper discloses the backend contract and makes no performance claim. CASAAL already has the broad translation capability, so the paper should emphasize the proof architecture. TSE is plausible, but impact depends on showing how the result can be integrated or used.

### Reviewer 8 — Skeptical assessment

**Major:** Strengthen the comparison with CASAAL and specify the proof delta. The abstract backend contract, absent concrete adapter, and arbitrary-real bounds leave practical impact uncertain. Narrow the practical claim or provide a concrete adapter. The clock claim is syntactic identity-based, which should be made clear.

The reviewer did not compile the development or independently check novelty claims against external full text.

### Reviewer 9 — Related work

**Major:** Add FoSSaCS 2025 and give a precise CASAAL comparison.

**Minor:** Discuss the unused Wang et al. TACAS 2025 bibliography entry and adjacent TEMPORA TACAS 2026 work. The reviewer could not access the ACM full paper needed to verify detailed CASAAL clock-allocation claims, so this report does not assert those details.

## Reviewer 10 — Meta-review

**Recommendation:** Major Revision  
**Confidence:** Moderate

The paper’s formal core is substantive: its treatment of repeated and overlapping activations for a formula-keyed clock policy is a plausible contribution, and the conditional backend boundary is disclosed. No central theorem defect was established in the source-level audit. The bounded-response example, however, has a concrete mismatch under the paper’s stated existential initial-clock semantics and should be corrected before submission.

The paper should make its initial-clock convention and invariant model explicit, then sharpen its TSE relevance and novelty against CASAAL and recent formal work. It should also state whether the artifact provides an executable backend adapter and finite representation for bounds. Consolidating repeated proof material and adding artifact provenance are worthwhile but secondary.

The case for TSE is plausible because the work concerns a verified translation toolchain, but the current paper does not yet make its practical software-engineering impact persuasive. A concrete backend demonstration or a narrowly stated semantic result with a clear proof boundary would help. A broad performance study is not required unless the authors choose to make performance claims.

### Ranked revision plan

1. Correct the bounded-response example and show a trace consistent with the formal initialization and action semantics.
2. Align the paper’s timed-automaton definition with the Coq representation, especially initial clock values and location invariants.
3. State precisely what is mechanized and what is assumed or external: backend contract, backend adapter, parser, bounds representation, and generated output.
4. Reframe novelty around the verified clock-reuse proof and compare it carefully with CASAAL and recent adjacent work.
5. Consolidate duplicated proofs and add build/tool provenance for the displayed automaton and Coq artifact.

## Review limitations

- No Coq compilation, LaTeX build, Spot execution, or independent automaton regeneration was performed.
- The reported Spot state and transition counts are therefore unverified.
- The source audit did not independently validate every proof obligation or produce a Print Assumptions result.
- Detailed implementation claims about CASAAL were kept conservative because its full source was not independently inspected.
- The review assesses the supplied manuscript and artifact files, not external claims about authors, venues, or tool performance.

