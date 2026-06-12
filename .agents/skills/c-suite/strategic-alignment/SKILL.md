---
name: strategic-alignment
description: Cascades strategy from boardroom to IC. Detects misalignment between company goals and team execution.
disable-model-invocation: true
title: "Strategic Alignment"
category: c-level
tags: ["strategy", "leadership", "c-suite", "alignment", "okrs"]
version: "1.0"
# https://github.com/alirezarezvani/claude-skills/blob/main/c-level-advisor/skills/strategic-alignment/SKILL.md
---

# Strategic Alignment Engine

Strategy usually fails in the cascade, not the boardroom. Goal: keep company strategy connected from CEO to individual contributor.

## Use When

Use for:

* Strategic alignment
* Strategy cascade
* OKR alignment
* Orphan OKRs
* Conflicting goals
* Silos
* Communication gaps
* Cross-functional misalignment
* Departments optimizing locally at company expense

## Quick Start

```bash
python scripts/alignment_checker.py
```

Checks JSON-formatted OKRs for:

* Orphan goals
* Conflicts
* Coverage gaps

## Core Principle

The further a goal moves from original strategy, the more likely it loses intent.

Alignment problem = organizational telephone game.

## 1. Strategy Articulation Test

Ask five people from five teams:

> What is the company’s most important strategic priority right now?

Score:

| Result              | Meaning                                                           |
| ------------------- | ----------------------------------------------------------------- |
| 5 same answers      | Clear articulation                                                |
| 3–4 similar answers | Loose alignment. Clarify and repeat.                              |
| <3 agree            | Strategy too unclear to cascade. Fix strategy articulation first. |

Strategy must fit in one sentence.

Weak:

> We focus on product-led growth while maintaining enterprise relationships and expanding internationally and investing in platform capabilities.

Strong:

> Win the mid-market healthcare segment in DACH before Series B.

## 2. Cascade Mapping

Map strategy flow:

```text
Company OKRs
  ↓
Department OKRs
  ↓
Team OKRs
  ↓
Individual goals
```

For every goal, ask:

* Which company goal does this support?
* If fully achieved, how much does it move the company goal?
* Is the connection direct or theoretical?

## 3. Misalignment Detection

### Orphan Goals

Team or individual goals with no company-level parent.

Symptom:

> We worked on this all quarter and nobody above us cares.

Cause:

* Bottom-up goals
* Old priorities copied forward
* No reconciliation with current company OKRs

Fix:

> Connect or cut. Every goal needs a parent.

### Conflicting Goals

Two teams succeed locally but damage company outcome.

Example:

* Sales goal: close volume contracts.
* CS goal: maintain satisfaction.
* Sales closes bad-fit customers.
* CS satisfaction drops.

Fix:

* Cross-functional OKR review before quarter starts.
* Shared metrics where teams interact.

### Coverage Gaps

Company OKRs lack team ownership.

Example:

```text
Company OKR-1: 5 teams support
Company OKR-2: 2 teams support
Company OKR-3: 0 teams support
```

Fix:

> Assign explicit ownership. If no team owns it, it will not happen.

## 4. Silo Identification

Silos exist when teams optimize local metrics at company expense.

Signals:

* Departments hit goals while company misses.
* Teams do not know adjacent team priorities.
* “That’s not our problem” appears often.
* Escalation flows up, not sideways.
* Dependent teams do not share data.

Root causes:

1. Incentive misalignment
2. No shared goals
3. No shared language
4. Geography or time-zone separation

Measure:

* Frequency of cross-team requests
* Time to resolve cross-functional issues
* Ability to describe adjacent team priorities

## 5. Communication Gap Analysis

CEO message ≠ team interpretation.

Decay model:

```text
CEO communicates strategy
  ↓
Managers filter it
  ↓
Teams receive modified version
  ↓
Individuals reinterpret it
```

Gap sources:

| Source          | Failure mode                                     |
| --------------- | ------------------------------------------------ |
| Ambiguity       | Strategy too broad, teams invent meaning         |
| Low frequency   | One quarterly all-hands does not change behavior |
| Medium mismatch | Written doc for visual/auditory teams            |
| Trust deficit   | Teams assume strategy will change again          |

Detect gaps by asking:

* What did leadership think they communicated?
* What did teams hear?
* What changed in actual work after the strategy update?

## 6. Realignment Protocol

Do not call it “realignment.” It creates fear.

### 6a. Start With Direction

Avoid:

> Here is our misalignment.

Use:

> Here is where we are heading. I want to make sure we are connected.

### 6b. Re-cascade in Workshop

Use live workshops, not memos.

Include:

* Company OKR owners
* Department leads
* Cross-functional stakeholders

Map:

* Goal connections
* Conflicts
* Ownership gaps

### 6c. Fix Incentives First

If leaders are rewarded for local metrics that conflict with company goals, goal-setting will not fix alignment.

Change incentives before changing OKRs.

### 6d. Install Quarterly Alignment Check

Repeat every quarter. Prevent drift.

Reference:

```text
references/alignment-playbook.md
```

## Alignment Score

Score each area 0–10.

| Area                 | Question                                                              | Score |
| -------------------- | --------------------------------------------------------------------- | ----- |
| Strategy clarity     | Can five people from different teams state the strategy consistently? | /10   |
| Cascade completeness | Do all team goals connect to company goals?                           | /10   |
| Conflict detection   | Were cross-team OKR conflicts reviewed and resolved?                  | /10   |
| Coverage             | Does every company OKR have explicit team ownership?                  | /10   |
| Communication        | Do team behaviors reflect strategy?                                   | /10   |

Total:

```text
__/50
```

Interpretation:

| Score | Status                            |
| ----- | --------------------------------- |
| 45–50 | Excellent. Maintain system.       |
| 35–44 | Good. Fix weak areas.             |
| 20–34 | Misalignment is costly. Act now.  |
| <20   | Strategic drift. Treat as crisis. |

## Diagnostic Questions

* What is the most important thing the company is trying to achieve right now?
* Which company OKR does your team’s top priority support?
* When Team A and Team B both hit their goals, does the company always win?
* What changed in how your team works after the last strategy update?
* Name one decision last week influenced by company strategy.

## Red Flags

* Teams hit goals while company misses.
* Cross-functional projects take 3x longer than expected.
* Strategy updates quarterly, but team priorities do not change.
* Teams say: “That is a leadership problem.”
* New initiatives launch without OKR linkage.
* Department heads optimize for headcount or budget instead of outcomes.


## References
* references/alignment-playbook.md - Cascade techniques, quarterly alignment check, common patterns
