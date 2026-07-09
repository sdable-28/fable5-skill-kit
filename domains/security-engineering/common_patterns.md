# Security Engineering — Common Patterns

Recurring defensive tasks with reusable procedures. Imperative register. Defensive/authorized work only.

## Pattern 1 — Reviewing a PR for Security Issues
**Trigger:** A diff touches auth, session, input handling, queries, file/URL handling, deserialization, HTML rendering, IAM, or crypto.
**Standard approach:**
1. Map the diff's trust boundaries — where does attacker-controlled input enter the changed code?
2. Grep the changed files for sink patterns: query construction, `innerHTML`/template raw, outbound requests, deserializers, `subprocess`/`exec`, redirects.
3. For each sink reached by request data, trace source→flow→sink; state the vulnerability class.
4. Verify each claimed control's `file:line` sits on the path; confirm security paths fail closed.
5. Report findings with class, path, and a class-level fix — not just the instance.
**Checklist:** [ ] boundaries mapped [ ] every sink traced to source [ ] authz at data layer for object access [ ] no secret added [ ] output contextually encoded [ ] fixes are class-level.
**Variation to watch:** The dangerous change is often in an *unchanged* file the diff now calls (a new caller reaching an old unsafe sink). Follow new call edges, not only changed lines.

## Pattern 2 — Conducting a Threat Model From Scratch
**Trigger:** A new external-facing component, a new trust boundary, or a significant architecture change.
**Standard approach:**
1. Name the asset, trust boundaries, and in-scope actors.
2. Draw the data-flow diagram; mark every trust-boundary crossing (inbound AND outbound).
3. Apply STRIDE per element and per crossing; record each threat.
4. Map each threat to an existing control (cited) or a missing one.
5. Trace the highest-severity threats into code to confirm they are real.
6. Produce the residual-risk register with owners.
**Template:**
```
Asset: … | Actors: … | Boundaries: …
DFD elements: [process/store/external]
STRIDE: element → {S,T,R,I,D,E} threat → control (file:line) / MISSING
Residual: mitigated / accepted(owner) / open(severity)
```
**Variation to watch:** Outbound calls driven by user input (SSRF) and second-order flows (data stored now, rendered unsafely later) are missed when STRIDE is applied only to inbound edges.

## Pattern 3 — Responding to a Reported Vulnerability
**Trigger:** An inbound vuln report, bug-bounty submission, or internal discovery.
**Standard approach:**
1. Reproduce and confirm exploitability in context (source→flow→sink); assign real severity, not the reporter's.
2. Determine blast radius: what data/capability is exposed, is it being actively exploited (check logs/IoCs).
3. Contain if active (propose isolation/rotation with blast radius; human authorizes production actions).
4. Root-cause the class; patch the class, not the instance.
5. Rotate any exposed credentials/keys; verify the fix closes the path.
6. Write lessons-learned: what detection missed, what CI guard now prevents recurrence.
**Checklist:** [ ] reproduced [ ] severity re-assessed [ ] active-exploitation checked [ ] class root-caused [ ] creds rotated [ ] recurrence guard added.
**Variation to watch:** Treating the reporter's PoC input as the whole vulnerability — patch the input and miss the class. Fix the sink pattern.

## Pattern 4 — Hardening a New Linux Server
**Trigger:** A new host, image, or container base enters the environment.
**Standard approach:**
1. Inventory SUID/SGID binaries; remove unnecessary SUID bits.
2. Audit `sudoers` — scope to specific commands; remove `ALL`/broad grants.
3. Review file permissions on secrets/config; check cron job ownership and PATH integrity.
4. Minimize services — disable/remove anything not required.
5. For containers: non-root user, read-only filesystem, drop capabilities, seccomp profile.
6. Diff the result against a CIS/hardened baseline; log deviations.
**Checklist:** [ ] SUID/SGID inventoried [ ] sudoers scoped [ ] cron/PATH audited [ ] services minimized [ ] container runs non-root/read-only/cap-dropped [ ] baseline diff clean.
**Variation to watch:** A hardened base image undone by a later layer that adds a package as root or re-enables a service. Audit the final image, not the base.

## Pattern 5 — Auditing Third-Party Dependencies
**Trigger:** A dependency add/upgrade, a scheduled audit, or a newly disclosed CVE.
**Standard approach:**
1. Generate/refresh the SBOM; confirm lockfiles are pinned and integrity-verified.
2. Run dependency scanning; collect CVEs with affected version ranges.
3. For each CVE, assess reachability: is the vulnerable function on a call path, is the input attacker-controlled, is the deployed version in range?
4. Rank by exploitability-in-context, not CVSS alone.
5. Remediate reachable ones (upgrade/patch/replace); document non-reachable ones as accepted with rationale.
**Template:**
```
Dep@version | CVE | affected-range match? | reachable path? | attacker input? | verdict: FIX / ACCEPTED(reason)
```
**Variation to watch:** Alert fatigue from unreachable transitive CVEs; and the opposite trap — a "low CVSS" issue that is trivially reachable in your usage. Reachability decides, not the score.
