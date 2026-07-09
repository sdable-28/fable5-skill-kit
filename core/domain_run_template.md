# Domain Run Template — Deep Domain Pack Generator

Paste this entire prompt to a capable model (Fable-class preferred) with the two placeholders filled. It produces a complete domain pack via the Write tool only, ending with a manifest table.

---

## THE TEMPLATE (fill {DOMAIN_NAME} and {DOMAIN_BRIEF}, paste everything below)

```
You are generating a deep domain pack for: {DOMAIN_NAME}

Domain brief (context, stakes, who uses this, what good looks like):
{DOMAIN_BRIEF}

## CRITICAL OUTPUT RULE
Write ALL artifacts directly to disk with the Write tool. Do NOT output file
content in chat — no previews, no excerpts. When done, output ONLY a manifest:
  | File path | Lines | One-line description |

## Output directory
All files under: fable-kit/domains/{domain-name-kebab}/

fable-kit/domains/{domain-name-kebab}/
├── DOMAIN.md              ← domain operating guide (the core file)
├── pitfalls.md            ← specific failure modes with concrete examples
├── verification.md        ← how claims are verified IN THIS DOMAIN
├── walkthrough.md         ← one real end-to-end scenario, ≥600 words
└── skills/
    ├── {domain-skill-1}/SKILL.md
    ├── {domain-skill-2}/SKILL.md
    └── {domain-skill-3}/SKILL.md   (3–6 skills; as many as the domain truly needs)

## File requirements

### DOMAIN.md
- The domain's core mental model: what expertise in this domain actually consists of
  (the 3–5 load-bearing concepts, not a glossary).
- Effort calibration for this domain: what counts as low/medium/high/max-stakes work,
  with one example each.
- The domain's evidence standards: what counts as VERIFIED here (cite the domain's
  authoritative sources by name), what is merely PLAUSIBLE, what practitioners
  wrongly treat as verified.
- High-risk zones: where errors in this domain are most expensive (extend
  Anti_Hallucination.md §5.5 for this domain specifically).
- Hard rules: non-negotiables in this domain, each with the failure it prevents.

### pitfalls.md
Minimum 8 pitfalls. Each MUST have:
- A specific name (not "be careful with data")
- A CONCRETE failure example: what someone did, what happened, why it was wrong —
  realistic enough that a practitioner would wince in recognition
- The detection signal (how you notice you're mid-pitfall)
- The prevention discipline (a behavior, not an aspiration)
REJECT any pitfall that would be true of every domain ("verify your assumptions").
Every pitfall must be one that {DOMAIN_NAME} practitioners specifically hit.

### verification.md
- The domain's verification hierarchy: rank the authoritative sources
  (e.g., for law: statute text > case law > commentary > memory).
- Per claim-type verification recipes: "to verify a claim of type X, do Y" —
  minimum 5 claim types.
- What CANNOT be verified in this domain and how to communicate that honestly.

### walkthrough.md
ONE real end-to-end scenario, minimum 600 words, showing the full workflow:
realistic starting request → understanding/scoping → investigation with the
domain's actual tools and sources → intermediate findings including at least one
wrong turn and its correction → verified conclusion → deliverable. Use concrete
names, numbers, and artifacts throughout. A reader should finish knowing what
competent work in this domain LOOKS like, move by move.

### skills/*/SKILL.md
3–6 skills. Each must address a challenge that ONLY exists in this domain — if the
skill would make sense in fable-kit/skills/ (generic), it does not belong here.
Each SKILL.md:
- YAML frontmatter: name, description (with trigger keywords and when NOT to use)
- When invoked: exact steps
- Output format: precise structure of what it produces
- Integration: which core skills (evidence-reasoning, adversarial-disproof, etc.)
  it composes with, and at which step

## Quality bar (self-verify before writing)
1. Pitfalls are SPECIFIC with concrete failure examples — a generic pitfall is a
   failed pitfall.
2. Walkthrough is a REAL scenario ≥600 words with a wrong turn included.
3. Every domain skill is domain-exclusive — the "would this fit in the generic
   library?" test rejects it if yes.
4. Every output format is defined precisely — not "produces analysis".
5. Evidence standards name the domain's actual authoritative sources.
6. No content duplicated across files — one authoritative location per fact.
Fix any failure, then write all files, then output ONLY the manifest table.
```

---

## Usage notes (not part of the template)

- **{DOMAIN_NAME}**: e.g., "Futures Trading Systems", "Contract Law (US)", "Clinical Pharmacology", "Site Reliability Engineering".
- **{DOMAIN_BRIEF}**: 3–10 sentences. Include: who the operator is, what decisions the pack feeds, the stakes (money/health/legal exposure), any house constraints (locked systems, regulatory regime, existing tooling). The brief's specificity directly determines pack quality — "trading" produces generic output; "NQ futures intraday system on a prop account with trailing drawdown, backtest-vs-live fidelity is the core risk" produces a sharp one.
- Generated packs slot beside the core kit: core files define universal discipline; the domain pack defines what that discipline means locally. On conflict, domain pack wins within its domain.
- Regenerate a pack when the domain brief materially changes (new stakes, new tooling, new regime) — don't hand-patch drifted packs; the template is cheap to re-run.
