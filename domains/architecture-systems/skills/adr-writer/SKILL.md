---
name: adr-writer
description: >
  Write an Architecture Decision Record for any significant, hard-to-reverse system design choice.
  Triggers: "should we use X or Y", "document this decision", "why did we pick", choosing a datastore,
  queue, consistency model, service boundary, protocol, sharding key, or breaking/keeping a monolith.
  Do NOT use when the choice is trivially reversible (a library helper, a variable name, a config flag),
  when no alternatives realistically exist, or for product/feature decisions with no architectural blast radius.
---

# adr-writer

## When invoked
1. State the decision in one sentence as a question ("How do we replicate session state across regions?"). If the question is ambiguous, split it — one ADR per decision. Never bundle.
2. Write **Context**: the forces in play — load numbers, latency budgets, team constraints, existing commitments, compliance limits. Every force must be a verifiable fact, not a vibe. Pull real numbers (QPS, data size, team headcount) from the system or the requester; if a number is estimated, mark it `~` and say how it was estimated.
3. Enumerate **at least 3 options**, always including "do nothing / keep current". For each: mechanism in 2 sentences, then explicit trade-offs against the forces in Context. Name the failure mode each option introduces (consistency gap, hot partition, operational burden, vendor lock-in).
4. Run adversarial-disproof against your leading option before writing the Decision: argue the strongest case for the runner-up. If you cannot construct a real argument for any alternative, your options list is fake — go back to step 3.
5. Write **Decision** (one option, stated in active voice: "We will use...") and **Consequences** — both positive and negative. Negative consequences are mandatory; an ADR with no downsides is a sales pitch, not a record. Include the reversal cost: what it takes to undo this in 12 months.
6. Assign status (`Proposed` | `Accepted` | `Superseded by ADR-NNN`) and a sequential number. Check the ADR directory for the next number; never reuse.

## Output format
A single Markdown file `docs/adr/NNNN-short-slug.md` (or the project's existing ADR location) with exactly these sections: **Title, Status, Date, Context, Options Considered, Decision, Consequences**. Options Considered is a table: option | mechanism | pros | cons | failure mode introduced.

## Quality gate
FAIL if any of: fewer than 3 options; "do nothing" absent; Consequences lists zero negatives; Context contains no numbers; the Decision could not be reconstructed by a stranger from Context + Options alone. PASS only when a reviewer who disagrees with the decision would still call the record fair.

## Integration
- Feed the chosen option's failure mode directly into **failure-mode-mapper** as a seed entry.
- If the decision hinges on scale claims, run **capacity-planner** first and cite its envelope math in Context.
- Use **evidence-reasoning** for every Context fact; use **adversarial-disproof** at step 4.
- If the decision triggers a system change, hand the Consequences section to **migration-strategist** as its rollback-planning input.
- Gate acceptance through **plan-gate**: an ADR marked `Accepted` without stakeholder sign-off is a lie in the record.
