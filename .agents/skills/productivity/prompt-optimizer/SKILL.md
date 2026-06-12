---
name: prompt-optimizer
description: Rewrite any rough prompt, vague task, or draft into one finished, copy-pasteable chat prompt for any LLM. Use when user asks to write, rewrite, improve, optimize, sharpen, polish, or draft a prompt, or when they describe a task they want to give an LLM. Output only one fenced code block containing the final prompt. No commentary.
disable-model-invocation: false
title: "Prompt Optimizer"
category: productivity
tags: ["prompting", "optimization", "productivity", "drafting"]
version: "1.0"
---

# Prompt Optimizer

Convert user input into one high-quality prompt for chat-based LLMs. Not API prompts. No system prompts, parameters, tool config, or templates.

## Hard rules

### 1. No placeholders

Never output placeholders: `[paste X here]`, `[your content]`, `{topic}`, `<your_input_here>`, `[INSERT Y]`, `___`, or similar.

User must copy, paste, and send the prompt as-is.

### 2. Always ship a finished prompt

Handle two cases.

**Case A — user provided real content.**  
Bake the content directly into the prompt. Include all relevant drafts, code, documents, lists, specs, or facts inside the code block.

**Case B — user described a task type only.**  
Write a complete prompt that works on its own. End by instructing the target LLM to ask the user for required inputs, or to wait for the user’s next message containing the content.

No fill-in blanks. No template syntax.

## Output format

Always output exactly one fenced code block. No text before or after.

Inside the block: the optimized prompt only.

End with one reasoning-depth instruction:

For reasoning-capable models:
`Think before answering (maximum reasoning).`

For general models:
`Take time to think through this carefully before responding.`

Adapt wording when useful, but preserve the intent.

## Internal workflow
Work through these in your head before writing the prompt. You don't need to surface them.
1. Identify concrete goal.
2. Identify audience and use.
3. Decide Case A or Case B.
4. Spot missing details.
5. Resolve gaps:
   - Make defensible assumptions for non-essential gaps.
   - For essential missing inputs in Case B, make the prompt ask the user for them.
6. Choose structure:
   - Simple task: direct paragraph.
   - Multi-section task: XML-style sections.
7. Write final prompt.
8. Add reasoning-depth closing line.
9. Scan for placeholder syntax and remove it.

## Prompting principles

- State the task directly.
- Specify output format and hard constraints.
- Explain important instructions briefly.
- Use positive instructions: say what to do, not only what to avoid.
- Match prompt style to desired output style.
- Use XML tags for complex prompts with context, instructions, examples, or long input e..g. `<instructions>`, `<context>`, `<examples>`, `<input>`. Nest naturally where there's hierarchy. This is the single highest-leverage structuring move for complex prompts. For simple one-shot prompts, skip it; XML on a haiku request is overkill.
- Add a role only when it improves behavior.
- Use examples when format, tone, or structure matters.
- Put long user-provided input near the top; put the final task near the bottom.
- For long-document analysis, ask the model to extract relevant quotes first, then answer from those quotes.
- Be explicit about scope: “apply to every section,” “edit directly,” “report every issue.”
- Add verification instructions for code, math, claims, safety, or high-stakes outputs.

## Domain moves

**Frontend/design:** Specify palette, typography, layout, and interaction direction, or ask for several visual directions before implementation.

**Code review:** Optimize for coverage first. Report all issues, including uncertain and low-severity findings. Include severity and confidence.

**Research/analysis:** Use competing hypotheses, confidence tracking, and self-critique.

**Creative writing:** Specify voice, audience, length, constraints, and example sentences when available.

**Documents/slides/reports:** Ask for visual hierarchy, typography, structure, and design intentionality.

## Edge cases

- “Is this prompt good?” means rewrite it.
- API/system-style prompts must be converted into one chat prompt.
- Many small asks should become one coherent structured prompt.
- Already-good prompts should be tightened, not over-engineered.
- Non-English input should produce output in the same language.
- Never create empty `<context>` or `<input>` blocks for user completion.

## Required output pattern
```
Optimized prompt text goes here, fully self-contained, with no placeholders.

Think before answering (take time to reason through this carefully).
```


