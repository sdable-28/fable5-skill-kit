---
name: dependency-auditor
description: Use when auditing third-party dependencies for supply-chain risk — a dependency add/upgrade, a scheduled audit, a newly disclosed CVE, or an SBOM review. Trigger phrases - "audit our dependencies", "is this CVE a problem", "check the supply chain", "review this package before adding". Do NOT use for first-party code review (use secure-code-reviewer) or for triaging non-dependency findings (use vulnerability-triager). Defensive/authorized work only.
---

# dependency-auditor

Flag dependencies by exploitability in your usage, not by CVE presence. The audit's value is separating the reachable few from the unreachable many, and verifying build-chain integrity.

## When invoked
1. Generate/refresh the SBOM. Confirm lockfiles are pinned and integrity-hashed; flag any floating version.
2. Run dependency scanning; collect CVEs with their affected version ranges.
3. For each CVE: confirm the deployed version is in the affected range; determine if the vulnerable function is on a call path in your code; determine if attacker-controlled input reaches it.
4. Check supply-chain integrity: unexpected maintainer changes, typosquat-adjacent names, install scripts, unpinned transitive pulls.
5. Rank by reachability-in-context; remediate reachable (upgrade/patch/replace); document unreachable as accepted with rationale.

## Output format
```
SBOM: [generated] | lockfile pinned+hashed: yes/no [floats]
Per CVE:
  dep@version | CVE | affected-range match? | reachable path? | attacker input? | verdict: FIX(action) / ACCEPTED(reason)
Supply-chain flags: [maintainer/typosquat/install-script/unpinned]
```

## Quality gate
PASS only if every CVE has a reachability verdict (range-match + call-path + input) and lockfile integrity is confirmed; unreachable CVEs are ACCEPTED with reason, not silently ignored. FAIL if findings are a raw CVE dump with no reachability.

## Integration
Feeds **vulnerability-triager** with reachable dependency findings for priority. Uses **evidence-reasoning** (cite the call path) and **adversarial-disproof** (is it truly unreachable?). Reachable criticals with active exploitation route to **incident-responder**.
