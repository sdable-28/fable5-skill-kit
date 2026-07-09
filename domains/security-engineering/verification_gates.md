# Security Engineering — Verification Gates

Domain-specific pass/fail gates. Run before merging a security-relevant change, closing a review, or signing off a threat model. Defensive/authorized work only.

### Gate 1 — Threat Model Reaches Code
- **Pass:** Every new external-facing component has a completed STRIDE analysis, and each enumerated threat maps to a `file:line` (control present) or a named missing-control location.
- **Fail:** The threat model is missing, or it stops at the architecture diagram without reaching code.
- **Check:** For each DFD element, confirm a STRIDE row exists and each threat cites code, not just a box.

### Gate 2 — Every Finding Has an Attacker Path
- **Pass:** Each finding states source (attacker-controlled input) → flow → sink.
- **Fail:** A finding asserts a vulnerability with no path from input to dangerous operation.
- **Check:** Read each finding — confirm source, flow, and sink are all named.

### Gate 3 — Exploitability, Not CVE Count
- **Pass:** Each dependency finding carries a reachability verdict (vulnerable path called with attacker input?).
- **Fail:** A dependency flagged solely because a scanner reported a CVE, with no reachability assessment.
- **Check:** Confirm every dep finding has a reachability line, not just a CVE ID and severity.

### Gate 4 — Object Access Is Authorized at the Data Layer
- **Pass:** Every object fetched by a client-supplied ID is scoped to the principal server-side.
- **Fail:** Any query returns an object on a client ID with no ownership/authorization check.
- **Check:** Grep object-fetch queries; confirm each has a principal scope or a data-layer authz decorator.

### Gate 5 — No Secret in Tree or History
- **Pass:** Secret scan of the working tree AND full git history is clean; secrets resolve to a manager.
- **Fail:** A credential appears in code, config, logs, or any historical commit.
- **Check:** Run secret scanning on the diff and on history; confirm zero hits, and that exposed keys were rotated (not just deleted from HEAD).

### Gate 6 — Untrusted Input Deserialization Blocked
- **Pass:** No deserializer (`pickle`, native Java, YAML unsafe-load) runs on attacker-controlled bytes; untrusted input uses data-only formats with schema validation.
- **Fail:** Any unsafe deserializer is invoked on request data.
- **Check:** Grep deserialization sinks; confirm none take untrusted input.

### Gate 7 — Least Privilege, No Unjustified Wildcards
- **Pass:** New IAM policies, sudoers entries, service accounts, and AD delegations grant minimum scope; every `*` is documented as necessary.
- **Fail:** A `"*"` action/resource or unconstrained delegation exists with no justification.
- **Check:** Inspect each grant; confirm scoped, or the wildcard has a written necessity.

### Gate 8 — Security Paths Fail Closed
- **Pass:** Error handling in authn/authz/validation code denies on exception.
- **Fail:** A `catch`/`except` in a security path falls through to allow.
- **Check:** Read exception handling on every security decision; confirm the default is deny.

### Gate 9 — Contextual Output Encoding Present
- **Pass:** User data reaching an HTML/JS/attribute/URL sink is context-encoded at render, with CSP set.
- **Fail:** User data hits `innerHTML`/template raw output without contextual encoding.
- **Check:** Grep output sinks; confirm encoding matches context and CSP headers exist.

### Gate 10 — Residual-Risk Register, Not a Pass Stamp
- **Pass:** The deliverable lists mitigated / accepted (named owner) / open risks with severities.
- **Fail:** The review concludes with "secure" or "passed" and no residual register.
- **Check:** Confirm a residual-risk register exists and every accepted risk has an owner.

### Gate 11 — Recurrence Guard in CI
- **Pass:** Each remediated vulnerability class has a lint/SAST/test guard added so it cannot silently return.
- **Fail:** A class-level fix ships with no CI check preventing reintroduction.
- **Check:** Confirm a new rule or test exists for each fixed class.
