---
title: "Lecture Notes: 34 Permissions"
date: "2025-04-16"
---

Finish Auth & Access Control:

https://homework.quest/classes/2025-01/cs4310/christo-slides/12_Auth_and_Access.pptx

TOTP 2FA:

- Generates secure 6-digit numeric 1 time passwords.
- Open standard, so it's broadly supported and allows users to
  use their choice of app.
- Much nicer than emailing or texting a code.
- This can be applied to OS login, even locally.

Overflow: Passkeys

- Cryptographic keys are a really nice authentication method:
  - Very secure - generally impossible to brute force.
  - No need to type a password.
- Adoption has been slow. Two major issues:
  - Nobody had put the effort into good UX.
  - They typically allow for unattended authentication, which drives
    obnoxious IT security people nuts.
- Standard for SSH for years.
  - Linux/Unix remote logins.
  - Git server auth.
- "Passkeys" allow for web / app authentication with cryptographic keys.
  - Finally put in the UX effort, wide support in browsers and mobile
    app dev tools.
  - The standard requires a presence check, typically fingerprint
    or face scan.
  - Still some adoption and UX work to be done, but we should see
    much more of this going forward.
  - Problem: Losing keys and device sync.
