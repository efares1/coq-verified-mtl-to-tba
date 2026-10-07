# Pre-submission review — IEEE TSE

| Field | Value |
|---|---|
| Manuscript | “A Mechanically Verified Translation of MTL₀,∞ into Timed Büchi Automata” |
| Authors | Elie Fares, Jean-Paul Bodeveix, Hussain Al-Aqrabi, Azar Salami |
| Review date | 7 October 2026 |
| Recommendation | **Major Revision** |
| Confidence | **Moderate** |

## Scope and review limits

This review covers the live manuscript and its included source files: `paper1.tex`, `worked_translation.tex`, the figure sources, `references.bib`, `supplement.tex`, `proof_details.tex`, the Rocq proof modules and assumptions record, the Spot input/DOT/regeneration script, the root and proof READMEs, the build script, and the related-submission disclosure. Existing prior review reports were not used as evidence.

The checked-in `paper1.pdf` (11 pages) and `supplement.pdf` (3 pages) were rendered and visually inspected. **No LaTeX build, Rocq compilation, or Spot regeneration was run**: this is a read-only review, and the project README’s reported Rocq 9.0.1 check was not independently repeated here. The paper’s GitHub artifact link is present, but its public accessibility could not be independently confirmed because the web fetch returned a cache-miss error; this does not establish that the repository is unavailable.

## Executive assessment

The paper has a clear formal contribution: a Rocq-mechanized semantic translation from pointwise `MTL₀,∞` to event-guarded timed Büchi automata, with one clock per distinct primitive timed subformula and a completeness argument that handles repeated, overlapping activations. The artifact exposes a theorem parameterized by an explicit correctness contract for the untimed Büchi backend. The formal reviewer found **no confirmed defect in the central theorem or its eight strict/non-strict primitive cases**.

The recommendation is Major Revision because three matters materially affect the paper’s credibility and fit:

1. One paragraph describes the relaxation proof with the monotonicity direction reversed, even though the later explanation and Rocq proof use the correct direction.
2. The comparison with MightyPPL is now carefully bounded against arbitrary punctual MTL, but it underdescribes the QEST+FORMATS paper’s reported existentially-punctual input class and the mathematical construction proofs in the TACAS paper.
3. The software impact is still prospective. The manuscript explains a concrete clock-reuse failure that the theorem prevents, but it should state more directly what a tool builder can rely on and how that result matters within the stated boundary. TSE accepts theoretical results with potential impact on software, so this does not by itself require Paper 2’s implementation or benchmarks; it does require a precise, credible impact argument.

The remaining findings are local and readily fixable: the worked-example title does not match its formula, Figure 4 is dense, zero-bound reductions are not explained in the manuscript, and the proof README contains a less reliable duplicate command block. No reviewer identified a need for performance benchmarks under the paper’s current claims.

## Prioritized revisions before submission

### 1. Correct the relaxation explanation

At `paper1.tex:640–645`, the text says that a satisfying assignment can be adjusted to the original backend cube “while remaining a model of the positive formula.” That is not generally justified: changing a deleted negative extended atom from true to false can make a positive formula false.

The later explanation at `paper1.tex:678–689` and the proof of `relax_sound` in `proof/MTL_to_TBA_Shared_Clock_Derived_Strict_Direct_Core.v:1420–1477` give the sound direction. First reconstruct an assignment satisfying the original cube; the backend contract gives satisfaction of the formula on that reconstructed word. Then use upward closure to infer satisfaction on the relaxed word, which only adds truth on relevant extended atoms. Rewrite the earlier paragraph to say this. This is an exposition inconsistency, **not evidence that the mechanized theorem is false**.

### 2. Make the MightyPPL comparison complete and precise

The current discussion at `paper1.tex:1013–1031` correctly separates TACAS 2026 from QEST+FORMATS 2026 and does not claim a head-to-head comparison. The QEST passage also correctly says its displayed response formula does not establish support for unrestricted punctual MTL. However, the QEST+FORMATS author manuscript describes a wider **existentially punctual MTLPPL** input class, including a one-sided MTL fragment; it is therefore incomplete to characterize the follow-up mainly through the single punctual response formula. Explain that restricted class and identify the exact relation, if any, between its supported inputs and this paper’s fragment. Do not conflate the two different uses of “one-sided MTL” without defining them. The follow-up’s exact `G(p => F_{=5} q)` example and TEMPORA evaluation can remain as examples of the reported extension.

Also distinguish the TACAS paper’s mathematical construction results and proof sketches from this paper’s **Rocq-mechanized** theorem. The novelty claim can remain that this paper mechanizes its particular clocked-LTL factorization and formula-keyed reuse argument; the related-work prose should not leave an impression that MightyPPL offers implementation but no correctness reasoning.

Primary sources: [MightyPPL, TACAS 2026](https://link.springer.com/chapter/10.1007/978-3-032-22752-2_24), [MightyPPL, QEST+FORMATS 2026](https://link.springer.com/chapter/10.1007/978-3-032-35298-9_12), and the [QEST+FORMATS author manuscript](https://arxiv.org/abs/2609.19073). Springer lists the QEST+FORMATS conference as 2026 and the chapter citation year as 2027; the current bibliography’s `year=2027` is consistent with that citation metadata.

### 3. Sharpen the software-impact argument without importing Paper 2

The manuscript already supplies a useful concrete consequence: if a new request resets a shared clock, it can overwrite the age of an older pending request and hide a missed deadline (`paper1.tex:91–96, 144–158`). State this as the software risk the theorem rules out, then say exactly what the result licenses: a property-automaton generator may reuse one formula-keyed clock across activations **provided** the backend satisfies the stated language-equivalence contract and the consumer handles the target’s event guards and existential initial clock values.

Keep the limits equally concrete: the result starts from Rocq-level formulas with real-valued bounds; it does not verify parsing, finite textual bound encoding, external-backend invocation/validation, output export, or a zero-initialization adapter (`paper1.tex:160–170, 900–925`). Avoid presenting the Spot illustration as an end-to-end verified run. A full compiler, generic optimizer, UPPAAL export, or Paper 2’s evaluation is not needed to make this paper’s narrower assurance claim; if the authors want to claim demonstrated deployment impact, the current artifact does not establish it.

This framing is relevant to TSE’s stated interest in theoretical results with potential impact on software construction, analysis, or management ([IEEE TSE scope](https://www.computer.org/digital-library/journals/ts/cfp-ieee-transactions-on-software-engineering)). The work should be presented as a reusable assurance component for timed-verification software, not as an operationally validated tool.

### 4. Align the manuscript’s boundary and proof-assumption disclosures

The mechanized well-formedness condition excludes zero lower bounds (and zero strict upper bounds), while the main text introduces the broader `MTL₀,∞` fragment (`paper1.tex:183–199, 235–243`). The Rocq core comments that a zero lower bound is represented by the corresponding untimed operator. Add a concise statement of the applicable zero-bound reductions and their conditions so readers can see how the declared fragment relates to the mechanized domain.

The manuscript distinguishes the explicit backend premise from the convenience theorem’s `LTL_TO_BUCHI_CORRECT` axiom (`paper1.tex:900–910`). The captured `proof/ASSUMPTIONS.txt` also lists standard Rocq assumptions—classical real-number reasoning, dependent functional extensionality, definite description, and classical propositions—for the proved theorem. Name these separately from the backend premise in the manuscript or a clearly referenced supplement note. The proof remains conditional on those standard assumptions; their presence is transparent in the artifact, but not summarized in the main text.

### 5. Fix the worked-example label

The heading “Worked example: translating a bounded response” in `worked_translation.tex:1` introduces `F_{≤5} p ∧ G_{<2} ¬p`, which requires a bounded eventual occurrence of p and excludes p during the initial window. It is not the request/acknowledgment property used to motivate overlapping responses in the Introduction. Rename it, for example, “bounded eventuality with an exclusion window,” or replace it with a genuine request/response formula if that is the intended example. Renaming preserves the existing derivation and automaton.

### 6. Improve figure legibility and clarify notation

Figure 4 is visually dense at normal page size. Its transition labels are smaller than the body text after the full diagram is scaled to `\textwidth`; consider simplifying the labels or splitting the two automata so the key guards and resets are readable (`figures/fig_steps45.tex:1–4`; `worked_translation.tex:76–83`; existing PDF p. 8).

The caption defines `\neg p` as the independent atom `LNAct(p)` and `!p` as the literal negation of `LAct(p)`. Because the backend treats these as independent propositions, labels such as `p\land\neg p` are intentional at this stage, but can look contradictory. Explain the distinction just before the figure or add a compact legend at first use.

### 7. Keep artifact instructions and supplement handoff synchronized

`proof/README_proof.md:12–25` repeats the proof command recipe but checks `$LASTEXITCODE` only after the final assumptions command. With stale compiled files, that can obscure an earlier failure. It also assumes the repository root as the current directory without saying so. Link this file to the robust root README block or sync its per-command checks and state the working directory.

The root README’s Spot section says the script “records” the exact input and command. The checked-in `.ltl` file and script source do provide those inputs, but the script itself checks the Spot version, reads the formula, writes the DOT file, and prints the Spot version; it does not emit a separate invocation log. Clarify the wording if “records” is intended to describe generated output.

The main paper needs the reset-policy intuition and theorem invariant, while the supplement supplies case-specific completeness details. Some of the reset/residual discussion is repeated (`paper1.tex:516–619`; `proof_details.tex:86–163`). Keep the main narrative self-contained, but tighten the supplement handoff so each repeated overview points clearly to the additional proof argument rather than restating it.

## Overall strengths and risks

**Strengths**

- The central claim is specific and verifiable: formula-keyed clocks remain complete under repeated activations, with older deadlines retained when residual obligations require them.
- The paper states strict/non-strict cases and the reset policy explicitly, and the Rocq artifact exposes the main theorem and its backend premise.
- It is commendably candid that the theorem does not verify Spot, parsing, output export, or a complete model-checking pipeline.
- The CASAAL comparison correctly concedes that translating the broad fragment is not new and does not make unsupported clock-count or performance claims. CASAAL’s tool page advertises the same broad `MTL₀,∞`-to-timed-Büchi capability ([CASAAL](https://lcs.ios.ac.cn/~ligy/tools/CASAAL/)).
- The companion manuscript disclosure distinguishes this upstream proof from Paper 2’s optimizer, export, extracted implementation, and evaluation. Those downstream claims should remain Paper 2’s contribution.

**Main risk**

TSE may ask whether a verified semantic component for Rocq formulas, without a concrete consumer or discharged backend premise, has sufficient practical significance. The paper can answer this without claiming a full tool: explain the clock-reuse failure mode, specify precisely how the proof protects an adopter from it, and acknowledge that integration remains future work. The official journal scope allows theoretical work with potential software impact, but this remains an editorial judgment, not something established by the theorem alone.

## Specialist assessments

### Reviewer 1 — Language and presentation

No critical language defect or broad grammar problem was found. The manuscript reads clearly overall.

- **[MINOR]** Figure 4 uses `!p` and `\neg p` for different propositions/literals. Their distinction is explained in the caption after the graph, but the labels can initially look contradictory. Introduce the distinction before the figure.
- **[MINOR]** The main text repeats scope boundaries in the Introduction, proof-boundary table, conclusion, and supplement. Streamline where possible.
- **[MINOR]** The reset-policy explanation in the main text and supplement overlaps in places; make the handoff clearer.
- The long MightyPPL paragraph can be split. No other notable copy-editing issues were reported.

**Limit:** This reviewer did not inspect the rendered PDF; Figure 4’s small labels were separately confirmed by reviewers 5 and the lead reviewer.

### Reviewer 2 — Internal consistency, references, and claims

- No unresolved citation keys or cross-references were found in the checked source.
- **[MINOR]** The main paper explains the backend contract and convenience axiom but does not name the standard Rocq-library assumptions listed in `proof/ASSUMPTIONS.txt`. Supplement/artifact disclosure exists; a one-sentence distinction in the main text would improve assumption transparency.
- The root README and Spot script agree on the checked-in formula and command. The wording “records” could be read as implying a runtime log, but the formula and script source are present.
- MightyPPL comparison years and the formula-specific QEST statement are internally consistent; the comparison should still be broadened to the actual restricted input class reported in the author manuscript.

### Reviewer 3 — Technical correctness and claims

- No unsupported performance or automaton-size claim was found; the paper explicitly disclaims both.
- **[MINOR]** The worked-example title suggests request/response, but the formula is bounded eventuality plus an initial exclusion window (`worked_translation.tex:1–17`). Rename it or use the stated request/response formula.
- The Spot graph illustrates the propositional backend stage; it is not the Rocq-generated or reset-completed output. The manuscript discloses this boundary.
- The theorem gives a potential software-assurance benefit for generators, but practical deployment is unvalidated. This is an acceptance risk, not a theorem-validity defect.

### Reviewer 4 — Mathematical and formal correctness

No confirmed flaw was found in the semantic definitions, strict/non-strict clauses, reset policy, residual arguments, or theorem composition. The source-level audit did not independently re-prove the result or compile Rocq.

- **[MINOR, exposition]** The monotonicity argument at `paper1.tex:640–645` is stated in the wrong direction; see Priority 1.
- **[MINOR, scope]** Zero lower-bound cases are excluded from `well_formed`, while the claimed fragment is introduced more broadly. The code comment says zero lower bounds reduce to untimed operators; state that reduction and its applicability in the paper.
- The explicit backend premise and existential initial clock convention are correctly bounded.

### Reviewer 5 — Figures, tables, and experimental reporting

No critical/major figure or table error was found. The existing PDFs were visually inspected.

- **[MINOR]** Figure 4 transition labels are noticeably smaller than body text at normal scale, though legible when enlarged. Simplify or split the diagram.
- Figure states/transitions were consistent with the checked-in Spot `.ltl` and `.dot` artifacts on static inspection.
- Tables describe definitions and proof scope; there are no empirical charts or measured results to audit.

**Limit:** Spot regeneration was not run.

### Reviewer 6 — Methodology, evaluation, and reproducibility

No empirical evaluation is reported, consistently with the paper’s declared claims. Benchmarks are **not required for theorem validity** and would be optional unless the paper adds performance claims. The potential deployment gap is a TSE acceptance question, not an experimental-method defect.

- **[MINOR]** `proof/README_proof.md:12–25` is a less robust duplicate of the root verification instructions: it lacks immediate exit-code checks after each compile/check and does not state the required working directory. Sync it or link to the root README.
- The root README documents Rocq 9.0.1, compile/check/assumption commands, and the limited Spot example. Existing PDFs report 11 main-paper pages and 3 supplement pages.
- The `proof/Makefile` compiles the two modules but is not presented as the complete independent-check recipe.

**Limit:** This reviewer checked source and artifact instructions but did not visually assess layout or run a build.

### Reviewer 7 — Contribution advocate

The strongest defensible contribution is a Rocq-checked semantic assurance result, not a new claim to translate `MTL₀,∞` or to outperform other tools. The concrete delta is a clocked-LTL factorization and formula-keyed sharing theorem under repeated activations, supported by the reset policy and residual obligations.

CASAAL already translates the same broad fragment; the manuscript correctly concedes this and avoids clock-count/performance superiority claims. MightyPPL has an implemented pipeline for a different but overlapping timed-logic scope; this paper’s claimed contribution remains the specific mechanized clock-sharing argument. The result can help tool builders, conditionally on adapters and backend evidence, but does not establish operational or performance impact.

### Reviewer 8 — Contribution skeptic

This reviewer considered the contribution too narrow for TSE as currently presented.

- **[MAJOR, acceptance risk]** The result concerns the paper’s own translation architecture and does not compare clock counts or assurance coverage with CASAAL. The reviewer found the benefit to a tool builder insufficiently demonstrated.
- **[MAJOR, acceptance risk]** The artifact is not an integrated compiler: no frontend, backend-contract discharge, export, or checker consumption is shown. The Spot script only regenerates the propositional graph, and the TBA is hand-derived.
- The reviewer suggested an end-to-end overlapping-response demonstration and comparison on shared inputs. That would be a substantial addition and risks overlapping Paper 2’s downstream tool contribution. The meta-review therefore treats it as a significant dissenting concern, **not a prerequisite benchmark** under the paper’s current no-performance claims. Strengthen the software-risk/assurance explanation and narrow impact language; if the authors want to claim demonstrated deployment, the current evidence is insufficient.

### Reviewer 9 — Related work and novelty

The core novelty boundary remains defensible: Paper 1 claims mechanization of formula-keyed clock sharing and completeness, not first translation or performance superiority.

- CASAAL’s official page and SPIN 2017 paper confirm existing translation support and controller-synthesis context.
- **[MINOR, framing]** MightyPPL TACAS 2026 provides mathematical correctness results/proof sketches as well as an implementation. Distinguish those from Rocq mechanization.
- **[MINOR, coverage]** QEST+FORMATS 2026 author materials report an existentially punctual input class, including a one-sided MTL fragment. The paper’s current single-formula description is incomplete; name the broader restricted class and retain the caveat that it is not unrestricted punctual MTL.
- These related-work revisions improve accuracy and clarify the delta; they do not overturn the central novelty claim.

## Reviewer 10 — Senior meta-review

**Recommendation: Major Revision. Confidence: Moderate.**

The central theorem is credible and technically specific; no specialist found a confirmed theorem defect. The most important correction is the reversed relaxation explanation. The principal editorial risk is TSE fit: the software-impact argument is plausible as potential assurance for a property-automaton generator, but the current evidence does not demonstrate an operational pipeline.

The review does not require performance benchmarking, a full compiler, Paper 2’s optimizer/export, or its UPPAAL case studies. It does require a sharper explanation of the software fault avoided by the clock policy, the exact guarantee an adopter receives, and the assumptions/adapters still required. Complete the MightyPPL comparison, disclose zero-bound reductions and standard library assumptions, rename the worked example, and improve Figure 4 and artifact guidance. The unresolved minority view is that TSE may still expect a concrete consumer; if the authors choose that route, they should add only an upstream demonstration that preserves Paper 2’s distinct downstream contribution.
