---
name: stage-playbook-enforcer
description: >
  Detect and block stage-mismatched growth tactics — the #1 startup growth failure is running a
  playbook from the wrong ARR stage. Trigger phrases: "what should we focus on now", "is this the
  right time to", "we're copying what [bigger company] does", "should we build a growth team",
  "hire a VP of X", "our advisor from [Series C co] says". Invoke on ANY proposed growth initiative,
  hire, or metric target to classify the company's actual stage and test the proposal against it.
  Do NOT use for evaluating whether a motion type fits the product (growth-model-selector) or whether
  PMF exists (pmf-signal-reader) — this skill assumes those and checks stage-appropriateness only.
---

# Stage Playbook Enforcer

## When invoked
1. Classify the actual stage from evidence, not the fundraise label: 0→$1M ARR = founder-led everything, searching for repeatability; $1M→$10M = building the first repeatable engine, one motion, one ICP; $10M→$100M = multi-channel, second product/segment, systems and management layer. A company that raised a Series B on a pre-repeatable engine is STAGE-2 regardless of the round name — classify by what is repeatable, state the evidence.
2. Take the proposed tactic/hire/target and identify its native stage: which stage's playbook does this come from? (VP of Growth + experimentation team = stage 3; SDR pod of 6 = late stage 2; founder doing every demo = stage 1; multi-channel paid diversification = stage 3.)
3. Compare. If native stage > actual stage, name the specific mismatch failure: scaling before repeatability = burning CAC to learn nothing; hiring a VP to find PMF = delegating the one job founders can't delegate; Series B pipeline-coverage rituals on a Series A product = process theater over iteration speed. If native stage < actual stage, flag the inverse (founder still closing every deal at $8M ARR = bottleneck).
4. Check the metric vocabulary matches the stage: pre-PMF teams tracking Rule of 40 or magic number are measuring noise; stage-2 teams should live in MRR growth, NRR, CAC payback; stage-3 adds Rule of 40, NDR >120%, payback <18mo, pipeline coverage. Strike stage-inappropriate metrics from any proposed dashboard and say why.
5. Interrogate borrowed playbooks: when the proposal cites what a successful larger company does, ask what stage that company was at when the tactic actually worked for them — most public knowledge describes stage-3 companies and is toxic at stage 1-2. Also separate market timing from execution quality: a tactic that worked in a bull-market land-grab is not evidence for it in the current market.
6. If mismatched, do not merely reject — translate: state the stage-appropriate version of the same intent ("instead of a 6-SDR pod, founder + 1 SDR until 3 consecutive months of repeatable close rate from a written playbook").
7. Define the graduation trigger: the measurable condition under which the originally proposed tactic BECOMES appropriate, so the rejection has an expiry.

## Output format
Produce a **Stage Fit Ruling**:
- `actual-stage`: 1 / 2 / 3 with the two strongest pieces of classifying evidence
- `proposal-native-stage`: which stage the proposed tactic belongs to, with reasoning
- `ruling`: FIT / PREMATURE / OVERDUE
- `failure-mode`: if PREMATURE or OVERDUE, the named failure pattern and its mechanism in one sentence
- `translation`: the stage-appropriate version of the proposal's intent
- `graduation-trigger`: metric + threshold at which the original proposal unlocks
- `metric-hygiene`: any stage-inappropriate metrics to strike from dashboards

## Quality gate
PASS only if: (a) actual-stage classification cites repeatability evidence, not round name or headcount; (b) every PREMATURE/OVERDUE ruling includes both a translation and a graduation-trigger — a rejection without an unlock condition is incomplete; (c) borrowed-playbook proposals were checked against the source company's stage-at-time. FAIL if the ruling defers to seniority ("the advisor said") or to the fundraise label anywhere.

## Integration
- **plan-gate**: this ruling is a mandatory gate on any growth plan, hire req, or OKR set before execution begins; PREMATURE = plan blocked pending translation.
- **evidence-reasoning**: stage classification is an evidence chain (what is repeatable, shown by what data), never an assertion.
- **root-cause-first**: when growth stalls, run this before tactical fixes — stage mismatch is a root cause that makes every downstream optimization futile.
- **pmf-signal-reader**: its scaling-license DENIED verdict hard-caps actual-stage at 1 regardless of revenue.
- **growth-model-selector** and **growth-loop-mapper**: their outputs are proposals too — pass their recommended mechanics through this ruling before shipping the plan.
