# fable5-skill-kit

Discipline skills for Claude — built by Fable 5, usable by any model.

26 universal skills + 81 domain skills across 17 domains. The master skill `/fable` auto-detects your domain and activates the right discipline — invoke it once at session start and it handles the rest.

---

## What is this

Every skill is a set of operating instructions: principles, verification gates, and procedures for a specific type of work. They don't change what Claude can do — they change how rigorously it does it.

- **Universal skills** apply to any domain: adversarial disproof, evidence reasoning, plan gating, code investigation, root cause analysis, and more.
- **Domain skills** apply the right discipline for specific work: backtest rigor for trading, threat modeling for security, mom-test compliance for startups, and so on across 17 domains.
- **`/fable`** is the master router: reads your context, detects the domain, activates the right principles and gates, and lists which skills to use next.
- **`/fable-mode`** adds maximum investigation rigor on top: evidence anchoring, hypothesis-before-read, adversarial self-check, coverage accounting.

---

## Install

### Claude Code

```
pip install fable5-skill-kit && fable5-skill-kit
```

Copies all skills into `~/.claude/skills/`. Restart Claude Code, then use any skill with `/skill-name` in conversation.

### claude.ai web

Skills are added one file at a time via Settings → Customize → Skills → Add.

**To get all 17 domains in one step:** upload `skills/fable/SKILL.md`. The master router is self-contained — it embeds the principles and gates for every domain and routes automatically. You do not need to upload individual domain skills unless you want them available as standalone commands.

To add a specific skill: upload its `SKILL.md` from `skills/` or `domains/<name>/skills/<skill-name>/`.

---

## Skill Index

### Start here

| Skill | What it does |
|-------|-------------|
| `/fable` | Detects domain from context, activates principles + gates + skill list for that domain |
| `/fable-mode` | Maximum investigation rigor: evidence anchoring, hypothesis loops, adversarial self-check |
| `/plan-gate` | Gates any implementation: GOAL → CURRENT STATE → STEPS → RISKS → stop for approval |

### Universal skills

| Skill | What it does |
|-------|-------------|
| `/adversarial-disproof` | Three-level disproof of any finding before shipping |
| `/evidence-reasoning` | Source hierarchy enforcement — cite primary, flag inference |
| `/code-investigation` | Cartography-first codebase investigation |
| `/root-cause-first` | Class-level root cause, not instance-level patches |
| `/assumption-flagging` | Surface hidden assumptions before they become bugs |
| `/scope-fence` | Explicit in/out-of-scope declaration before any task |
| `/uncertainty-handling` | Calibrated uncertainty — confident where earned, explicit where not |
| `/coverage-accounting` | Audit what was checked vs skipped |
| `/security-threat-modeling` | STRIDE threat enumeration + residual risk register |
| `/hypothesis-led` | Answer-first reasoning: form a hypothesis, then verify |
| `/iterative-refinement` | Named failure modes per iteration, not generic "improve" |

### Domain skills

| Domain | Skills |
|--------|--------|
| **software-engineering** | `/debug-isolator` `/refactor-gate` `/api-contract-verifier` + 2 more |
| **trading-finance** | `/backtest-discipline` `/execution-analysis` `/risk-first-sizing` `/regime-awareness` `/trade-journaling` |
| **architecture-systems** | `/adr-writer` `/capacity-planner` `/failure-mode-mapper` `/observability-designer` `/migration-strategist` |
| **marketing-sales** | `/icp-sharpener` `/channel-attribution-auditor` `/copy-testing-loop` |
| **legal-compliance** | `/jurisdiction-first` `/contract-risk-scan` `/compliance-gap-mapper` |
| **creative-media** | `/brief-sharpener` `/consistency-enforcer` `/iterative-image-refiner` |
| **data-science-ml** | `/leakage-detector` `/eval-metric-alignment` `/drift-monitor-designer` |
| **devops-infrastructure** | `/blast-radius-estimator` `/runbook-writer` `/cost-anomaly-scanner` |
| **product-management** | `/hypothesis-prioritizer` `/north-star-aligner` `/stakeholder-no-framer` |
| **research-academic** | `/source-hierarchy-enforcer` `/harking-detector` `/so-what-extractor` |
| **operations-supply-chain** | `/bullwhip-detector` `/process-reality-checker` `/sop-writer` |
| **business-strategy** | `/mece-decomposer` `/so-what-enforcer` `/scenario-planner` |
| **personal-productivity** | `/context-switch-minimizer` `/decision-journal-writer` `/weekly-review-runner` |
| **founder-entrepreneur** | `/momtest-auditor` `/term-sheet-analyzer` `/cofounder-agreement-checklist` + 3 more |
| **startup-growth** | `/pmf-signal-reader` `/growth-model-selector` `/nrr-health-checker` |
| **security-engineering** | `/threat-modeler` `/secure-code-reviewer` `/vulnerability-triager` `/dependency-auditor` `/incident-responder` |
| **healthcare-life-sciences** | Domain pack + verification gates included; dedicated skills coming soon |

---

## Usage patterns

**Session start, any domain:**
```
/fable
```
Reads the conversation, detects the domain, outputs the relevant principles and gates. Work proceeds under that discipline.

**Hard investigation, maximum rigor:**
```
/fable
/fable-mode
```
Domain routing + behavioral discipline. Use when mistakes are costly.

**Gate an implementation before writing code:**
```
/plan-gate
```
Produces GOAL → CURRENT STATE → STEPS → OUT OF SCOPE → RISKS → ASSUMPTIONS. Stops for approval before any file is written.

---

## Repository structure

```
fable5-skill-kit/
├── skills/                     # 26 universal + router skills
│   ├── fable/SKILL.md          # Master router — start here
│   ├── fable-mode/SKILL.md     # Behavioral rigor layer
│   ├── plan-gate/SKILL.md      # Implementation gating
│   └── ...
├── domains/                    # 17 domain packs
│   ├── software-engineering/
│   │   ├── domain_pack.md
│   │   ├── verification_gates.md
│   │   └── skills/
│   └── ...
├── core/                       # Framework files
├── install.ps1                 # Windows install
└── install.sh                  # Mac/Linux install
```

---

## Notes

- Skills are opt-in — they only activate when invoked. No effect on default model behavior.
- Works with any Claude model: Haiku, Sonnet, Opus, Fable.
- Healthcare dedicated skills are pending a follow-up session to meet the evidence standards that domain requires.
