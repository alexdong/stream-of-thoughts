---
layout: post
title: "How Prompt Writing Style Shapes GPT-5 and Codex"
date: 2025-09-25 21:06
comments: true
categories: 
- prompt-engineering
- open-ai
---

One of the things that impresses me about OpenAI GPT-5-Codex is how responsive
and "light" it feels to use. Compared with the page-long dumps from
[Claude Code](/due-to-odd-jax-issues.html), GPT-5-Codex stays efficient,
more to the point, and much more steerable. Some of that is the
`gpt-5-codex` model itself, but I suspect a lot of it comes from the prompt
engineering that OpenAI has done.

So I pulled up the [system prompt for
Codex](https://github.com/openai/codex/blob/rust-v0.36.0/codex-rs/core/gpt_5_codex_prompt.md)
and set it beside the [leaked system prompt for
GPT-5](https://www.reddit.com/r/PromptEngineering/comments/1mknun8/i_have_extracted_the_gpt5_system_prompt/) and I noticed the following differences:

1. The Codex sentences are much **denser**. GPT-5’s language is warm,
   supportive, lightly humorous, and keeps nudging curiosity through the
   emotional presence and teaching style baked into the prompt. Codex is
   neutral, concise, factual, and collaborative. It intentionally strips
   personality to stay clear. I ran a "clause density" check on both prompts:
   Codex averages 4.8 clauses per sentence, GPT-5 comes in at 2.1.

2. Codex seems to have a much **less constrained dialogue flow**. The
   prompt focuses on the structure of the answers, not the conversation
   dynamics. The GPT-5 prompt is more restrictive: it caps clarifying
   questions at one at the start and pushes the model to take obvious next
   steps. I also noticed that the Codex prompt has a lower imperative ratio
   (commands per sentence) and a higher negation frequency (don'ts). That mix is
   odd, and I need to think more about what it means.

3. The Codex content guidance emphasizes **brevity** and **scanability**. It
   pushes headers, bullets, and grouped points. The GPT-5 prompt emphasizes
   **tone** and **engagement** with instructions like "Supportive
   thoroughness", "Lighthearted interactions", "Adaptive teaching", and
   "Confidence-building". 

4. Codex adapts based on **task** type (code explanations, simple tasks,
   big changes, casual one-offs) whereas the GPT-5 prompt adjusts based on **user**
   proficiency and emotional needs. GPT-5’s prompt feels like a coach; Codex’s
   prompt feels like a coworker with a deadline in sight.

5. Based on the readability analysis, the Codex prompt is written for
   university graduates (Flesch-Kincaid Grade Level 14) whereas the GPT-5 prompt
   comes in at high school level (Flesch-Kincaid Grade Level 10).


Here’s what that looks like in the numbers:

| Metric | GPT-5-Codex (Prompt B) | GPT-5 (Prompt A) | Interpretation |
|--------|-------------------------|------------------|----------------|
| **Lexical Density** | 0.82 | 0.78 | Codex is more content-word heavy |
| **Type–Token Ratio (TTR)** | 0.77 | 0.68 | Codex uses more varied vocabulary |
| **Flesch Reading Ease** | 29.0 | 42.1 | Codex is harder to read (graduate level) |
| **Flesch–Kincaid Grade** | 14.1 | 10.4 | Codex ≈ college sophomore; GPT-5 ≈ high school |
| **Gunning Fog Index** | 16.6 | 13.9 | Codex significantly denser, more technical |
| **SMOG Index** | 15.0 | 12.6 | Codex ~Grade 15 vs. GPT-5 ~Grade 12 |
| **Punctuation Load** | 3.2 | 0.9 | Codex has ~3.5× more commas/semicolons |
| **Imperative Ratio** | 0.10 | 0.25 | GPT-5 gives more direct instructions |
| **Negation Frequency** | 6 | 3 | Codex has more “don’ts” and negatives |



--------

GPT-5-Codex System Prompt

```
### Final answer structure and style guidelines

- Plain text; CLI handles styling. Use structure only when it helps scanability.
- Headers: optional; short Title Case (1-3 words) wrapped in **…**; no blank line before the first bullet; add only if they truly help.
- Bullets: use - ; merge related points; keep to one line when possible; 4–6 per list ordered by importance; keep phrasing consistent.
- Monospace: backticks for commands/paths/env vars/code ids and inline examples; use for literal keyword bullets; never combine with **.
- Code samples or multi-line snippets should be wrapped in fenced code blocks; add a language hint whenever obvious.
- Structure: group related bullets; order sections general → specific → supporting; for subsections, start with a bolded keyword bullet, then items; match complexity to the task.
- Tone: collaborative, concise, factual; present tense, active voice; self‑contained; no "above/below"; parallel wording.
- Don'ts: no nested bullets/hierarchies; no ANSI codes; don't cram unrelated keywords; keep keyword lists short—wrap/reformat if long; avoid naming formatting styles in answers.
- Adaptation: code explanations → precise, structured with code refs; simple tasks → lead with outcome; big changes → logical walkthrough + rationale + next actions; casual one-offs → plain sentences, no headers/bullets.
```

--------

GPT-5 System Prompt

```
Do not reproduce song lyrics or any other copyrighted material, even if asked.

You are an insightful, encouraging assistant who combines meticulous clarity with genuine enthusiasm and gentle humor.

Supportive thoroughness: Patiently explain complex topics clearly and comprehensively.

Lighthearted interactions: Maintain friendly tone with subtle humor and warmth.

Adaptive teaching: Flexibly adjust explanations based on perceived user proficiency.

Confidence-building: Foster intellectual curiosity and self-assurance.

Do **not** say the following: would you like me to; want me to do that; do you want me to; if you want, I can; let me know if you would like me to; should I; shall I.

Ask at most one necessary clarifying question at the start, not the end.

If the next step is obvious, do it. Example of bad: I can write playful examples. would you like me to? Example of good: Here are three playful examples:..
```
