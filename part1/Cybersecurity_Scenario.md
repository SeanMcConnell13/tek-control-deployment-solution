**Part 1 — Cybersecurity Scenario**

**Context**



A financial company suffered a breach through an unpatched web application vulnerability, giving attackers unauthorized access to the network. What follows is an analysis of likely attack types, how the exploit unfolded, the steps we would take in response, and the network security controls that should be in place to prevent recurrence.



**Threat Intelligence Report**

**Likely Attack Types**



Injection (SQLi/NoSQLi, Deserialization to RCE)

Equifax (2017): Attackers exploited an unpatched Apache Struts vulnerability (CVE-2017-5638) for remote code execution, compromising ~143M U.S. consumers.



SSRF into Cloud Metadata Abuse

Capital One (2019): An SSRF flaw in a misconfigured WAF let attackers steal IAM credentials from AWS metadata services, exfiltrating over 100M customer records. No CVE issued; this was misconfiguration, not a code bug.



Authentication Bypass / IDOR

Instagram (2015, Bug Bounty): A backend misconfiguration allowed full access to source code, secret keys, and SSL certs through an authentication bypass. No CVE assigned.



Cross-Site Scripting (XSS)

British Airways (2018): Magecart attackers injected malicious JavaScript into a third-party script, skimming card details from ~380K–430K transactions. No CVE; this was a supply-chain compromise.



Supply Chain Compromise

SolarWinds Orion (2020): Backdoored Orion updates (SUNBURST) impacted ~18,000 organizations. Later linked to API auth bypass CVE-2020-10148.



Path Traversal with path to File Access / RCE

VMware vCenter (2021): CVE-2021-21972 allowed unauthenticated path traversal and file upload, leading to RCE. Rapidly exploited in ransomware campaigns.



Credential Stuffing / Brute Force

Nintendo (2020): ~160K accounts hijacked by attackers reusing leaked credentials from other breaches.



Misconfiguration (Cloud / Storage)

Accenture (2021): Publicly exposed Azure Blob Storage buckets leaked ~6TB of internal and client data. No CVE; this was a pure cloud misconfiguration.



**How the Exploit Led to Network Access**



Alice manages the customer-facing app. On the surface it looks secure, but Mallory finds a flaw, an input bug that lets her slip a command past the defenses. With one request, she’s inside.



Once in, she scavenges for secrets: database connection strings, API keys, even cloud tokens pulled from the metadata service via SSRF. Each credential becomes a skeleton key.



Now armed, Mallory pivots sideways. Bob’s database, the message broker, the file store, even the CI/CD pipeline, they all open up once she tries the stolen keys.



Then she climbs. A developer-friendly IAM role turns out to be over-scoped. Mallory assumes it and suddenly has control of the management plane. She’s no longer just an intruder, she’s in charge.



To ensure persistence, she plants her backdoors: a quiet web shell, a rogue service principal, and even a tampered container image in the pipeline. Long after the alerts quiet down, she still has ways back in.



**Preventive Measures**



Vulnerability management: Patch SLAs (critical <72h), automated dependency updates (Dependabot/Renovate), monthly rollups.



Shift-left security: SAST/DAST in CI/CD, IaC and container scanning, signed images (Sigstore/Cosign).



IAM hardening: Role-based access, least privilege, short-lived tokens, just-in-time elevation, MFA.



Web app protection: WAF with managed rules (Azure Front Door/App Gateway), plus DDoS protection.



Secrets management: Use Managed Identity and Key Vault; rotate secrets on deploy.



Network controls: Private endpoints, deny-by-default egress, NSGs and Azure Firewall.



Monitoring \& detection: Centralized logging in Sentinel, tuned alerts, Defender for Cloud integration.



Backup \& recovery: Immutable, versioned backups; regularly tested restore runbooks.



**Incident Response Plan (IRP)**

**Objectives**



Stop the breach, remove the adversary, restore safely, and strengthen defenses for the future.



**1. Preparation**



Define roles: Incident Commander, Comms, Forensics, cloud ops lead.



Tools staged: Microsoft Sentinel, Defender for Cloud, Key Vault, VM snapshots.



Golden images and infrastructure-as-code ready for rebuilds.



Compliance and legal protocols reviewed.



**2. Identification**



Confirm anomalies via web logs, WAF/Firewall alerts, or APM data.



Assess scope: impacted services, data, identities; map TTPs to MITRE ATT\&CK.



Begin time-stamped incident log; preserve evidence (snapshots, log exports).



**3. Containment**



Network: quarantine affected pods/VMs, block malicious IPs at the firewall.



Identity: disable suspect accounts, revoke sessions, rotate keys/tokens.



Workloads: cut compromised containers, redeploy patched images.



**4. Eradication**



Patch the vulnerable component and redeploy clean builds.



Remove persistence (web shells, rogue service principals).



Scan repos/registries; verify image signatures.



**5. Recovery**



Rebuild from IaC and hardened baselines.



Run security and smoke tests before restoring traffic.



Restore gradually while monitoring Sentinel and Defender alerts.



Verify data integrity; notify regulators/stakeholders if needed.



**6. Post-Incident**



Document timeline and root cause analysis (5 Whys).



Strengthen controls: patch cadence, tighter IAM, stricter WAF rules, enforced egress policy.



Run tabletop drills; update runbooks and training.



**Network Security Measures**



**1. Segmentation \& Zero Trust**



Subnet-level NSGs with deny-by-default.



Private Link for PaaS resources; remove all public exposure.



Just-in-time admin access via Azure Bastion.



**2. Perimeter \& East/West Protection**



Azure Firewall Premium (IDS/IPS, TLS inspection, threat-intel).



WAF (Azure Front Door or Application Gateway) for public endpoints.



DDoS Protection Standard for internet-facing workloads.



**3. Detection \& Response**



Centralized SIEM: Microsoft Sentinel.



Defender for Cloud for posture management and alerts.



NSG flow logs and diagnostics into Log Analytics/Event Hub.



Continuous vuln scanning of VMs and images.



**4. Hardening \& Hygiene**



Enforce strict egress control; allow-list only.



TLS everywhere with managed certs, HSTS enabled.



Secrets rotated through Key Vault.



Azure Policy to deny insecure configs by default.

