# Threat Intelligence Reference

This document provides the threat intelligence foundation for EGP's ICS protocol checks
and vendor CVE definitions, including adversary tactics, affected protocols, and
protocol-level hardening guidance.

---

## ICS Protocol Threat Landscape

### DNP3 — Distributed Network Protocol (TCP 20000)

**Standard**: IEEE 1815  
**Used in**: Substations, RTUs, protective relays, SCADA outstations

**Threat context**:  
DNP3 was designed for reliable communication in electrically noisy environments, not for
security. It has no native authentication or encryption in most implementations. CISA
Alert AA26-097A documents Iranian state-sponsored actors conducting reconnaissance and
probing against internet-exposed DNP3 endpoints on U.S. grid infrastructure.

**Attack surface**:
- Unauthenticated command injection (function codes 3, 4 — direct operate/SBO)
- DNP3 spoofing from any host that can reach the master station port
- Denial of service via malformed application layer PDUs

**Hardening**:
1. Restrict DNP3 (TCP 20000) to an explicit IP ACL permitting only the designated master
   station IP addresses.
2. Enable DNP3 Secure Authentication (SA) v5 (IEEE 1815-2012 Annex A) where supported by
   RTU firmware. Requires shared HMAC key provisioning.
3. Monitor for unexpected master station source IPs and function code anomalies.
4. Never expose DNP3 to internet-routable addresses.

---

### Modbus TCP (TCP 502)

**Standard**: Modbus Application Protocol Specification v1.1b3  
**Used in**: PLCs, drives, relays, meters, process controllers

**Threat context**:  
Modbus TCP has no authentication, no encryption, and no built-in authorization. Any host
that can establish a TCP connection to port 502 can read any coil, register, or discrete
input — and write any output coil or holding register. Multiple vendor CVEs have been
assigned for Modbus TCP implementations with buffer overflow conditions on malformed
function codes.

**Attack surface**:
- Read any process variable (function codes 1, 2, 3, 4)
- Write any output (function codes 5, 6, 15, 16)
- No session state — any source IP can send commands

**Hardening**:
1. Apply firewall ACLs restricting Modbus TCP (port 502) to the designated master station
   and engineering workstation IP addresses only.
2. Deploy a unidirectional gateway (data diode) for historian connections to Modbus data.
3. Monitor for unexpected function code 5, 6, 15, 16 (write) commands from unauthorized sources.
4. Enable Modbus/TCP Security (MBAP Security extension) where supported.

---

### IEC 61850 MMS / Siemens S7 (TCP 102)

**Standard**: IEC 61850-8-1 (MMS), ISO 8650-1 (ACSE/MMS transport)  
**Used in**: Substation automation, protection IEDs, bay controllers, Siemens S7 PLCs

**Threat context**:  
IEC 61850 MMS (Manufacturing Message Specification) enables reading and writing of
logical nodes, datasets, and control objects on IEDs and bay controllers. Unauthorized
access to IEC 61850 MMS can allow an attacker to read protection settings, modify
control objects, and potentially operate circuit breakers. CISA has documented advisories
for multiple IEC 61850 stacks with authentication bypass vulnerabilities.

Port 102 is also used by Siemens S7 (ISO-TSAP) communication, which similarly lacks
native authentication in older S7-300/400 hardware generations.

**Hardening**:
1. Restrict port 102 to an explicit IP ACL permitting only authorized engineering
   workstations and SCADA/EMS systems.
2. Enable role-based access control and authentication in IEC 61850 client-server
   configurations where the IED firmware supports it (IEC 62351-8).
3. Segment IED networks from the control center VLAN using a firewall or data diode.
4. For Siemens S7, upgrade to S7-1200/1500 hardware with TLS-secured S7+ communication.

---

### IEC 60870-5-104 / IEC 104 (TCP 2404)

**Standard**: IEC 60870-5-104  
**Used in**: SCADA control centers, RTUs, protective relays, IEDs

**Threat context**:  
IEC 104 is the TCP/IP adaptation of IEC 60870-5-101 used for SCADA telecontrol. It
carries command and data objects for substation control, including time-tagged commands
for circuit breaker operation. Like IEC 61850 and DNP3, the base protocol lacks
authentication, making any host that can reach port 2404 a potential control plane
attacker.

**Hardening**:
1. Restrict IEC 104 (TCP 2404) to the designated control center master station IP range.
2. Implement IEC 62351-5 security extensions where supported (challenge-response
   authentication for IEC 104 command objects).
3. Log all IEC 104 command object transmissions (ASDU type IDs 45–64) for anomaly detection.

---

### EtherNet/IP — CIP (TCP 44818, UDP 2222)

**Standard**: ODVA EtherNet/IP, IEC 61158 Type 2  
**Used in**: Allen-Bradley / Rockwell Automation PLCs, drives, safety controllers

**Threat context**:  
EtherNet/IP (Common Industrial Protocol over Ethernet) is used extensively in
manufacturing and utility OT environments. Port 44818 carries CIP explicit messaging
(read/write tag operations). Port 2222 carries CIP implicit I/O (real-time cyclic
data). An attacker who can reach these ports can enumerate the device, read and write
tags, and potentially control physical outputs.

**Hardening**:
1. Restrict ports 44818 and 2222 to the PLC management VLAN and authorized engineering
   workstation IP addresses.
2. Disable unused CIP services in Logix controllers (e.g., disable FactoryTalk services
   if not needed).
3. Enable EtherNet/IP authentication extensions where supported by the controller firmware.

---

### PROFINET (TCP/UDP 34962, 34963)

**Standard**: IEC 61158 Type 10  
**Used in**: Siemens, Phoenix Contact, Beckhoff PLCs and drives

**Threat context**:  
PROFINET RT (Real Time) uses port 34962 for cyclic I/O data and port 34963 for alarm
and acyclic data. Exposure of PROFINET outside the automation cell allows an attacker to
read and write I/O data, impersonate controllers, or inject alarms.

**Hardening**:
1. Restrict PROFINET ports (34962, 34963) to the dedicated automation VLAN using a
   Layer 2 managed switch with VLAN segmentation.
2. Enable PROFINET device access control (DAC) where supported.
3. Do not route PROFINET traffic across Layer 3 boundaries unless explicitly required.

---

### OPC UA (TCP 4840)

**Standard**: IEC 62541, OPC Foundation UA Specification  
**Used in**: Historian connections, SCADA/DCS integration, vendor-neutral data exchange

**Threat context**:  
OPC UA provides a vendor-neutral, service-oriented communication model for OT data
exchange. Unlike legacy OPC Classic (which relies on DCOM), OPC UA includes a security
model with certificate-based authentication, message signing, and encryption. However,
misconfigurations (e.g., anonymous endpoint policy enabled, self-signed certificates
without verification, missing endpoint security policies) are common and leave OPC UA
endpoints effectively unauthenticated.

**Hardening**:
1. Disable the OPC UA anonymous authentication endpoint. Require certificate-based
   client authentication.
2. Enforce `SignAndEncrypt` security mode on all OPC UA connections.
3. Validate client certificates against an internal CA. Do not accept self-signed
   certificates from unknown clients.
4. Restrict TCP 4840 to the historian and SCADA server IP addresses only.

---

## Hitachi Energy RTU500 Series — Multi-CVE

The EGP finding `RTU500-MULTI-CVE` aggregates multiple publicly disclosed vulnerabilities
in the Hitachi Energy RTU500 product line, including:

- Authentication bypass via crafted protocol messages
- Denial of service via malformed DNP3 and IEC 104 frames
- Improper certificate validation allowing man-in-the-middle attacks on secured channels

**Affected products**: RTU500 series (all hardware generations prior to patched firmware)  
**Affected ports**: 20000 (DNP3), 2404 (IEC 104), 102 (IEC 61850/MMS), 443 (HTTPS management)

**Remediation**:
1. Upgrade RTU500 firmware to the latest patched release per the Hitachi Energy security advisory.
2. Enforce strict certificate validation on all TLS-secured channels.
3. Restrict DNP3 and IEC 104 access to the designated master station IP addresses.
4. Monitor RTU syslog for authentication failure events.

**References**:
- Hitachi Energy Security Advisories: https://www.hitachienergy.com/cybersecurity
- CISA ICS Advisories: https://www.cisa.gov/news-events/ics-advisories

---

## Adversary Tactics — OT Kill Chain Mapping

| Stage | Tactic | Relevant EGP Findings |
|---|---|---|
| Initial Access | Exploit internet-exposed remote access | RDP, VNC, Telnet, SSH |
| Discovery | Enumerate ICS protocols | DNP3, Modbus, IEC 61850, IEC 104 |
| Lateral Movement | Use FTP/SMB for payload delivery | FTP (21), SMB (445) |
| Execution | Exploit unpatched RTU/IED firmware | CVE-2026-42945, CVE-2025-1445, RTU500-MULTI-CVE |
| Impact | Issue unauthorized control commands | DNP3, IEC 104, EtherNet/IP, PROFINET |

---

## Additional Resources

| Resource | URL |
|---|---|
| CISA ICS Advisories | https://www.cisa.gov/news-events/ics-advisories |
| ICS-CERT Advisories | https://www.cisa.gov/topics/industrial-control-systems |
| NERC CIP-007 (Security Management Controls) | https://www.nerc.com/pa/Stand/Pages/CIPStandards.aspx |
| IEC 62351 (Security for Power Systems) | https://webstore.iec.ch |
| ODVA EtherNet/IP Security | https://www.odva.org |
| OPC Foundation Security | https://opcfoundation.org/security |
