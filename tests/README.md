# Tests

These tests only parse source files and inspect repository documentation. They do not import or execute scanner scripts and generate no network traffic.

```powershell
Install-Module Pester -Scope CurrentUser
Invoke-Pester ./tests/PowerShell -Output Detailed
```

```bash
bash ./tests/bash/repository_tests.sh
```
