# Energy-Grid-Protector - Free Power Grid & Substation OT/SCADA Security Scanner

**Energy-Grid-Protector** is a free, open-source cybersecurity scanning tool that helps utility operators, OT security teams, and critical infrastructure professionals detect internet-exposed power grid systems, substation SCADA networks, and ICS/OT devices before attackers exploit them. Available in both **PowerShell** and **Bash**, Energy-Grid-Protector is built on real CISA ICS advisories, NERC CIP requirements, and vendor-specific CVE intelligence from ABB, Hitachi Energy, Siemens, GE, and SEL.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://docs.microsoft.com/en-us/powershell/)
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey.svg)]()
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen.svg)]()
[![GitHub issues](https://img.shields.io/github/issues/spinfosecurity/Energy-Grid-Protector)](https://github.com/spinfosecurity/Energy-Grid-Protector/issues)
[![GitHub last commit](https://img.shields.io/github/last-commit/spinfosecurity/Energy-Grid-Protector)](https://github.com/spinfosecurity/Energy-Grid-Protector/commits/main)
[![GitHub stars](https://img.shields.io/github/stars/spinfosecurity/Energy-Grid-Protector?style=social)](https://github.com/spinfosecurity/Energy-Grid-Protector/stargazers)

---

## Table of Contents

- [About](#about)
- [Why This Matters](#why-this-matters)
- [What This Tool Does](#what-this-tool-does)
- [Real-World Threat Intelligence](#real-world-threat-intelligence)
- [Key Features](#key-features)
- [Quick Start](#quick-start)
- [Sample Output](#sample-output)
- [What This Does NOT Do](#what-this-does-not-do)
- [Repository Structure](#repository-structure)
- [Documentation](#documentation)
- [Technical Specifications](#technical-specifications)
- [Contributing](#contributing)
- [Issues & Support](#issues--support)
- [References](#references)
- [License](#license)
- [Disclaimer](#disclaimer)

---

## About

Electrical power grids, transmission networks, and substations rely on decades-old industrial control protocols that were never designed with cybersecurity in mind. In 2026, CISA and the Department of Energy have documented increasing exploitation of OT/SCADA systems across utility infrastructure, including critical vulnerabilities in ABB, Hitachi Energy, and Siemens grid equipment.

**Energy-Grid-Protector** gives utility operators, OT security teams, and critical infrastructure defenders a fast, free way to identify these exact exposures on their own networks — without needing expensive commercial scanning tools or deep penetration testing expertise. Aligned with **NERC CIP** requirements (especially CIP-007, CIP-010, and CIP-015 for internal network monitoring).

> 🔎 **Keywords:** power grid cybersecurity, substation security scanner, SCADA vulnerability detection, DNP3 scanner, IEC 61850 security, Modbus TCP exposure, ABB RTU vulnerability, Hitachi Energy SCADA, Siemens grid equipment CVE, NERC CIP compliance tool, OT security scanner, critical infrastructure protection, ICS cybersecurity

## Why This Matters

Critical electrical infrastructure runs on legacy industrial protocols that lack authentication, encryption, and access controls. A single exposed DNP3 outstation, IEC 61850 MMS interface, or unprotected HMI workstation can give an attacker remote control over substations, circuit breakers, and generation assets — with cascading impacts on regional power reliability.

- ⚡ **National security impact**: Grid attacks can cause widespread blackouts affecting hospitals, water systems, and communications
- 🔓 **Protocol-level insecurity**: DNP3, Modbus, and IEC 61850 have no native authentication or encryption
- 🚨 **Active exploitation confirmed**: CISA has documented real-world attacks on utility OT networks since 2024
- 🆓 **Free alternative to commercial tools**: No licensing fees, no vendor lock-in, no NDA required

## What This Tool Does

- **Scans substation and control center networks** for exposed ICS/OT devices, SCADA workstations, and RTUs
- **Detects primary attack vectors**: RDP (3389), VNC (5900), SSH (22), Telnet (23), HTTP/HTTPS (80/443)
- **Identifies ICS protocol exposure**: DNP3 (20000), IEC 61850 MMS (102), Modbus TCP (502), IEC 104 (2404), PROFINET (34962/34963)
- **Fingerprints vendor-specific platforms**: ABB RTU500/600, Hitachi Energy Network Manager™, Siemens SICAM, GE Multilin, SEL relays
- **Flags critical vendor CVEs** including ABB remote code execution vulnerabilities, Hitachi Energy privilege escalation flaws, and Siemens grid equipment CVEs
- **Prioritizes findings by severity** (CRITICAL vs HIGH vs MEDIUM)
- **Generates simple text/CSV reports** for sharing with OT teams, compliance auditors, and CISOs
- **Runs on Windows, Linux, and macOS** via matching PowerShell and Bash implementations

## Real-World Threat Intelligence

This tool is built directly on documented CISA ICS advisories, DOE reports, and vendor CVEs:

| Vendor / System | CVE / Advisory | Severity | Details |
|---|---|---|---|
| ABB RTU500/600 Series | ICSA-25-201-01 (Jul 2025) | 🔴 CVSS 9.8 Critical | Unauthenticated remote code execution via network access to RTU management interface |
| Hitachi Energy Network Manager™ | CVE-2025-38472 | 🔴 CVSS 9.1 Critical | SQL injection in web HMI enables full database compromise and operator credential theft |
| Siemens SICAM PAS / SCADA | CVE-2025-41203 | 🟠 High | Privilege escalation via unprotected engineering interface |
| GE Multilin UR Series Relays | ICSA-25-189-02 (Jun 2025) | 🟠 High | Default credentials and unprotected Modbus TCP exposure |
| DNP3 Protocol | Historical + ongoing | 🔴 Critical | No authentication or encryption; spoofing and command injection trivial |
| IEC 61850 MMS | CISA Advisory (2025) | 🔴 Critical | Unauthenticated attackers can read/write protection settings and control breakers |
| Modbus TCP | Multiple vendor CVEs | 🟠 Medium-High | No authentication; function code injection enables coil/register manipulation |

## Key Features

### 🎯 Vendor-Specific Critical Alerts
Energy-Grid-Protector doesn't just scan generic ports — it fingerprints known vendor platforms and cross-references them against active CISA advisories and vendor CVEs, delivering actionable, vendor-specific remediation guidance instead of generic port-scan output.

### 📡 Protocol Coverage
| Protocol | Port(s) | Standard |
|---|---|---|
| DNP3 (Distributed Network Protocol) | 20000 | IEEE 1815 |
| IEC 61850 MMS (Manufacturing Message Specification) | 102 | IEC 61850-8-1 |
| Modbus TCP | 502 | RFC 9113 |
| IEC 60870-5-104 | 2404 | IEC 60870-5-104 |
| PROFINET | 34962, 34963 | IEC 61158 |
| OPC Classic (DCOM) | 135 | Microsoft DCOM |
| OPC UA | 4840 | IEC 62541 |

## Quick Start

### PowerShell Version (Windows)
```powershell
.\scripts\powershell\Energy-Grid-Protector.ps1
```

### Bash Version (Linux/macOS)
```bash
chmod +x scripts/bash/Energy-Grid-Protector.sh
./scripts/bash/Energy-Grid-Protector.sh
```

Both versions deliver identical scanning logic, vendor fingerprinting, and reporting — pick whichever matches your OS.

## Sample Output

```text
[2026-08-03 22:15:01] [CRITICAL] 10.20.5.33:20000  DNP3 outstation exposed — ABB RTU540 fingerprint detected (unauthenticated, ICSA-25-201-01)
[2026-08-03 22:15:04] [CRITICAL] 10.20.5.41:102     IEC 61850 MMS reachable — Hitachi Energy Network Manager™ HMI (CVE-2025-38472, CVSS 9.1)
[2026-08-03 22:15:07] [HIGH]     10.20.5.55:502     Modbus TCP exposed — GE Multilin UR relay (default credentials likely)
[2026-08-03 22:15:09] [HIGH]     10.20.5.61:3389    RDP exposed on substation SCADA network — segment immediately
[2026-08-03 22:15:12] [MEDIUM]   10.20.5.70:22      SSH reachable — review access policy and MFA enforcement

Scan complete. Findings: 5 (2 CRITICAL, 2 HIGH, 1 MEDIUM)
Report saved: ./reports/Energy-Grid-Protector-20260803-221512.csv
```

## What This Does NOT Do

- ❌ **Does NOT exploit vulnerabilities** — this is a detection and reporting tool, not an attack framework
- ❌ **Does NOT modify device configurations** — scans are read-only and non-intrusive
- ❌ **Does NOT replace commercial penetration testing** — use this for continuous monitoring, not compliance sign-off
- ❌ **Does NOT guarantee NERC CIP compliance** — this tool supports CIP-007, CIP-010, and CIP-015 activities but does not replace formal audits
- ❌ **Does NOT scan IT networks** — focused on OT/SCADA subnets, substations, and control centers

## Repository Structure
