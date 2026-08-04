# Contributing to Energy Grid Protector (EGP)

Thank you for your interest in contributing to Energy Grid Protector! This project aims to improve cybersecurity posture for power grid, transmission, and substation OT/SCADA environments. Contributions from ICS/OT security professionals, researchers, and developers are welcome.

---

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [How to Contribute](#how-to-contribute)
- [Reporting Issues](#reporting-issues)
- [Submitting Pull Requests](#submitting-pull-requests)
- [Development Guidelines](#development-guidelines)
- [CVE & Threat Intelligence Updates](#cve--threat-intelligence-updates)
- [Style Guide](#style-guide)

---

## Code of Conduct

All contributors are expected to maintain a respectful, professional environment. This project serves critical infrastructure security — contributions must be made in good faith and for defensive purposes only.

---

## How to Contribute

### Types of Contributions Welcome

- **New CVE detection modules** for ICS/OT vendors (Hitachi Energy, ABB, Siemens, Schneider Electric, GE, etc.)
- **Protocol scanner enhancements** (DNP3, Modbus, IEC 61850, EtherNet/IP, PROFINET, etc.)
- **Bug fixes** in PowerShell (`EGP.ps1`) or Bash (`EGP.sh`) scanners
- **Documentation improvements** (threat intelligence updates, CISA advisory references)
- **Report template enhancements** (JSON, CSV, HTML output formats)
- **Cross-platform compatibility** fixes

---

## Reporting Issues

1. Search [existing issues](https://github.com/spinfosecurity/Energy-Grid-Protector/issues) before opening a new one.
2. Use the appropriate issue template:
   - **Bug Report**: Scanner errors, false positives/negatives, platform-specific failures
   - **Feature Request**: New CVE checks, protocol support, output formats
   - **Threat Intelligence**: New vendor advisories, updated CVE information
3. Include:
   - Operating system and version
   - PowerShell version (if applicable): `$PSVersionTable.PSVersion`
   - Bash version (if applicable): `bash --version`
   - Command used and full error output
   - Sanitized subnet info (never include real production IP ranges)

---

## Submitting Pull Requests

1. **Fork** the repository and create a feature branch:
   ```bash
   git checkout -b feature/cve-2025-99999-siemens-s7
   ```

2. **Make your changes** following the [Style Guide](#style-guide) below.

3. **Test thoroughly**:
   - PowerShell: Test on Windows 10/11 with PowerShell 5.1 and PowerShell 7+
   - Bash: Test on Ubuntu 20.04+, Debian 11+, and RHEL/CentOS 8+
   - Validate with both `-CveOnly` / `cve_only` fast-scan and full-scan modes
   - Test with valid /24 CIDR input and invalid inputs (error handling)

4. **Update documentation**:
   - Add CVE details to `docs/Threat-Intelligence.md`
   - Add CISA/ICS-CERT references to `docs/CISA-Reference.md` if applicable
   - Update `README.md` threat table if adding new detections

5. **Submit the PR** with:
   - Clear title: `[CVE] Add detection for CVE-XXXX-XXXXX (Vendor ProductName)`
   - Description of what was changed and why
   - Reference to any relevant CISA advisories or NVD entries
   - Screenshot or sample output if applicable

---

## Development Guidelines

### Adding a New CVE Check

**PowerShell (`EGP.ps1`)**:
```powershell
# Add to the $CveChecks hashtable:
'CVE-XXXX-XXXXX' = @{
    Description = 'Vendor ProductName — Vulnerability description'
    Ports       = @(XX, YY)   # Ports associated with the vulnerable service
    Severity    = 'CRITICAL'  # CRITICAL / HIGH / MEDIUM / LOW
    Remediation = 'Reference: https://www.cisa.gov/...'
}
```

**Bash (`EGP.sh`)**:
```bash
# Add to the cve_checks associative array:
cve_checks["CVE-XXXX-XXXXX"]="XX,YY|Vendor ProductName — Description|CRITICAL|https://cisa.gov/..."
```

### Severity Ratings

| Severity | CVSS Range | Usage |
|----------|-----------|-------|
| CRITICAL | 9.0–10.0 | Remote code execution, authentication bypass on critical systems |
| HIGH | 7.0–8.9 | Privilege escalation, significant data exposure |
| MEDIUM | 4.0–6.9 | Local exploitation required, limited impact |
| LOW | 0.1–3.9 | Minimal impact, difficult to exploit |

---

## CVE & Threat Intelligence Updates

When submitting new CVE detections or updating existing ones:

1. Cite the **NVD entry**: `https://nvd.nist.gov/vuln/detail/CVE-XXXX-XXXXX`
2. Cite the **CISA ICS Advisory** if available: `https://www.cisa.gov/news-events/ics-advisories/`
3. Cite the **vendor security bulletin** if available
4. Include affected versions and products
5. Include recommended remediation steps

> ⚠️ **Important**: Never include working exploit code or proof-of-concept payloads. EGP is a **detection and awareness** tool only.

---

## Style Guide

### PowerShell
- Use `[CmdletBinding()]` and proper param blocks with validation attributes
- Prefer `Write-Host` with color coding for console output; `Add-Content` for file logging
- Use `[System.Net.Sockets.TcpClient]` for port checks (no external dependencies)
- Follow verb-noun naming: `Invoke-EgpScan`, `Test-EgpPort`, `Write-EgpReport`
- Comment blocks must include `.SYNOPSIS`, `.DESCRIPTION`, `.PARAMETER`, `.EXAMPLE`

### Bash
- Use `#!/usr/bin/env bash` shebang
- Use `set -euo pipefail` for strict error handling (where scan logic allows)
- All file writes must use `flock` for thread safety in parallel operations
- Use `nc` (netcat) or `/dev/tcp` for port checks — no nmap dependency required
- Variables: `UPPER_CASE` for constants, `lower_case` for locals
- Functions: `snake_case_names`

### Documentation (Markdown)
- Headers: Use `##` and `###` only (no `####` or deeper in main docs)
- Tables: Always include alignment row
- Code blocks: Always specify language (` ```powershell `, ` ```bash `, ` ```json `)

---

## Questions?

Open a [GitHub Discussion](https://github.com/spinfosecurity/Energy-Grid-Protector/discussions) or file an issue with the `question` label.

*EGP is a defensive tool. Use only on networks you own or have explicit written authorization to scan.*
