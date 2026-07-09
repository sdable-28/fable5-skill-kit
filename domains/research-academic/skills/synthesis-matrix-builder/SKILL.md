---
name: synthesis-matrix-builder
description: Convert a pile of sources into a cross-source synthesis matrix so the literature review argues instead of summarizing — kills the "annotated bibliography in paragraph form" failure. Trigger phrases - "write my literature review", "synthesize these papers", "related work section", "how do these studies fit together", "my lit review reads like a list". Use when integrating 4+ sources into a review, related-work section, or background chapter. Do NOT use for auditing whether individual sources are citable (use source-hierarchy-enforcer first) or for single-source deep reading.
---

# Synthesis Matrix Builder

## When invoked
1. Take only sources that passed source-hierarchy-enforcer. If that audit has not run, run it first.
2. Derive 3-6 comparison dimensions from the research question — not generic ones. Wrong: "method, findings, year". Right: dimensions on which sources can actually disagree (e.g., "assumed mechanism", "population studied", "how the outcome was operationalized", "direction of effect").
3. Build the matrix: sources as rows, dimensions as columns, each cell a one-line position statement with page/section anchor. Empty cells are data — mark them GAP, do not pad.
4. Read the matrix by column, never by row. For each column, classify the pattern: CONSENSUS (sources agree), CONFLICT (sources disagree — name who vs whom and the most likely explanation for the disagreement: different populations, measures, eras, or genuine dispute), GAP (nobody addresses it).
5. Convert each column pattern into a synthesis sentence that cites 2+ sources in one clause ("While A and B find X under condition P, C shows the reverse when Q"). A paragraph that discusses exactly one source is a summary paragraph — rewrite or delete it.
6. Position the current work: state which CONFLICT it resolves or which GAP it fills, in one sentence anchored to specific matrix cells. If the current work maps to no conflict and no gap, report that — it means the review has not yet justified the study.
7. Order the eventual prose by dimension (thematically), never chronologically or source-by-source, unless the argument is explicitly historical.

## Output format
(1) The **Synthesis Matrix** as a table (sources × dimensions, cells anchored); (2) a **Column Verdict List** — per dimension: CONSENSUS / CONFLICT / GAP with named parties and explanation; (3) **Synthesis Sentences** — one per dimension, each citing 2+ sources; (4) a one-sentence **Positioning Statement** tying the current work to a specific cell-level conflict or gap.

## Quality gate
PASS only if every dimension has a column verdict, every synthesis sentence cites at least two distinct sources in a single clause, no output paragraph is organized source-by-source, and the Positioning Statement points at a named CONFLICT or GAP from the verdict list. A matrix where every column reads CONSENSUS is suspect — re-derive dimensions once before accepting it.

## Integration
Consumes the tier table from source-hierarchy-enforcer; weight CONFLICT adjudication by tier (a T1 vs T5 "conflict" is not a conflict). CONFLICT columns are inputs to adversarial-disproof — steelman the side the draft argues against. GAP columns feed so-what-extractor's contribution statement. Use evidence-reasoning when explaining why sources disagree — the explanation is an inference and must be labeled as such, not asserted.
