---
name: meeting-minutes
description: Generate concise, actionable internal meeting minutes with metadata, attendees, agenda, decisions, action items, and follow-ups.
disable-model-invocation: false
title: "Meeting Minutes"
category: c-suite
tags: ["c-suite", "meeting", "minutes", "communication", "management"]
version: "1.0"
---

# Meeting Minutes Skill

## Purpose

Generate concise, consistent meeting minutes for internal meetings up to 60 minutes. Prioritize decisions, action items, owners, due dates, and follow-ups. Output should convert easily into GitHub Issues, Jira, email, or shared docs.

## Use When

* Internal syncs, standups, design reviews, triage, planning, ad-hoc meetings.
* Need concise record of decisions, actions, and follow-ups.
* Source is live meeting, transcript, recording, agenda, slides, or raw notes.

## Workflow

### 1. Intake

Collect:

* Title
* Date
* Start/end time or duration
* Organizer
* Intended audience
* Agenda, slides, transcript, recording, or raw notes

Ask up to 3 clarifying questions when critical fields are missing:

1. Meeting title, date, start time or duration, organizer?
2. Agenda, transcript, recording, or notes available?
3. Reviewer or approver for minutes?

If no agenda/transcript exists, proceed with source material marked `ad-hoc notes` and flag gaps.

### 2. Capture

Record:

* Attendees
* Absentees/regrets
* Notes per agenda item
* Time markers, when available
* Explicit decisions
* Rationale summary
* Action items with owner and due date

### 3. Draft

Use strict schema below. Every action item needs:

* Owner
* Due date or timeframe
* Acceptance criteria, when applicable
* Linked artifact or ticket, when available

Unresolved items go to Parking Lot.

### 4. Review / Publish

Send draft to organizer or reviewer within 24 hours when possible. Publish to agreed channel. Optionally create tracker tasks.

## Strict Minutes Schema

### 1. Metadata

* **Title**:
* **Date (YYYY-MM-DD)**:
* **Start Time (UTC)**:
* **End Time (UTC) or Duration**:
* **Organizer**:
* **Location / Virtual Link**:
* **Minutes Author**:
* **Distribution List**:

### 2. Attendance

* **Present**: names + roles
* **Regrets / Absent**:
* **Notetaker / Recorder**:

### 3. Agenda

* Item 1:
* Item 2:

### 4. Summary

1–3 sentences covering objective and outcome.

### 5. Decisions Made

* **Decision 1**:

  * **Who decided / approved**:
  * **Rationale**:
  * **Effective date**:

### 6. Action Items

* **[A1] Action**:

  * **Owner**:
  * **Due**:
  * **Acceptance Criteria**:
  * **Linked artifacts / tickets**:

### 7. Notes by Agenda Item

* **Agenda Item 1**:

  * **Key points**:

    * Point A
    * Point B
  * **Open issues / questions**:

    * Q1

### 8. Parking Lot / Unresolved Items

* **Item**:

  * **Why parked / next step**:
  * **Suggested owner or next meeting**:

### 9. Risks / Blockers

* **Risk 1**: description, impact, mitigation owner

### 10. Next Meeting / Follow-up

* Proposed date/time:
* Objectives:

### 11. Attachments / References

* Agenda:
* Slides:
* Transcript / Recording:
* Related tickets:

### 12. Version & Change Log

* **Version**: 1.0
* **Last updated**: YYYY-MM-DDTHH:MM:SSZ
* **Changes**:

## Style Rules

* Keep concise:

  * ≤30 min meeting: usually under 1 A4 page
  * ~60 min meeting: usually under 2 pages
* Use plain language and bullets.
* Put decisions and action items high in document.
* No speculation or unverified claims.
* Use `TBD` or `Unknown` for missing information.
* Use ISO 8601 dates and UTC timestamps.

## Required Quality Bar

Minutes are acceptable only when:

* Metadata, Attendance, Decisions, and Action Items are present.
* Every action item has owner and due date/timeframe.
* Significant decisions include rationale.
* References are linked or marked `None`.
* Uncertain facts are labeled `TBD`.

## Do

* Include owner and due date for every action item.
* Add acceptance criteria when possible.
* Link tickets, slides, agenda, recordings.
* Request quick review when decisions are significant.

## Don’t

* Omit decisions or action items.
* Mix opinions with facts.
* Publish raw PII unless required and authorized.

## Copyable Short Template

```text
- Title:
- Date:
- Organizer:
- Present:
- Summary:
- Decisions:
  - Decision 1 — Who — Effective:
- Action Items:
  - [A1] Action — Owner — Due — Acceptance Criteria
- Next Steps / Next Meeting:
```

## Example Prompts

```text
Generate meeting minutes from this transcript.
Title: Platform Weekly Sync.
Date: 2026-02-10.
Duration: 45 minutes.
Organizer: Priya (Platform Lead).
Transcript: <paste transcript>.
Follow Strict Minutes Schema.
Highlight decisions and create action items with owners and due dates where implied.
```

```text
Generate concise minutes from these raw notes.
Title: Feature Y Design Review.
Date: 2026-02-11.
Notes: <paste notes>.
Follow Strict Minutes Schema.
Ask up to 3 clarifying questions if critical fields are missing.
```
