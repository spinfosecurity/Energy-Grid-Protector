# Changelog

This project follows [Keep a Changelog](https://keepachangelog.com/) and intends to use [Semantic Versioning](https://semver.org/).

## [Unreleased]

## [1.1.0] - 2026-08-19

### Added
- PROFINET RT/RTA ports (34962, 34963) added to ICS protocol checks in both Bash and PowerShell scanners.
- OPC UA port (4840) added to ICS protocol checks in both scanners.
- `docs/CISA-Reference.md`: full CISA advisory reference, CVE remediation steps, and remote-access hardening guidance.
- `docs/Threat-Intelligence.md`: ICS protocol threat context, adversary tactic mapping, and per-protocol hardening.

### Fixed
- **Bash — color differentiation**: `DARK_RED` was identical to `RED` (`\033[0;31m`). Changed CRITICAL severity to bold red (`\033[1;31m`) so CRITICAL and HIGH findings are visually distinct.
- **Bash — timeout enforcement**: `check_port` now wraps the `/dev/tcp` connection in `timeout $TIMEOUT` (with graceful fallback if `timeout` is unavailable), so the `-t` flag is actually enforced during port checks.
- **Both scripts — finding deduplication**: Added deduplication logic (associative array in Bash, `HashSet` in PowerShell) so a single open port that matches multiple CVE or protocol checks is recorded and displayed once, not multiple times.
- **PowerShell — socket cleanup**: `Test-TcpPort` now uses a `finally` block to call `$client.Dispose()` in all paths, preventing socket handle leaks on long scans.
- **README — script filenames**: Corrected quick-start examples to use actual filenames (`EGP.sh` / `EGP.ps1`).
- **README — report format**: Removed inaccurate CSV output claim; reports are plain text (`.txt`).
- **README — fingerprinting claim**: Removed claim of vendor banner fingerprinting; tool performs TCP port reachability checks only.

## [1.0.0] - 2026-08-16
- Initial public release for authorized power-grid and substation OT/SCADA exposure assessment.
- PowerShell and Bash scanners with defensive reporting.
