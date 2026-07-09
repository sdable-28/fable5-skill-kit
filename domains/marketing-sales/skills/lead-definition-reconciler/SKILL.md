---
name: lead-definition-reconciler
description: >
  Diagnose and repair the sales/marketing split where each team uses a different definition of a
  qualified lead. Trigger phrases: "sales says the leads are garbage", "MQLs aren't converting",
  "marketing hit their number but pipeline is flat", "SQL acceptance rate", "lead scoring is
  broken", "define MQL/SQL/PQL", "SLA between sales and marketing". Invoke whenever MQL volume
  and pipeline creation are moving in opposite directions. Do NOT use for generic org-conflict
  mediation, for CRM field cleanup with no definitional dispute, or when there is no sales team
  (pure self-serve — use PQL funnel analysis inside channel-attribution-auditor instead).
---

# When invoked

1. Extract the operative definitions as they actually run, not as documented: the marketing-automation scoring rules that stamp MQL, and the behavioral definition sales uses to accept/work a lead (infer it from which MQLs got ≥2 touches within 5 days vs. which were ignored). The gap between these two is the object under repair.
2. Compute the leak table for the last 2 quarters: MQL → accepted → worked (≥2 touches) → SQL → opportunity → closed-won, with counts and stage conversion. Identify the single largest leak stage. Do not propose fixes before this table exists.
3. Test the vanity-metric hypothesis: correlate monthly MQL volume against pipeline dollars created 30/60/90 days later. Near-zero or negative correlation proves the MQL definition optimizes a number, not a business outcome — state this finding bluntly with the coefficient.
4. Rebuild the qualification ladder from closed-won backwards: which pre-opportunity signals actually appeared in deals that closed (use icp-sharpener predicates if available). Score weights must trace to win-rate deltas, not to gut ("downloaded 3 whitepapers = 15 points" must show downloaders win more, or it goes to zero).
5. Draft the bilateral SLA: marketing commits to leads meeting the rebuilt definition with a volume forecast; sales commits to touch-within-X-hours and a mandatory rejection-reason taxonomy (bad-fit / no-intent / duplicate / timing) so rejected leads become training data instead of silence.
6. Define the single shared scoreboard metric both teams are paid on: pipeline dollars created from marketing-sourced leads — never raw MQL count.

# Output format

A **Reconciliation Memo** containing: (a) side-by-side operative definitions (as-scored vs. as-worked) with the specific divergent criteria; (b) the leak table with the largest leak flagged; (c) MQL-to-pipeline correlation coefficient and verdict; (d) rebuilt qualification criteria, each row citing its win-rate evidence; (e) the bilateral SLA with numeric commitments and the rejection-reason taxonomy; (f) the shared scoreboard metric definition.

# Quality gate

PASS only if both operative definitions were extracted from system behavior (scoring rules + touch data), the leak table has real counts at all six stages, and every rebuilt scoring criterion carries win-rate evidence or is explicitly zeroed. FAIL if the memo proposes "better alignment meetings" without changing a definition, or if any criterion survives on anecdote.

# Integration

- **root-cause-first**: the leak table localizes the failure stage before any fix — never accept "leads are bad" as the root cause statement.
- **evidence-reasoning**: step 4's traceability rule (score weight → win-rate delta) is its citation discipline applied to lead scoring.
- **icp-sharpener**: supplies the evidenced fit predicates; this skill adds the intent/behavior layer on top.
- **channel-attribution-auditor**: after reconciliation, re-run channel CAC against the NEW qualified definition — channel rankings usually reshuffle.
- **verified-done**: the fix is done when acceptance rate and MQL→pipeline correlation improve over one full quarter, not when the new scoring model deploys.
