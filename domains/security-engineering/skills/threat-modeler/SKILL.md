---
name: threat-modeler
description: Use when a new external-facing component, trust boundary, or significant architecture change needs a STRIDE threat model before merge. Trigger phrases - "threat model this", "security review the design", "new endpoint before launch", "is this architecture safe". Do NOT use for a pure code-diff review with no architectural change (use secure-code-reviewer) or for triaging an already-reported vulnerability (use vulnerability-triager). Defensive/authorized work only.
---

# threat-modeler

Enumerate threats so they can be mitigated. A threat model that stops at the architecture diagram is unfinished — every threat must reach the code where it is introduced or defended.

## When invoked
1. State the asset (data/capability/availability), in-scope threat actors, and trust boundaries.
2. Build the data-flow diagram: processes, data stores, external entities. Mark EVERY trust-boundary crossing — inbound and outbound (outbound user-driven calls are where SSRF hides).
3. Apply STRIDE to each element and each crossing. Record every threat in the matrix; do not skip cells silently — log any skip with reason.
4. Map each threat to an existing control cited by `file:line`, or to a named missing-control location.
5. Trace the highest-severity threats into code to confirm they are real, not diagram-theoretical.
6. Produce the residual-risk register: mitigated / accepted(owner) / open(severity).

## Output format
```
Asset: … | Actors: … | Boundaries: …
DFD: [elements + crossings]
STRIDE matrix: element → {S,T,R,I,D,E}: threat → control(file:line) | MISSING@location
Verified-in-code: [top threats, CONFIRMED/dropped]
Residual-risk register: mitigated / accepted(owner) / open(severity)
```

## Quality gate
PASS only if every DFD element has a STRIDE row AND every enumerated threat cites code (control location or missing-control location), AND a residual register with owners exists. FAIL if any element is unanalyzed or any threat stops at the diagram.

## Integration
Feeds **secure-code-reviewer** (which reaches the code for each threat) and **security-threat-modeling** core skill (this is its domain instance). Uses **coverage-accounting** for the STRIDE matrix and **adversarial-disproof** to confirm the top threats are exploitable.
