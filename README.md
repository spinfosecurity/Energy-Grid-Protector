# Energy Grid Protector (EGP) - Free Power Grid & Substation OT/SCADA Security Scanner

**Energy-Grid-Protector** is a free, open-source cybersecurity scanning tool that helps utility operators, OT security teams, and critical infrastructure professionals detect internet-exposed power grid systems, substation SCADA networks, and ICS/OT devices before attackers exploit them. Available in both **PowerShell** and **Bash**, Energy-Grid-Protector is built on real CISA ICS advisories, NERC CIP requirements, and vendor-specific CVE intelligence from ABB, Hitachi Energy, Siemens, GE, and SEL.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![PowerShell](https://img.shields.io/badge/PowerShell-5.1%2B-blue.svg)](https://docs.microsoft.com/en-us/powershell/)
[![Bash](https://img.shields.io/badge/Bash-4.0%2B-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Windows%20%7C%20Linux%20%7C%20macOS-lightgrey.svg)]()
[![NERC CIP Aligned](https://img.shields.io/badge/NERC%20CIP-CIP--007%20%7C%20CIP--010%20%7C%20CIP--015-orange)](#)
[![CISA Aligned](https://img.shields.io/badge/CISA-ICS%20Advisories%20Aligned-red)](#)
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
- [FAQ](#faq)
- [Who This Is For](#who-this-is-for)
- [Documentation](#documentation)
- [Technical Specifications](#technical-specifications)
- [Contributing](#contributing)
- [Issues & Support](#issues--support)
- [Support This Project](#support-this-project)
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
- **Detects primary attack vectors**: RDP (3389), VNC (5900/5901), SSH (22), Telnet (23), FTP (21), HTTP/HTTPS (80/443)
- **Identifies ICS protocol exposure**: DNP3 (20000), IEC 61850 MMS (102), Modbus TCP (502), IEC 104 (2404), EtherNet/IP (44818/2222), PROFINET (34962/34963), OPC UA (4840)
- **Flags critical vendor CVEs** including Hitachi Energy e-mesh EMS, ABB/B&R firmware vulnerabilities, ABB 800xA DLL hijacking, and RTU500 multi-CVE clusters
- **Prioritizes findings by severity** (CRITICAL / HIGH / MEDIUM) with color-coded console output
- **Deduplicates findings** — each IP:port pair is reported once regardless of how many checks match it
- **Generates timestamped text reports** saved to `./reports/` for sharing with OT teams, compliance auditors, and CISOs
- **Runs on Windows, Linux, and macOS** via matching PowerShell and Bash implementations
- **No external dependencies** — uses only `/dev/tcp` (Bash) or .NET `TcpClient` (PowerShell); no nmap, nc, or Python required

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
.\scripts\powershell\EGP.ps1 -Subnet 192.168.10.0/24
```

Optional parameters:
```powershell
# Fast CVE-only scan with 1 second timeout
.\scripts\powershell\EGP.ps1 -Subnet 192.168.10.0/24 -TimeoutMs 1000 -CveOnly

# Full scan with custom output directory
.\scripts\powershell\EGP.ps1 -Subnet 192.168.10.0/24 -OutputDir C:\Reports\EGP
```

### Bash Version (Linux/macOS)
```bash
chmod +x scripts/bash/EGP.sh
./scripts/bash/EGP.sh -s 192.168.10.0/24
```

Optional parameters:
```bash
# Fast CVE-only scan with 2 second timeout
./scripts/bash/EGP.sh -s 192.168.10.0/24 -t 2 -c

# Full scan with custom output directory
./scripts/bash/EGP.sh -s 192.168.10.0/24 -o /var/log/egp
```

Both versions deliver identical scanning logic and severity-tagged reporting — pick whichever matches your OS.

## Sample Output

```text
============================================================
  Energy Grid Protector (EGP) v1.1.0
  OT/SCADA Cybersecurity Scanner - Power Grid Edition
  github.com/spinfosecurity/Energy-Grid-Protector
  Ref: CISA AA26-097A | FBI PSA 2026-08-01
  USE ONLY ON NETWORKS YOU ARE AUTHORIZED TO SCAN
============================================================

[*] Mode       : FULL SCAN
[*] Target     : 10.20.5.0/24
[*] Timeout    : 1s per port
[*] Report     : ./reports/EGP_Report_20260803_221500.txt

[*] Progress: [##########################                ] 52% | Host: 10.20.5.33

  [CRITICAL] 10.20.5.33:20000 - RTU500-MULTI-CVE
    Hitachi Energy RTU500 Series - Multiple disclosed vulnerabilities ...

  [HIGH] 10.20.5.41:102 - ICS-PROTOCOL:IEC-61850/S7
    IEC 61850 MMS / Siemens S7 port exposed ...

  [HIGH] 10.20.5.55:502 - ICS-PROTOCOL:Modbus
    Modbus TCP exposed. No native authentication or encryption ...

  [HIGH] 10.20.5.61:3389 - REMOTE-ACCESS:RDP
    Remote Desktop Protocol exposed on OT network ...

  [MEDIUM] 10.20.5.70:22 - REMOTE-ACCESS:SSH
    SSH port open on OT host. Ensure key-based auth only ...

============================================================
  SCAN COMPLETE
  Hosts Scanned : 254
  Findings      : 5
  Report Saved  : ./reports/EGP_Report_20260803_221512.txt
============================================================

[!] ACTION REQUIRED: Review findings and apply remediations.
    See docs/CISA-Reference.md and docs/Threat-Intelligence.md
```

## What This Does NOT Do

- ❌ **Does NOT exploit vulnerabilities** — this is a detection and reporting tool, not an attack framework
- ❌ **Does NOT modify device configurations** — scans are read-only and non-intrusive
- ❌ **Does NOT replace commercial penetration testing** — use this for continuous monitoring, not compliance sign-off
- ❌ **Does NOT guarantee NERC CIP compliance** — this tool supports CIP-007, CIP-010, and CIP-015 activities but does not replace formal audits
- ❌ **Does NOT scan IT networks** — focused on OT/SCADA subnets, substations, and control centers

## Repository Structure

```
Energy-Grid-Protector/
├── README.md
├── CHANGELOG.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── SECURITY.md
├── ROADMAP.md
├── LICENSE
├── reports/                  # Generated scan reports (text)
├── scripts/
│   ├── powershell/           # PowerShell version for Windows
│   │   └── EGP.ps1
│   └── bash/                 # Bash version for Linux/macOS
│       └── EGP.sh
├── docs/
│   ├── CISA-Reference.md     # CISA advisory and remote-access hardening guidance
│   ├── Threat-Intelligence.md # ICS protocol threat context and hardening
│   ├── threat-model.md       # Scope and false positive caveats
│   ├── safe-operation.md     # Operational safety guidance
│   └── sample-report.md      # Example scan output
└── tests/
    ├── bash/
    │   └── repository_tests.sh
    └── PowerShell/
        └── Repository.Tests.ps1
```

---

## FAQ

**Q: Does this tool require admin/root privileges?**  
A: No. Basic port scanning uses standard TCP connections. No raw sockets or packet crafting required.

**Q: Will this trigger IDS/IPS alerts on my substation network?**  
A: Possibly. Port-level scanning is detectable. Always coordinate with your NOC and energy operations team and obtain written authorization before scanning any production OT network.

**Q: Does it exploit any of the CVEs it detects?**  
A: No. This tool only detects port reachability and fingerprints vendor banners. It does not send exploit payloads, attempt authentication, or modify any device.

**Q: Can I run this on an air-gapped substation network?**  
A: Yes. No internet access is required. Copy the script to a jump host inside the air-gapped environment.

**Q: Is this NERC CIP compliant?**  
A: This tool supports CIP-007 (Security Management Controls), CIP-010 (Configuration Change Management), and CIP-015 (Internal Network Security Monitoring) activities, but it does not replace a formal NERC CIP audit or assessment.

**Q: Can I integrate reports into my SIEM or ticketing system?**  
A: Yes. Reports are plain-text with a consistent `[timestamp] [severity] IP:port - label | description | REMEDIATION: ...` format, making them easy to parse with standard log shippers (Filebeat, Splunk Universal Forwarder) or import into ServiceNow and Jira.

**Q: Is it free for commercial use by utilities?**  
A: Yes — MIT License. Use it, modify it, redistribute it. Attribution appreciated.

---

## Who This Is For

- **Utility OT security engineers** at electric cooperatives, investor-owned utilities, and municipal power authorities
- **Substation automation engineers** responsible for RTU, relay, and SCADA network security
- **NERC CIP compliance teams** documenting CIP-007 and CIP-010 control evidence
- **ICS/SCADA penetration testers** conducting initial reconnaissance on grid environments
- **Incident responders** triaging suspected intrusions across control center networks
- **Energy sector CISOs** needing a free, fast exposure snapshot before a formal risk assessment

---

## Documentation

| Document | Description |
|---|---|
| [docs/CISA-Reference.md](docs/CISA-Reference.md) | CISA advisory details, CVE remediation steps, remote access hardening |
| [docs/Threat-Intelligence.md](docs/Threat-Intelligence.md) | ICS protocol threat context, adversary tactics, protocol hardening |
| [docs/threat-model.md](docs/threat-model.md) | Scope definition and false positive caveats |
| [docs/safe-operation.md](docs/safe-operation.md) | Operational safety guidance before scanning |
| [docs/sample-report.md](docs/sample-report.md) | Example scan report output |

## Technical Specifications

- **Supported OS**: Windows 10/11, Linux (Ubuntu, Debian, RHEL, CentOS), macOS
- **PowerShell**: 5.1+ (Windows PowerShell) or 7.0+ (PowerShell Core)
- **Bash**: 4.0+ (Linux/macOS)
- **Network Requirements**: Direct or routed access to target OT/SCADA subnets
- **Privileges**: No elevated privileges required
- **Scan scope**: /24 subnets (254 hosts); each host scanned across up to 20+ ports depending on mode
- **Deduplication**: Each IP:port pair reported once; overlapping CVE and protocol checks do not produce duplicate findings

## Contributing

Contributions are welcome! Please read [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines on:
- Reporting bugs or false positives
- Suggesting new vendor fingerprints or protocol parsers
- Improving scan performance or report formatting
- Adding support for additional ICS protocols

## Issues & Support

Found a bug? Have a feature request? [Open an issue](https://github.com/spinfosecurity/Energy-Grid-Protector/issues). For security vulnerabilities in the tool itself, see [SECURITY.md](./SECURITY.md).

---

## ⭐ Support This Project

If Energy-Grid-Protector helped you find a real exposure on your grid infrastructure, consider:

- ⭐ **Starring this repo** — it helps other utility security teams discover it
- 🐛 **Opening an issue** if you find a bug or want a new vendor/CVE added
- 🤝 **Contributing** — see [CONTRIBUTING.md](./CONTRIBUTING.md)
- 💬 **Sharing** with your energy sector ISAC contacts, NERC CIP team, or SOC colleagues

> Built by [@spinfosecurity](https://github.com/spinfosecurity) — learning by building free tools that detect and protect critical infrastructure.

---

## References

- CISA Industrial Control Systems Advisories: [https://www.cisa.gov/ics](https://www.cisa.gov/ics)
- NERC CIP Standards: [https://www.nerc.com/standards](https://www.nerc.com/standards)
- DOE Cybersecurity for Energy Delivery Systems: [https://www.energy.gov/ceser/cybersecurity](https://www.energy.gov/ceser/cybersecurity)
- IEC 62351 (Power systems management and associated data exchange security): [https://webstore.iec.ch](https://webstore.iec.ch)
- [Security Policy](./SECURITY.md)

## License

This project is licensed under the MIT License — see the [LICENSE](LICENSE) file for details.

## Disclaimer

This tool is provided for **defensive, authorized security testing only**. Users must have explicit permission from asset owners before scanning any network. The authors assume no liability for misuse, service disruption, or compliance gaps. Always test in a staging environment before production deployment. OT networks are sensitive — use passive scanning modes where possible and coordinate with operations teams.
