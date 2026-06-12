# Strategic Alignment Playbook

Cascading strategy. Detecting drift. Maintaining alignment at scale.

---

## 1. Strategy Cascade

### One-Page Strategy Filter

Compress strategy to one page before cascade. If it does not fit, it is not clear enough.

```text
Company Strategy — [Quarter/Year]
─────────────────────────────────
WHERE WE'RE GOING (6-word vision):
─────────────────────────────────
TOP 3 PRIORITIES THIS QUARTER:
1. [Priority] — owner: [name]
2. [Priority] — owner: [name]
3. [Priority] — owner: [name]
─────────────────────────────────
WHAT WE'RE NOT DOING:
- [Deprioritized initiative]
- [Deferred initiative]
─────────────────────────────────
HOW WE MEASURE SUCCESS:
- [Key metric 1]
- [Key metric 2]
- [Key metric 3]
```

“What we’re not doing” prevents teams from adding local priorities.

### Cascade Workshop

1. **Company OKR owners present to department leads — 60 min**
   Explain each OKR and its reasoning.

2. **Department leads draft response OKRs — 90 min**
   Prompt: “Given company OKRs, what is our department uniquely positioned to contribute?”

3. **Cross-check conflicts and gaps — 60 min**
   Identify unsupported company OKRs. Identify departments likely to conflict.

4. **Resolve before publishing — 30 min**
   Assign missing coverage. Set shared metrics for conflict-prone areas.

5. **Cascade to teams and individuals — within 1 week**
   Department leads repeat the process with their teams.

### Cascade Rules

1. **Top-down plus bottom-up**
   Reserve 20–30% of team OKRs for team-defined goals tied to company direction.

2. **Every team goal needs a parent**
   No link to company OKR means the team goal is wrong or the company OKR is incomplete.

3. **Cascade why, not only what**
   “Achieve €800K ARR in DACH” is weaker than “Achieve €800K ARR in DACH to prove product-market fit before Series B in Q4.”

---

## 2. Strategy Telephone Game

### Problem

Most employees cannot name company priorities. Many who can interpret them differently than leadership intended.

This is not only communication failure. It is organizational physics.

### Why Strategy Degrades

* **Layer 1 → Layer 2:** Managers interpret strategy through local context.
* **Layer 2 → Layer 3:** Teams receive the manager’s interpretation, not the original strategy.
* **Written vs. oral:** Written strategy persists. Oral strategy mutates.
* **Recency bias:** Later messages overwrite earlier strategy.

### Countermeasures

* **Repeat strategy often**
  One communication is not enough. Aim for 7+ exposures.

* **Use multiple formats**
  Writing. Verbal. Visual. Story. Example.

* **Create shared vocabulary**
  “DACH focus mode” travels better than a paragraph.

* **Test comprehension**
  Ask random team members: “What are our top 3 priorities right now?”

* **Use stories over slides**
  “This decision is an example of the strategy” is more memorable than restating OKRs.

---

## 3. Cross-Functional OKRs

Silos form when teams have no shared goals. Fix with OKRs that require cooperation.

### Shared Ownership OKR

```text
Objective: [What we will achieve together]
Primary owner: [Team A]
Contributing owner: [Team B]

Key Results:
- KR owned by Team A: [Metric]
- KR owned by Team B: [Metric]
- Shared KR: [Metric requiring both teams]
```

Example:

```text
Objective: Launch partner API and acquire first 3 integrations
Primary owner: Engineering
Contributing owner: Business Development

KR 1 — Engineering: API v1 live with 100% documentation by Week 8
KR 2 — BD: 3 signed partner integration agreements by EoQ
KR 3 — Shared: First partner integration live in production by EoQ
```

### Conflict Guardrail Metric

Use shared guardrails when team goals may conflict.

Example:

```text
Sales goal: 15 new logos
CS goal: Churn < 2%
Shared guardrail: New customer 90-day churn < 5%
```

Effect: Sales cannot close unqualified customers. CS cannot blame Sales without shared accountability.

---

## 4. Alignment Cadence

### Quarterly Alignment Check

Run before next-quarter OKR planning.

**Week −2**

* Review current OKRs.
* Identify hits and misses.
* Run alignment checker: orphans, gaps, conflicts.

**Week −1**

* Run cascade workshop.
* Review cross-functional conflicts.
* Assign coverage gaps.

**Week 1**

* Finalize team OKRs.
* Document parent company OKRs.
* Document shared OKRs and co-owners.
* Add guardrail metrics for known conflict areas.

### Monthly Alignment Pulse

Ask in every department review:

> “How is our work moving company-level OKRs? What is the connection?”

Weak answer means cascade has broken.

### Weekly Alignment Signal

Ask in leadership L10:

> “Is anything happening in our team that is at odds with company strategy?”

Creates recurring misalignment detection.

---

## 5. Misalignment by Company Stage

### Seed: <20 People
* **Pattern:** Informal alignment through daily contact.
* **Risk:** Breaks after ~15 people.
* **Fix:** Start documenting strategy at 10–12 people.

### Early Growth: 20–60 People

* **Pattern:** Functions form. Sales, Product, Engineering separate.
* **Misalignment:** Engineering builds features Sales did not ask for. Sales promises unplanned features.
* **Fix:** Shared quarterly planning. Sales/Product roadmap review. Monthly Engineering/Sales pipeline update.

### Scaling: 60–200 People

* **Pattern:** Multiple management layers. Strategy reaches ICs slowly.
* **Misalignment:** Department heads optimize local metrics. Cross-functional work stalls.
* **Fix:** Cross-functional OKRs. Shared metrics. Quarterly alignment check. 

### Large: 200+ People

* **Pattern:** Business units, geographies, and product lines form sub-strategies.
* **Misalignment:** Units compete for same customer segment. Platform priorities drift from product direction.
* **Fix:** Annual strategy alignment summit. Centralized OKR system. Visible cross-functional links. Dedicated alignment owner, often COO or Chief of Staff.
