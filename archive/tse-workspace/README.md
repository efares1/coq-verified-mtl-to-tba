# Historical TSE working workspace

This directory preserves the former IEEE Transactions on Software Engineering
working manuscript and its local build tree. Its paper1.tex is not the current
IEEE Access manuscript. The current source and proof snapshot are in
../../ieee_access/.

To reproduce this archival working version, open PowerShell in this directory
and run:

~~~powershell
.\reproduce-tse.ps1
~~~

This workspace intentionally keeps the source, bibliography, figures, proof
snapshot, examples, and build scripts together so their relative paths continue
to work. For the current submission, use ieee_access/reproduce-ieee-access.ps1.
