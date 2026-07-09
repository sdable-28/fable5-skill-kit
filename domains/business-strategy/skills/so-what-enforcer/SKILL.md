---
name: so-what-enforcer
description: Enforce pyramid-principle, answer-first communication on every strategic deliverable - each data point must carry an implication, the executive summary must contain the full answer, one slide one message. Trigger phrases - "write up the findings", "draft the exec summary", "build the storyline", "prepare the recommendation deck", or any time analysis output is being turned into a client-facing artifact. Do NOT use on raw working analysis, internal scratch notes, or code documentation - it governs communication artifacts only.
---

# So-What Enforcer

Data without implication is cost, not insight. An executive who reads only the first page must get the entire answer.

## When invoked

1. Write the governing answer FIRST: one sentence that resolves the locked problem statement, including the recommendation, the expected impact number, and the primary risk. If you cannot write it, the analysis is not done — go back, do not draft around the gap.
2. Build the pyramid beneath it: 3 (max 4) supporting arguments, each a full assertion sentence ("Pricing is the largest lever, worth $4.2M EBITDA"), never a topic label ("Pricing analysis"). Arguments must be MECE against the governing answer.
3. Run the so-what pass on every data point, exhibit, and finding: append "— which means [implication for the decision]". Any item whose so-what is "context" or "interesting" gets cut or moved to appendix. No exceptions.
4. Enforce one-slide-one-message: each section/slide headline is its full message as an assertion; the body only proves the headline. A reader skimming headlines alone must reconstruct the complete argument.
5. Write the executive summary to contain the whole answer — recommendation, impact, cost, timeline, top risk, immediate next step. Ban forward references ("see section 3"). Test: if pages 2+ were deleted, could the decision still be made? It must be yes.
6. Attach the implementation path: owner, first 90 days, resource ask, and the change-management step (who loses power/budget and how that resistance is handled). A recommendation without an implementation path FAILS this skill by definition.

## Output format

A **Pyramid Storyline**: (a) governing answer sentence, (b) argument layer as assertion headlines, (c) evidence layer with every item ending in "— which means...", (d) self-contained executive summary, (e) implementation path block (owner / 90 days / resources / change-management risk).

## Quality gate

Mechanical check — scan the artifact: every headline is a full sentence with a verb; every exhibit caption contains "which means" (or equivalent implication clause); the exec summary contains a number, a date, and a named owner; zero forward references. Any miss = FAIL, rewrite that element.

## Integration

- Runs LAST in the chain: after mece-decomposer findings, framework-fit-gate outputs, and scenario-stress-planner results are complete.
- The governing answer must trace to evidence-reasoning-grade support — assert nothing the evidence layer does not prove.
- verified-done for a consulting engagement = this skill's quality gate passing on the final artifact.
- Implication claims with numbers route through statistical-analysis before they enter the pyramid.
