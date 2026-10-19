---
title: "cs4140 Notes: 10-19 Supply Chain"
date: "2026-10-17"
---

## Dependencies

Many modern programming languages provide a package management tool.

**Node**

Command:

```bash
npm install package
```

Config file (package.json):

```json
{
  ...
  "dependencies": {
    ...
    "prisma": "^5.2.0",
  }
}
```

Version number specifiers:

- Exact string "5.2.0" means exactly that.
- Approximate "~5.2.0" means new patch releases are allowed, like 5.2.17
- Compatible "^5.2.0" means new minor releases are allowed, like 5.2.17 or 5.3.5

Specifying a dependency also requests its transitive dependencies. Npm
provides some mechanisms to allow multiple versions of the same
dependency to be installed which helps avoid version conflicts for
indirect deps.

When you run "npm install", you get a lock file: package-lock.json

This pins exact versions, including URLs and cryptographic hashes.
This should guarantee that subsequent "npm install"s give you exactly
the same code, even if a dependency author is trying to mess you up.

**Semantic Versioning**

<https://semver.org/>

This is a convention for how version numbers should work:

- Major version means incompatible API changes.
- Minor version means backwards compatible new functionality.
- Patch version means backwards compatible bug fixes only.

Following this for libraries is a good idea.

**Elixir**

Add deps by editing "mix.exs"

- Functionally similar to the JS stuff.
- Let's take a look at an example.

## Issues with Dependencies

**left-pad**

Back in 2016 a bunch of popular JavaScript packages - including
React - just broke. The developer of one of their dependencies had
gotten mad and deleted it. The dependency was called "left-pad"; it
was just one function that added padding characters to a string to
make it a minimum length.

And... that was kind of the best case scenario. Every dependency you
add is an opportunity for some external developer to make changes to
your program. The more typical malicious dependency change is adding
code to find and steal bitcoins - that's happened several times.

<https://npmgraph.js.org>

- d3
- webpack
- @uiw/react-codemirror

Other examples:

- event-stream (2018) - new developer of library injected cryptocurrency
  theft code and stole $300k.
- liblzma (2024) - maintainer inserted remote backdoor in C library
- SolarWinds (2020) - Russian hackers breached proprietary software
  company with IT management platform used by a bunch of companies and
  US federal government agencies, stole a bunch of government email
- chalk, debug, etc (last month) - Major npm developer account got
  hijacked and cryptocurrency theft stuff got injected.

Conclusions:

- The threat isn't just libraries or open source software. *Any* mechanism that
results in software installs, especially automatically or periodically, is a
huge threat vector.
- "Universal back door" - Automatic updates + user authentication is a targeted
attack vector.
- Cryptocurrency is great for computer security. It gives attackers something
moderately valuable to target, effectively creating global bug bounties for
all software.

## Overflow: Deepseek Notes

Here are direct, credible references for each of the examples I mentioned. I've prioritized technical analyses, vendor research, and official post-mortems over general news where possible, as those tend to be more useful for a lecture.

### 📦 TanStack / "Mini Shai-Hulud" Worm (May 2026)

- **Safeguard.sh — "TanStack and the Mini Shai-Hulud npm Worm"**: A detailed reconstruction that explains the **CI-native** nature of the attack—how it abused a `pull_request_target` "Pwn Request" and cache poisoning to steal GitHub Actions OIDC tokens, rather than phishing a maintainer. It also covers the blast radius and the fact that the malicious packages carried **valid SLSA attestations**, making them cryptographically indistinguishable from legitimate releases.
- **Dark Reading — "Worm Redux: Fresh Mini Shai-Hulud Infections"**: A news analysis that corroborates the scale (hundreds of packages, 169 npm package names) and emphasizes the **self-propagating, credential-stealing** design, noting that these packages are likely installed in local developer environments, CI jobs, and release workflows.
- **Cloud Security Alliance Labs — "Mini Shai-Hulud"**: A threat-intelligence brief that provides the **CVE designation (CVE-2026-45321)**, the number of malicious versions (404 across 172 npm packages and 2 PyPI packages), and the sub-six-hour propagation timeline.

### 🔑 Axios Compromise (UNC1069, March 2026)

- **BleepingComputer — "Axios npm hack used fake Teams error fix"**: This is the best source for the **social-engineering tradecraft**. It details the fake Slack workspace, the staged Teams meeting, and the fake "Teams update" that installed a RAT, leading to the theft of npm credentials. It also links the attack to UNC1069 and notes the three-hour exposure window for the malicious versions (`1.14.1` and `0.30.4`).
- **Cloud Security Alliance Labs — "UNC1069 Axios Supply Chain Attack: AI Vendor Code-Signing at Risk"**: This analysis is essential because it covers the **downstream impact on AI vendor infrastructure**. It explains how OpenAI's macOS code-signing workflow executed the malicious Axios version, potentially exposing certificates for ChatGPT Desktop and Codex. It also highlights the **structural failure**: Axios had adopted OIDC/SLSA provenance, but a **legacy long-lived npm token remained active**, and npm defaulted to the token, nullifying the provenance guarantees.

### 🐍 LiteLLM PyPI Backdoor (March 2026)

- **Security Affairs — "Malicious LiteLLM versions linked to TeamPCP"**: A clear technical summary explaining that the malicious code was **not in the GitHub repository** but was injected during or after the wheel build process into `proxy_server.py`. It also details the `.pth` file in version `1.82.8` that triggers the payload on **every Python interpreter startup**, even if LiteLLM is never imported.
- **BleepingComputer — "Popular LiteLLM PyPI package backdoored"**: Corroborates the build-artifact compromise and provides scale context (95+ million monthly downloads), the multi-stage payload (credential harvester, Kubernetes lateral movement, systemd backdoor), and the link to the earlier Trivy CI/CD breach.
- **Endor Labs (referenced in both articles)**: The original technical analysis is cited as the source for the "12 lines inserted during the wheel build" finding. The Security Affairs and BleepingComputer pieces both link to it directly.

### 🎵 Telnyx Python SDK (PyPI, March 2026)

- **The Hacker News — "TeamPCP Pushes Malicious Telnyx Versions to PyPI, Hides Stealer in WAV Files"**: This is the most accessible technical write-up. It explains the **WAV audio steganography** technique—how the payload was hidden inside `hangup.wav` (Windows) and `ringtone.wav` (Linux/macOS) to evade network inspection and EDR. It also aggregates links to deeper analyses from Aikido, Endor Labs, JFrog, Socket, and StepSecurity.
- **SANS Internet Storm Center — "Telnyx Python SDK Compromised on PyPI"**: A diary entry from the day of the compromise. It highlights the **novel TTP** (WAV steganography) and notes that the technique blends naturally with Telnyx's purpose as a voice/telecom API provider, making the malicious audio files less suspicious.
- **Wiz — GHSA-955r-262c-33jc**: A security advisory that confirms the compromised PyPI credentials were used to publish versions `4.87.1` and `4.87.2` directly to PyPI, with the payload downloaded from a C2 server hidden inside a WAV file.

### 🪱 GlassWorm (VS Code / Open VSX, 2025–2026)

- **Palo Alto Networks (originally Koi Security) — "GlassWorm's Native Rust Loaders Target VS Code"**: The definitive technical analysis. It documents the **evolution** from invisible Unicode obfuscation to **compiled native Rust binaries (`.node` addons)** to complicate static analysis. It also covers the **dual-marketplace targeting** (OpenVSX and Microsoft's official VS Code Marketplace), typosquatting/update poisoning, and the resilient **Solana blockchain C2** infrastructure.
- **VicOne — "GlassWorm: When Invisible Code Exposes Gaps"**: A broader campaign overview that contextualizes GlassWorm's **self-propagating** nature—stolen credentials (GitHub, npm, OpenVSX tokens) are used to compromise more extensions and repositories. It notes the expansion to **151 GitHub repositories** and the use of **Unicode variation selectors** to make malicious code invisible in standard editors and code review.
- **ThaiCERT — "Warning to VSCode Users: Malicious Extensions Containing GlassWorm"**: A government CERT advisory that confirms the use of **invisible Unicode characters** to hide malicious JavaScript in VS Code extensions, enabling execution without anything suspicious appearing in the source code.

### 🎯 `is-arrayish`, `color-name`, `simple-swizzle` (September 2025)

- **Cyberint — "The Great NPM Heist – September 2025"**: A thorough incident analysis. It lists all 18 compromised packages with their **weekly download volumes** (e.g., `color-name` at 191.7M, `is-arrayish` at 73.8M), illustrating the massive transitive blast radius. It also explains the malware's **cryptocurrency transaction hijacking** logic—using the Levenshtein distance algorithm to swap wallet addresses for visually similar attacker-controlled ones, and intercepting `window.fetch`, `XMLHttpRequest`, and `window.ethereum` APIs.
- **SK-CERT (Slovak CERT) — "Masívna infekcia softvérových balíkov NPM"**: A CERT advisory that corroborates the affected versions and download statistics, and provides an official government-level confirmation of the incident.
- **Aqua Security — "NPM Supply Chain: A Critical Threat to Cloud-Native"**: A security vendor analysis that lists the tainted versions (e.g., `is-arrayish@0.3.3`, `simple-swizzle@0.2.3`) and frames the incident within the broader cloud-native supply chain threat model.

---

**A note on sourcing for a lecture:** The Safeguard.sh, CSA Labs, Palo Alto/Koi, and Endor Labs pieces are the strongest technical references for explaining *mechanism*. The BleepingComputer and The Hacker News pieces are best for narrative and incident timeline. The CERT advisories (ThaiCERT, SK-CERT, ACN) are useful if you want to show that these are officially recognized critical infrastructure incidents.

