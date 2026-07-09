---
name: north-star-aligner
description: >
  Select or audit a North Star Metric and build the metric tree beneath it — input metrics,
  guardrails, and the causal chain from any initiative to the North Star. Trigger phrases:
  "what should our north star be", "is DAU the right metric", "build a metric tree",
  "does this feature ladder up", "define success metrics for", "OKR alignment check".
  Do NOT use when designing a single A/B test's stats (MDE, power — that is experiment
  design), when the ask is dashboard/visualization work, or for company financial
  reporting metrics (revenue recognition, CAC accounting).
---

# north-star-aligner

## When invoked
1. Extract the candidate North Star. Test it against four criteria, each pass/fail: (a) measures value delivered to the user, not activity extracted from them; (b) leading indicator of revenue, not revenue itself; (c) a team can move it within a quarter; (d) resistant to gaming — state the obvious gaming vector and why it fails.
2. Run the vanity screen: if the metric can grow while retention is flat or falling (raw DAU, signups, page views, downloads, cumulative anything), reject it and say so. Replace with the retained-action form: "users who did [core value action] ≥N times in [period]".
3. Build the metric tree exactly 3 levels deep: North Star → 3-5 input metrics (each causally movable by a specific team, name the team) → the initiative/lever level. Every edge must state its causal claim in one sentence.
4. Attach guardrail metrics: for each input metric, name what breaks if a team maximizes it naively (e.g., notification-driven sessions → uninstall rate). Minimum one guardrail per input metric.
5. If auditing an initiative: trace its path to the North Star through the tree. No path = the initiative has no measurable strategy link. Say that plainly; do not invent a path.

## Output format
A metric tree in indented text or a table (`Level | Metric | Owner team | Causal claim | Guardrail`), the four-criteria verdict on the North Star (pass/fail per criterion with one-line justification), and — if auditing — an "Alignment trace" section: initiative → input metric → North Star, or the explicit verdict "NO PATH".

## Quality gate
PASS only if: the North Star survived all four criteria or was replaced, every input metric has a named owner team AND a named guardrail, and no tree node is a cumulative or raw-count vanity metric. FAIL if any edge lacks a causal claim sentence or if "engagement" appears as a metric name without an operational definition.

## Quality gate cross-check
The gaming vector in step 1d must differ from the guardrails in step 4 — if they collapse into one, the analysis was shallow; redo step 4.

## Integration
Supplies the metric vocabulary for `hypothesis-prioritizer` Impact scores and for `roadmap-outcome-converter` outcome statements. Use core `root-cause-first` when a proposed North Star is really a symptom metric (churn) rather than a cause (activation quality). Use core `statistical-analysis` to verify claimed input→North Star correlations before accepting a tree edge as causal. Gate final adoption through core `verified-done`: the tree is done when each input metric has a live query or data source named, not before.
