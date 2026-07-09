---
name: deliverability-collapse-triage
description: >
  Triage and recover a collapsing email program — inbox placement, sender reputation, and list
  hygiene — before anyone writes another sequence. Trigger phrases: "open rates fell off a
  cliff", "emails going to spam", "domain reputation", "Google/Yahoo bulk-sender rules",
  "blacklisted", "bounce rate spiked", "cold outreach stopped getting replies". Invoke whenever
  reply/open metrics drop >30% program-wide within weeks, or before scaling send volume >2x.
  Do NOT use for copy-level performance of individual emails (use copy-testing-loop), for
  transactional email latency/infra bugs, or for CRM sync issues with no deliverability signal.
---

# When invoked

1. Separate measurement artifact from real collapse first: check whether the drop coincides with Apple MPP changes, a new ESP, tracking-domain change, or seed-list change. An open-rate drop with stable reply/click rates is a measurement story, not a deliverability story — verify before triaging.
2. Pull the authentication triad and fail fast: SPF, DKIM, DMARC on every sending domain and subdomain actually in use (check the ESP's actual DKIM selector, not the DNS you think is live). One misaligned domain after a DMARC p=quarantine rollout explains most sudden collapses.
3. Check reputation surfaces in order: Google Postmaster Tools (domain + IP reputation, spam-rate graph against the 0.3% bulk-sender threshold), Microsoft SNDS if volume warrants, and the major blocklists (Spamhaus, SORBS) for both IP and domain.
4. Audit list-quality mechanics: hard-bounce rate trend (>2% = list decay or purchased data), spam-complaint rate per campaign, sunset policy existence (are 180-day non-engagers still being mailed?), and whether cold outbound and opted-in marketing share a domain — sharing is a standing violation; mandate separate domains with the marketing domain quarantined from cold sends.
5. Reconstruct the timeline: overlay send volume, segment changes, new sequences, and domain/IP changes against the placement drop date. Name the most probable trigger event; if volume jumped >2x without warm-up, that is the presumptive cause.
6. Prescribe the recovery ramp: cut sends to the most-engaged decile, hold until Postmaster reputation exits Low/Bad, then re-expand ~20% per week gated on spam-rate <0.1%. Give the explicit week-by-week schedule with its gate metric. State recovery duration honestly (weeks, not days).

# Output format

A **Deliverability Triage Report**: (a) artifact-vs-real verdict with the evidence from step 1; (b) auth triad status per sending domain (pass/fail per mechanism, with the failing record quoted); (c) reputation readout per surface with the spam-rate number; (d) list-hygiene findings with bounce/complaint rates; (e) named probable trigger event with timeline evidence; (f) week-by-week recovery ramp with gate metrics per step.

# Quality gate

PASS only if step 1's verdict is explicit, auth was checked against live DNS for every domain in use (not assumed from ESP settings pages), and the recovery ramp has numeric gates. FAIL if the report recommends "improve content quality" as the primary fix, or if any domain in the send path was left unchecked.

# Integration

- **root-cause-first**: step 5's timeline reconstruction is the root-cause discipline — never start the recovery ramp before naming the trigger.
- **adversarial-disproof**: actively try to prove the collapse is a measurement artifact (step 1) before accepting the expensive real-collapse diagnosis.
- **evidence-reasoning**: every pass/fail cites the actual DNS record, Postmaster graph, or blocklist lookup — no status claimed from memory.
- **copy-testing-loop**: freeze all copy tests during recovery — test results on a damaged domain are uninterpretable; resume only after the quality gate passes.
- **lead-definition-reconciler**: complaint-heavy segments feed back as disqualifiers — audiences that mark you spam were never qualified.
