# TSE Pre-submission Review — Fresh Pass

**Manuscript:** “A Mechanically Verified Translation of MTL$_{0,\infty}$ into Timed Büchi Automata”  
**Authors:** Elie Fares, Jean-Paul Bodeveix, Hussain Al-Aqrabi, and Azar Salami  
**Target venue:** IEEE Transactions on Software Engineering (TSE)  
**Review date:** 2026-10-07  
**Recommendation:** Major revision; borderline on TSE fit  
**Confidence:** Moderate

This is a new review of the live working tree. The earlier report was left untouched and was not used as evidence. The review covered `paper1.tex`, its live includes and figures, `supplement.tex` and `proof_details.tex`, `references.bib`, both included Coq/Rocq source files, the READMEs and build script, and the existing PDFs. The main PDF has 10 pages and the supplement 6. I rendered and visually inspected all pages: there is no obvious clipping or overlap; some labels in the two-automaton figure are dense.

The working tree was already dirty when inspected, including manuscript, proof, figure, and PDF files. This review assesses the current files; it does not attribute those existing changes. No manuscript or proof source was edited in this review. The current review workflow was static: I did not run LaTeX, Rocq/Coq, `coqchk`, or Spot. Consequently, this report does not certify that the current sources compile or that the Spot figure regenerates.

## Overall assessment

The paper presents a valuable formal-methods result: it mechanizes a clocked-LTL translation for eight hatted timed Until/Release primitives and proves soundness and completeness for a formula-keyed shared clock, including repeated overlapping activations. The end-to-end theorem is properly conditional on an LTL-to-Büchi correctness contract. The paper is unusually candid about not proving the external backend and not providing a parser, finite bound encoding, or extracted compiler.

I found no semantic counterexample to the current clock clauses, reset policy, or worked TBA example in the static audit. The worked example now has an initial transition that enforces `¬p` and resets the deadline clock. The main correctness concern is instead a confirmed specification-to-proof mismatch: the displayed upper-bounded hatted Until equation prints both strong and weak Until, the prose describes weak Until, and the supplement and Coq use strong Until. Strong and weak Until may coincide on the stated clock-consistent, time-divergent traces, so this review does not conclude that the theorem is false. The manuscript must state the intended clause and connect it explicitly to the mechanized definition.

The second major issue is scope and impact. The target is an event-guarded, invariant-free TBA semantics with existential initial clock valuations. The result does not yet provide the finite-input, standard-initialization, backend-invocation, and output path that would make it a usable verified translator. These limits are disclosed in the body and README, but should be prominent in the contribution framing and accompanied by a clear TSE-facing use case or a narrower positioning as a verified semantic translation layer. IEEE describes TSE as publishing theoretical results and empirical studies with potential impact on software construction, analysis, or management ([TSE scope](https://www.computer.org/digital-library/journals/ts/cfp-ieee-transactions-on-software-engineering)); the revision needs to make that impact case concrete.

I recommend **major revision**, not rejection on technical correctness grounds. The equation mismatch is repairable, and the formal contribution is plausible. Acceptance would depend on whether the authors can make the exact guarantee, target semantics, relationship to prior constructions, and practical relevance clear enough for TSE.

## Major issues

### 1. Repair the upper-bounded hatted Until equation and align it with Coq

In `paper1.tex`, Eq. `eq:t-hule` (around lines 319–321) contains `\Until` immediately followed by `\WeakUntil`. The rendered PDF on page 3 therefore shows `P U W (...)`, which is not the single weak-Until clause described in the surrounding prose. That prose says the upper-bounded hatted Until uses weak Until. In contrast, the supplemental translation (`proof_details.tex`, around lines 186–188), the Coq `T_at` clauses (`proof/MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v`, around lines 852–860 and 899–903), and the worked translation use strong Until.

The available argument suggests that weak and strong Until can agree on clock-consistent extensions of divergent timed words: if the clock is preserved and time diverges, the finite upper bound cannot be avoided forever. This prevents a demonstrated counterexample to the timed-language theorem, but the paper currently leaves readers unable to tell which formula is specified and what the proof establishes.

**Required revision:** make the displayed clause syntactically valid, state whether the translation uses strong or weak Until, and align the main paper, supplement, and Coq definition. If weak Until is retained in the prose, state and prove the equivalence under the exact clock-consistency and divergence hypotheses and explain how it discharges the contract used in the backend construction. If strong Until is intended, remove the weak-Until claim and state the correspondence with the mechanized clause. Do not leave the bridge implicit.

### 2. Foreground the target automaton semantics and explain the interface boundary

Section 2.2 defines the target as an event-guarded TBA with no location invariants, one transition per event, and existential initial clock values (`paper1.tex`, around lines 244–273 and 644–652). In particular, it does not assume the conventional all-clocks-zero initialization. The definition is explicit, so this is not a hidden proof assumption. However, the title, abstract, and contribution framing say “timed Büchi automata” without foregrounding this specialization, and the current theorem does not prove an adapter to a standard zero-initialized model.

The manuscript and README also state that the Coq syntax uses bounds in `Real`, supplies no finite textual encoding or extracted compiler, and leaves parser, backend invocation, initialization, optimization, and output/export outside the theorem. The `_with` theorem takes the LTL-to-Büchi semantic contract as a hypothesis; the project’s convenience `compile` path depends on `LTL_TO_BUCHI_CORRECT` in the Coq core. These are disclosed boundaries, not hidden verification claims.

**Required revision:** name the event-guarded, invariant-free, existential-initialization semantics in the abstract or contribution summary. Then either add and prove the initialization/export adapter needed by the conventional tooling the paper targets, or consistently frame the result as a verified semantic translation layer and give a concrete example of how that layer supports a software verification workflow. Explain what a user can and cannot do with the included artifact. A performance study is not required because the paper makes no performance claim.

### 3. Make the TSE significance argument carry the formal contribution

The paper correctly says CASAAL already translates this logic fragment and does not claim a first translation or general automaton-size advantage (`paper1.tex`, around lines 131–136 and 959–962). Its strongest novelty is the mechanized completeness proof for a canonical reset policy that reuses one clock per distinct primitive timed subformula despite overlapping activations. The supplement also says that the canonical extended-word construction follows CASAAL and adapts it to formula-keyed clocks.

That is a credible scholarly contribution, but the manuscript currently provides no concrete software use case, runnable end-to-end path, or evidence that the additional assurance changes a construction or verification decision. The missing path is one venue-fit concern, not three independent defects: the external backend contract, existential initial clocks, and separate initialization/extraction project are related parts of the same boundary.

**Required revision:** make the mechanized completeness result the primary contribution and explain who relies on it and what error class it rules out in a real verification pipeline. A small end-to-end example with a named backend and a clear account of the remaining trusted assumptions would help. If the intended contribution is strictly foundational, narrow the applied framing accordingly. No benchmark or comparative performance claim is needed unless the authors choose to make one.

### 4. Complete and sharpen the closest-work comparison

The existing comparison is generally cautious, but should cover the nearest recent work and avoid implying an unverified priority claim.

- Add **MightyPPL** (TACAS 2026), a compositional pointwise timed-logic model checker for finite and infinite timed words that also manages overlapping obligations. Explain how its logic and automaton architecture differ and how its obligation-merging/copy-bounding approach relates to the paper’s formula-keyed clock theorem. [MightyPPL, Springer](https://link.springer.com/chapter/10.1007/978-3-032-22752-2_24).
- Make the CASAAL table’s “clock sharing” row precise. CASAAL already targets MTL$_{0,\infty}$ and translates to timed Büchi automata ([CASAAL tool page](https://lcs.ios.ac.cn/~ligy/tools/CASAAL/); [Li et al., SPIN 2017](https://doi.org/10.1145/3092282.3092303)). The manuscript can claim its proved guarantee—one clock per distinct normalized primitive formula under arbitrary repeated activations—but should not assert that CASAAL lacks that property unless the full construction establishes it.
- Scope the broad statement about full MTL and timed automata. Acknowledge results under bounded-variability assumptions and distinguish ordinary timed automata from alternating timed automata. For example, [Nickovic and Piterman, FORMATS 2010](https://link.springer.com/chapter/10.1007/978-3-642-15297-9_13) give a full-MTL-to-DTA construction under bounded-variability assumptions.
- In the recent-work paragraph, say explicitly that the FoSSaCS 2025 result by Bouyer, Srivathsan, and Vishwanath targets finite timed words and one-clock alternating timed automata, unlike this paper’s infinite-word TBA result ([FoSSaCS 2025](https://link.springer.com/chapter/10.1007/978-3-031-90897-2_19)). Distinguish the automaton models and clock-activity mechanisms.
- Briefly distinguish mechanized decision procedures and monitoring proofs from this paper’s mechanized automata-translation proof. The existing discussion of MLTL-to-regex verification and TEMPORA is directionally sound; it can explain the adjacent but different logic, target, and assurance claims ([MLTL-to-regex, TACAS 2025](https://doi.org/10.1007/978-3-031-90643-5_13); [TEMPORA, TACAS 2026](https://link.springer.com/chapter/10.1007/978-3-032-22752-2_33)).

The detailed CASAAL clock-allocation policy could not be verified from an accessible proceedings source in this pass. The revision should verify that comparison from the full construction rather than strengthening it by inference.

## Minor issues and presentation

1. **Spot figure provenance:** `worked_translation.tex` calls the left automaton Spot output and labels the two diagrams generated automata, but the supplied build materials do not give a Spot version, exact invocation, serialized input, or raw output. Add those items or relabel the figures as representative illustrations. The paper explicitly disclaims state-size and performance claims, so this is a reproducibility issue rather than a missing experiment.
2. **Action alphabet:** the formal alphabet description in `paper1.tex` (around lines 280–283) says “action atoms” but should define the positive `LAct` and distinct negative `LNAct` propositions. The worked-example caption now explains their relationship to `!p`, redundancy, and action-semantic incompatibility; keep that explanation and make the formal definition consistent with it.
3. **Build reproducibility:** the README and proof README give different build entry points, and neither pins the Rocq/Coq version. State the tested version (the authors report Rocq 9.0.1), provide one clean command sequence, and record the `coqc`/`rocq` and `coqchk` outcomes and assumptions. This review did not run them.
4. **Bibliography:** add available publication locators to `roohi_viswanathan_vmcai18`, `bersani_cltloc`, and `chattopadhyay_mamouras_rv20`. The current keys resolve and are unique, but those entries appear incomplete.
5. **Terminology and compression:** use “distinct primitive timed subformula” consistently. The abstract’s phrase “even when its obligation is activated repeatedly and overlaps itself” can be clearer as “even when multiple activations of that obligation overlap.” Condense the proof outline where it repeats the reset policy and cases already given in Sections 3.3–3.5 and the supplement. Separate the combined notation from its properties in the supplement and remove draft/audit narration from comments in the Coq source.
6. **Worked automaton labels:** the caption explains why positive/negative action propositions and their negated literals can be redundant or incompatible. The right-hand diagram suppresses a redundant action condition; explicitly saying that this label was omitted for readability would make the diagram-to-caption mapping immediate. This is a small clarity point, not a semantic flaw.

## Technical, evaluation, and artifact assessment

- **Technical correctness:** Static checks found no counterexample to the eight timed clauses, reset policy, overlap handling, or worked TBA. The main Eq. `eq:t-hule` mismatch above remains a major specification-to-proof alignment defect. The result is conditional on the stated backend correctness contract; that dependency is explicit.
- **Novelty:** The paper is not the first MTL$_{0,\infty}$-to-TBA construction. Its defensible contribution is the machine-checked proof architecture and formula-keyed clock-completeness argument. The comparison should focus on that precise delta and acknowledge that the canonical extended-word method follows CASAAL.
- **Evaluation:** No empirical study is asserted and no performance advantage is claimed. A benchmark suite is therefore not required. A reproducible Spot example and a concrete backend/adapter demonstration would improve artifact value without turning the paper into an empirical paper.
- **Artifact:** The current instructions identify the theorem sources and state the backend assumption, but do not pin the compiler version or report a fresh build/checker run. The current review did not compile. A versioned, one-command proof build and recorded assumptions would make the formal claim easier to audit.
- **Presentation:** The existing 10-page manuscript and 6-page supplement render cleanly in the inspected PDFs. Figure 4 contains dense automaton labels, but no obvious clipping, overlap, or broken glyphs was visible.

## Independent specialist reports

### Reviewer 1 — Language and presentation

No critical or major language defect was identified. Minor edits: clarify the abstract’s “obligation ... overlaps itself” phrasing; align “distinct” and “primitive” in the clock contribution; shorten the proof outline where it repeats Sections 3.3–3.4 and the supplement; separate combined notation from its properties in `proof_details.tex`; rephrase personified statements about soundness/completeness; and remove draft/audit narration from comments in the Coq core. This reviewer did not compile or inspect the PDF, bibliography metadata, or mathematical details.

### Reviewer 2 — Internal consistency and references

The 26 citation keys resolve and there are no duplicate BibTeX keys. Minor consistency issues: define both `LAct` and distinct `LNAct` in the formal alphabet; provide provenance for the Spot figure; and fill available missing locators for `roohi_viswanathan_vmcai18`, `bersani_cltloc`, and `chattopadhyay_mamouras_rv20`. The Spot point is a provenance gap, not evidence that the diagram is wrong. This reviewer did not inspect PDFs, run tools, or externally verify the bibliography metadata.

### Reviewer 3 — Technical audit

No semantic counterexample was found. The eight hatted clauses, ordinary-operator identities, clock recurrence, reset behavior, and current worked automaton appear consistent with the Coq definitions. The TBA is explicitly event-guarded and has no location invariants. The existential initial clock convention is stated, but interoperability with zero-initialized tools would need a bridge. Spot provenance is a minor reproducibility gap; there is no performance claim requiring an evaluation. This was a static audit, not a compilation.

### Reviewer 4 — Mathematical and formal correctness

The main finding is the major Eq. `eq:t-hule` mismatch: the main equation prints both `U` and `W`; the prose says weak Until; the supplement and Coq use strong Until. Because clock-consistent traces diverge and the clock cannot remain within a finite upper bound forever, the reviewer found no timed-language counterexample, but requires the equation and mechanized definition to be aligned or an equivalence lemma to be stated and proved. The other checked semantic domains, eight cases, clock keys, residuals, reset policy, composition boundary, and event-guarded target matched the Coq structure. Static audit only; no compilation.

### Reviewer 5 — Figures and experimental reporting

The bounded-response TBA, Until/sporadicity diagrams, tables, and named proof lemmas were consistent with the text and Coq source. The Spot figure lacks version and invocation. The reviewer also noted that the right-hand worked automaton suppresses a redundant action condition. The revised caption explains that `!p` and `LNAct(p)` represent the same action exclusion under timed-word interpretation; a brief note that the diagram omits a redundant label would clarify the display. No performance/evaluation result is asserted. The reviewer did not visually inspect the PDFs; the lead review did. No compilation.

### Reviewer 6 — Methodology and assumptions

Major scope issue: the theorem concerns event-guarded TBAs without invariants and with existential initial clock values, which differs from the conventional all-clocks-zero interpretation. This is disclosed in the body and README, but the abstract and contribution framing use generic TBA language; foreground the model or prove an adapter. Minor issues: Spot provenance and unpinned Coq version/build instructions. The theorem’s backend assumption is explicit, not hidden. A large empirical evaluation is not needed because the paper makes semantic and clock-count claims rather than performance claims. No compilation.

### Reviewer 7 — Contribution advocate

The strongest defensible novelty is the Coq-verified completeness argument for formula-keyed clocks under overlapping activations, not the translation capability itself. CASAAL already handles the same logic fragment; the supplement describes the canonical extended-word construction as following CASAAL and adapting it. The contribution is a plausible assurance result for verification-tool builders, but practical significance is limited by no parser, finite bound representation, extracted compiler, backend integration proof, or measured use. The reviewer recommends a repeated-activation illustration and reproducible proof/build evidence. Related-work claims were checked against primary tool/publisher pages where available; full CASAAL/controller sources were not all accessible.

### Reviewer 8 — Skeptical review

The strongest rejection case is TSE significance: the demonstrated new capability is a conditional formal proof of an abstract construction, with no executable finite-input pipeline or use case. The paper acknowledges those omissions, so this is not a misrepresentation and does not establish lack of scholarly value. A TSE reviewer could reasonably reject if the journal requires a demonstrated software method or integration; a standalone formal contribution remains plausible. Avoid implying automaton minimization or practical size improvement. This reviewer did not compile and did not independently verify CASAAL implementation details.

### Reviewer 9 — Related work and novelty

Add MightyPPL (TACAS 2026) as a close adjacent pointwise timed-logic model checker with overlapping-obligation handling; clarify the exact delta from CASAAL without claiming an unverified priority result; scope the broad full-MTL claim around bounded-variability and alternating-automaton results; specify that the FoSSaCS 2025 alternating-automaton result is for finite timed words; and distinguish prior decision-procedure/monitoring mechanizations from a mechanized automata-translation proof. The TEMPORA and MLTL-to-regex comparisons are directionally sound. The ACM CASAAL proceedings text was not accessible, so the clock-allocation comparison should be checked against the full construction.

### Reviewer 10 — Meta-review

**Recommendation: Major Revision. Confidence: Moderate.** Reviewers 3 and 4 are compatible: no timed-language counterexample was found, but the displayed formula and formal definition are misaligned. Reviewers 6–8 raise one correlated venue-fit/interoperability concern, not multiple independent defects. The current worked-example initialization fix is sound. Priority order: align Eq. `eq:t-hule` with Coq; foreground the target semantics and practical boundary; close the nearest-work comparison; make Spot provenance reproducible; then apply terminology, alphabet, bibliography, and language edits. No Coq compile was performed; Spot output is not reproducible from the repository.

## Reviewer’s scope and limitations

This assessment is based on current source inspection, source-to-proof comparison, the supplied PDFs, a visual inspection of all PDF pages, and fresh specialist reviews. It does not certify compilation, the full proof kernel trust assumptions, correctness of an external Spot run, or priority against inaccessible CASAAL source material. The external sources linked above support venue scope and the cited related-work comparisons; exact CASAAL clock-policy claims should be verified from the full construction before revision.
