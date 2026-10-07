# Addendum: related Paper 2 and software-impact recommendation

This note updates the software-impact recommendation in
`PRE_SUBMISSION_REVIEW_2026-10-07-v4.md` after inspecting the companion IEEE
Access manuscript and its artifact.

The v4 report recommended adding a full end-to-end UPPAAL demonstration to
Paper 1. That recommendation was made without the Paper 2 context and should
not be followed literally. Paper 2 reuses the same Rocq MTL-to-TBA translation
proof and extends the pipeline with generic, language-preserving TBA
optimization and UPPAAL-oriented export, an extracted implementation, and
evaluation including UPPAAL case studies. Repeating that full demonstration in
Paper 1 would blur the contribution boundary without adding a distinct result.

Keep Paper 1 focused on the translation theorem and its clock-sharing result
under overlapping activations. Its software-impact discussion should explain
the concrete assurance consequence for a tool builder, while retaining the
stated limits on parsing, backend validation, initialization adapters, and
export. Disclose the shared proof and the distinct downstream contributions to
both journal editors, and provide both manuscripts for comparison.

This addendum changes only the recommendation about duplicating an integrated
UPPAAL case study. It does not replace the remaining technical and editorial
findings in the v4 report.
