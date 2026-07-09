---
name: secure-code-reviewer
description: Use when reviewing code (a PR, a module, a service) for vulnerability classes — injection, IDOR, SSRF, XSS, unsafe deserialization, broken auth, secret exposure. Trigger phrases - "security review this PR", "check this code for vulnerabilities", "is this endpoint safe to merge". Do NOT use for design-level threat modeling with no code yet (use threat-modeler) or for dependency CVEs (use dependency-auditor). Defensive/authorized work only.
---

# secure-code-reviewer

Find the code shapes that introduce vulnerability classes, prove they are reachable, and remediate the class. Grep the sinks first, then read the slices — never read whole files hunting.

## When invoked
1. Identify trust boundaries in scope: where does attacker-controlled input enter this code?
2. Grep for sink patterns: query construction (f-string/concat/`.format` on request data), `innerHTML`/raw template output, outbound requests on user URLs, deserializers on untrusted bytes, `subprocess`/`exec`, redirects on user input, mass-assignment binds.
3. For each sink reached by request data, trace source→flow→sink and name the vulnerability class.
4. Verify each claimed control's `file:line` is on the path; confirm security paths fail closed; secret-scan the diff and history.
5. For each confirmed finding, give a class-level fix (parameterize the sink, scope the query, allowlist the destination) plus a CI guard.

## Output format
```
Findings (ranked):
  [class] source→flow→sink @ file:line — CONFIRMED (reachable) / dropped(reason)
    fix: [class-level remediation] | CI guard: [lint/test]
Secret scan: clean / [hits]
Residual: [what remains]
```

## Quality gate
PASS only if every finding has source→flow→sink with `file:line` and a class-level fix, secret scan (tree + history) ran, and no finding rests on a sink not reachable by attacker input. FAIL on instance-only fixes or unproven reachability.

## Integration
Consumes **threat-modeler** output (reaches code for each threat). Uses **code-investigation** (cartography of sinks) and **evidence-reasoning** (cite every finding). Confirmed classes hand to **vulnerability-triager** for severity; **adversarial-disproof** rules out compensating controls before a finding ships.
