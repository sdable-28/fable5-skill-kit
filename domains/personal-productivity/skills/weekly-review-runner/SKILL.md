---
name: weekly-review-runner
description: >
  Run a complete GTD-style Weekly Review: empty all capture points, reconcile calendar
  vs. what actually happened, prune and re-commit the task system, and set next week's
  MITs. Triggers: "weekly review", "help me review my week", "reset my system",
  "plan next week", Friday/Sunday planning requests. Do NOT use for daily planning
  (too heavy — pick MITs directly), for reviewing a single project's status, or as
  a substitute for doing overdue work the review uncovers.
---

# Weekly Review Runner

## When invoked

1. **Get clear.** Enumerate every capture point the user has (inbox, notes app, desk pile, browser tabs, chat saved-items, voice memos). Walk them one at a time; for each item force exactly one verdict: do-now (<2 min), delegate, defer (becomes a next action with a verb), or delete. No item may survive as "look at later."
2. **Reconcile the past week.** Pull last week's calendar and planned task list. For each planned-but-not-done item demand a cause, not an apology: mis-estimated, deprioritized (by what?), blocked (by whom?), or avoided (why?). Avoidance three weeks running means the task is mis-specified or the goal is dead — say which.
3. **Prune the system.** For every active project confirm it has exactly one concrete next action. Kill or someday-list projects with none. Flag any list that has grown >20% two reviews in a row — the system is capturing more than the person can execute, and the fix is saying no upstream, not a better list.
4. **Look ahead.** Scan next 2 weeks of calendar for landmines (prep-needed meetings, deadlines, travel). Convert each landmine into a dated next action now.
5. **Commit.** Select 3 MITs for next week — outcomes, not activities ("draft sent to Sam", not "work on draft"). Reject a 4th; three is the cap.
6. Timebox the whole ritual: announce a 60–90 min budget at the start and cut scope (step 3 first) if it overruns. A review that takes 3 hours will be skipped next week, and a skipped review kills the system.

## Output format

A **Weekly Review Record** with five fixed sections: `Inboxes Emptied (list, item counts) / Last Week Reconciliation (planned vs. done table with cause column) / System Prunes (killed, someday'd, next-action-added) / Landmines → Actions / Next Week's 3 MITs`.

## Quality gate

PASS only if: (a) every capture point enumerated in step 1 shows a final count of zero or an explicit carry-over decision, (b) the reconciliation table has a cause (not "didn't get to it") on every miss, (c) exactly 3 MITs, each phrased as a completed outcome. FAIL if any section is "N/A" without a stated reason.

## Integration

- **root-cause-first**: apply to step 2 — a third consecutive miss triggers a root-cause pass, not another re-schedule.
- **verified-done**: MITs from last week are graded done only against their outcome phrasing, never "made progress."
- **decision-journal-writer**: step 4 surfaces journal entries whose review dates land this week.
- **context-switch-minimizer**: hand next week's MITs and calendar to it for block scheduling after the review closes.
- **productivity-theater-detector**: run on the review itself if step 3 keeps producing reorganizations instead of completions.
