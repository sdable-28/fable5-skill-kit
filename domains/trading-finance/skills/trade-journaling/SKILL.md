---
name: trade-journaling
description: >
  Log every trade, signal, and research verdict in a structured, append-only record that makes
  edge validation and falsification memory possible. Triggers: "log this trade", "journal",
  "why did we take that trade", "have we tried this before", "record the backtest result",
  "post-mortem this loss", "what happened on {date}". Do NOT use for generic note-taking,
  meeting notes, or code changelogs with no trade/signal/edge content.
---

# When invoked

1. Log at signal time, not at close time: capture what was KNOWN when the decision fired — regime card, conviction inputs, level context, size and its binding constraint, intended stop/targets. A journal reconstructed after the outcome is contaminated by hindsight; mark any backfilled entry `RECONSTRUCTED`.
2. On trade close, append the outcome fields to the same record: fill prices (modeled AND actual), exit reason (STOP/T1/T2/EOD/MANUAL/EMERGENCY), MAE and MFE in points, slippage per leg, realized R-multiple against the ORIGINAL stop.
3. Log negative knowledge with the same rigor as trades: every falsified hypothesis gets a permanent entry with the evidence and the exact variant tested, so no future session re-runs a dead idea. Falsifications are the highest-value journal entries — they only pay if they are findable.
4. Never edit or delete a past entry. Corrections are new entries referencing the old one. An editable journal cannot validate an edge because survivors get polished.
5. Enforce sample-size honesty at query time: when the journal is asked "does setup X work," answer with n, WR, avg R, and per-regime split — and refuse a verdict below 30 occurrences (state "INSUFFICIENT SAMPLE: n=…" instead).
6. Separate live entries from backtest entries at the schema level (a flag or separate table). Mixing them poisons any ML training set and inflates edge estimates; live fills are the only ground truth.

# Output format

A **Journal Entry** (one per trade/verdict) with fixed fields: `id, timestamp, type {LIVE|BACKTEST|FALSIFICATION|DECISION}, instrument, signal_type, regime_card, entry/stop/targets, size + binding_constraint, outcome {fills, exit_reason, MAE, MFE, R, slippage}, evidence_refs (file paths, commits), lesson (one sentence)`. Queries return the aggregate line `n / WR / avg R / per-regime split` plus the matching entry ids.

# Quality gate

PASS only if the entry contains the decision-time snapshot (regime card + binding constraint) recorded before outcome fields, and every falsification entry cites concrete evidence. FAIL if any entry was silently mutated, if live and backtest records share a pool without the type flag, or if a "setup works" answer was given on n<30 without the INSUFFICIENT SAMPLE label.

# Integration

Is the persistence layer for the other four skills: regime-awareness writes the regime card here, execution-analysis reads modeled-vs-actual fills from here, backtest-discipline checks here for previously-falsified variants before any run, risk-first-sizing audits binding-constraint history here. Feeds evidence-reasoning directly — journal entries are citable evidence objects — and gives adversarial-disproof its record of what has already been disproven.
