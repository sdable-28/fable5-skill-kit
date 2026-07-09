---
name: productivity-theater-detector
description: >
  Audit recent activity for productivity theater — motion that feels like progress but
  moves no outcome: re-organizing task lists, tool migrations, inbox-zero rituals,
  over-planning, meeting-heavy weeks with no shipped output. Triggers: "I'm busy but
  nothing's getting done", "I keep tweaking my system", "am I actually making progress",
  "I spent all week in meetings", third+ tool/app migration in a quarter.
  Do NOT use when the user is demonstrably shipping and just feels guilty — confirm
  output first — or during a legitimate one-time system setup week.
---

# Productivity Theater Detector

## When invoked

1. Demand the outcome ledger first: for the audit window (default: last 2 weeks), list things **shipped** — sent, published, decided, delivered to another human, or irreversibly advanced. Not "worked on." If the user can't name any, that is the finding; proceed to locate where the time went.
2. Build the activity inventory for the same window and sort every activity into one of three bins:
   - **OUTPUT** — directly produced a shipped item.
   - **ENABLEMENT** — provably required by a specific OUTPUT item (name which one).
   - **THEATER** — organizing, re-planning, tool-shopping, inbox grooming, status meetings, and any ENABLEMENT that cannot name its OUTPUT.
3. Apply the signature tests. Flag as theater when: the same task has been re-prioritized 3+ times without being started; a system/tool change is the 2nd+ this quarter; planning time for a task exceeds 25% of its estimated execution time; inbox-zero was achieved on a day with zero OUTPUT items.
4. For each theater cluster, name the avoided task hiding behind it. Theater is almost always anesthetic for one specific dreaded item — identify it explicitly ("the tool migration started the day the proposal was due").
5. Prescribe exactly one corrective: start the avoided task for 25 minutes before any further system work is permitted. Do not prescribe a new system, template, or app — that would be prescribing more theater.

## Output format

A **Theater Audit** containing: `Shipped (list, may be empty) / Activity Bins (OUTPUT / ENABLEMENT→linked output / THEATER, with hours if known) / Theater Ratio (theater hours ÷ total) / Avoided Task (named) / Single Corrective`.

## Quality gate

PASS only if every ENABLEMENT item names the specific OUTPUT it served, the Avoided Task section names one concrete task (not "hard stuff generally"), and the Corrective contains zero new tools, lists, or templates. FAIL any audit whose corrective is itself organizational work.

## Integration

- **root-cause-first**: step 4 is a root-cause pass — the theater is the symptom, the avoided task is the cause.
- **evidence-reasoning**: bin assignments must cite the activity record, not the user's self-description ("that meeting was important" needs the OUTPUT it enabled).
- **weekly-review-runner**: invoke this detector when reviews show list churn without completions two weeks running.
- **context-switch-minimizer**: do NOT chain into it from a theater finding — rescheduling avoided work is theater; the 25-minute start comes first.
