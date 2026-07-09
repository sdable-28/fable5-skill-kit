---
name: so-what-extractor
description: Force every research finding to yield an explicit, audience-anchored implication — kill the "descriptive dump" failure where a paper or report presents results and never answers "so what". Trigger phrases - "write the discussion", "implications section", "executive summary", "recommendations", "why does this matter", "conclusion feels flat". Use when drafting or revising discussion sections, abstracts, executive summaries, or recommendation lists. Do NOT use for verifying whether the findings themselves are sound (use harking-detector / statistical-analysis first) or for restructuring the literature review (use synthesis-matrix-builder).
---

# So-What Extractor

## When invoked
1. Identify the named audiences of the deliverable (practitioners, policymakers, the field's theorists, funders). If none are named, force the choice before proceeding — an implication without an audience is decoration.
2. List every finding the results section actually supports. Pull them from the results, not the abstract — abstracts inflate.
3. For each finding, apply the three-turn ladder and write all three rungs: (a) FINDING — what was observed; (b) MEANING — what it changes about what the audience believed or did before this study; (c) ACTION — what a named audience member should do differently, with a verb and an object. "Further research is needed" is banned as an ACTION unless it names the specific study design that would resolve the specific open question.
4. Separate recommendations from observations ruthlessly. An observation restates data ("adoption was low among group X"). A recommendation commands ("target onboarding at group X via Y"). Any item in a recommendations list that lacks an imperative verb gets demoted to observation.
5. Test each implication against the evidence chain: does the ACTION follow from the FINDING at the sample and effect size actually obtained, or does it require the inflated version? Cut or weaken any rung the data cannot carry.
6. Write the one-sentence contribution statement: "Before this work, X was believed/unknown; this work shows Y; therefore Z should change." If this sentence cannot be written, the deliverable has no thesis — escalate that as the finding.

## Output format
A **So-What Ladder**: one block per finding with labeled FINDING / MEANING / ACTION rungs and a target-audience tag on each ACTION. Followed by a **Recommendations vs Observations** two-column sort of every takeaway in the draft, and the single **Contribution Statement** sentence at the end.

## Quality gate
PASS only if every finding block has all three rungs populated, every ACTION names an audience and contains an imperative verb, zero ACTIONs read "more research is needed" without a named design, and the Contribution Statement exists as one grammatical sentence. Any finding with an empty ACTION rung must be explicitly marked "descriptive only — no actionable implication" rather than silently padded.

## Quality gate enforcement note
Rung (b) MEANING must reference a prior belief or practice — if it merely rephrases rung (a), it fails.

## Integration
Run after harking-detector and claims-boundary-auditor — implications inherit the evidence status and generalization bounds they set. The Contribution Statement is the seed for the abstract (problem → method → results → implications) and the executive summary. Use plan-gate before drafting a full discussion section around the ladder; use verified-done to confirm the final draft's recommendations match the ladder one-to-one with nothing invented in prose.
