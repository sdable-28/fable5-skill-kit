---
name: debug-isolator
description: Systematic root-cause isolation for software defects — incomplete stack traces, "works on my machine" bugs, intermittent failures, regressions with unknown origin. Trigger phrases: "why is this failing", "can't reproduce", "started breaking after", "intermittent test failure", "no stack trace", "works locally but not in CI". Do NOT use when the failing line and cause are already known from a complete stack trace, when the task is a design decision rather than a defect, or when the failure is a data/statistics question with no code path to isolate.
---

# Debug Isolator

## When invoked

1. Freeze the evidence. Capture the exact failure output (error text, exit code, wrong value) verbatim before touching anything. State the observed behavior and the expected behavior as two separate sentences.
2. Build a minimal reproduction. Strip the failing path to the smallest input, shortest code, and fewest dependencies that still exhibits the failure. If you cannot reproduce, stop fixing — instrument instead (logging, assertion injection) and rerun until reproduction exists. No fix ships without a repro.
3. Binary-search the search space along the correct axis. Pick one: **time** (git bisect between last-known-good and first-known-bad commit), **code** (disable half the pipeline, rerun, halve again), **data** (bisect the input set), or **environment** (diff env vars, dependency lockfiles, container images between working and broken contexts). Record each halving as `hypothesis → test → result`.
4. Enumerate candidate causes before testing any single one. List every mechanism that could produce the exact observed symptom — including race conditions, cache staleness, N+1 amplification, and third-party side effects. Eliminate them one test at a time; never fix the first plausible candidate untested.
5. Confirm the root cause by prediction: state what a targeted change (one line, one flag, one env var) will do to the symptom BEFORE running it. Root cause is confirmed only when the prediction holds both ways — symptom disappears when cause is removed, reappears when restored.
6. Fix at the cause, not the symptom. Then rerun the minimal repro to show it passes, and rerun the original full failing scenario.

## Output format

An **Isolation Log** with exactly these sections: `Symptom` (verbatim), `Repro` (command + minimal case), `Bisection Axis + Steps` (table of hypothesis/test/result rows), `Root Cause` (mechanism, file:line), `Prediction Check` (both directions), `Fix + Reverification` (diff summary + passing output).

## Quality gate

PASS only if: (a) a runnable minimal repro exists, (b) at least two candidate causes were tested and eliminated with recorded evidence, and (c) the prediction check shows the symptom toggles with the cause in both directions. FAIL if the fix was applied before reproduction, or if "root cause" is stated without a bidirectional toggle test.

## Integration

- Feeds **root-cause-first**: this skill is its executable protocol for code defects.
- Every eliminated hypothesis is an **adversarial-disproof** move — try to prove each candidate wrong, not right.
- Log entries in the Isolation Log satisfy **evidence-reasoning**: claims cite command output, never memory.
- Hand the confirmed fix to **refactor-gate** if the fix touches shared code, and to **verified-done** before claiming completion.
- For intermittent failures, use **statistical-analysis** to size the rerun count (e.g., 0 failures in N runs bounds the residual failure rate).
