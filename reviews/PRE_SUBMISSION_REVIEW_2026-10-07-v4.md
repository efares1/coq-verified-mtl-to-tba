# Pre-submission review — IEEE Transactions on Software Engineering

- **Date:** 2026-10-07
- **Paper:** “A Mechanically Verified Translation of MTL\(_{0,\infty}\) into Timed Büchi Automata”
- **Authors:** Elie Fares, Jean-Paul Bodeveix, Hussain Al-Aqrabi, and Azar Salami
**Target venue:** IEEE Transactions on Software Engineering (TSE)

## Executive assessment

The paper presents a coherent formal result: a Rocq-verified semantic translation from pointwise dense-time MTL\(_{0,\infty}\) through clocked LTL to event-guarded timed Büchi automata. Its most distinctive result is completeness with one logical clock per distinct primitive timed subformula despite repeated, overlapping activations. The theorem is stated under a clear LTL-to-Büchi language-equivalence contract, and the paper is unusually candid that the artifact is not a source-to-automaton compiler and makes no performance claim.

I found no confirmed mathematical or proof defect in the reviewed text and sources. The main submission risk is instead TSE impact: the paper explains how a property-automaton generator could use the theorem, but the artifact does not instantiate the complete path from a formula through the verified construction to a model checker. The Spot figure regenerates only a propositional graph; reset completion and target initialization/export are not integrated. This leaves the software consequence plausible and concrete at the level of the overlapping-deadline example, but not demonstrated in a running verification workflow. TSE explicitly welcomes theoretical results when they have potential impact on software construction, analysis, or management; the paper should make that potential more tangible.

**Recommendation: Major Revision. Confidence: Moderate.** This is a pre-submission judgment, not a prediction of an editorial decision. The recommendation is driven by evidence of software impact and artifact integration, not by a confirmed correctness issue. A focused end-to-end demonstrator for one bounded-response property would materially strengthen the TSE case. If that is not feasible, the manuscript should further narrow the software-impact claim and explain precisely what a tool builder can reuse and what remains to be proved or implemented.

## Scope and evidence reviewed

The main source is `paper1.tex`, including its recursively included `worked_translation.tex` and the figure sources `figures/figure_style.tex`, `figures/fig_until_hat.tex`, `figures/fig_sporadic_hat.tex`, `figures/fig_tba_example.tex`, and `figures/fig_steps45.tex`. I also reviewed `references.bib`; `supplement.tex` and `proof_details.tex`; the two Rocq modules, `proof/CheckAssumptions.v`, `proof/ASSUMPTIONS.txt`, `proof/Makefile`, and `proof/README_proof.md`; `README.md`, `build.ps1`, and the Spot example files under `examples/spot/`.

I rendered and visually inspected the tracked `paper1.pdf` (11 pages) and `supplement.pdf` (3 pages). The page count is within the project README’s stated 12-page maximum for the main paper. The supplement supplies omitted reset-completion, soundness/completeness, structural-induction, and theorem-composition arguments plus a Rocq result map; it does not substantially repeat the paper’s semantic development. I did not compile LaTeX or Rocq: the invoked review-paper workflow is read-only and expressly excludes compilation. Therefore, PDF layout was reviewed, but current source-to-PDF synchronization and a fresh proof build were not independently established in this pass.

For the venue and recent related work, I checked TSE’s stated scope and the publisher pages for both 2026 MightyPPL papers. The TSE scope allows well-defined theoretical results when they have potential software impact ([IEEE TSE scope](https://www.computer.org/digital-library/journals/ts/cfp-ieee-transactions-on-software-engineering)). The TACAS 2026 paper describes a complete MightyPPL implementation and experiments as well as a compositional timed-automata construction ([Springer TACAS 2026 chapter](https://link.springer.com/chapter/10.1007/978-3-032-22752-2_24)). The QEST+FORMATS chapter reports an implemented extension for MTL properties including the exact-time request/response form and an evaluation against TEMPORA ([Springer QEST+FORMATS chapter](https://link.springer.com/chapter/10.1007/978-3-032-35298-9_12)). I also checked the official CASAAL project page, which identifies CASAAL as a translator for MTL\(_{0,\infty}\) into timed and deterministic timed Büchi automata ([CASAAL project page](https://lcs.ios.ac.cn/~ligy/tools/CASAAL/)).

The specialist roles 4, 7, and 8 returned independent fresh reports on this HEAD. A new subagent launch was unavailable because the native agent thread limit had been reached. I therefore performed separate role-based passes for roles 1–3, 5–6, and 9, and wrote the senior synthesis myself. Those passes are not independent peer reports.

## Major issues

### [MAJOR] Demonstrate the software impact in a usable path

The introduction now gives a concrete consequence: blindly resetting a formula-keyed response clock on a later request can lose the older request’s age and hide a missed deadline. It also correctly states that the theorem establishes semantic correctness rather than a runtime or automaton-size improvement (`paper1.tex`, Introduction, especially the software-impact and artifact-boundary paragraphs; bounded-response example in §4.3 and Fig. 3). These are meaningful clarifications.

The remaining gap is that the submitted artifact does not demonstrate the claimed use. The Spot script regenerates only the propositional automaton; the manuscript says it does not establish Spot’s contract or generate the reset-completed TBA (`paper1.tex`, Introduction and Fig. 4; `README.md`, “Spot backend example”). The target semantics also permits existential initial clock values, while zero-initialized-clock adaptation, parsing, finite-bound encoding, backend invocation/validation, and export remain outside the artifact. Thus a tool builder is given a theorem and an example of the backend stage, but no tested integration showing that the result can be consumed in a property-checking workflow.

**Recommended change:** add a small executable end-to-end case study for the overlapping bounded-response property. It should show the formula input, a concrete backend result, reset completion, the resulting automaton in a named target format, and one model-checking outcome that distinguishes a valid response trace from a missed older deadline. State which stages are proved, assumed, or tested, and how the target’s clock-initialization convention is handled. This need not be a performance study or a claim against MightyPPL. If a demonstrator is out of scope, revise the software-impact passages to present the result strictly as a formal assurance theorem and explain what additional assumptions and implementation work a tool builder must supply.

## Minor issues

### [MINOR] Narrow the wording about QEST+FORMATS MightyPPL

The comparison in §6 is current and appropriately disclaims equivalence, subsumption, and performance superiority. The TACAS 2026 paragraph describes MightyPPL’s MITL-with-past/Pnueli construction and tool; the QEST+FORMATS paragraph gives the exact-time response example and evaluation against TEMPORA. The official QEST+FORMATS abstract describes model checking MTL properties of the form \(G(p\Rightarrow F_{=5}q)\), rather than establishing a general implementation for punctual MTL. In `paper1.tex` §6, replace “an implemented treatment of punctual MTL” with wording such as “an implemented extension for punctual response properties, including …” and retain the explicit scope caveat that follows. This avoids allowing a broad reading of the comparator.

The BibTeX entry `mightyppl_qest26` uses year 2026 (`references.bib`). The publisher page labels the conference QEST+FORMATS 2026 and gives first-online date 30 August 2026, but its formatted citation lists 2027. Confirm the desired IEEE reference-year convention against the publisher’s final metadata; this is a bibliographic consistency check, not a substantive problem with the related-work comparison.

### [MINOR] Fence the assumption-record command in the project README

In `README.md`, the command to regenerate `proof/ASSUMPTIONS.txt` appears as raw lines outside a fenced PowerShell block, unlike the compile and proof-check commands immediately above it. Put the command and `$LASTEXITCODE` check in a `powershell` code fence so that readers can identify and copy the whole reproduction step.

### [MINOR] Improve legibility of the automata comparison figure

The inspected PDF pages have no obvious clipping, missing figures, or broken page flow. Figure 4 (page 8) is dense, however, and several transition labels are small at normal page scale. Increase label size or simplify the labels and explain the shorthand in the caption. The prose’s explicit account of what the Spot output does and does not establish is useful and should remain.

## Technical correctness and formal boundary

The paper defines its source semantics over pointwise, strictly increasing, time-divergent timed words and states the event-guarded TBA model, clock-update convention, and existential initial valuations. The derived ordinary operators are tied to the eight hatted Until/Release primitives; the upper-bounded Until translation uses strong Until. The proof architecture distinguishes soundness for arbitrary clock-consistent reset traces from completeness using a canonical trace, with residual obligations handling shared clocks under overlapping activations (`paper1.tex` §§2–5; `proof_details.tex` §§2.1–2.4).

The backend boundary is stated consistently: the theorem with suffix `_with` assumes language equivalence for the propositional backend, while the convenience theorem uses `LTL_TO_BUCHI_CORRECT`. The captured assumption record lists the standard-library/classical assumptions for the encoding and `_with` results and the additional backend axiom for the convenience result (`proof/CheckAssumptions.v`, `proof/ASSUMPTIONS.txt`, and `paper1.tex`, §5). The relaxation and reset-completion proof relies on positivity of extended atoms and asymmetric monotonicity of preservation and restart clocks; the paper points to the full argument in the supplement.

The static formal audit found no confirmed gap between the paper’s stated theorem and the Rocq definitions or named proof results. The existential-initial-clock convention, event-guard/no-location-invariant target, and assumptions on backend correctness are limitations of the result, but they are disclosed rather than hidden defects. The external backend is not verified by this development.

## Novelty and contribution

The broad ability to translate MTL\(_{0,\infty}\) to timed automata is not novel: CASAAL already documents such a translation and deterministic approximations. The manuscript now states that plainly and limits its contribution to a machine-checked clocked-LTL factorization, reset completion, and formula-keyed clock-sharing proof. This is the correct framing.

The TACAS 2026 MightyPPL paper is a close software comparator: it describes a runnable implementation, compositional timed-automata construction, and experimental results. The QEST+FORMATS 2026 follow-up is relevant to the response-property use case because it adds exact-time response properties to its implemented pipeline. These works make the assurance-versus-tool distinction important, but do not erase the paper’s distinct theorem. The manuscript does not claim to cover MightyPPL’s full logic, to subsume it, or to outperform it. I found no basis in the checked sources for a priority claim that this is the first MTL\(_{0,\infty}\) translation, and the paper explicitly disclaims that claim.

The specific CASAAL construction details are supported here by its project page and cited literature, but I did not independently reconstruct CASAAL’s internal clock policy. The manuscript appropriately avoids asserting that CASAAL uses more clocks or that the present method reduces automaton size.

## Experimental evaluation and reproducibility

There is no benchmark or experimental claim to audit, and a comparative performance study is not necessary to support the theorem as currently stated. A small integrated case study is nevertheless high value because it would support the paper’s TSE software-impact argument. The README records Rocq 9.0.1 / OCaml 4.14.2, direct compile and independent-check commands, and a Spot 2.16 regeneration command. The Spot script checks the version and writes the DOT output. The manuscript and README correctly limit that script’s evidential role.

The recorded assumption output is useful evidence, but no compile or assumptions command was rerun in this read-only review. The PDF render was inspected from the tracked files; no fresh LaTeX build was performed to establish that the PDFs exactly match all current source files.

## Presentation and likely reviewer objections

The main PDF is compact but readable overall. The supplement contains the proofs and proof map that are not fully presented in the article, and its introduction explicitly says it does not restate the main-paper definitions. No major paper/supplement duplication was identified in the inspected material. The current 11-page article is within the repository’s stated 12-page cap; there is no need to add material merely to reach 12 pages.

Likely TSE objections are:

1. “What can an implementer use today?” The answer remains a mechanized semantic core, but the checked-in example does not invoke it end to end.
2. “Can the resulting automaton be consumed by a standard checker?” Not without an initialization/export adapter whose correctness is outside the theorem.
3. “Is the contribution different from MightyPPL?” The paper now makes a credible distinction—verified semantic assurance versus implemented analysis—but a small integration example would make the former’s practical value clearer.
4. “Does clock sharing improve the system?” The paper proves a bound on logical clocks and safe reuse, but makes no measured speed or automaton-size claim. Keep this limitation explicit.

## Prioritized changes before submission

1. **P1 — Add an executable integration case** for an overlapping bounded-response property, including target clock initialization and one model-checking result; label the proof, backend assumption, and tested adapter boundary separately.
2. **P1 — If no integration can be supplied, tighten the software-impact claim** so it promises only the reusable semantic assurance result and gives concrete integration obligations without implying a currently usable compiler component.
3. **P2 — Bound the QEST+FORMATS comparison phrase** to the implemented punctual response-property extension and reconcile the BibTeX publication year with the final Springer metadata.
4. **P3 — Fix the README code fence** around the assumption-record command.
5. **P3 — Enlarge or simplify Fig. 4 transition labels** for print-scale readability.

## Specialist reports

### Reviewer 1 — Language and academic presentation

The prose is generally clear and technically restrained. Terms such as “formula-keyed clock,” “canonical reset policy,” and “existential initial clock valuations” are used consistently. The abstract and introduction state the scope limits before a reader could mistake the artifact for a full compiler. No grammar or terminology issue changes the technical meaning. The dense proof paragraphs and small Fig. 4 labels merit a final print-scale copy edit. No major language finding.

### Reviewer 2 — Internal consistency, references, and claims

The abstract, introduction, theorem statements, proof-boundary table, conclusion, README, and assumption record agree on the theorem’s backend premise and implementation boundary. The “one clock per distinct primitive timed subformula” result is consistently described as a clock-count guarantee, not as a measured automaton-size improvement. The QEST+FORMATS 2026 wording should be narrowed to the exact response-property extension, and its publication year should be checked against Springer metadata. The README’s assumption-record command should be fenced. No broken cross-reference or visibly unresolved citation was found in the inspected PDF.

### Reviewer 3 — Technical narrative and unsupported claims

The narrative supports its formal claims and avoids causal or performance claims not backed by evidence. The request/ack example explains why preserving an older reference matters when the same formula clock is shared. The important unsupported part is not theorem correctness but practical adoption: parsing, finite bound encoding, external backend use, initialization, and export are all excluded. Treat this as an impact/evaluation gap, not as evidence that the theorem is false. No separate confirmed technical defect.

### Reviewer 4 — Mathematical and formal correctness (independent report)

**Finding: no confirmed mathematical or proof defect; confidence moderate.** The independent static audit checked the upper-bounded hatted Until clause against the Rocq source, semantic domains and well-formedness conditions, formula-keyed clocks, reset policy, existential initial values, the eight primitive proof families, and the assumption boundary. It confirmed that the `_with` theorem takes backend correctness as a premise, while the convenience theorem uses `LTL_TO_BUCHI_CORRECT`. It did not compile the proof or validate an external backend, and therefore cannot confirm that the captured assumption output reproduces from the current sources.

### Reviewer 5 — Figures, tables, and visual reporting

All 11 main-paper pages and all 3 supplement pages were rendered and inspected. The plots/automata correspond to the surrounding descriptions, the tables are legible, and no page has an evident clipping or blank-page issue. Figure 4 is the least legible visual: its transition labels are small and dense. The manuscript appropriately labels the Spot graph illustrative and distinguishes it from the reset-completed TBA. There are no statistical figures or experimental tables.

### Reviewer 6 — Methodology, evaluation, and reproducibility

The formal proof is the method, so conventional benchmark requirements do not apply to the theorem and the paper claims no performance result. Reproduction instructions identify Rocq and Spot versions and commands; the checked-in Spot script produces the propositional DOT graph only. The key reproducibility gap is that no example drives the Rocq development, a concrete backend, reset completion, and a target checker in a single path. A small end-to-end case study is more valuable here than a broad, incomparable benchmark suite. The review did not rerun compile commands.

### Reviewer 7 — Contribution advocate (independent report)

**Recommendation: Minor Revision; confidence moderate.** The strongest contribution is the Rocq proof of completeness for formula-keyed clock sharing under overlapping activations, across strict and non-strict timed primitives, under an explicit backend contract. CASAAL already provides the broad translation capability, and MightyPPL already supplies practical timed-automata toolchains, so the sound claim is formal assurance rather than first translation or efficiency. The manuscript has improved this distinction and describes the limitations honestly. A backend-contract instantiation or small adapter example would strengthen the paper but is not viewed as essential to the mathematical result.

### Reviewer 8 — Contribution skeptic (independent report)

**Recommendation: Major Revision; confidence moderate.** The paper does not demonstrate the proposed software impact in an executable verification workflow. Its own scope excludes the parser, finite textual bounds, backend integration, initialization adapter, and export, and the Spot figure only illustrates the backend stage. MightyPPL makes the practical comparison sharper: it has an implemented timed-automata pipeline, while the present work has a different assurance contribution. A concrete backend instantiation and one end-to-end property checked in an existing pipeline—or equivalent integration evidence—would materially improve the TSE case. The skeptic did not identify hidden proof unsoundness or an inaccurate claim that the two tools have identical scope.

### Reviewer 9 — Related work and novelty

The comparison with CASAAL is appropriately candid: CASAAL already translates MTL\(_{0,\infty}\), and the manuscript disclaims a first-translation or automaton-size claim. The two MightyPPL entries are current and relevant. The TACAS chapter supports the description of a complete implementation and compositional construction; the QEST+FORMATS chapter supports the exact-time response example and TEMPORA evaluation. Keep the latter’s scope explicit as the implemented property family, rather than allowing “punctual MTL” to suggest a broader supported fragment. This wording adjustment does not change the novelty assessment. CASAAL’s internal clock policy was not independently checked, and the manuscript correctly makes no comparative clock-count claim.

## Reviewer 10 — Senior meta-review

The paper’s strongest evidence is its substantial Rocq development, the consistency between the theorem claims and named source results, and a clearly disclosed backend contract. The core novelty is a machine-checked semantic factorization and proof that one formula-keyed clock suffices under repeated activations. The proof audit found no confirmed correctness issue, and the recent-related-work discussion now fairly distinguishes the result from the implemented MightyPPL pipeline.

The unresolved decision is how much evidence TSE should require for the asserted software impact. Reviewer 7 considers the explicit semantic guarantee and plausible tool-builder use sufficient for minor revision. Reviewer 8 considers the absence of an integrated example material because the artifact is not yet usable in a model-checking path. The paper’s own boundaries support both readings: they preserve theorem precision, but also leave the software consequence untested. TSE’s stated scope admits theory with potential software impact, so a complete production tool or performance comparison is not required. Still, the current Spot example stops before the novel reset-completion layer and the target checker. On balance, this leaves a material, addressable acceptance risk.

**Final recommendation: Major Revision; confidence Moderate.** Add a compact end-to-end property-automaton case, or substantially narrow the software-impact framing and explain the integration contract in operational terms. There is no basis in this review to reject the formal result, and no confirmed mathematical error. The remaining conclusions are limited by the absence of a fresh Rocq/LaTeX build and by the fact that only three roles returned independent agent reports; the remaining role reviews and this synthesis were performed by the lead reviewer.
