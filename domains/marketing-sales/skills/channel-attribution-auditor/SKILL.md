---
name: channel-attribution-auditor
description: >
  Audit channel performance claims by stress-testing the attribution model behind them before any
  budget moves. Trigger phrases: "which channel is working", "should we cut/scale spend on X",
  "our CAC by channel", "last-click says", "the agency's report shows", "attribution", "marketing
  mix". Invoke whenever a budget reallocation is justified by per-channel ROAS/CAC numbers.
  Do NOT use for single-channel creative optimization (use copy-testing-loop), for auditing web
  analytics implementation bugs generically, or when the business has one channel and direct —
  there is nothing to attribute.
---

# When invoked

1. Identify the attribution model producing the numbers under discussion: first-touch, last-touch, linear, position-based, data-driven, or platform-reported (Meta/Google self-attribution). Name it explicitly. If nobody knows, that is the finding — stop and report it.
2. Pull the same conversion set through at least one alternative model (minimum: last-touch vs. first-touch vs. platform-reported). Build a divergence table: channel × model × attributed conversions. Any channel whose credit swings >40% across models is UNSTABLE — mark it and forbid budget conclusions from it without a holdout test.
3. Check for the three standard frauds: (a) branded search cannibalizing organic (compare branded-term spend against direct+organic trend); (b) retargeting claiming credit for users already in-pipeline (check audience overlap with open opportunities); (c) view-through conversions counted as clicks (strip view-through and recompute).
4. Reconcile top-down: sum of platform-claimed conversions vs. actual CRM-recorded new pipeline for the period. Overcounting ratio >1.3x means platform numbers are inadmissible as-is; apply the deflation factor to every channel before comparing.
5. For any channel the user wants to cut or scale, specify the cheapest incrementality test that would settle it: geo holdout, audience split, or spend pulse. State duration and minimum detectable effect.
6. Recompute CAC payback per channel using CRM-side revenue only, cohorted by first-touch month.

# Output format

An **Attribution Audit** with: (a) model-in-use statement; (b) divergence table (channel × ≥3 models) with UNSTABLE flags; (c) fraud-check results for all three checks in step 3, each PASS/FAIL with the number; (d) overcounting ratio and deflated channel table; (e) per-channel verdict — SCALE / HOLD / CUT / TEST-FIRST — with the incrementality test spec attached to every TEST-FIRST.

# Quality gate

PASS only if the divergence table exists with real numbers, the overcounting ratio is computed, and no SCALE/CUT verdict rests on an UNSTABLE channel without an attached holdout design. FAIL if the audit merely restates the platform dashboard.

# Quality gate integration

- **statistical-analysis**: powers the incrementality test sizing in step 5 and the minimum detectable effect math.
- **adversarial-disproof**: step 3 is structured disproof — assume every channel's claim is inflated and try to break it.
- **root-cause-first**: when a channel "collapsed," check attribution-model or tracking changes (iOS updates, consent banners, GA4 migrations) before concluding demand died.
- **icp-sharpener**: run channel CAC per ICP segment; blended CAC across segments hides which channel finds the right buyers.
