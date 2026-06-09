---
name: markmap-editor
description: Create, read, understand, and update mindmap (Markmap-compatible) Markdown files for brainstorming, idea tracking, structured notes, concept modelling, and data/topic visualisation.
disable-model-invocation: true
title: "Manage Mindmap (Markmap) Markdown"
category: creation
tags: ["creation", "markmap", "markdown", "mindmap", "visualization", "notes", "brainstorming"]
version: "1.0"
---

# Markmap Editor

## Purpose

Manage Markdown files intended for Markmap visualisation. Markmap renders Markdown hierarchy as an interactive mind map using headings, nested lists, and supported inline Markdown.

Use this skill to create, read, explain, update, refactor, expand, prune, or reorganise Markmap Markdown files.

## When to use

Use when the user wants to create, understand, or maintain a hierarchical knowledge map, especially for:

- Brainstorming product, security, architecture, research, or strategy ideas.
- Tracking ideas, assumptions, risks, questions, decisions, and follow-ups.
- Modelling systems, concepts, domains, threat models, workflows, or data relationships.
- Converting notes, documents, meetings, or rough thoughts into a Markmap.
- Reading or updating an existing Markmap `.md` file.

Do not use for linear prose, tables-only output, flowcharts, sequence diagrams, state machines, or explicit graph-edge diagrams. Suggest a better format instead.

## File workflow

1. Resolve `targetFile`.
2. If it exists, read it before editing.
3. If it does not exist, create a complete valid Markmap file.
4. Preserve YAML frontmatter unless explicitly changed.
5. Preserve hierarchy unless refactoring is requested.
6. Apply the smallest safe edit.
7. Write the complete updated Markdown back to `targetFile`.
8. Summarise changes.

## Required file shape

Every Markmap file should contain YAML frontmatter followed by one Markdown body.

Default frontmatter for new files:

```markdown
---
title: markmap
markmap:
  colorFreezeLevel: 2
  color: ["blue", "orange", "green", "violet", "grey"]
  maxWidth: 640
  embedAssets: true
---
````

Retain existing frontmatter unless invalid or explicitly changed.

## Body rules

* Use exactly one `#` root heading.
* Use `##` for primary branches.
* Use `###` for secondary branches.
* Use nested bullet lists for deeper detail.
* Markdown headings support only six levels; prefer lists beyond `###`.
* Avoid unrelated block types at the same hierarchy level.
* Aim for 3–9 primary branches.
* Keep branch names short, concrete, and scannable.
* Remove filler, duplicates, and vague nodes.
* Merge weak single-child branches where appropriate.

Example:

```markdown
# Main Topic

## Branch A

### Sub-branch A1

- Detail
- Open question
- Decision

## Branch B

- Supporting point
- Risk
- Follow-up
```

## Supported Markdown

Use sparingly where helpful:

* `**bold**`, `*italic*`, `~~strikethrough~~`, `==highlight==`
* Inline code: `` `code` ``
* Short fenced code blocks
* Checkboxes: `- [ ]` and `- [x]`
* KaTeX math: `$x = y + z$`
* Small comparison tables

Hierarchy matters more than decoration.

## Update rules

When updating an existing file:

* Do not overwrite unrelated content.
* Do not remove branches unless requested or clearly duplicate.
* Keep terminology consistent.
* Add new material to the most relevant branch.
* Create a branch only when no suitable one exists.
* Prefer minimal restructuring if the request conflicts with the current structure.
* Preserve user wording where possible.
* Translate only when `language` requires it.

## Read mode

When asked to understand a file:

* Summarise the root topic.
* Identify primary branches.
* Explain structure and intent.
* Highlight gaps, duplication, overloaded nodes, or unclear hierarchy.
* Suggest improvements without modifying unless asked.

## Quality checklist

Before finishing, confirm:

* Frontmatter is valid YAML.
* File extension is `.md`.
* Exactly one `#` root exists.
* Branches are distinct and balanced.
* Nesting is valid Markdown.
* Language matches the request.
* Existing content was preserved unless change was requested.
* Final output is the complete file, not a patch fragment.

