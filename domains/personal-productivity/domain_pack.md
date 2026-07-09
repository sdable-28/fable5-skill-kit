# Domain Pack: Personal Productivity & Executive Function

Operating instructions for work in individual effectiveness, focus systems, decision-making frameworks, and cognitive load management. Read fully before advising on, building, or auditing any productivity system.

---

## 1. Domain Overview

### What makes this domain unique for AI

This domain has no compiler, no test suite, and no production incident to tell you the work failed. The failure mode is silent: a beautifully organized system that produces no output, a decision framework that is never consulted at decision time, a calendar full of blocks nobody honors. Every artifact in this domain is a *proxy* for the real deliverable — important work completed — and proxies drift. Treat every system, list, and framework as a hypothesis about behavior that must be validated against actual throughput, not against how good it looks.

Second uniqueness: the "user" is also the execution environment. In software, the code runs the same regardless of the author's mood. Here, the system runs on a human whose energy, willpower, and attention vary by hour and degrade under load. A system that assumes constant executive function will fail exactly when it is needed most — during overload. Design for the depleted version of the person, not the motivated version who set the system up.

Third: measurement changes the system. Ask someone to track their time and they work differently for a week, then stop tracking. Any protocol requiring sustained self-report will decay. Prefer designs where the artifact is produced as a byproduct of the work (a decision journal entry written at decision time, a done-list generated from completed task records) over designs requiring separate logging effort.

### Where AI adds most value

- **Externalization at capture speed.** Converting a rambling brain-dump into clarified next actions, projects, and waiting-fors faster and more completely than the human would. This is the single highest-leverage AI intervention: it removes the clarify-step friction that kills most GTD implementations.
- **Ruthless triage without ego.** AI has no sunk-cost attachment to the user's task list. It can say "17 of these 40 items have been on the list for 60+ days; they are not tasks, they are guilt" — a statement humans avoid making to themselves.
- **Decision hygiene enforcement.** Prompting for base rates, running pre-mortems, checking reversibility, and comparing predicted vs. actual outcomes in a decision journal. Humans skip these steps under time pressure; AI doesn't.
- **Pattern detection across time.** Spotting that every "urgent" Friday task traces to a Monday meeting with no written outcome; that deep-work blocks scheduled after 3pm get cancelled 80% of the time; that decisions made after 6pm score worse on the journal.
- **Cost accounting on attention.** Computing the real cost of a recurring meeting (attendees × duration × frequency × loaded rate), the context-switch tax of a fragmented calendar, the reply-latency distribution of an inbox.

### Where AI must defer to human expertise

- **Values and priority order.** AI can surface that two goals conflict; it must not resolve which one matters more. "Family dinner vs. shipping Friday" is not an optimization problem.
- **Energy self-report.** The human's felt sense of "I'm fried" overrides any schedule. Never argue someone into a deep-work block their body has vetoed. Adjust the system; do not litigate the human.
- **Irreversible personal decisions.** Quit the job, end the partnership, move cities: AI structures the analysis (reversibility check, pre-mortem, base rates), the human decides. Never output a recommendation phrased as the answer for one-way-door personal decisions.
- **Commitments to other people.** AI may draft the renegotiation of a commitment; the human sends it. Do not silently drop or deprioritize items involving promises to others.
- **What must stay in human hands permanently:** final priority calls, relationship communication with emotional stakes, anything where the human's own judgment is the skill being trained (a person who offloads all decisions to AI loses decision fitness — flag this explicitly when detected).

---

## 2. Core Principles

Each principle is falsifiable — a practitioner can check compliance in under a minute.

1. **Capture is complete or it is worthless.** Every commitment lives in exactly one trusted system. Compliance check: ask "is anything you've promised anyone held only in your head or in an unprocessed inbox older than 48 hours?" If yes, the system is failing at capture, and no downstream sophistication matters. Fix capture before touching anything else.

2. **A next action names a physical, visible behavior.** "Plan offsite" is a project, not an action. "Email Priya three candidate dates for offsite" is an action. Compliance check: pick 5 random items from the next-action list; each must be executable without further thinking about *what to do*. Any item that fails is unclarified inventory, not a task.

3. **The Weekly Review is the system's heartbeat; skip two consecutive weeks and declare the system dead, not paused.** A dead system produces false confidence — worse than no system, because the human trusts a stale list. Compliance check: date of last completed Weekly Review. >14 days → treat every list in the system as unreliable until re-reviewed.

4. **Schedule energy, not just time.** Match task type to energy phase: creative/deep work to peak hours, administrative to troughs. Compliance check: the calendar shows deep-work blocks placed in the user's stated peak window on at least 3 of 5 workdays. Deep work scheduled exclusively in energy troughs is a compliance failure regardless of total hours blocked.

5. **MITs before inbox.** 1–3 Most Important Tasks chosen the evening before or at day start, and the first work block goes to MIT #1 — not to email. Compliance check: what was touched first this morning? If the answer is inbox/Slack on 3+ of the last 5 days, the day is being run by other people's priorities.

6. **One decision journal entry per consequential decision, written BEFORE the outcome is known.** Entry contains: decision, date, context, alternatives considered, expected outcome with probability, review date. Compliance check: entries written after outcomes are known are contaminated and must be marked as retrospective, not predictive. A journal with no probability estimates cannot be calibrated and is a diary, not an instrument.

7. **Classify reversibility before analysis depth.** Two-way-door decisions get ≤ the time they deserve (minutes to hours) and a bias to act; one-way-door decisions get pre-mortem + base rates + sleep. Compliance check: for the last 5 decisions, was analysis time proportional to irreversibility? Spending a week on a reversible tool choice is a violation; deciding a hire in an afternoon is one too.

8. **Every recurring meeting has an owner, a written purpose, and an annual cost figure — or it dies at the next audit.** Compliance check: pick any recurring meeting on the calendar; the owner can state its purpose and its cost (attendees × hours × frequency × 52) in one sentence each. "We've always had it" is a fail.

9. **Context switches are budgeted, not free.** Average recovery to full focus after an interruption is ~23 minutes; a day with 10 unplanned switches has no deep work in it regardless of hours "worked." Compliance check: deep-work blocks are ≥90 minutes, single-tasked, with notifications off and communication channels closed. A "deep work block" with Slack open is a shallow block wearing a costume.

10. **The system's success metric is important-work-completed, never inbox state, list tidiness, or tool count.** Compliance check: the weekly review answers "what important work shipped this week?" before it answers "are my lists clean?" If a week's productivity effort went into re-organizing tools rather than output, log it as a theater incident (see Pitfalls).

11. **Externalize by default; memory is for pattern recognition, not storage.** Anything that must survive 24 hours goes into the system at the moment it appears. Compliance check: interruptions during deep work are handled by a ≤10-second capture (one line in the inbox), not by task switching. If the human "handles it real quick," that is a 23-minute purchase.

12. **Notes exist to be re-found and re-used; a note never surfaced again was write-only noise.** Progressive summarization or linking happens on second touch, not at creation. Compliance check: sample 10 notes older than 3 months — how many have been revisited or linked? Near-zero means the note system is a landfill; stop optimizing it and change the retrieval habit instead.

13. **Async first; a meeting is the escalation path, not the default.** A meeting request without a written brief (context → ask → by-when) is returned for a brief. Compliance check: of the last 5 meetings accepted, how many could have been a document + 2 comments? More than 2 → tighten the acceptance filter.

14. **AI offload follows the boundary rule: offload retrieval, formatting, first drafts, and enumeration; retain judgment, priority, relationships, and any skill you are actively training.** Compliance check: for each recurring AI use, ask "if this tool vanished, would I have lost a capability I need?" If the human can no longer write a first draft, size a decision, or recall their own commitments without AI, the boundary has been crossed — pull the task back.

15. **Every intervention gets a two-week falsification window.** New habit, new tool, new schedule: define the observable success signal and the kill criterion before starting. Compliance check: "what would make you abandon this change, and when will you check?" No answer → the change is a hope, not an experiment.

---

## 3. Master Framework — the 7 Stages in this Domain

### Stage 1 — Understand
Establish the real problem before touching the system. The stated problem ("I need a better to-do app") is almost never the real problem (capture leak, energy mismatch, commitment overload, avoidance of one hard task).

Domain tools:
- **Commitment inventory:** enumerate every open commitment across all sources (email, chat, head, meeting notes, task tools). The gap between the inventory and what the person *thinks* they've committed to is the diagnostic.
- **Time forensics:** compare last week's calendar to what actually happened. Cancelled blocks, meeting sprawl, and untracked reactive time reveal the true constraint.
- **Energy map:** ask for the last 5 workdays' subjective energy by 2-hour block. Do not design a schedule before this exists.
- **Single-question probe:** "What important thing have you been avoiding, and what does the avoidance protect you from?" Most productivity requests are avoidance wearing a systems costume. Name it if found; do not build a system around it.

### Stage 2 — Decompose
Break the effectiveness problem into the four independent subsystems, and diagnose each separately: **capture** (does everything enter?), **clarify/organize** (does it become actionable and findable?), **decide** (are priorities and decisions made deliberately?), **execute** (does focused work actually happen?). A failure in one subsystem masquerades as failure in another — an execution problem ("I procrastinate") is often a clarify problem (the task is a vague project with no next action).

Domain tools: GTD's capture→clarify→organize→reflect→engage as the decomposition spine; the reversibility split for decision problems; the deep/shallow split for execution problems.

Rule: fix subsystems in dependency order — capture before clarify, clarify before prioritize, prioritize before schedule. Never install time blocking on top of a leaking capture layer.

### Stage 3 — Plan
Design the minimal intervention. One change per two-week window. The plan names: the single behavior changing, the trigger that initiates it, the observable success signal, the kill criterion, and the review date.

Domain tools:
- **Time-block template:** deep blocks in peak energy, admin batches in troughs, buffer between meetings, hard stop time. The template is a default, violated consciously, never silently.
- **MIT protocol:** selection happens the evening before; ≤3 items; MIT #1 gets the first block.
- **Pre-mortem for the plan itself:** "It is two weeks from now and this change failed — why?" The top two answers get mitigations built in before launch.
- **Friction budget:** every added step of system maintenance costs adherence. If the plan adds >5 minutes/day of overhead, cut it down before proposing.

### Stage 4 — Execute
Execution support means protecting the block, not supervising the human.

Domain tools:
- **Block protocol:** notifications off, communication apps closed, one named deliverable per block, a capture pad for intrusions (≤10-second capture, return to task).
- **Switch log:** when a block breaks, record what broke it in one line. Three occurrences of the same breaker → it becomes a design problem, not a willpower problem.
- **Batching:** email/chat processed in 2–3 fixed windows, triaged with the 4 D's (do <2 min, delegate, defer to system, delete). Outside windows, the inbox does not exist.
- **AI-augmented execution:** offload first drafts, formatting, enumeration, retrieval. Prompts specify output format, length ceiling, and decision-relevant content only — density over volume (see communication pattern in `common_patterns.md`).

### Stage 5 — Verify
Verification in this domain is throughput and calibration, never tidiness.

Domain tools:
- **Output ledger:** at week end, list important work actually completed. This is the primary metric. Compare against the MITs selected — selection-to-completion rate below ~60% means MITs are too big, too many, or not actually most important.
- **Adherence vs. outcome split:** measure both "did the behavior happen?" (blocks held, reviews done, journal written) and "did output improve?" Adherence without outcome for 4+ weeks → the intervention is theater; kill it.
- **Decision journal review:** at each review date, score expected vs. actual. Calibration drift (systematic overconfidence, systematic optimism about timelines) is the finding — feed it back into future estimates.
- **Leak test:** ask "name something you've committed to that isn't in the system." A non-empty answer fails verification regardless of every other metric.

### Stage 6 — Self-Correct
When the system fails, diagnose which subsystem failed and whether the failure was design or circumstance — before changing anything.

Domain rules:
- **Never respond to a failed week by adding system complexity.** The default correct response to failure is *subtraction*: fewer lists, fewer categories, fewer tools, smaller MITs.
- **Distinguish lapse from relapse:** one missed Weekly Review is a lapse (reschedule within 48h); three is a design failure (the review is too long, wrongly timed, or reviewing dead lists — shrink it).
- **Root-cause procrastination behaviorally:** avoided task → check in order: (1) is the next action concrete? (2) is it under 25 minutes or chunked? (3) is there a fear attached (visibility, judgment, irreversibility)? Fix in that order. Do not skip to motivation talk.
- **Re-baseline after life changes.** New job, new child, new manager: the old system's assumptions are void. Rerun Stage 1; do not patch.

### Stage 7 — Iterate
The system is never done; it is re-fit quarterly to the current life shape.

Domain tools:
- **Quarterly system audit:** kill unused lists/tags/tools; re-run the meeting audit; re-run the energy map (it drifts with seasons and life load); prune the someday/maybe list without mercy.
- **Calibration compounding:** the decision journal's accumulated expected-vs-actual record becomes the base-rate library for future decisions ("my 'two-week' projects take a median 5 weeks").
- **Graduation rule:** when a behavior has been automatic for 90 days, remove its scaffolding (reminders, tracking) and spend the freed attention on the next constraint.

---

## 4. Pitfalls Checklist

1. **Productivity theater.**
   - Looks like: three hours on Sunday migrating tasks from Todoist to Notion, color-coding projects, building a dashboard — while the quarterly report due Tuesday remains untouched.
   - Detection signal: system-maintenance time > deep-work time in any week; a new tool adopted within 30 days of the last one; the person can describe their setup in more detail than their output.
   - Prevention: hard cap system maintenance at 30 min/week outside the Weekly Review. Tool changes require a written failure statement about the current tool and a two-week trial with kill criteria. Weekly Review opens with the output ledger, not the lists.

2. **Inbox zero as terminal goal.**
   - Looks like: inbox cleared by 9:40am daily, dopamine collected, MIT untouched until 3pm; email processed 15 times a day to keep the zero.
   - Detection signal: first work action of the day is email on 3+ of 5 days; email checked outside designated windows; pride expressed about inbox state with no corresponding output claim.
   - Prevention: MIT block before first inbox open. Email in 2–3 fixed windows. Reframe metric: replies-that-unblocked-others and decisions-made, never count-in-inbox.

3. **Vague next actions (project-action confusion).**
   - Looks like: "Website redesign," "Taxes," "Mom" sitting on the action list for weeks. Each is a project or a person, not a behavior; each triggers avoidance because the brain must re-plan on every glance.
   - Detection signal: any list item without a verb; any item older than 14 days that gets looked at and skipped repeatedly.
   - Prevention: clarify step enforces verb-first, single-behavior phrasing. Weekly Review flags every stale item with: "what is the actual next physical action, and do you still want the outcome?"

4. **Context-switch hemorrhage.**
   - Looks like: calendar shows 6 hours "free," actual day is 22 Slack threads, 40 inbox visits, 9 unplanned conversations. Nothing over 20 contiguous minutes. Person reports being exhausted and having done nothing.
   - Detection signal: no calendar block ≥90 minutes was actually held this week; the person answers messages during "deep work"; average time-to-respond on chat is under 5 minutes all day (meaning they are always watching).
   - Prevention: minimum viable deep-work block of 90 min, notifications physically off, status set, one escalation channel for true emergencies. Budget switches: >4 unplanned/day sustained → escalate to environment redesign (office hours, response-latency SLA announced to team).

5. **Weekly Review decay.**
   - Looks like: review skipped two weeks running "because busy"; then the lists are stale; then the person stops trusting the lists; then everything moves back into their head and ad-hoc email flagging. System silently dead while still installed.
   - Detection signal: last review date >14 days; the person hesitates when asked "is your project list current?"; commitments discovered in email that appear nowhere in the system.
   - Prevention: review is an immovable calendar block ≤60 minutes (long reviews are the #1 cause of skipping — shrink until it survives contact with a busy week). Two-week miss triggers a declared system-dead recovery: full re-capture before resuming, no pretending the lists are alive.

6. **Energy-blind scheduling.**
   - Looks like: deep work blocked 4–6pm daily because mornings are "for meetings"; every deep block ends in browsing; person concludes they lack discipline.
   - Detection signal: deep-work blocks systematically cancelled or unproductive at a consistent time of day; creative work attempted post-lunch or post-meeting-marathon.
   - Prevention: energy map before schedule design. Peak hours defended for deep work *first*; meetings take what remains. If the org owns the mornings, negotiate two protected mornings rather than pretending 4pm is equivalent.

7. **Decision journal written in hindsight.**
   - Looks like: journal entries composed after the outcome is known, narrating the decision as wiser or more deliberate than it was. Calibration data is now fiction.
   - Detection signal: entry date ≥ outcome date; no probability estimates; entries only exist for decisions that went well.
   - Prevention: entry is written before commitment is executable — make it a gate ("no consequential decision executes without a dated pre-outcome entry"). Retrospective entries are allowed but tagged RETRO and excluded from calibration scoring.

8. **Reversibility misclassification.**
   - Looks like: two weeks of analysis paralysis over a note-taking app (two-way door); same person accepts a job offer after one evening's thought (one-way door). Analysis budget inversely proportional to stakes.
   - Detection signal: decision latency uncorrelated with irreversibility; FOMO language ("what if the other option was better") on trivially reversible choices.
   - Prevention: first question of every decision: "what does it cost to undo this?" Reversible → decide within one sitting, disagree-and-commit with yourself, calendar a 30-day check. Irreversible → mandatory pre-mortem, base rates, one night's sleep, one outside view.

9. **Base-rate neglect in personal planning.**
   - Looks like: "This project will take two weeks" — said about the 7th consecutive project, the previous six of which took five weeks each. Plans built on the inside view every time.
   - Detection signal: no reference to past similar work when estimating; decision journal shows systematic timeline optimism; deadlines set without consulting the calibration record.
   - Prevention: estimation protocol requires one sentence of outside view: "the last N similar things took X." Multiply inside-view estimates by the personal historical ratio until the journal shows the ratio converging to 1.

10. **Note-taking landfill (collector's fallacy).**
    - Looks like: 4,000 notes, 200 highlights a week clipped in, elaborate Zettelkasten folder taxonomy — and when writing an actual document, the person starts from a blank page and Google because retrieval never happens.
    - Detection signal: capture volume high, revisit rate near zero; notes have no links; the note system was reorganized more recently than it was used to produce anything.
    - Prevention: progressive summarization on second touch only (capture raw; summarize only what gets revisited — effort follows demonstrated value). Every writing task begins with a search of one's own notes; if that search fails three times running, fix retrieval (linking, titles-as-claims), stop increasing capture.

11. **Meeting acceptance by default.**
    - Looks like: calendar 70% recurring meetings, half without agendas; person attends a weekly 10-person status meeting where their 2 relevant minutes could be one Slack message; no meeting has been declined in a month.
    - Detection signal: recurring-meeting hours not audited in the last quarter; meetings without written purpose accepted; person cannot name the annual cost of their top-3 recurring meetings.
    - Prevention: quarterly meeting audit — each recurring meeting scored keep/shrink/async/kill with annual cost computed. New recurring invites require a written purpose and a decay date (auto-expires, must be actively renewed).

12. **Busyness-as-progress conflation.**
    - Looks like: 60-hour week, exhausted, calendar solid — but the week's output ledger shows zero movement on the two goals that matter this quarter. Motion mistaken for progress; effort used as the metric because output is scarier to measure.
    - Detection signal: person answers "how's work going?" with hours and busyness, never with completed outcomes; MIT completion rate below 40% while total task completions are high (small-task binging).
    - Prevention: output ledger reviewed weekly against quarterly goals. Explicit small-task-binge rule: no more than 30 min of quick wins before MIT #1 is touched. If a week was genuinely all-reactive, name the fire and decide deliberately whether firefighting is the actual job right now.

13. **AI over-reliance atrophy.**
    - Looks like: every email, every plan, every decision analysis drafted by AI from a one-line prompt; six months later the person cannot produce a structured argument unaided, and their prompts have degraded to "handle this" because their own model of the task has faded.
    - Detection signal: inability to evaluate whether AI output is good (rubber-stamping); prompts getting shorter and vaguer over time; discomfort or paralysis when the tool is unavailable; decisions executed on AI recommendation without the human articulating the reasoning in their own words.
    - Prevention: boundary rule (Principle 14). For judgment tasks, the human writes the conclusion first, then uses AI to stress-test it — never the reverse. Quarterly unaided rep: draft one significant document, one decision analysis without AI, to keep the muscle testable.

14. **Token-waste prompting / low-density AI use.**
    - Looks like: asking AI open-ended questions ("thoughts on my schedule?"), receiving 800 words of hedged generalities, reading all of it, extracting one usable line. The interaction cost more attention than it saved.
    - Detection signal: AI outputs regularly skimmed rather than used; no format/length constraints in prompts; the same clarifying context re-typed in every session instead of maintained in a persistent brief.
    - Prevention: every recurring AI task gets a prompt template specifying role, context source, output format, and hard length ceiling ("table, max 10 rows, decision-relevant deltas only"). Maintain a standing personal context document the AI reads instead of re-eliciting. Measure the interaction in net minutes saved; renegotiate any recurring prompt that nets negative.

15. **System designed for the idealized self.**
    - Looks like: a 5am-workout, 90-minute-review, 12-category system designed on a motivated Sunday, dead by Thursday. The design assumed peak willpower as the constant baseline.
    - Detection signal: adherence collapses specifically on high-load days; the system has no degraded mode; the person describes failure as a character flaw rather than a design flaw.
    - Prevention: design every protocol with an explicit minimum viable version (Weekly Review: 60-min full / 15-min triage; capture: full clarify / raw dump). The system is validated only when it survives the person's worst realistic week, and the two-week trial must include at least one such week.

---

## 5. Sample Task Walkthrough

**Task:** A senior engineering manager (call her R.) asks: "I'm drowning. I have three task apps, 40+ hours of meetings a week, I haven't done focused work in a month, and I just missed a commitment to my VP that I'd completely forgotten about. Fix my system."

**Stage 1 — Understand.** Do not recommend a tool. The missed VP commitment is the loudest signal: this is a *capture* failure first, whatever else is also true. Run the commitment inventory: have R. dump every open commitment — from head, from the three apps, from starred emails, from Slack saved-items, from the last month's meeting notes — into one raw list. Result: 143 items; 31 exist only in her head or in unprocessed email; 12 are duplicated across apps with conflicting states. Run time forensics on last week's calendar: 34 meeting hours actually attended (not 40 — she skipped some, another data point: she is already triaging by silent no-show, which burns trust), zero deep-work blocks held, 4 blocks scheduled and all cancelled. Energy map: peak 8:30–11:30am; that window is 80% occupied by recurring meetings. Ask the avoidance probe. Answer: she has been avoiding a re-org proposal her VP asked for — the missed commitment. It's on no list because looking at it produces dread. Flag it: part of this "system problem" is one avoided high-stakes task.

**Stage 2 — Decompose.** Four subsystems: Capture is broken (31 head-only items, three apps with no single source of truth). Clarify is broken downstream of capture (the 143 items include ~50 project-sized vagaries). Decide is untested — can't evaluate priorities on unreliable lists. Execute is broken by environment (peak hours colonized by meetings), not by discipline — her 4 cancelled blocks were all scheduled 3–5pm, her trough. Dependency order says: fix capture → clarify → then the calendar. The avoided proposal is handled in parallel as a single-task intervention, not held hostage to the system rebuild.

**Stage 3 — Plan.** Minimal intervention set, two-week window: (1) One system: pick one of the three apps (the one on her phone — capture speed beats features), export/abandon the other two today; incomplete migration is acceptable, a single trusted inbox is not negotiable. (2) Process the 143-item dump in two 45-minute clarify sessions using the AI to accelerate: R. talks through items, AI converts each to next-action / project / waiting-for / someday / delete, R. approves each classification — AI drafts, human decides. (3) Calendar: negotiate exactly two protected mornings (Tue/Thu 8:30–11:00) — not five; a plan reclaiming all mornings from a 34-meeting-hour reality fails on contact. (4) The re-org proposal gets Tuesday's first protected block with the next action clarified down to "open doc, write the one-paragraph problem statement" — 25 minutes, concrete, dread-sized-down. (5) Weekly Review: Friday 4pm, 45-minute cap, agenda written. Pre-mortem the plan: "two weeks from now this failed — why?" Top answers: meetings will invade the Tue/Thu blocks (mitigation: decline-with-alternative template drafted in advance, VP informed of the protected blocks framed as proposal-delivery time); the clarify sessions won't happen (mitigation: they're scheduled before anything else, day one and day two). Kill criteria defined: if capture inbox isn't being processed to zero twice a week by day 10, the app choice or the clarify step is wrong — revisit, don't add tools.

**Stage 4 — Execute.** During week one, the switch log shows Tuesday's block broke once: a production incident — legitimate, logged, block rescheduled to Wednesday same hours (protect the *quota*, not the slot). Slack invaded Thursday's block; correction is environmental: Slack quit, status message with escalation path, phone in drawer.

**Stage 5 — Verify.** End of week two, check against pre-defined signals: (a) Leak test — "name a commitment not in the system": R. searches, finds none; two colleagues confirm nothing owed them is missing. Pass. (b) Output ledger: proposal problem-statement plus full outline done (2 of 4 protected blocks held as scheduled, 1 rescheduled and held, 1 lost — 75% quota adherence, above the 60% floor). (c) Capture inbox processed to zero 3 times. Pass. (d) What did NOT improve: total meeting load unchanged — explicitly deferred to the next iteration, stated as such rather than silently dropped.

**What could go wrong and how it's caught:** If R. had spent week one comparing Notion templates instead — theater — the maintenance-time cap and the output-ledger-first review catch it: the Friday review opens with "what shipped?" and an empty ledger with a beautiful new setup is named as a theater incident, not progress. If the clarified list had quietly re-vaguened ("work on proposal" reappearing), the 5-item spot check in the Weekly Review catches verb-less items. If the VP commitment pattern were actually a relationship/expectations problem rather than capture (VP making asks in hallways that R. never agreed to), the leak test would keep failing despite a working system — that contradiction triggers Stage 6 re-diagnosis rather than more system tuning.

**Stage 6/7 — Correct and iterate.** Next two-week window takes the deferred constraint: the meeting audit (34 hours × cost; kill/shrink/async each recurring meeting). One change per window, sequenced by the dependency order established in Stage 2. The decision journal starts with the re-org proposal itself: expected outcome and probability logged before submission, review date set — the system's first calibration data point.

---

## 6. Integration with Core Skills

- **plan-gate** — Most critical pairing. Every system intervention passes the gate: single behavior, trigger, success signal, kill criterion, review date — before any tool is opened. Domain variation: the gate also requires the *minimum viable degraded mode* (Pitfall 15) and the friction budget (<5 min/day overhead).
- **scope-fence** — Guards against the domain's signature failure: a request to "fix my mornings" ballooning into a full life-system rebuild. Fence to one subsystem per two-week window. Domain variation: the fence also runs in reverse — refuse to install downstream fixes (time blocking) on upstream breakage (capture), even when the user asks for the downstream fix by name; say why, fix upstream first.
- **root-cause-first** — Procrastination, missed commitments, and "no time" each have 3–4 distinct root causes with different fixes (vague next action vs. fear vs. energy mismatch vs. genuine overload). Run the behavioral diagnostic chain (Stage 6) before proposing anything. Never treat a clarify failure with a motivation intervention.
- **verified-done** — "Done" in this domain means the output ledger shows the work, the leak test passes, and adherence held for the full trial window — never "the system is set up." A configured system with no throughput evidence is not done.
- **adversarial-disproof** — Powers the pre-mortem (attack the plan before launch) and the decision journal review (attack the narrative: "what evidence would show this decision was wrong?"). Domain variation: also aim it at the productivity system itself quarterly — "argue this entire setup is theater; what output evidence refutes that?"
- **assumption-flagging** — Every schedule assumes an energy map; every estimate assumes a base rate; every delegation assumes a capability. Flag them explicitly in plans ("assumes Tue/Thu mornings stay protected — invalidated if VP overrides"). Personal-planning assumptions decay faster than technical ones; attach review dates.
- **uncertainty-handling** — Decision support runs on explicit probabilities (journal entries carry them), reversibility classification, and expected-value framing for meeting/commitment tradeoffs. Never output a confident recommendation on a one-way-door personal decision; output the structured analysis and hand the judgment back.
- **statistical-analysis** — Small-n personal data: calibration scoring of the decision journal, MIT completion rates, block-adherence trends. Domain variation: resist over-reading two weeks of self-report; demand 4+ weeks before declaring an intervention's effect, and prefer directional findings over precision theater.
- **self-correction-loop** — Maps directly onto Stage 6: lapse-vs-relapse triage, subtraction-first correction, re-baseline on life change. The loop's domain-specific twist: the correction target is usually the *design*, not the human; reframe every "I failed" as a design review.
- **context-budget-management** — Applies twice: to the human's attention (context switches are the budget; the 23-minute tax is the exchange rate) and to AI interactions (persistent personal-context brief instead of re-elicitation; density-constrained prompts per Pitfall 14).
- **long-task-orchestration** — Quarterly goals decompose into weekly MIT streams with review checkpoints; the Weekly Review is the orchestration heartbeat. Use it to keep multi-month personal projects from dissolving into the daily reactive stream.
- **evidence-reasoning** — Base rates over vibes: the person's own historical record (journal, ledger, past project durations) is the primary evidence source, and it outranks their in-the-moment self-assessment, which is systematically optimistic.

Skills largely inapplicable here — code-investigation, cartography-first, security-threat-modeling, image/video skills — are not to be force-fit. If a task genuinely needs them (e.g., auditing a personal automation script), invoke them under their own domains.
