---
name: document-mastery
description: Use for any professional document — reports, proposals, specs, memos, READMEs, post-mortems, executive summaries, emails that matter. Defines audience + purpose + format BEFORE drafting; runs structure → draft → self-review against purpose → gap check → final. Quality gates - would the target reader understand this, and does every section serve the purpose. Trigger keywords - "write a report", "draft a proposal", "document this", "write up", "summary for {audience}". Do NOT use for quick conversational answers or code comments.
---

# document-mastery

A document is a machine for changing its reader's mind or enabling their action. Most bad documents fail before the first sentence — written for no particular reader, toward no particular decision. The discipline is front-loading the definition and then ruthlessly testing every section against it.

## When invoked

1. **Define, before any drafting — three lines, written out:**
   - **AUDIENCE:** who reads this, what they already know (calibrates vocabulary and what needs explaining), and what they'll DO with it (skim for a decision? execute steps? forward upward?).
   - **PURPOSE:** the change in the reader — "after reading, they {decide X / can do Y / understand Z}." One purpose. A document with three purposes is three documents stapled together.
   - **FORMAT:** the container and its conventions (one-page memo ≠ spec ≠ post-mortem), length budget, and the reader's entry point (executives read the first five lines and the headings; engineers read the steps and skip the preamble).
2. **Structure before prose.** Outline as full-sentence section claims, not topic nouns — "The migration is reversible until step 4" outlines; "Migration details" doesn't. Order by the reader's need: conclusion/ask first (BLUF — the reader who stops early leaves with the point), then support, then detail. Test each planned section NOW: "how does this serve the purpose?" — cut what has no answer, before it costs drafting effort.
3. **Draft within the structure.** Complete sentences over fragment chains; concrete over abstract (numbers, names, dates — "reduces startup from 40s to 6s," not "significantly improves performance"); the reader's vocabulary, with codenames and internal shorthand either translated or cut. Tables only for enumerable facts; the reasoning lives in prose.
4. **Self-review against PURPOSE — as the named reader.** Re-read cold, wearing the audience's knowledge state. Gate questions: Can they act after reading? Where do they stumble on an unexplained term or a leap? Does the first paragraph deliver the purpose to a reader who stops there? Fix the worst failure, not everything (self-correction-loop discipline).
5. **Gap check — what the document omits:** the objection the reader will raise (answer it in-text or acknowledge it openly); the missing input they need to act (owner, deadline, link, cost); the unstated assumption they don't share. A persuasive document that ignores the obvious counter-argument reads as either naive or evasive.
6. **Final pass — mechanical:** length vs budget (cut detail that doesn't change what the reader does next); heading-only skim still tells the story; numbers consistent between prose and tables; the ask/next-step is explicit and placed where the reader will see it.

## Output format

Preceding or accompanying the document (dropped for routine docs, kept for reviewed ones):
```
AUDIENCE: {who + knows + will-do}
PURPOSE: after reading, they {X}
FORMAT: {container, length}
```
Then the document itself, structured per step 2. Review artifacts (step 4–5 findings) reported only when material.

## Integration

- **self-correction-loop** is step 4 with a document-specific flaw list; **assumption-flagging** powers step 5's unshared-assumption hunt.
- Claims inside the document obey **evidence-reasoning** (a report's numbers cite their sources) and **mathematical-reasoning** (shown arithmetic for derived figures).
- **idea-generation** upstream when the document's content is still unformed; **video-editing** borrows this skill's audience/purpose discipline for scripts.
- The handoff briefs and ADRs defined elsewhere in this kit are instances of this skill with fixed AUDIENCE (a cold model / a future maintainer) and fixed FORMAT.
