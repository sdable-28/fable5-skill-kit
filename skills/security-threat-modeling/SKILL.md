---
name: security-threat-modeling
description: Use when assessing the security of any system, feature, or change — new endpoints, auth flows, data stores, integrations, anything crossing a trust boundary. STRIDE-based - attack surface enumeration, trust boundary mapping, threat→mitigation pairs, residual risk acknowledged. Trigger keywords - "is this secure", "security review", "threat model", "before we expose", "auth", "handles user input". Do NOT use for malicious purposes; defensive assessment of systems you're authorized to assess only. Never conclude "this is secure" without an explicit threat model — that phrase without one is the anti-pattern this skill exists to kill.
---

# security-threat-modeling

"Is it secure?" is not a yes/no question — it's "secure against whom, trying what, with what access?" A threat model makes the question answerable: map where trust changes, enumerate what an attacker can reach, apply STRIDE per element, pair every threat with a mitigation or an acknowledged residual. Security claims without this structure are vibes.

## When invoked

1. **Scope and assets.** What system/change is being modeled; what's worth attacking: data (secrets, PII, financial state), capabilities (order placement, code execution, fund movement), and availability. Rank — the model's depth follows asset value.
2. **Map trust boundaries.** Every line where the trust level changes: user↔service, service↔third-party API, process↔file-system, internet↔internal, human↔automation. Data crossing a boundary is where validation, authn, and authz must live; a boundary with none of the three is a finding before any STRIDE analysis starts.
3. **Enumerate the attack surface** with evidence (from the code/config, not the architecture diagram's optimism): network listeners, API endpoints, file inputs, environment/config, dependencies (and their update path), credentials at rest, admin interfaces. Everything reachable by less-than-fully-trusted input goes on the list.
4. **Apply STRIDE per boundary-crossing element:**
   - **S**poofing — can the caller be someone else? (auth strength, token handling, replay)
   - **T**ampering — can data be altered in flight or at rest? (integrity, signing, file permissions)
   - **R**epudiation — can an action be denied later? (logging, audit trail integrity)
   - **I**nformation disclosure — what leaks? (errors, logs, timing, backups)
   - **D**enial of service — what falls over or locks out? (rate limits, resource exhaustion, poison input)
   - **E**levation of privilege — can low become high? (injection, deserialization, confused-deputy, path traversal)
   Not every cell yields a threat; every cell gets a look. Skipped cells are logged (coverage-accounting).
5. **Pair every threat with exactly one of:** MITIGATED (existing control, cited to code/config — verify the control exists, don't trust the intent), FIX (proposed control + effort), or **RESIDUAL** (accepted, with rationale and the trigger that would change the decision). An unpaired threat means the model is unfinished. Rank by exploitability × asset impact.
6. **State residual risk out loud.** The deliverable's verdict is never "secure" — it is "modeled against {scope}; {n} threats mitigated, {m} fixes proposed, {k} residuals accepted: {list}." Include what was NOT modeled (physical, insider, supply-chain, etc.) so absence of mention never reads as absence of risk.

## Output format

```
## Threat Model: {system/change}
ASSETS: {ranked}
TRUST BOUNDARIES: {each: what crosses, what controls exist [cited]}
ATTACK SURFACE: {enumerated, with evidence}
THREATS (ranked):
  T-{n} [{STRIDE letter}] {threat} @ {boundary/element}
    → MITIGATED by {control, file:line} / FIX: {proposal, effort} / RESIDUAL: {rationale, revisit-trigger}
NOT MODELED: {exclusions + why}
VERDICT: {counts + the residual list — never the word "secure" unqualified}
```

## Integration

- Runs on **system-design**'s component diagram whenever a trust boundary appears or moves; findings feed **enterprise-architect**'s failure-mode section.
- Mitigation claims obey **evidence-reasoning** — "we validate input" requires the validator's file:line; **adversarial-disproof** L2 (handled-elsewhere) applies in reverse: the claimed handler must actually be on the path.
- NOT MODELED implements **coverage-accounting** for the security dimension.
- Fixes route through **plan-gate**; authorization context per platform policy (defensive/authorized assessment only).
