---
name: manual-traction-ladder
description: >
  Design and audit the do-things-that-don't-scale path: first 10 customers by hand, manual
  service delivery, and $10k MRR before any growth machine. Trigger phrases: "how do I get
  my first customers", "launch plan", "go-to-market for my startup", "should I run ads",
  "hire a salesperson", "build a growth team", "no users yet". Do NOT use when the company
  is past ~$10k MRR with repeatable acquisition — that is scaling, a different discipline.
  Do NOT use for idea-stage questions with zero customer evidence — run momtest-auditor
  first; a traction plan for an unvalidated problem automates waste.
---

# Manual Traction Ladder

## When invoked
1. Confirm the prerequisite: momtest-auditor verdict is VALIDATED (or equivalent behavior evidence exists). If not, stop and route there.
2. Locate the founder on the ladder and refuse to plan above their rung:
   - **Rung 0 → 10 customers:** founder-personal direct outreach only. Named individuals from the discovery interviews and their referrals. No ads, no content, no launch, no landing-page-and-wait.
   - **Rung 10 → $10k MRR:** manual delivery of the core value, founder as the product where possible (concierge/Wizard-of-Oz — the Airbnb photographer, Stripe "we'll integrate it for you", DoorDash founders doing deliveries). Instrument what the manual work teaches.
   - **Rung $10k MRR →:** only now design repeatable acquisition, and only from channels that produced the first customers organically.
3. For Rung 0, produce the outreach plan: a named list of 30+ specific prospects (person, company, why-them from the JTBD evidence), the first-line message referencing THEIR observed behavior not the product, and a weekly contact quota the founder personally executes.
4. Hard-block the scaling reflexes, by name, with the reason: paid ads before 10 hand-won customers (buys vanity, hides the message-market gap); hiring sales before founder-led sales works (outsources the learning); building self-serve onboarding before manual onboarding has been done 20 times (automates guesses); press/launch-day plans (optimizes appearance over survival).
5. Define the honest metrics for the rung: conversations started, calls held, offers made, paid conversions, churn of first cohort, and — critically — full-price payment. **Flag friend-pricing and forgiveness-discounts: forgiving first customers mask a bad product.** First 10 must include strangers paying real money.
6. Set the graduation test for the current rung with numbers and a date, and the kill/pivot condition if the numbers don't come (e.g., 50 qualified outreaches → <2 paying = message or market problem, return to discovery).

## Output format
A **Ladder Plan**: (1) current rung declaration with evidence; (2) prospect table (Rung 0) or manual-delivery playbook (Rung 1) — concrete, named, dated; (3) blocked-actions list with one-line reasons; (4) metrics table `metric | current | graduation threshold | kill threshold | review date`; (5) single next action for tomorrow morning.

## Quality gate
FAIL if: the plan contains any paid channel, hire, or automation below the rung that justifies it; the prospect list has fewer than 30 named entries at Rung 0; metrics include impressions, signups, or waitlist size as success measures; or no kill threshold is set. PASS only when every planned action is executable by the founder personally this week.

## Integration
Consumes momtest-auditor's JTBD and BEHAVIOR evidence as the targeting input. Graduation tests run under **verified-done**: a rung is complete only when the metric threshold is evidenced from payment records, not founder recall. Apply **statistical-analysis** to conversion counts before declaring a channel works (n=3 sales is an anecdote, not a funnel). Feed real revenue numbers into `bottoms-up-market-sizer` to replace assumed conversion rates, and into `term-sheet-analyzer` pitch-prep as the proof section — traction earned here is the only non-narrative slide in the deck.
