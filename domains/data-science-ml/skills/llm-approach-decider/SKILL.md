---
name: llm-approach-decider
description: Choose between prompting, RAG, fine-tuning, and tool use for an LLM feature, and define its eval harness before building. Trigger phrases - "should we fine-tune", "build a RAG pipeline", "the model hallucinates", "add an LLM feature", "which chunking strategy", "how do we evaluate the LLM output". Use when designing or fixing any LLM-powered capability. Do NOT use for classical ML modeling decisions (baseline-first-gate), non-LLM metric selection (eval-metric-alignment), or generic API integration work with no generation quality question.
---

# LLM Approach Decider

## When invoked
1. Classify the gap first — this determines the tool, and mixing them up burns weeks:
   - Model lacks KNOWLEDGE (private, fresh, or long-tail facts) → RAG. Fine-tuning does not reliably inject facts and does not update.
   - Model lacks BEHAVIOR/FORM (style, format, domain register, consistent structured output) → prompting first; fine-tune only after a maxed-out prompt with few-shot examples measurably fails.
   - Model lacks ABILITY TO ACT (live data, computation, side effects) → tool use. Never generate what can be computed or fetched deterministically.
   - Model lacks nothing but output is unreliable → constrain: schemas/grammars, retrieval grounding with mandatory citations, or a verification pass.
2. Enforce the escalation ladder: prompt → prompt + few-shot → RAG or tools → fine-tune. Each rung requires a measured failure of the previous rung on the eval set — "we assume prompting won't work" is not a measurement. Fine-tuning is last: it costs data collection, per-base-model re-runs, and forfeits base-model upgrades.
3. Build the eval harness BEFORE the pipeline: 20-50 real input cases minimum, each with either a gold answer, a checkable property (schema-valid, citation resolves, number matches source), or a rubric. Define the grader per case type: exact/programmatic check where possible; LLM-as-judge only for open-ended quality, with a rubric and spot-check of the judge itself against a handful of human labels.
4. For RAG specifically, evaluate retrieval and generation SEPARATELY: recall@k of gold passages first — if retrieval misses, no prompt fixes generation. Choose chunking from document structure (respect semantic boundaries; start ~300-800 tokens with overlap) and record the choice as a tunable, not a truth.
5. Address hallucination structurally, not by prompt pleading: ground with retrieved context + "answer only from context" + citation requirement + an automated check that cited spans exist. Measure the abstention rate — a system that never says "not found" is hallucinating somewhere.
6. Budget the context window: rank what enters the prompt by marginal value, define the truncation order now, and verify critical instructions survive the worst-case fill.

## Output format
An **Approach Decision Record**: (1) gap classification with one-line evidence, (2) chosen rung on the ladder + which lower rungs were measured as failing (scores), (3) eval harness spec `case source | N | grader type | pass criterion`, (4) if RAG: retrieval eval plan (recall@k target) + chunking choice, (5) hallucination controls + abstention check, (6) context budget with truncation order.

## Quality gate
PASS only if the eval harness exists with >= 20 concrete cases before pipeline code is written, and any rung above "prompting" cites a measured failure score of the rung below. FAIL if fine-tuning is selected without few-shot prompt scores in the record, or if RAG quality is asserted from end-to-end vibes with no separate retrieval recall number.

## Integration
- The eval harness is this domain's Metric Contract analog — hand it to **eval-metric-alignment** patterns for baseline ("no-RAG prompt") comparison and to **drift-monitor-designer** for production regression tracking (model version bumps ARE distribution shifts).
- **adversarial-disproof**: seed the eval set with trap cases — unanswerable questions, near-miss retrieval distractors, injection attempts — designed to make the system fail.
- **plan-gate** blocks pipeline construction until the Decision Record and harness exist; **verified-done** = harness pass rate reported, not a demo transcript.
