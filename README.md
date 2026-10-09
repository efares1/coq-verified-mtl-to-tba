# Paper 1 workspace

This repository contains the current IEEE Access submission files and clearly
separated historical material.

## Which paper1.tex is current?

| Path | Role |
|---|---|
| [ieee_access/paper1.tex](ieee_access/paper1.tex) | **Canonical editable source** for the current IEEE Access article. Its matching PDF is ieee_access/paper1.pdf. |
| [release/ieee-access-paper1-submission-v3/paper1.tex](release/ieee-access-paper1-submission-v3/paper1.tex) | Frozen source copy in the v3 submission package. It is expected to match the canonical source byte for byte. |
| [archive/tse-workspace/paper1.tex](archive/tse-workspace/paper1.tex) | Historical TSE-formatted working manuscript. It is not the current submission. |

The repeated filename in the release package is intentional: it preserves the
exact manuscript included in that versioned archive. Edit the canonical file
under ieee_access/, then refresh the release snapshot only when preparing a
new versioned package.

## Build and reproduce the current article

From PowerShell:

~~~powershell
Set-Location .\ieee_access
.\reproduce-ieee-access.ps1
~~~

The Access README documents required tools, the Rocq checks, assumptions audit,
Python assurance checks, and LaTeX build procedure.

## Historical TSE workspace

The former TSE-formatted working source and its build dependencies are grouped
under [archive/tse-workspace/](archive/tse-workspace/). To build that archival
version, run .\reproduce-tse.ps1 from that directory. The historical TSE
package is kept separately in the author's local release archive.

## Assurance boundary

The paper establishes semantic correctness of the specified MTL-to-TBA
construction and its composition with an explicit propositional backend
contract. MTL_to_TBA_correct_with takes backend equivalence as a premise;
MTL_to_TBA_correct additionally depends on the project-specific
LTL_TO_BUCHI_CORRECT axiom. The alarm theorem proves a contract for a manually
transcribed Rocq record, not Spot or the graph-to-record path. This is a
verified semantic translation theorem, not an executable verified compiler.

## Current versioned package

The v3 IEEE Access package is in
[release/ieee-access-paper1-submission-v3/](release/ieee-access-paper1-submission-v3/)
and release/ieee-access-paper1-submission-v3.zip. The package includes its
source snapshot, matching PDF, proof sources, audit, scripts, and SHA-256
manifest. No DOI or immutable public release tag has been assigned.

## Submission documents

- [IEEE_ACCESS_FINAL_SUBMISSION_REPORT.md](IEEE_ACCESS_FINAL_SUBMISSION_REPORT.md)
- [IEEE_ACCESS_AUTHOR_ACTION_CHECKLIST.md](IEEE_ACCESS_AUTHOR_ACTION_CHECKLIST.md)
- [IEEE_ACCESS_SUBMISSION_CHECKLIST.md](IEEE_ACCESS_SUBMISSION_CHECKLIST.md)
- [RELATED_SUBMISSION_DISCLOSURE.md](RELATED_SUBMISSION_DISCLOSURE.md)
