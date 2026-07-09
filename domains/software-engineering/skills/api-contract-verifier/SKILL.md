---
name: api-contract-verifier
description: Backward-compatibility verification for any consumed interface — REST/GraphQL/gRPC endpoints, library public APIs, event/message schemas, CLI flags, webhook payloads. Trigger phrases: "change the endpoint", "update the response shape", "bump the API version", "will this break clients", "modify the schema", "deprecate this field". Do NOT use for purely internal functions with all callers in the same repo and no serialization boundary — that is refactor-gate territory — or for brand-new interfaces with zero existing consumers.
---

# API Contract Verifier

## When invoked

1. Identify the contract and its consumers. Locate the authoritative spec (OpenAPI/GraphQL SDL/proto files/JSON Schema/typed client) — if none exists, reconstruct the de facto contract from current serialized output and treat THAT as authoritative. List known consumer classes: same-repo, other internal services, external/uncontrolled clients, queued messages already in flight.
2. Classify every proposed change against the breakage matrix:
   - **Safe**: add optional field, add new endpoint/enum value consumers ignore, widen accepted input.
   - **Breaking**: remove/rename field, change type or nullability, tighten validation, change error codes/status semantics, reorder positional data, change default behavior, alter field meaning without renaming (silent break — worst class).
   - **Conditionally safe**: adding enum values consumers switch on, changing pagination/rate-limit behavior — verify consumer tolerance explicitly.
3. For each breaking change, require a compatibility strategy before approving: version bump per semver (or new API version path), expand–contract (add new alongside old, migrate consumers, then remove), or feature-flagged rollout. "All clients will update simultaneously" is not a strategy unless every consumer is in the same deploy unit.
4. Verify mechanically, not by inspection: diff old vs new spec with a compat tool if available; otherwise serialize real responses from both versions and diff field-by-field. Replay recorded consumer requests (or contract tests) against the new implementation.
5. Check the non-body surface: status codes, headers (auth, pagination, rate-limit, CORS), content types, idempotency behavior of retried calls, and error payload shape. These break clients as surely as body fields.
6. Confirm serialization round-trips: old-version messages already persisted in queues/DB must still deserialize under the new schema.

## Output format

A **Compatibility Verdict**: `Contract Source` (spec path or reconstruction method), `Consumer Inventory`, `Change Table` (each change → Safe / Breaking / Conditional, with the matrix rule cited), `Mitigation per Breaking change`, `Mechanical Evidence` (diff output, replay results, round-trip test), final line `VERDICT: COMPATIBLE | BREAKING-WITH-MITIGATION | BLOCKED`.

## Quality gate

PASS only if every change row cites a matrix rule AND every Breaking row has a named mitigation AND mechanical evidence (spec diff or request replay) exists — a verdict justified only by reading the code is a FAIL. Auto-FAIL if any field changed meaning while keeping its name and type.

## Integration

- Runs during **plan-gate** for any task touching a serialization boundary — before implementation, not after.
- The Change Table is **adversarial-disproof** applied to compatibility: assume each change breaks someone, then prove it doesn't.
- Replay/diff outputs are the **evidence-reasoning** record; the verdict must trace to them.
- Pairs with **refactor-gate** when internal restructuring leaks into a public signature, and with **migration-safety** when the contract change requires a schema change underneath.
- **verified-done** requires the Compatibility Verdict attached to any completion claim on interface work.
