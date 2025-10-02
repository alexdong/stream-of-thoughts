, -
layout: post
title: "Agentic Loop Design - Tool #1: Long-Term Memory that Survives Resets"
date: 2025-10-03 19:20
comments: true
categories: 
- agentic
- software-design
, -

When a session drags on and the context window fills up, I often watch the
models start to get lazy. They drop earlier decisions, skim the edges, and
sometimes declare "all tests are passing" after touching only part of the
suite.

Both Codex and Claude Code ship a `/compact` command that compresses,
summarizes, and trims conversation history to make room for new messages. In
practice, the compaction drops enough detail that I reach for it less and less.

We need a way to reset the conversation without losing the continuity of the
work. We need a tool that lets us restart often and still remember what we were
doing and where we left off. There have been many attempts at "Context
Compression," but none have worked well enough yet.

That tool is a plaintext `PLAN.md`. As the model cycles through the
design-plan-implement loop, it appends and updates this file, then re-reads it
at the start of every new session.

Here's the scaffold I use.


```markdown
## What and Why
<!,  define the what, why, scope , >

## Observation
<!,  facts only from Observation. Research. Note down relevant facts. , >

## Design
<!,  chosen shapes & interfaces; proposed options when there are real trade-offs , >

## Plan
<!,  five-minute tasks with [ ] checkboxes and nested numbering , >
```

Running the loop means cycling through four passes. After each pass I ask the
model to capture the discussion, note the details, and record the conclusions
in PLAN.md, then spin up a fresh session. The file becomes the single source of
truth the agent must consult before touching anything.

Here are the prompts I use for each phase.

## What and Why

I start by anchoring the change in plain language so the model and I share the
same target and boundaries.

```
Task: Refresh the "## What and Why" section in ./plans/PLAN-{slug}.md for "{brief change name}".

Steps:
1. Describe the change in 1–2 sentences.
1. Clarify why it matters now.
2. Capture scope boundaries: what is in/out, success measures.
3. List open questions that block commitment; ask me for any missing context.

Guardrails:
- No solution or implementation steps.
- Write in tight paragraphs or focused bullet points.
- Stop after the Why section is updated.
```

## Observation

Once the intent is locked, the next pass is a fact-finding sweep. No edits, no plans.

```
Task: Compile the Observation section for the changes described in `## What and Why`.

Read ./plans/PLAN-{slug}.md first, then browse, research, and note down facts.

Deliverable:
- Append under "## Observation".
- One bullet per relevant file, symbol, or endpoint: location + behavior in 1–2 sentences.
- Close with "Risks & brittle spots" listing edge cases or debt (facts only).

Scope to inspect:
- Code/config touching the affected data or control paths.
- Schemas/migrations, jobs, CLIs, scripts, docs, and tests relying on current behavior.
- External integrations, rate limits, feature flags, and environment switches.

Guardrails:
- Mark uncertain items with "?" rather than omitting them.
- Do not edit code or propose changes.
- Stop after Observation is complete.
- Be thorough and methodical. Go through the files one by one.
```

## Design

With the facts in place, we move into the design phase and ask for options,
trade-off analysis, and key code snippets.

```
Task: Draft the Design section for "What" using the "Observation" in ./plans/PLAN-{slug}.md.

Deliverable:
- Append under "## Design" in PLAN-{slug}.md.
- Describe chosen data flows, interfaces, and storage, naming concrete functions/types.
- When trade-offs exist, list 2–3 options with crisp pros/cons before recommending one.
- End with "Implications for tests" describing what must be covered.
- Include just enough code snippets to show the high-level design.

Guardrails:
- Ground every decision in Observation facts or clearly stated assumptions.
- No implementation details below the interface level.
- Stop after Design is complete.
```

## Plan

The design turns into an execution checklist: small, verifiable moves that keep
the loop tight.

```
Task: Translate the Design for "{brief change name}" into an execution plan.

Deliverable:
- Append under "## Plan" in PLAN-{slug}.md with checkbox tasks.
- Keep tasks to five-minute chunks; nest numbered substeps if needed.
- Include "Tests (fit)" for each task describing what must be verified before coding.

Order of operations:
1. Types/constants and contracts.
2. Write/update data producers.
3. Read paths/consumers.
4. Data migrations/backfills.
5. Clean-up and docs.

Guardrails:
- Highlight removals/renames and search/replace surfaces explicitly.
- Stop after the Plan section is written.
```

## Implement

Implementation finally pulls a single checkbox off the plan and runs it to
completion before coming up for air.

```
We are now implementing the tasks from the PLAN-{slug}.md file.

Execute the following tasks in order.
> {paste the exact checkbox line}

Execution rules:
- Begin with the task's Tests, write or adjust checks first.
- Make the smallest code changes needed to satisfy those tests.
- Run the standard project checks (`make lint`, `make test`) and report results.
- If anything fails, even outside touched areas, resolve it before stopping.
- Review the changes and rewrite the code changes to improve clarity or efficiency.
- Keep rewriting until no further improvements are possible.
- Check off the task only when all tests pass and the code is clean.
- Do not pull another task once this one closes.
```

This rhythm, write, compact, reset, load from PLAN.md, keeps the agent
sharp even on long-running task. Each task gets to benefit from the 
full context window, and the model never has to guess what it was doing
last time.
