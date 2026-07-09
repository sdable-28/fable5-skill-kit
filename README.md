# fable5-skill-kit

A collection of discipline skills for Claude — built by Fable 5, usable by any model.

26 universal skills + 81 domain skills across 17 domains. One master router (`/fable`) covers all of them in a single upload.

---

## What is this

Every skill in this kit is a set of operating instructions: principles, verification gates, and procedures for a specific type of work. They don't change what Claude can do — they change how rigorously it does it.

- **Universal skills** apply to any domain: adversarial disproof, evidence reasoning, plan gating, code investigation, root cause analysis, and more.
- **Domain skills** apply the right discipline for specific work: backtest rigor for trading, threat modeling for security, mom-test compliance for startups, and so on across 17 domains.
- **`/fable`** is the master router: detects your domain from context, activates the right principles and gates, lists which skills to use. One file, all 17 domains.
- **`/fable-mode`** activates maximum investigation rigor: evidence anchoring, hypothesis-before-read, adversarial self-check, coverage accounting. Use on hard tasks.

---

## Install

### Option A — Claude Code (all skills, one step)

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/YOUR_USERNAME/fable5-skill-kit/main/install.ps1 | iex
```

Or download and run locally:
```powershell
.\install.ps1
```

**Mac / Linux (bash):**
```bash
curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/fable5-skill-kit/main/install.sh | bash
```

After install, restart Claude Code. Use any skill with `/skill-name` in conversation.

### Option B — claude.ai web (individual upload)

1. Go to `claude.ai` → Settings → Customize → Skills → Add
2. Upload any `.md` file from the `skills/` folder
3. Invoke in conversation with `/skill-name`

**Recommended starting point:** upload `skills/fable/SKILL.md` — the master router covers all 17 domains in one file. Then add specific domain or universal skills as needed.

---

## Skill Index

### Start here

| Skill | What it does |
|-------|-------------|
| `/fable` | Master router: detects domain from context, activates principles + gates + skill list |
| `/fable-mode` | Maximum investigation rigor: evidence anchoring, hypothesis loops, adversarial self-check |
| `/plan-gate` | Gates any implementation: GOAL → CURRENT STATE → STEPS → RISKS → STOP for approval |

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
| **security-engineering** | See universal `/security-threat-modeling` + domain pack for specialized skills |
| **healthcare-life-sciences** | Domain pack available; dedicated skills coming in v1.1 |

---

## Usage patterns

**Session start, any domain:**
```
/fable
```
Detects the domain from what you're working on. Outputs principles + critical gates + skills to use. Work proceeds under that discipline.

**Hard investigation, maximum rigor:**
```
/fable
/fable-mode
```
Domain routing + behavioral discipline. Use this when mistakes are costly.

**Gate an implementation before writing code:**
```
/plan-gate
```
Produces GOAL → CURRENT STATE → STEPS → OUT OF SCOPE → RISKS → ASSUMPTIONS. Stops for your approval before any file is written.

**Specific domain skills:**
```
/backtest-discipline     # trading: data integrity + fill model gates
/momtest-auditor         # founders: validation quote compliance
/leakage-detector        # ML: feature timestamp audit
```

---

## Repository structure

```
fable-kit/
├── skills/                     # 26 universal + router skills
│   ├── fable/SKILL.md          # Master router (start here)
│   ├── fable-mode/SKILL.md     # Behavioral rigor layer
│   ├── plan-gate/SKILL.md      # Implementation gating
│   └── ...
├── domains/                    # 17 domain packs
│   ├── software-engineering/
│   │   ├── domain_pack.md
│   │   ├── verification_gates.md
│   │   ├── skills_index.md
│   │   └── skills/
│   └── ...
├── core/                       # Framework files
│   ├── system_prompt_opus.md
│   └── ...
├── install.ps1                 # Windows install
└── install.sh                  # Mac/Linux install
```

---

## Versioning

| Version | Contents |
|---------|----------|
| v1.0 | 26 universal skills, 81 domain skills, 15 domain packs with full verification gates |
| v1.1 (planned) | Healthcare & Life Sciences full skills (currently domain pack only) |
| v1.2 (planned) | Offensive Security / Penetration Testing (dedicated Fable session, ships last) |

---

## Notes

- Skills are opt-in — they only activate when invoked. They do not override any model's system prompt or default behavior.
- Works with any Claude model: Haiku, Sonnet, Opus, Fable. The skills were written by Fable 5 for maximum rigor but are readable and useful at any tier.
- Healthcare skills and offensive security skills are intentionally deferred — they require a dedicated Fable session to meet the evidence and safety standards those domains demand.
