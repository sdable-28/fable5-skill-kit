---
name: mece-decomposer
description: Decompose a locked business problem into a MECE issue tree and route each branch to hypothesis-led or data-led treatment. Trigger phrases - "break this down", "build an issue tree", "structure the analysis", "what drives X", "profitability diagnostic". Do NOT use when the problem statement is not yet locked (run problem-statement-lock first), or for decompositions of code, tasks, or systems outside a business-strategy question.
---

# MECE Decomposer

## When invoked

1. Take the locked problem statement. Refuse to decompose a symptom or a topic.
2. Choose the top-level cut deliberately and name why: arithmetic (profit = revenue − cost), process (value chain stages), segment (customer/product/geo), or hypothesis buckets. State the rejected cuts in one line each.
3. Build the tree 2-3 levels deep. At every level run the two tests explicitly:
   - **ME**: can any datum land in two branches? If yes, redraw.
   - **CE**: name what would fall outside all branches. If anything real does, add a branch or widen one.
4. Tag every leaf as HYPOTHESIS-LED (state the hypothesis and the single analysis that confirms/kills it) or DATA-LED (state the dataset and the question asked of it). No untagged leaves.
5. Prioritize leaves by (impact on the metric in the problem statement) × (ease of resolution). Kill or park leaves that cannot move the metric — write "parked: cannot move [metric] by more than X" next to each.
6. Assign the top 3-5 leaves as workstreams with a named killer analysis each.

## Output format

An **Issue Tree Sheet**: (a) the tree in indented outline form with level-by-level MECE verdicts, (b) rationale for the chosen top-level cut plus rejected cuts, (c) leaf table with columns: leaf, tag (H/D), killer analysis or dataset, impact estimate, priority rank, status (active/parked).

## Quality gate

PASS only if: every level records an explicit ME check and a CE check with a named residual ("what's left out: nothing / X, added"), every leaf carries an H or D tag with a concrete analysis, and at least one leaf is parked with a quantified reason. A tree where all branches survived prioritization FAILS — it was not prioritized.

## Quality gate failure modes

Overlap smuggled in via vague labels ("market factors" + "competitive factors") — force operational definitions. Depth beyond 3 levels — that is analysis paralysis, stop and analyze.

## Integration

- Requires problem-statement-lock output as input; decomposes only the locked statement.
- Each HYPOTHESIS-LED leaf goes through adversarial-disproof: design the analysis to kill the hypothesis, not confirm it.
- DATA-LED leaves route to statistical-analysis for the actual number-crunching.
- Leaf priorities feed plan-gate as the workplan; so-what-enforcer runs on every leaf's findings before synthesis.
