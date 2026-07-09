---
name: jurisdiction-first
description: >
  Establish which law governs BEFORE any legal or compliance analysis begins. Trigger phrases:
  "is this legal", "can we do X", "does GDPR/CCPA/HIPAA apply", "review this contract", "what are
  the rules for", any question about rights, obligations, liability, or regulatory exposure.
  Invoke this skill first — it gates every other legal-compliance skill. Do NOT use when the
  question is purely internal-policy interpretation with no external legal source (e.g., "does
  this violate our style guide"), or when jurisdiction was already pinned earlier in the same
  matter and nothing about parties, data, or territory has changed.
---

# jurisdiction-first

## When invoked
1. Extract the jurisdiction-determining facts from the request: (a) where each party is organized and operates, (b) where the affected people are located (employees, data subjects, consumers, investors), (c) where performance/delivery occurs, (d) any choice-of-law or forum clause already in a governing document. If any of these is unknown and outcome-determinative, ask — do not assume.
2. Identify every plausibly applicable regime, not just the obvious one. Check extraterritorial reach explicitly: GDPR Art. 3 (targeting/monitoring EU residents), CCPA revenue/volume thresholds, US securities law for any offer touching US persons, FCPA for any US-nexus entity acting abroad. A company's home jurisdiction never automatically excludes others.
3. Rank the regimes: mandatory law that cannot be contracted around (privacy, employment, consumer, securities) vs. default law displaced by a choice-of-law clause. State which category each identified regime falls in.
4. Record the jurisdiction determination as a pinned premise: "Analysis assumes [regime(s)] apply because [facts]. If [fact] is different, the analysis changes materially." Every downstream conclusion inherits this premise.
5. If regimes conflict (e.g., US discovery obligation vs. GDPR transfer restriction), flag the conflict as its own finding — do not silently pick one side.
6. Close with the mandatory framing: this is analysis support, not legal advice; a licensed attorney in the identified jurisdiction(s) must confirm before anyone acts on it.

## Output format
A **Jurisdiction Determination block** placed at the top of any legal analysis:
- `Facts relied on:` bullet list (party seats, subject locations, performance locus, existing clauses)
- `Regimes in scope:` table — regime | why it attaches | mandatory or waivable
- `Regimes excluded:` with one-line reason each (explicit exclusion, never silence)
- `Open facts:` unknowns that could flip the determination
- `Standing caveat:` the licensed-attorney framing sentence

## Quality gate
FAIL if any downstream analysis cites a statute, regulation, or case without that authority's regime appearing in the "Regimes in scope" table. FAIL if the block contains zero excluded regimes (means alternatives were never considered). FAIL if extraterritorial reach was not checked for at least GDPR when any natural-person data is involved. PASS otherwise.

## Integration
- Runs before **contract-risk-scan**, **compliance-gap-mapper**, **authority-hierarchy-check**, and **privacy-reach-triage** — they consume the pinned Regimes-in-scope table and must refuse to run without it.
- Pairs with core **plan-gate**: the jurisdiction block IS the plan gate for legal tasks — no analysis plan is approved without it.
- Pairs with **adversarial-disproof**: attack the determination by asking "what fact, if true, would attach a regime I excluded?" before pinning it.
