---
name: authority-hierarchy-check
description: >
  Verify that every legal proposition rests on a primary source of the right rank, in the right
  jurisdiction, still good law. Trigger phrases: "cite the statute", "is that actually the law",
  "source for that", "check these citations", and MANDATORY before delivering any legal
  conclusion that names a rule. Catches the domain's signature failures: secondary-source
  laundering (blog post cited as if it were the regulation), stale law (amended statute,
  overruled case, superseded framework), and rank confusion (guidance treated as binding).
  Do NOT use for non-legal factual claims (use core evidence-reasoning), or for pure business
  judgment questions with no rule-of-law assertion in them.
---

# authority-hierarchy-check

## When invoked
1. Extract every rule-assertion from the draft analysis — each sentence of the form "the law requires/permits/prohibits X". Number them. Unnumbered assertions escape checking.
2. For each assertion, identify the supporting authority and classify its rank: (1) constitution/statute/regulation text, (2) binding case law in the pinned jurisdiction, (3) agency guidance/enforcement actions (persuasive, not binding), (4) secondary sources (treatises, firm memos, blogs — never sufficient alone). Assertions resting only on rank-4 get downgraded to "commonly stated, unverified against primary source" in the output.
3. Check jurisdiction match against the jurisdiction-first block: a Ninth Circuit case does not bind a Delaware state claim; a UK ICO opinion does not settle a CNIL question. Mismatched authority is flagged, not silently kept.
4. Check currency — the regulatory-lag test. For each primary source ask: has it been amended, repealed, superseded, or (for cases) overruled/limited since the knowledge cutoff or since the source was written? Any authority in a fast-moving area (privacy, AI regulation, securities exemptions, non-compete enforceability) gets an explicit currency flag: `verified current as of [date]` or `currency unverified — confirm before relying`. When web verification is available, verify; when it is not, the flag stays.
5. Distinguish holding from dicta and rule from safe-harbor: an assertion that "Reg D allows X" must say which rule (504/506(b)/506(c)) and which condition set — conditions are part of the rule, not a footnote.
6. Never present a conclusion with more confidence than its best authority supports. Rank-3/4-only support means the conclusion is phrased as "guidance suggests" / "practitioners commonly", never "the law requires".

## Output format
A **Citation Ledger** appended to the analysis: table `# | assertion | authority | rank (1-4) | jurisdiction match (Y/N) | currency (verified [date] / unverified) | confidence phrasing check (OK/overstated)`. Followed by a list of assertions that must be softened or cut, and the attorney caveat.

## Quality gate
FAIL if any assertion in the final analysis lacks a ledger row. FAIL if any "the law requires" phrasing survives on rank-3/4-only support. FAIL if any authority in privacy, securities, or employment lacks a currency flag. PASS otherwise.

## Integration
- Runs against the output of **contract-risk-scan** (enforceability claims), **compliance-gap-mapper** (framework text citations), and **privacy-reach-triage** (applicability conclusions) before any of them ship.
- Consumes the **jurisdiction-first** Regimes-in-scope table for the jurisdiction-match column.
- Implements core **evidence-reasoning** for the legal domain, where "evidence" has a formal rank hierarchy that generic fact-checking lacks.
- Pairs with core **adversarial-disproof**: for each rank-1 authority, search for the amendment or contrary case that would kill the assertion; only after that search fails is the assertion stable.
