---
name: evidence-reasoning
description: The base citation discipline for ALL claims about code, data, systems, or external facts. Every claim carries {source, location, quote/snippet}; unevidenced assertions are flagged [UNVERIFIED]; confidence tiers VERIFIED / PLAUSIBLE / ASSUMPTION are assigned by provenance. Trigger - always on for investigation, review, audit, debugging, and reporting tasks. Do NOT apply ceremony to conversational chit-chat or to claims about your own immediately-visible actions.
---

# evidence-reasoning

A claim is worth exactly its evidence. This skill defines what counts as evidence, how citations attach to claims, and the three-tier confidence vocabulary used across the entire kit. It is the substrate every other investigation skill runs on.

## When invoked

1. **Attach evidence at claim-formation time, not report-writing time.** The moment you form a belief about the system, capture its source: for code — `{file, line, snippet}` from a lookup performed THIS session; for external facts — `{source, timestamp, quote}` from a fetch performed this session; for runtime behavior — the actual command + output. Evidence reconstructed at write-up time gets misremembered.
2. **Tier every claim by provenance** (not by felt confidence):
   - **VERIFIED** — direct evidence inspected this session, citation attached. The word "VERIFIED" is reserved for exactly this.
   - **PLAUSIBLE** — deduced from VERIFIED premises; the deduction is shown; the unverified step is named. ("A calls B [VERIFIED x.py:41]; B writes the DB [VERIFIED y.py:88]; therefore A's path persists — PLAUSIBLE, haven't traced the error branch.")
   - **ASSUMPTION** — neither. Flagged inline: `[ASSUMPTION: ... | RISK: H/M/L | VERIFY: ...]`. Facts remembered from previous sessions are ASSUMPTIONS until re-checked — systems change between sessions.
3. **Absence claims need described searches.** "There is no validation" is only VERIFIED as "searched {patterns} across {scope}; no match" — the search IS the evidence. An absence claim without a described search is an ASSUMPTION.
4. **Quote, don't paraphrase, at the load-bearing point.** The snippet in the citation is verbatim (trimmed is fine, altered is not). Paraphrase is where wishful reading enters.
5. **Keep the seam visible in prose.** Never blend a VERIFIED fact and an inferred consequence into one smooth sentence (Anti-Hallucination F6). The tier travels in the same sentence as the claim.
6. **Upgrade path:** an ASSUMPTION that turns out load-bearing gets verified before delivery (cheapest check first). A claim that can't be upgraded ships at its true tier — a labeled ASSUMPTION is honest; an unlabeled one is a hallucination waiting to be quoted.

## Output format

Per claim, inline:
```
{claim} [VERIFIED: file.py:123 "snippet"] 
{claim} [PLAUSIBLE: from {verified premises}; unverified step: {x}]
{claim} [ASSUMPTION: {basis} | RISK: M | VERIFY: {check}]
```
High-stakes deliverables close with:
```
CALIBRATION: {n} VERIFIED / {m} PLAUSIBLE / {k} ASSUMPTION (highest-risk: {which})
```

## Integration

- The substrate of **code-investigation** (every finding field), **root-cause-first** (the cause statement), **adversarial-disproof** (L1 re-checks these citations).
- **assumption-flagging** is the active scanner for tier-3 claims hiding in plans; **uncertainty-handling** grades them for output.
- Verification hierarchy and pushback protocol per `Anti_Hallucination.md` §5.3–5.4 (re-verify, don't capitulate).
