---
name: growth-model-selector
description: >
  Select and justify the primary growth motion — PLG, sales-led, community-led, marketing-led, or
  partnership-led — from ACV, buyer type, and category dynamics. Trigger phrases: "should we do PLG",
  "do we need a sales team", "freemium or demo", "how should we go to market", "which growth motion",
  "should we hire SDRs", "self-serve vs enterprise". Also invoke when a team is running a motion that
  contradicts its unit economics (e.g., SDRs selling a $500/yr product). Do NOT use when PMF is
  unverified — run pmf-signal-reader first; motion selection pre-PMF is premature optimization.
  Do NOT use for channel-level tactics inside an already-chosen motion — that is growth-loop-mapper's job.
---

# Growth Model Selector

## When invoked
1. Confirm a PMF Verdict Card exists with verdict PMF or PARTIAL-PMF. If not, stop and route to pmf-signal-reader. Motion selection without PMF is choosing an engine for a car with no wheels.
2. Extract the three deciding variables and write them down before evaluating any motion: (a) ACV — actual or realistic target, not aspirational; (b) buyer — end-user self-adopts vs manager approves vs committee/procurement; (c) category — established (buyers search for it) vs new (must be evangelized).
3. Apply the economics fence first, it eliminates motions mathematically: ACV under ~$5k cannot support human-touch sales (fully-loaded AE cost divided by realistic quota fails); ACV over ~$100k with procurement and security review cannot close self-serve. Kill the eliminated motions explicitly with the arithmetic shown.
4. Score surviving motions against fit criteria: PLG requires time-to-value under one session and a user who can experience value without permission; SLG requires multi-stakeholder value and ACV to fund the SDR/AE split; community-led requires practitioners who gain status by participating; marketing-led requires searchable demand or content-compoundable expertise; partnership-led requires an existing channel whose incentive aligns (they must make money moving you).
5. Name the primary motion and at most one secondary. Reject "all of the above" — a Series A company running three motions runs zero well. Sequence the secondary with an explicit trigger condition ("add outbound SLG layer when self-serve accounts show 3+ seats organically").
6. Stress-test against the failure inventory: PLG chosen but time-to-value is 2 weeks → activation will crater; SLG chosen on a single-player product → champions can't sell internally; marketing-led in a zero-search new category → SEO moat has no traffic to moat.
7. Define the motion's own success metric and a 90-day falsification threshold (e.g., PLG: activation rate and free→paid conversion floor; SLG: qualified-opp-per-SDR-month floor).

## Output format
Produce a **Motion Decision Record**:
- `inputs`: ACV, buyer type, category maturity, time-to-value, PMF verdict cited
- `eliminated`: motion → one-line arithmetic or structural reason each was killed
- `primary-motion` + `secondary-motion` (with sequencing trigger, or "none")
- `mechanics`: the 3-5 concrete first components to build (e.g., for PLG: activation milestone definition, onboarding path, upgrade trigger)
- `falsification`: metric, threshold, date — what reading in 90 days means the motion choice was wrong
- `stage-note`: what changes about this motion at the next revenue stage

## Quality gate
PASS only if: (a) at least two motions were explicitly eliminated with arithmetic or structural evidence; (b) exactly one primary motion is named; (c) the falsification block has a number and a date. FAIL if the record recommends a motion the economics fence killed, or hedges with "hybrid approach" absent a sequencing trigger.

## Quality gate note
If the team is ALREADY running a motion, evaluate it as a candidate like any other — do not grandfather it. Sunk SDR hires are not evidence.

## Integration
- **plan-gate**: the Motion Decision Record is the gate artifact before any GTM hiring or spend plan proceeds.
- **root-cause-first**: when invoked because growth stalled, first check whether the stall is motion-mismatch vs execution — do not re-select the motion to escape an execution problem.
- **pmf-signal-reader**: upstream dependency; consumes its `strongest-segment` as the ICP for motion scoring.
- **stage-playbook-enforcer**: downstream check that the chosen motion's mechanics match the current revenue stage.
- **nrr-health-checker**: PLG and SLG choices set which expansion machinery NRR decomposition should expect (self-serve expansion vs account-managed upsell).
