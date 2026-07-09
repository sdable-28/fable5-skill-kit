---
name: uncertainty-handling
description: Use whenever you are about to state something you are not sure of — an estimate, a prediction, an interpretation, a fact you couldn't verify. Surfaces uncertainty explicitly with confidence level, sensitivity, and verification path. Trigger signals - hedging words forming in your draft ("probably", "should", "typically", "I believe"), questions about future/unobserved state, any fact you'd bet less than 9-to-1 on. Do NOT use to blanket-hedge everything — VERIFIED claims are stated plainly; this skill is for genuine uncertainty only.
---

# uncertainty-handling

Uncertainty buried in confident prose is a lie with plausible deniability. Uncertainty surfaced explicitly is information the user can act on. The skill is not "be less confident" — it is "put the confidence number where the reader can see it, and tell them what would move it."

## When invoked

1. **Isolate the uncertain claim.** Separate it from the surrounding verified material — one claim, stated crisply. Uncertainty about a paragraph usually resolves into uncertainty about one clause.
2. **Assign a confidence level, honestly.** Use coarse bands, not false precision:
   - **HIGH (~85%+)** — would act on it, but a specific check could still flip it.
   - **MODERATE (~60–85%)** — more likely than not; would not build anything load-bearing on it unverified.
   - **LOW (<60%)** — a hypothesis, stated only because it's useful as a direction.
   Calibration check: "would I take the corresponding bet?" If not, drop a band.
3. **State what would change the estimate.** Name the observation that would raise or lower it: "MODERATE that the fill logic causes the gap — would go HIGH if the log shows entry and exit in the same minute; would collapse if the gap appears on multi-minute trades too."
4. **State how to verify,** concretely: the command, the file, the experiment, the person to ask. An uncertainty without a verification path is a shrug; with one, it's a work item.
5. **Verify now if cheap and load-bearing.** If the check costs under a minute and the claim feeds the current decision, do the check instead of shipping the uncertainty. This skill is the fallback for when verification is expensive or impossible, not an excuse to skip cheap checks.
6. **Never average into confidence.** Two conflicting sources don't yield one MODERATE claim — they yield an explicit conflict: "Source A says X, source B says Y, unresolved; here's how to resolve it."

## Output format

Inline, attached to the claim (never in a distant disclaimer section):
```
{claim} — CONFIDENCE: HIGH/MODERATE/LOW.
Would change on: {observation}. Verify: {concrete check}.
```
For multiple uncertain claims in one deliverable, add a closing calibration line:
```
UNCERTAINTY SUMMARY: {n} claims below VERIFIED — highest-impact: {which one}, verify first.
```

## Integration

- Implements the ASSUMPTION/PLAUSIBLE tiers of **evidence-reasoning** with graded confidence.
- **assumption-flagging** finds hidden assumptions; this skill dresses them for output once found.
- Under user pushback, follows Anti-Hallucination F5: re-verify, restate the confidence with evidence — don't drop a band to be agreeable.
- Master Framework: unresolved HIGH-impact uncertainty at Gate 3 or Gate 5 is a gate failure, not a footnote.
