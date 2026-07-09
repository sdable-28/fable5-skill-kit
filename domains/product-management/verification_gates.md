# Product Management & Strategy — Verification Gates

Domain-specific pass/fail gates. Run before delivering any roadmap, PRD, prioritization, or experiment analysis.

### Gate 1 — Problem-Before-Solution Validation
- **Pass:** The problem is validated (JTBD, non-leading interviews) before any solution is specified.
- **Fail:** A solution is scoped on assumed demand, or interview questions led the witness.
- **Check:** Confirm problem-validation evidence precedes the solution and questions are non-leading.

### Gate 2 — Outcome-Based Roadmap
- **Pass:** Roadmap items are stated as metric outcomes to move, not features to ship.
- **Fail:** The roadmap is a feature list with dates and no target metric.
- **Check:** Confirm each item names the outcome/metric it moves.

### Gate 3 — Prioritization Inputs Grounded
- **Pass:** RICE/ICE scores use evidenced reach/impact/confidence, not gut numbers.
- **Fail:** Scores are invented to rank a predetermined favorite.
- **Check:** Trace each score's inputs to evidence; confirm confidence reflects real uncertainty.

### Gate 4 — HiPPO Guard
- **Pass:** The prioritization decision is traceable to evidence, not to the most senior opinion.
- **Fail:** An executive preference overrides the scoring with no new evidence.
- **Check:** Confirm the ranked order matches the evidence, or the override is justified with data.

### Gate 5 — North Star With Guardrails
- **Pass:** The North Star metric is paired with guardrail metrics that catch gaming.
- **Fail:** A single metric optimized with no guardrail (e.g. engagement up, retention down unwatched).
- **Check:** Confirm guardrail metrics exist and are monitored alongside the North Star.

### Gate 6 — Input vs. Output Metric Separation
- **Pass:** The team's controllable input metrics are distinguished from lagging output metrics.
- **Fail:** The team is steered by an output metric it cannot directly move.
- **Check:** Confirm each tracked metric is labeled input (actionable) or output (lagging).

### Gate 7 — A/B Test Power and MDE
- **Pass:** Experiments pre-state MDE, sample size, and duration from a power calculation.
- **Fail:** A test is called on an underpowered sample or read before the planned N.
- **Check:** Confirm the power calc exists and the readout waited for the pre-registered sample.

### Gate 8 — Peeking Discipline
- **Pass:** Results are read at the pre-committed stopping point, or a sequential-testing correction is applied.
- **Fail:** The test is stopped early on a favorable peek without correction.
- **Check:** Confirm no early call was made, or a valid sequential method was used.

### Gate 9 — Vanity Metric Rejection
- **Pass:** Success is activated-and-retained users or a retention curve, not DAU/signups in isolation.
- **Fail:** DAU or cumulative signups cited as success without a retention denominator.
- **Check:** Confirm the metric has a retention/activation denominator.

### Gate 10 — Feature-Impact Closure
- **Pass:** Shipped features are measured against their predicted outcome; misses are logged.
- **Fail:** Features ship and the team moves on without validating impact (feature factory).
- **Check:** Confirm each shipped item has a post-ship metric read against its predicted outcome.
