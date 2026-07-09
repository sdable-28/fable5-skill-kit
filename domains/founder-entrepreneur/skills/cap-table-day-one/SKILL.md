---
name: cap-table-day-one
description: >
  Set up and sanity-check the cap table and entity structure from incorporation through the
  first ~10 hires — entity choice, 83(b) deadlines, option pool sizing, per-role early-hire
  equity, and dilution hygiene. Trigger phrases: "should I incorporate", "Delaware C-corp or
  LLC", "how much equity for my first engineer", "option pool size", "83(b)", "advisor
  equity", "contractor or employee". Do NOT use for term-sheet negotiation (that is
  term-sheet-analyzer) or for post-Series-A comp benchmarking. Do NOT use as a substitute
  for a startup lawyer on executed filings — it decides WHAT to do and checks WHAT was done;
  a lawyer executes it.
---

# Cap Table Day One

## When invoked
1. Entity check first. Default recommendation: Delaware C-corp if the plan includes outside equity investors or employee options; LLC only if bootstrapping with pass-through profits and no option plan intended. If an LLC already exists and a raise is planned, flag the conversion now — cost and pain grow with every month and every new member. Home-state incorporation to "save fees" before a raise: flag as false economy, investors will force re-incorporation.
2. Run the irreversible-deadline sweep, dated: (a) **83(b) election — 30 days from stock purchase, no extensions, missing it is an uncorrectable tax disaster**: confirm filing proof (mail receipt) per founder; (b) IP assignment signed by every founder and every contractor who touched the code — before the first raise; (c) QSBS clock (C-corp stock held 5 years) — note the start date.
3. Audit worker classification: anyone working core product hours under direction is an employee, not a 1099 contractor, regardless of what the contract says. Misclassification surfaces in diligence and in state audits. List every current worker with classification and risk flag.
4. Size the option pool from a hiring plan, not a round number: list the next 12-18 months of hires, assign each a grant from the stage-appropriate band (first engineer 0.5–2%, founding-level exec 1–5%, early non-engineering 0.1–0.5%, advisors 0.1–0.5% with 2-year vest and clear deliverables), sum, add ~30% buffer. Note in the ledger: investors will push the pool into the pre-money — an oversized pool is founder dilution wearing a generosity costume; carry the hiring-plan math into the negotiation.
5. Verify grant hygiene on every existing grant: board approval recorded, 409A valuation current (refresh at 12 months or any material event), vesting schedule standard (4/1) unless a documented reason, no verbal equity promises outstanding. Verbal promises are recorded as liabilities in the ledger until papered or retracted.
6. Produce the fully-diluted table and check it: founders + pool + advisors + any SAFEs-as-converted sum to 100%, and founder combined ownership is consistent with stage norms (materially low pre-seed founder ownership is a red flag investors will price or pass on).

## Output format
A **Day-One Ledger**: (1) entity verdict with one-line rationale; (2) deadline table `item | owner | deadline | proof on file?`; (3) worker classification table with risk flags; (4) option pool build-up `role | timing | grant % | band check`; (5) fully-diluted cap table summing to 100%; (6) fix list ordered by irreversibility (83(b) first, always).

## Quality gate
FAIL if: any founder's 83(b) status is unknown or unproven within its 30-day window; the pool size is not derived from the listed hiring plan; the fully-diluted table does not sum to 100%; any verbal equity promise is omitted from the ledger; or a contractor building core IP lacks a signed IP assignment. PASS only when every fix-list item has an owner and a date.

## Integration
This ledger is the diligence substrate for `term-sheet-analyzer` — its waterfall starts from this fully-diluted table, and pool-shuffle negotiation uses the hiring-plan build-up as ammunition. Cross-references `cofounder-agreement-checklist` on founder vesting and IP (do not duplicate; link the gaps). Deadline sweep runs under **verified-done**: "my lawyer handled it" is a claim; the filed document or mail receipt is the evidence. Apply **root-cause-first** when the table doesn't reconcile — the discrepancy is usually an unpapered promise, not an arithmetic slip.
