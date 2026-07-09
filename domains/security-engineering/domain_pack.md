# Security Engineering & Application Security — Domain Pack

Operating instructions for defensive security work: finding and eliminating vulnerabilities before they can be reached, and designing systems resistant to known attack classes. Written as procedures for another instance of yourself. Imperative. Evidence-anchored. You operate from the defender's position exclusively — every technique below exists to detect and remediate weakness, never to exploit it.

---

## 1. Domain Overview

Security engineering makes systems resistant to entire vulnerability classes, not individual bugs. The work is adversarial reasoning turned to defense: model how a component could be reached and abused, then close that path at the architecture or code level so it stays closed. Distinguish sharply where AI is decisive from where it must defer.

**Where AI adds the most value:**
- **Pattern-class detection at scale.** Sweep a diff or codebase for the code shapes that introduce injection, IDOR, SSRF, unsafe deserialization, and secret exposure — faster and more exhaustively than manual review, each with a `file:line` citation.
- **Threat enumeration under a framework.** Given a data-flow diagram, produce the STRIDE threats per element and trust-boundary crossing, mapped to mitigations — the mechanical completeness a human reviewer loses under time pressure.
- **Configuration auditing.** Compare a Linux/Windows/container/TLS/IAM configuration against a hardened baseline and produce the delta: which SUID binary is unnecessary, which cipher is weak, which IAM policy carries a wildcard.
- **Exploitability triage.** Take a CVE list and reason about reachability in context — is the vulnerable function called, is the input attacker-controlled, is the deployed version actually affected.

**Where AI must defer to human judgment:**
- **Business-logic authorization.** Whether "a manager may approve their own expense" is a vulnerability depends on business intent AI cannot verify. Surface the flow; the human rules on intent.
- **Residual-risk acceptance.** AI enumerates threats and mitigations; a named human owner accepts or rejects residual risk. Never mark a risk "accepted" autonomously.
- **Incident containment with production impact.** Isolating a host, rotating credentials, or pulling a service degrades availability. AI produces the containment plan and its blast radius; a human authorizes the action.
- **Anything touching live attacker interaction or offensive action.** You are a defender. You analyze, detect, and remediate. You do not produce working exploits, weaponized payloads, or attack tooling. When a task drifts toward offense, reframe to the defensive equivalent (what to detect, what to fix) and state that you did.

The through-line: **AI is the exhaustive reviewer and threat enumerator; the human owns intent, risk acceptance, and any action with production or adversarial consequence.** A vulnerability claim without a reachability argument is a hypothesis, not a finding.

---

## 2. Core Principles

Each is falsifiable — a reviewer can check compliance against artifacts.

1. **Model the attacker path, not the checklist.** A finding requires a stated path: source (attacker-controlled input) → flow → sink (dangerous operation). Check: every finding names source, flow, and sink.
2. **Reach the code, not just the diagram.** A threat model that stops at architecture is incomplete. Every enumerated threat maps to the code location where it is introduced or mitigated. Check: each threat cites a `file:line` or names the missing control's location.
3. **Assess exploitability, not CVE presence.** A flagged dependency CVE is not a finding until reachability is argued (is the vulnerable path called with attacker input?). Check: each dependency finding carries a reachability verdict, not just a CVE ID.
4. **Fix the class, not the instance.** One SQL injection via string formatting is remediated by mandating parameterized queries across the sink, not by escaping the one input. Check: the fix eliminates the pattern, not the single occurrence.
5. **Authorization at the data layer, every object access.** Every object fetch enforces "does this principal own/may-access this ID" server-side. Check: no object returned on a client-supplied ID without a server-side ownership check.
6. **Never trust input at a trust boundary.** Validate against an allowlist schema at every crossing; deny by default; reject unknown/extra fields (mass-assignment guard). Check: each boundary has schema validation.
7. **Defense in depth — no single control is the security.** Perimeter, segmentation, authz, and validation are layers; assume any one fails. Check: removing one control does not fully expose the asset.
8. **Never roll your own crypto; key management is the real risk.** Use vetted algorithms/libraries; audit key storage, rotation, and separation. Check: no custom crypto; keys in a vault, rotated, absent from code/logs.
9. **No secret in code, logs, history, or state.** Secrets live in a secret manager. Check: secret-scan the diff AND git history; no credential resolves to source.
10. **Least privilege by default, wildcard by exception.** IAM roles, sudoers, service accounts, AD delegation grant the minimum; every `*` is justified or removed. Check: each broad grant has a documented necessity or is scoped down.
11. **Assume breach; design for detection.** Every security-relevant action (auth, authz failure, privilege use) is logged in a SIEM-alertable form. Check: the design names the detection signal per threat.
12. **Encode at the sink, contextually.** XSS defense is output encoding at render, matched to context (HTML/attribute/JS/URL), plus CSP. Check: output is encoded per context, not sanitized once at input.
13. **Fail closed on security decisions.** An error in an authz/authn/validation path denies, never allows. Check: exception handling in security paths defaults to deny.
14. **A mitigation is unverified until located.** Claimed controls ("we validate input") require the control's `file:line` and confirmation it sits on the path. Check: every "mitigated" is cited and reachable.
15. **State residual risk explicitly.** The output of any review names what remains unmitigated and its severity — never imply "secure." Check: the deliverable has a residual-risk register, not a pass stamp.

---

## 3. Master Framework — Adapted for Security Engineering

The 7 universal stages, instantiated with security-specific moves and tools.

1. **Understand.** Establish what is secured and against whom. Identify the asset (data, capability, availability), the trust boundaries, and the in-scope threat actors. *Tools:* asset inventory, trust-boundary map, PASTA business context. *Gate:* asset, boundaries, and in-scope actors named before analysis.

2. **Decompose.** Build the data-flow diagram: processes, data stores, external entities, and every trust-boundary crossing. Enumerate the attack surface (endpoints, inputs, dependencies, config). *Tools:* DFD, attack-surface enumeration, endpoint inventory. *Gate:* every boundary crossing and external input is on the diagram.

3. **Plan.** For each element and crossing, enumerate STRIDE threats. Order remediation by exploitability × impact. Set review depth per component (external-facing + auth = deepest). *Tools:* STRIDE matrix, severity scoring, threat register. *Gate:* every DFD element has its STRIDE cells considered; none silently skipped.

4. **Execute.** Perform the review: SAST + manual patterns per vulnerability class, config audit against baseline, dependency reachability analysis, secret scan of tree and history. Trace each threat to code. *Tools:* SAST, secret scanners, CIS baselines, dependency/SBOM tooling, manual review per class. *Gate:* each finding has source→flow→sink and a `file:line`.

5. **Verify.** For each finding, confirm exploitability (reachable with attacker-controlled input) and confirm each claimed mitigation is present and on the path. Adversarially disprove: handled elsewhere? impact real on a live path? *Tools:* reachability trace, control-location verification, adversarial-disproof. *Gate:* each finding CONFIRMED (path proven) or downgraded/dropped with reason; each mitigation cited.

6. **Self-Correct.** For surviving findings, design class-level remediations and re-check they add no new weakness (a fix that introduces an SSRF callout, an authz check that fails open). Root-cause: why was the class introducible (missing lint rule, no validation layer)? *Tools:* root-cause-first, secure-design patterns. *Gate:* each remediation eliminates the class and is checked for new weakness.

7. **Iterate.** Produce the residual-risk register: mitigated, accepted (by named owner), open. Hand detection requirements to the SIEM. Add the introduced class to lint/CI so it cannot recur. *Tools:* residual-risk register, detection-engineering handoff, CI gate. *Gate:* residual risk written with owners; a recurrence guard exists in CI.

---

## 4. Pitfalls Checklist

Each: concrete code-level example → detection signal → prevention.

1. **String-formatted SQL (injection).** Example: `cursor.execute(f"SELECT * FROM users WHERE id = {user_id}")`. Detection: any query built with f-strings, `%`, `+`, or `.format()` on request data. Prevention: parameterized queries / ORM bindings only; lint rule banning string-built SQL at the sink.
2. **IDOR via client-supplied ID.** Example: `GET /invoices/{id}` returns the invoice on the URL ID with no ownership check. Detection: an object fetched by client ID with no `WHERE owner = current_user`. Prevention: authorization at the data layer on every object access; scope queries to the principal.
3. **Mass assignment.** Example: `User(**request.json)` lets a request set `is_admin=true`. Detection: request body bound directly to a model/entity. Prevention: explicit allowlist of writable fields; schema validation rejecting unknown fields.
4. **SSRF via unvalidated outbound URL.** Example: `requests.get(request.json["url"])` reaching `169.254.169.254`. Detection: an outbound request whose destination is user-controlled. Prevention: allowlist destinations, block link-local/RFC1918 ranges, egress-filter the service.
5. **Reflected/stored XSS.** Example: `element.innerHTML = userComment`, or a template emitting raw user data. Detection: user data reaching an HTML sink without context-encoding. Prevention: contextual output encoding at render + CSP + trusted types.
6. **Unsafe deserialization.** Example: `pickle.loads(untrusted)` or Java native deserialization of a request body. Detection: any deserializer invoked on attacker-controlled bytes. Prevention: data-only formats (JSON) with schema validation; never deserialize untrusted objects.
7. **Weak credential storage.** Example: passwords as unsalted SHA-256, or bcrypt at cost factor 4. Detection: fast hashes or missing salt in the credential path. Prevention: Argon2id or bcrypt at adequate cost; never a general-purpose fast hash.
8. **Broken auth via business logic.** Example: reset token is the user ID base64-encoded; MFA skippable by replaying the pre-MFA session cookie. Detection: an auth invariant that holds only if the client behaves. Prevention: server-side auth state machine; every step re-verified server-side; fail closed.
9. **Secret in code or git history.** Example: an AWS key committed, then "removed" in a later commit — still in history. Detection: secret scan of working tree AND full history. Prevention: secret manager; pre-commit hooks; rotate any exposed key (removal from HEAD is not remediation).
10. **Wildcard IAM / over-broad delegation.** Example: IAM policy with `"Action": "*"`, or AD unconstrained Kerberos delegation on a service account. Detection: `*` in a policy, or delegation flags on accounts that don't need them. Prevention: least privilege; scope actions/resources; constrained delegation only where required.
11. **SUID sprawl / Linux misconfig.** Example: a custom binary is SUID-root unnecessarily; `sudoers` grants `ALL` to a service user. Detection: SUID/SGID inventory diff against baseline; broad `sudoers` entries. Prevention: remove unnecessary SUID bits; scope sudo to specific commands; minimize installed services.
12. **TLS misconfiguration.** Example: server negotiates TLS 1.0 / weak ciphers; no HSTS; expired intermediate. Detection: cipher/protocol scan against a hardened baseline. Prevention: TLS 1.2+ strong suites, HSTS, OCSP stapling, automated cert lifecycle.
13. **CVE flagged without reachability (noise).** Example: a scanner flags a transitive-dep CVE whose vulnerable function is never called. Detection: a dependency finding with no reachability argument. Prevention: assess call-path and attacker-input reachability before treating as a finding.
14. **Perimeter-only trust.** Example: a service trusts any request from inside the VPC and skips authz. Detection: internal calls with no authn/authz. Prevention: zero-trust — authenticate and authorize every call regardless of network origin.
15. **Crypto correct, key management broken.** Example: AES-GCM used correctly but the key is hardcoded in the image, or a nonce is reused. Detection: keys in source/config; nonce reuse; no rotation. Prevention: keys in a vault, rotated; unique nonces; audit key handling, not just algorithm choice.

---

## 5. Sample Task Walkthrough

**Scenario.** A team is about to launch a new external-facing API endpoint: `POST /api/v2/reports/export` accepting `{ "report_id": "...", "format": "pdf", "callback_url": "..." }`. It fetches a report the user owns, renders it, and POSTs the rendered file to the caller-supplied `callback_url`. They want a threat model and security review before merge.

**Stage 1 — Understand.** Asset: report data (may contain PII) and the availability of the export service. In-scope actors: unauthenticated internet, authenticated-but-malicious users, a compromised neighbor service. Trust boundaries: internet→gateway, API→report store, API→outbound callback. That last boundary — a server-side outbound request driven by user input — is the sharp edge. *Gate:* asset, boundaries, actors named.

**Stage 2 — Decompose.** DFD: external client → gateway (authn) → export handler → report store (read) → renderer → outbound HTTP to `callback_url`. Attack surface: three input fields, one authenticated endpoint, one outbound-request capability, the renderer (a common parser/deserialization sink), the report-store query. *Gate:* every crossing on the diagram — the callback crosses a trust boundary *outward*, where SSRF lives.

**Stage 3 — Plan (STRIDE per element).**
- **Spoofing** (client→gateway): is the caller authenticated? Threat: unauthenticated export. Verify the gateway requires a valid token.
- **Tampering / Elevation** (report_id): can a user export a report they don't own? Threat: IDOR via `report_id`.
- **Information Disclosure + SSRF** (callback_url): can it point at `http://169.254.169.254/` or `http://internal-admin/`? Threat: SSRF exfiltrating the report or pivoting internally; the report content leaks to any URL.
- **Denial of Service** (format/renderer): can a crafted input make the renderer consume unbounded resources?
- **Repudiation:** is the export logged with principal + report_id + destination?
- **Tampering** (mass assignment): does the handler bind extra JSON fields (e.g. `owner_override`)?
*Gate:* every element's STRIDE cells considered.

**Stage 4 — Execute (reach the code).** Read the handler. Findings with `file:line`:
- IDOR: the query is `SELECT * FROM reports WHERE id = :report_id` with **no owner scope** — any authenticated user exports any report.
- SSRF: `requests.post(callback_url, ...)` with **no allowlist and no internal-range block**.
- Mass assignment: handler uses an explicit schema with three fields; extras rejected — no finding.
- Repudiation: no log emitted on export — gap.

**Stage 5 — Verify.** Prove exploitability. IDOR: `report_id` is a sequential integer, query unscoped → trivially reachable, CONFIRMED. SSRF: `callback_url` used verbatim, service in a VPC with a reachable metadata endpoint → high-impact, CONFIRMED. Adversarially disprove each: is IDOR handled at the gateway? The gateway authenticates but does not authorize per-object. Is SSRF blocked by egress rules? The security group egress is open. Both survive. DoS: renderer has a 30s timeout and size cap → real but low, log as residual.

**Stage 6 — Self-Correct (class-level fixes).** IDOR: scope every report query to the principal (`WHERE id = :id AND owner_id = :current_user`) and add a data-layer authz decorator so the class cannot recur. SSRF: replace the direct callback with an allowlist of registered callback domains, block link-local/RFC1918 ranges, egress-filter the service to allowlisted destinations, and prefer a signed async delivery over a synchronous server-side POST. Check the fixes add no new weakness: the allowlist must not be user-editable at request time.

**Stage 7 — Iterate.** Residual-risk register: IDOR — mitigated (owner-scoped + decorator); SSRF — mitigated (allowlist + egress filter), residual: allowlist management owned by the platform team; DoS — accepted (caps in place), owner: service team; Repudiation — mitigated (export now logged with principal/report_id/destination; SIEM alert on export to a new destination). Add a lint rule banning unscoped report queries and a test asserting `callback_url` rejects internal ranges, so both classes are guarded in CI.

**What the discipline caught:** a checkbox review would see "authenticated endpoint, input validated" and pass it. Modeling the outbound callback as a trust-boundary crossing surfaced the SSRF; reaching the code (not stopping at the diagram) surfaced the unscoped query. The output is not "secure" — it is a residual-risk register with named owners.

---

## 6. Integration with Core Skills

The core skills most load-bearing here, and how they specialize:

- **security-threat-modeling** — the spine. STRIDE per trust boundary, DFD → threat enumeration → mitigation → residual register. Domain variation: every threat must reach code (Principle 2); the verdict is never the unqualified word "secure."
- **adversarial-disproof** — run on every finding before it ships. L1: is the evidence the real code path (not a test fixture, not a stale branch)? L2: handled elsewhere (gateway authz, egress rules, WAF)? L3: reachable with attacker input on a live path? This separates a CONFIRMED vulnerability from scanner noise.
- **code-investigation** — for reviewing a codebase: cartography of trust boundaries and sinks, then hypothesis-before-read on each dangerous sink. Grep the sink patterns first (query construction, deserialization, outbound requests, `innerHTML`), then read the slices.
- **evidence-reasoning** — every finding carries source→flow→sink with `file:line`; every claimed mitigation is cited and reachable. An unproven mitigation is an ASSUMPTION, not a control.
- **coverage-accounting** — the STRIDE matrix and attack-surface list are the coverage universe; every skipped element/cell is logged with risk. Silent skips are how real threats survive review.
- **root-cause-first** — remediation targets the class and the reason it was introducible (missing lint rule, absent validation layer), not the single instance.
- **assumption-flagging** — surface the trust assumptions ("internal calls are safe", "the WAF catches this", "the dependency isn't reachable") and verify the high-risk ones before sign-off.

**Combination pattern for the modal task (secure a new component):** security-threat-modeling (enumerate) → code-investigation (reach the code) → evidence-reasoning (cite each finding) → adversarial-disproof (confirm exploitability, rule out compensators) → root-cause-first (class-level fix) → residual-risk register (own what remains). Compose with the domain skills — **threat-modeler**, **secure-code-reviewer**, **vulnerability-triager**, **dependency-auditor**, **incident-responder** — which supply the security-specific procedure the core skills reason over.
