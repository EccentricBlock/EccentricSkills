---
name: create-implementation-plan
description: Create a new implementation plan file for feature, refactor, upgrade, design, architecture, infrastructure, data, or process work.
disable-model-invocation: false
title: "Create Implementation Plan"
category: planning
tags: ["planning", "architecture", "design", "refactoring"]
version: "1.0"
---

# Create Implementation Plan

Create a deterministic, self-contained implementation plan for `${input:PlanPurpose}`.

Output must be machine-readable, Markdown, and executable by AI agents or humans without clarification.

## Requirements

- Create one implementation plan file in `/plan/`.
- File name format: `[purpose]-[component]-[version].md`.
- Allowed purpose prefixes: `upgrade`, `refactor`, `feature`, `data`, `infrastructure`, `process`, `architecture`, `design`.
- Use valid Markdown.
- Include required front matter.
- Use exact section headers.
- Use deterministic language.
- Use atomic phases and executable tasks.
- Use explicit dependencies when tasks or phases are sequential.
- Use standardized identifiers: `REQ-`, `SEC-`, `CON-`, `GUD-`, `PAT-`, `GOAL-`, `TASK-`, `ALT-`, `DEP-`, `FILE-`, `TEST-`, `RISK-`, `ASSUMPTION-`.
- Include measurable completion criteria.
- Include file paths, function names, configuration keys, constants, and implementation details where known.
- Do not leave placeholders.
- Do not require human interpretation.

## Status Values

Allowed `status` values:

| Status | Badge color |
|--------|-------------|
| `Completed` | `brightgreen` |
| `In progress` | `yellow` |
| `Planned` | `blue` |
| `Deprecated` | `red` |
| `On Hold` | `orange` |

Status must appear in front matter and introduction badge.

## Required Template

```md
---
goal: <concise implementation plan goal>
version: <version or date>
date_created: <YYYY-MM-DD>
last_updated: <YYYY-MM-DD>
owner: <team or individual>
status: 'Completed'|'In progress'|'Planned'|'Deprecated'|'On Hold'
tags: [<tag-1>, <tag-2>]
---

# Introduction

![Status: <status>](https://img.shields.io/badge/status-<status>-<status_color>)

<concise introduction explaining the plan goal>

## 1. Requirements & Constraints

- **REQ-001**: <functional requirement>
- **SEC-001**: <security requirement>
- **CON-001**: <implementation constraint>
- **GUD-001**: <implementation guideline>
- **PAT-001**: <required pattern>

## 2. Implementation Steps

### Implementation Phase 1

- GOAL-001: <phase goal>
- COMPLETION-001: <measurable completion criteria>
- DEPENDS-ON: None

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-001 | <atomic executable task with exact files, functions, and implementation details> |  |  |
| TASK-002 | <atomic executable task with exact files, functions, and implementation details> |  |  |

### Implementation Phase 2

- GOAL-002: <phase goal>
- COMPLETION-002: <measurable completion criteria>
- DEPENDS-ON: GOAL-001

| Task | Description | Completed | Date |
|------|-------------|-----------|------|
| TASK-003 | <atomic executable task with exact files, functions, and implementation details> |  |  |
| TASK-004 | <atomic executable task with exact files, functions, and implementation details> |  |  |

## 3. Alternatives

- **ALT-001**: <alternative approach and rejection reason>
- **ALT-002**: <alternative approach and rejection reason>

## 4. Dependencies

- **DEP-001**: <dependency name, version, purpose, and source>
- **DEP-002**: <dependency name, version, purpose, and source>

## 5. Files

- **FILE-001**: `<path>` — <required change>
- **FILE-002**: `<path>` — <required change>

## 6. Testing

- **TEST-001**: <test file, test name, command, and expected result>
- **TEST-002**: <test file, test name, command, and expected result>

## 7. Risks & Assumptions

- **RISK-001**: <risk and mitigation>
- **ASSUMPTION-001**: <assumption and validation method>

## 8. Related Specifications / Further Reading

- **REF-001**: <path or URL> — <relationship to this plan>
- **REF-002**: <path or URL> — <relationship to this plan>
````

## Validation Rules

Before finalizing the file, verify:

* Front matter contains every required field.
* `status` is one allowed value.
* Badge status matches front matter status.
* Badge color matches status mapping.
* All section headers match exactly.
* Every identifier uses the required prefix format.
* Every table contains required columns.
* Every task is atomic and executable.
* Every dependency is explicit.
* Every referenced file path is exact.
* No placeholder syntax remains.
* No vague terms remain, including `etc.`, `as needed`, `appropriate`, `TBD`, `TODO`, `might`, `maybe`, or `should`.

