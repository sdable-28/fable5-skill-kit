---
name: cartography-first
description: Use before any deep reading in unfamiliar territory — a new codebase, an unvisited module, a large document set. Maps structure (entry points, god files, interfaces, data flow) using only shallow reads, and outputs the map before any deep dive. Trigger keywords - "how does this codebase work", "onboard", "explore", "where does X live", or any task landing you in code you haven't mapped this session. Do NOT use in territory already mapped this session, or for single-symbol lookups where an index gives the answer directly.
---

# cartography-first

Deep-reading before mapping is how you spend 40 minutes in the wrong file. The map — entry points, god files, interfaces, data flow — costs a few hundred lines of shallow reading and makes every subsequent read targeted. Surgery only after cartography.

## When invoked

1. **Skeleton pass (no file contents yet).** Directory listing / glob: what exists, how big, how named. Note the tells: a `strategies/` dir implies a plugin shape; one 2,500-line file among 300-line files is a god file; `main.py` vs `run_*.py` distinguishes entry points from harnesses.
2. **Entry-point identification.** Find where execution starts (main, CLI handlers, service entry, test harness). Read ONLY their first ~30 lines and imports — imports are the cheapest dependency map available.
3. **God-file inventory.** The 2–4 files where the logic mass lives (by size and by import in-degree — an index/graph tool gives in-degree directly). For each: read signatures only (class/def lines — Grep `^class |^    def |^def ` or the index's symbol list). No bodies.
4. **Interface & data-flow sketch.** From signatures and imports, sketch: what calls what, what data structure flows along the spine (the bar, the request, the document), where state lives (DB, singleton, files).
5. **Output the map** (format below) BEFORE any deep read. This is the deliverable of the skill — if the task ends here, the map alone has value; if it continues, every deep read now has an address.
6. **Then dive — targeted.** Deep reads happen only on locations the map plus the task jointly select, each with a hypothesis (hand off to hypothesis-before-read).

Budget: the whole map should cost under ~500 lines of reading for a mid-size codebase. If you're past that, you've started reading bodies — stop, you're diving without a map.

## Output format

```
## Territory Map: {area}
ENTRY POINTS: {file → what starts there}
GOD FILES: {file (size) → responsibility, in one line each}
SPINE: {the central data flow, e.g. "bar → StateManager → engines → strategy.analyze() → PM"}
STATE LIVES IN: {db/singleton/files}
INTERFACES: {the 2-4 contracts everything plugs into}
NOT MAPPED: {areas skipped + why} 
```

## Integration

- Precedes **hypothesis-before-read** — the map generates the hypotheses.
- Precedes **plan-gate** on unfamiliar code — you cannot plan unmapped territory.
- Phase 2 of **code-investigation** is exactly this skill.
- NOT MAPPED feeds **coverage-accounting**'s unknowns list.
- With semantic indexes available (CodeGraph/Graphify-style), steps 2–4 query the index instead of grepping — same map, cheaper.
