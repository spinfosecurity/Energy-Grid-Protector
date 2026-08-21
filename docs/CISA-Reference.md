# CISA Reference Guide

This document maps EGP findings to authoritative CISA advisories, hardening guides, and
FBI public service announcements relevant to power grid OT/SCADA security.

---

## Active Advisories Referenced by EGP

### CISA Alert AA26-097A — Iranian Cyber Actors Targeting U.S. Grid Infrastructure
- **Issued**: 2026
- **URL**: https://www.cisa.gov/news-events/cybersecurity-advisories/aa26-097a
- **Relevant EGP findings**: RDP (3389), VNC (5900/5901), DNP3 (20000), Telnet (23)
- **Summary**: Documents active probing and exploitation of internet-exposed OT/SCADA
  remote-access services and ICS protocol ports by Iranian state-sponsored actors.
  Substations with RDP or VNC directly reachable from the internet are at immediate risk.

### FBI PSA 2026-08-01 — VNC and RDP Exploitation in ICS Environments
- **Issued**: August 1, 2026
- **URL**: https://www.fbi.gov/
- **Relevant EGP findings**: VNC (5900/5901), RDP (3389)
- **Summary**: FBI warns of ongoing campaigns targeting unprotected VNC and RDP on
  industrial control system networks. Actors use these as initial access vectors for
  ransomware deployment and operational disruption.

---

## CVE-Specific References

### CVE-2026-42945 — Hitachi Energy e-mesh EMS
- **Affected versions**: v4.1.6, v4.4.2, v4.7.0
- **CVSS**: Critical
- **Ports checked by EGP**: 80, 443, 8080, 8443
- **Vendor advisory**: https://www.hitachienergy.com/cybersecurity
- **Remediation**:
  1. Apply the vendor patch immediately.
  2. Isolate EMS management interfaces behind a VPN or firewall with MFA enforcement.
  3. Disable direct internet exposure of web management ports.
  4. Monitor for unauthorized access attempts in EMS audit logs.

### CVE-2025-1445 — Hitachi Energy / ABB / B&R Shared Hardware
- **Affected products**: ABB ACS880 drives with IEC 61131-3 license, B&R hardware
- **CVSS**: Critical
- **Ports checked by EGP**: 102, 2404, 44818, 2222
- **Vendor advisory**: https://www.hitachienergy.com/cybersecurity, https://www.abb.com/cybersecurity
- **Remediation**:
  1. Update firmware per vendor advisories.
  2. Apply IEC 62443 network segmentation — isolate drives in a dedicated automation VLAN.
  3. Restrict IEC 61850, IEC 104, and EtherNet/IP access to known engineering workstations.
  4. Disable unused communication interfaces on affected devices.

### CVE-2025-13162 — ABB Advant Master Online Builder / 800xA
- **Affected products**: ABB Advant Master, ABB 800xA
- **CVSS**: High
- **Ports checked by EGP**: 135, 445, 8080
- **Vendor advisory**: https://www.abb.com/cybersecurity
- **Remediation**:
  1. Apply the ABB Security Advisory patch for 800xA.
  2. Restrict write permissions on all DLL search path directories.
  3. Deploy application allowlisting (e.g., Microsoft AppLocker) on engineering workstations.
  4. Disable OPC Classic/DCOM (port 135) if not required.

---

## Remote Access Hardening

### RDP (TCP 3389)
- Remove RDP from all OT hosts whenever operationally possible.
- If RDP is required, place it behind a VPN with MFA. Do not expose it directly to any
  network segment outside the operations VLAN.
- Enable Network Level Authentication (NLA).
- Reference: CISA Advisory AA26-097A, FBI PSA 2026-08-01.

### VNC (TCP 5900, 5901)
- Disable VNC on all OT/SCADA hosts. If a graphical session is needed, use a VPN-connected
  jump host instead.
- If VNC cannot be disabled, restrict to localhost only and tunnel over SSH.
- Reference: FBI PSA 2026-08-01.

### Telnet (TCP 23)
- Telnet transmits credentials and data in cleartext. Remove it from all OT/SCADA assets.
- Replace with SSH using key-based authentication only.
- Reference: CISA ICS Best Practices.

### FTP (TCP 21)
- Replace FTP with SFTP or SCP. Active ICS malware campaigns use FTP for lateral movement
  and data exfiltration from OT networks.

### SSH (TCP 22)
- Disable password-based authentication. Enforce SSH key pairs only.
- Restrict SSH access to a designated jump host or bastion.
- Enable login banners and audit logging.

### HTTP / HTTPS (TCP 80, 443)
- Disable HTTP (port 80) for web management interfaces. Migrate all management traffic to HTTPS.
- Enforce TLS 1.2 or 1.3 only. Disable SSLv3, TLS 1.0, and TLS 1.1.
- Restrict HTTPS management interfaces to the operations VLAN.

---

## General Hardening Guidance

- **Network segmentation**: Enforce Purdue Model zone separation. OT hosts should not be
  directly reachable from corporate IT networks or the internet.
- **Firewall rules**: Apply default-deny ACLs at OT/IT boundaries. Explicitly permit only
  required traffic flows between zones.
- **MFA**: Require multi-factor authentication for all remote access to OT environments.
- **Patch management**: Maintain a current asset inventory and apply vendor security patches
  within the timeframes required by your NERC CIP CIP-007 patch management plan.
- **Monitoring**: Deploy network monitoring (e.g., Claroty, Dragos, Nozomi, or open-source
  alternatives) to detect anomalous protocol activity on OT segments.

---

## Additional Resources

| Resource | URL |
|---|---|
| CISA ICS Advisories | https://www.cisa.gov/news-events/ics-advisories |
| CISA Vulnerability Reporting | https://www.cisa.gov/report |
| NERC CIP Standards | https://www.nerc.com/pa/Stand/Pages/CIPStandards.aspx |
| DOE CESER Cybersecurity | https://www.energy.gov/ceser/cybersecurity |
| ICS-CERT | https://www.cisa.gov/topics/industrial-control-systems |
