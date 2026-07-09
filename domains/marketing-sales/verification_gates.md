# Marketing & Sales — Verification Gates

Domain-specific pass/fail gates. Run before delivering any campaign, funnel, or pipeline analysis.

### Gate 1 — Attribution Model Named
- **Pass:** Every ROAS/CAC claim states which attribution model produced it (first-touch/last-touch/linear/data-driven).
- **Fail:** A channel-performance number quoted with no model behind it.
- **Check:** Confirm each performance claim names its attribution model.

### Gate 2 — Multi-Touch Overcounting Check
- **Pass:** Channel credit sums are checked against total conversions; overcounting ratio computed.
- **Fail:** Per-channel conversions summed above actual total, inflating every channel.
- **Check:** Sum channel-attributed conversions; confirm they don't exceed real conversions.

### Gate 3 — LTV:CAC and Payback Grounding
- **Pass:** LTV:CAC and CAC payback are computed stepwise from named inputs, per segment.
- **Fail:** Round-number economics asserted, or blended across segments.
- **Check:** Trace each figure to inputs; confirm segment-level, not blended.

### Gate 4 — CAC Paired With Retention
- **Pass:** Cheap-CAC claims include the same cohort's retention/churn.
- **Fail:** A low CAC celebrated without checking the cohort retains.
- **Check:** Confirm CAC and retention reported for the same segment.

### Gate 5 — Lead-Definition Alignment
- **Pass:** MQL/SQL/PQL definitions are shared and agreed between marketing and sales, with MQL→pipeline correlation.
- **Fail:** Marketing and sales use different qualified-lead definitions; leads leak silently.
- **Check:** Confirm one written definition set and a measured MQL-to-pipeline conversion.

### Gate 6 — Deliverability Health
- **Pass:** Email programs verify SPF/DKIM/DMARC, sender reputation, and list hygiene before sends.
- **Fail:** Volume ramped on an unauthenticated domain or a stale list; inbox placement unchecked.
- **Check:** Confirm auth records pass and bounce/complaint rates are within threshold.

### Gate 7 — Creative Fatigue Watch
- **Pass:** Paid campaigns track frequency and CTR/CVR decay; refresh triggers are set.
- **Fail:** Spend sustained on creative whose performance is decaying from saturation.
- **Check:** Confirm frequency and performance-decay metrics are monitored with a refresh trigger.

### Gate 8 — SEO Cannibalization Check
- **Pass:** New content is checked against existing pages for the same keyword intent before publishing.
- **Fail:** Two pages compete for one query, splitting authority and rankings.
- **Check:** Confirm a keyword-overlap check ran and no two pages target identical intent.

### Gate 9 — Incrementality Over Correlation
- **Pass:** Channel SCALE/CUT decisions on an unstable channel require a holdout/incrementality test.
- **Fail:** Budget shifted on attributed ROAS alone without proving the conversions were incremental.
- **Check:** Confirm a holdout design is attached to any major reallocation.

### Gate 10 — Vanity vs. Pipeline Metric
- **Pass:** Success is stated in pipeline/revenue terms, not impressions/reach/followers.
- **Fail:** A campaign called successful on impressions with no pipeline movement.
- **Check:** Confirm the success claim maps to pipeline or revenue.
