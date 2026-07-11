# fable5-skill-kit

**Make Claude check its work.** Language models are capable of far more rigor than they apply by default. Left alone, Claude will pattern-match to a plausible answer, skip the verification step, and present a guess with the same confidence as a checked fact — the bug "should be fixed," the backtest "looks good," the clause "seems fine." fable5-skill-kit closes that gap. It's a library of *discipline skills* — compact operating procedures that make Claude slow down at exactly the moments that matter: reproduce the failure before fixing it, name the fill model before trusting a backtest, cite the primary source before stating a legal rule, prove the attacker path before calling something a vulnerability. The result is output you can rely on — fewer confident-but-wrong answers, fewer skipped steps, fewer things quietly missed.

Built by **Fable 5**. Works with any Claude model — Haiku, Sonnet, Opus, Fable.

**109 skills total:** 2 router skills + 26 universal skills + 81 domain skills across 17 domains. The master skill `/fable` auto-detects your domain and activates the right discipline, so you invoke *one* skill at session start and it handles the routing.

---

## What is this

Every skill is a `SKILL.md` file — a set of operating instructions written for the model: core principles, pass/fail verification gates, and step-by-step procedures for a specific type of work. Skills don't add new capabilities. They change *how rigorously* Claude uses the capabilities it already has.

There are three layers:

- **Router skills** decide what discipline applies. `/fable` reads your context, identifies the domain (or domains), and activates the right principles and gates. `/fable-mode` layers on maximum investigation rigor for high-stakes work.
- **Universal skills** apply in any domain — adversarial disproof, evidence-anchored reasoning, plan gating, coverage accounting, root-cause analysis.
- **Domain skills** carry the specific discipline for one field — backtest rigor for trading, threat modeling for security, the Mom Test for founders, leakage detection for ML.

---

## Install

### Claude Code

```
npx fable5-skill-kit
```

One command. Downloads the kit and copies all 109 skills into `~/.claude/skills/`. Restart Claude Code, then invoke any skill with `/skill-name` in a conversation.

> Prefer not to use npx? The repo also ships `install.ps1` (Windows) and `install.sh` (Mac/Linux) — clone the repo and run the one for your OS. Both do the same copy.

### claude.ai (web / desktop)

Skills are uploaded one file at a time via **Settings → Customize → Skills → Add**.

**To cover all 17 domains in a single upload:** upload `skills/fable/SKILL.md`. The master router is self-contained — it embeds the condensed principles and verification gates for every domain and routes automatically, so you don't need to upload the individual domain skills.

To add a specific skill on its own, upload its `SKILL.md` from `skills/<name>/` or `domains/<domain>/skills/<skill-name>/`.

---

## How to use it

### The one-move default

At the start of any real task, invoke the router:

```
/fable
```

`/fable` reads what you're working on, names the domain, and outputs the principles in effect, the gates it will hold your work to, and which specific skills to pull in. Everything after that runs under that discipline. For most work this is the only skill you need to invoke by hand.

**What that looks like in practice.** You paste a failing test and ask Claude to fix it:

```
You: /fable
     Here's a stack trace from our payment webhook — it double-charges on retry. Fix it.

Claude: DOMAIN ACTIVATED: software-engineering
        PRINCIPLES IN EFFECT: reproduce before fixing · map callers before editing ·
        idempotency is the default for anything that can retry · verify behavior not intent
        GATES TO RUN: reproduction · regression-proof test · blast radius · behavioral execution
        SKILLS TO USE: /debug-isolator, /root-cause-first

        Before touching code: the double-charge on retry is an idempotency gap, not a
        webhook bug. Reproducing first...
```

Instead of jumping to a plausible patch, Claude reproduces the failure, finds the class-level cause (a non-idempotent retry path), writes a test that fails before the fix and passes after, and checks every caller before it calls the work done.

### Maximum rigor for high-stakes work

When a mistake is expensive — a production migration, a security review, a trading change — use the rigor layer:

```
/fable-mode
```

`/fable-mode` is self-contained: it forces evidence anchoring (every claim cites a source), hypothesis-before-read (state what you expect before opening a file), adversarial self-check (try to *disprove* each finding before shipping it), and coverage accounting (name what you checked *and* what you skipped). It stays in effect for the rest of the conversation.

Want the domain-specific gates *and* the rigor layer? Invoke them in two back-to-back messages — one skill per message is how the interface works:

1. First message: `/fable` (plus your task) — activates the domain's principles and gates.
2. Next message: `/fable-mode` — adds the rigor layer on top for everything that follows.

### Gate an implementation before any code is written

```
/plan-gate
```

Produces GOAL → CURRENT STATE → STEPS → OUT OF SCOPE → RISKS → ASSUMPTIONS and **stops for your approval** before writing a single file. Use it whenever "just start coding" would be a mistake.

### Reach for a specific skill directly

You can always invoke a domain or universal skill without the router when you already know what you need:

```
/backtest-discipline    # trading: forces a stated fill model, out-of-sample split, slippage survival
/momtest-auditor        # founders: rejects "they said they'd buy" as validation evidence
/leakage-detector       # ML: audits every feature for a timestamp available at prediction time
/adversarial-disproof   # any domain: three-lens disproof of a conclusion before you act on it
```

---

## Skill Index

### Router & gating

| Skill | What it does |
|-------|-------------|
| `/fable` | Detects the domain from context; activates its principles, gates, and skill list |
| `/fable-mode` | Behavioral rigor layer: evidence anchoring, hypothesis-before-read, adversarial self-check, coverage accounting |
| `/plan-gate` | Gates any implementation: GOAL → CURRENT STATE → STEPS → OUT OF SCOPE → RISKS → ASSUMPTIONS, then stops for approval |

### Universal skills (any domain)

| Skill | What it does |
|-------|-------------|
| `/adversarial-disproof` | Three-lens disproof (correctness, completeness, impact) of a conclusion before acting on it |
| `/evidence-reasoning` | Every claim carries {source, location, quote}; unevidenced assertions are flagged |
| `/assumption-flagging` | Surfaces hidden assumptions with risk level; resolves the high-risk ones before proceeding |
| `/scope-fence` | Explicit in-scope / out-of-scope declaration before starting |
| `/coverage-accounting` | Tracks what was checked vs skipped; nothing is silently skipped |
| `/uncertainty-handling` | Calibrated confidence — certain where earned, explicit where not |
| `/cartography-first` | Maps unfamiliar territory (codebase, docs) with shallow reads before any deep dive |
| `/hypothesis-before-read` | State what you expect to find before each read; compare after |
| `/code-investigation` | Full 5-phase protocol for audits, gap analysis, architecture review |
| `/root-cause-first` | Fixes the class and its cause, not the single visible instance |
| `/self-correction-loop` | Iterate on named failure modes, not vague "make it better" |
| `/verified-done` | Verify behavior in a running context before claiming a task complete |
| `/enterprise-architect` | System-level architecture decisions, trade-offs, ADRs, migration paths |
| `/system-design` | Greenfield component design with capacity and failure modes |
| `/security-threat-modeling` | STRIDE enumeration + residual-risk register |
| `/statistical-analysis` | Statistical rigor — tests, power, honest interpretation |
| `/mathematical-reasoning` | Step-verified mathematical work |
| `/multimodal-analysis` | Disciplined analysis of images, video, and mixed media |
| `/document-mastery` | Audience-and-purpose-first writing for reports, specs, memos |
| `/idea-generation` | Structured divergent ideation before converging |
| `/image-refinement` | Iterative image refinement against named defects |
| `/video-editing` | Disciplined video edit planning and review |
| `/long-task-orchestration` | Structure and sequence long multi-phase work |
| `/multi-agent-orchestration` | Coordinate multiple agents on independent sub-tasks |
| `/context-budget-management` | Manage finite context on long-running tasks |
| `/plan-gate` | (see Router & gating above) |

### Domain skills

Each domain ships 5 skills (founder-entrepreneur has 6). Every domain also includes a `domain_pack.md` (principles + walkthrough) and `verification_gates.md` (pass/fail gates) that `/fable` draws on.

| Domain | Skills |
|--------|--------|
| **software-engineering** | `/debug-isolator` `/refactor-gate` `/api-contract-verifier` `/migration-safety` `/race-condition-prober` |
| **trading-finance** | `/backtest-discipline` `/execution-analysis` `/risk-first-sizing` `/regime-awareness` `/trade-journaling` |
| **architecture-systems** | `/adr-writer` `/capacity-planner` `/failure-mode-mapper` `/observability-designer` `/migration-strategist` |
| **data-science-ml** | `/leakage-detector` `/baseline-first-gate` `/eval-metric-alignment` `/drift-monitor-designer` `/llm-approach-decider` |
| **devops-infrastructure** | `/blast-radius-estimator` `/runbook-writer` `/cost-anomaly-scanner` `/drift-reconciler` `/restore-drill-verifier` |
| **security-engineering** | `/threat-modeler` `/secure-code-reviewer` `/vulnerability-triager` `/dependency-auditor` `/incident-responder` |
| **product-management** | `/hypothesis-prioritizer` `/north-star-aligner` `/stakeholder-no-framer` `/discovery-interview-auditor` `/market-sizing-builder` |
| **founder-entrepreneur** | `/momtest-auditor` `/term-sheet-analyzer` `/cofounder-agreement-checklist` `/bottoms-up-market-sizer` `/cap-table-day-one` `/manual-traction-ladder` |
| **startup-growth** | `/pmf-signal-reader` `/growth-model-selector` `/nrr-health-checker` `/growth-loop-mapper` `/stage-playbook-enforcer` |
| **marketing-sales** | `/icp-sharpener` `/channel-attribution-auditor` `/copy-testing-loop` `/lead-definition-reconciler` `/deliverability-collapse-triage` |
| **business-strategy** | `/mece-decomposer` `/so-what-enforcer` `/framework-fit-gate` `/problem-statement-lock` `/scenario-stress-planner` |
| **legal-compliance** | `/jurisdiction-first` `/contract-risk-scan` `/compliance-gap-mapper` `/authority-hierarchy-check` `/privacy-reach-triage` |
| **research-academic** | `/source-hierarchy-enforcer` `/harking-detector` `/so-what-extractor` `/claims-boundary-auditor` `/synthesis-matrix-builder` |
| **creative-media** | `/brief-sharpener` `/consistency-enforcer` `/iterative-image-refiner` `/repurposing-cascade` `/scene-continuity-planner` |
| **operations-supply-chain** | `/bullwhip-detector` `/process-reality-checker` `/sop-writer` `/safety-stock-calibrator` `/single-source-exposure-mapper` |
| **personal-productivity** | `/context-switch-minimizer` `/decision-journal-writer` `/weekly-review-runner` `/energy-task-matcher` `/productivity-theater-detector` |
| **healthcare-life-sciences** | Domain pack + verification gates included; dedicated skills coming soon |

---

## Repository structure

```
fable5-skill-kit/
├── skills/                      # 26 universal skills + 2 routers (/fable, /fable-mode)
│   ├── fable/SKILL.md           # Master router — start here
│   ├── fable-mode/SKILL.md      # Behavioral rigor layer
│   ├── plan-gate/SKILL.md       # Implementation gating
│   └── ...
├── domains/                     # 17 domains
│   ├── software-engineering/
│   │   ├── domain_pack.md       # Principles + sample walkthrough
│   │   ├── verification_gates.md # Pass/fail gates
│   │   └── skills/              # The domain's SKILL.md files
│   └── ...
├── core/                        # Framework files shared across domains
├── bin/install.js               # npx entry point
├── install.ps1                  # Windows install (fallback)
├── install.sh                   # Mac/Linux install (fallback)
├── package.json
├── LICENSE                      # MIT
└── README.md
```

---

## Notes

- **Opt-in and safe.** Skills only activate when you invoke them. They do not modify the model's system prompt or change default behavior when unused.
- **Model-agnostic.** Written by Fable 5 for maximum rigor, but readable and useful on any Claude model — Haiku, Sonnet, Opus, Fable.
- **Healthcare.** The healthcare-life-sciences domain currently ships its domain pack and verification gates; dedicated skills are pending a follow-up session to meet the evidence standards that field requires.

## License

MIT — see [LICENSE](LICENSE).
