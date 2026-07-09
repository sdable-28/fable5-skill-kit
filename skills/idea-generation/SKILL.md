---
name: idea-generation
description: Use when the task is to produce ideas, options, names, approaches, features, or creative directions — brainstorming, "what could we try", stuck-on-a-problem moments. Diverges first (quantity, zero filtering), then converges (structured evaluation on novelty × feasibility × impact). Trigger keywords - "brainstorm", "ideas for", "what are some ways", "alternatives to", "I'm stuck". Do NOT use when the option space is small and enumerable (2-3 known choices — just analyze them) or when the user wants one recommendation fast.
---

# idea-generation

The first three ideas are the ones everyone has — they're retrieval, not generation. Real generation requires separating the diverge phase (where judgment is banned, because evaluation kills the unusual before it can mature) from the converge phase (where judgment is the whole job). Never accept the first 3 ideas as the best; they almost never are.

## When invoked

### Diverge (no filtering, no feasibility comments, quantity is the metric)
1. **Set a quota beyond comfort** — 15–25 ideas minimum. The forcing matters: ideas 1–5 are obvious, 6–12 are variations, the interesting material starts where retrieval runs out.
2. **Rotate generation lenses** when a vein dries up:
   - **SCAMPER** — Substitute, Combine, Adapt, Modify/Magnify, Put-to-other-use, Eliminate, Reverse. ("Reverse: what if the stop moved TOWARD price?" — most reversals are absurd; the exercise is what surfaces the non-absurd one.)
   - **Constraint relaxation** — list the assumed constraints, delete each in turn: "if latency didn't matter... if we had 100× data... if it didn't have to be automated..." Ideas found here often survive partial re-imposition of the constraint.
   - **Constraint addition** — the inverse forcing: "what if it had to work with zero new code / by tomorrow / for free?"
   - **Cross-domain transplant** — how does another field solve the shape of this problem? (auction theory, immune systems, logistics, casino risk management). Force 3 transplants even when they feel strained.
   - **Inversion** — instead of "how to achieve X," generate "how to guarantee NOT-X," then negate each.
3. **Record every idea in one line, uncensored.** Bad ideas stay on the list — they're stepping stones (a bad idea plus a lens is often a good idea).

### Converge (judgment on)
4. **Cluster** duplicates and variants; name each cluster's underlying mechanism.
5. **Score on three axes, 1–5 each:** **novelty** (is this different from what's already been tried — check the falsified/tried list first), **feasibility** (buildable with real constraints back in force), **impact** (if it works, does it matter). Score with a phrase of reasoning per axis, not bare numbers.
6. **Select 2–4 finalists** — not necessarily the top scorers: take the best expected-value bet, the cheapest-to-test, and one high-variance wildcard. State why each earned its slot and what the first cheap test of each would be.

## Output format

```
DIVERGED: {n} ideas ({lenses used})
{full uncensored list, one line each}
CLUSTERS: {name → mechanism → member ideas}
SCORED: {cluster | N/F/I with one-phrase rationale each}
FINALISTS:
  1. {idea} — why: {...} — first cheap test: {...}
  2. ...
```

## Integration

- Feeds **plan-gate** or **system-design** once a finalist is chosen; the "first cheap test" is Master Framework G3's riskiest-assumption-first rule.
- Check novelty against the falsification ledger BEFORE scoring — re-generating disproven ideas wastes the converge phase.
- **assumption-flagging** on finalists (feasibility scores hide assumptions).
- Wide solution spaces at scale: the judge-panel pattern in **multi-agent-orchestration** (N independent generators, diverse lenses, scored synthesis).
