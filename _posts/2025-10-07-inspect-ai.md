---
layout: post
title: "Inspect AI"
date: 2025-10-07 21:24
comments: true
categories: 
- eval
---

[Joe](https://x.com/joecole) mentioned the new [Petri Alignment
tool](https://safety-research.github.io/petri/) from Anthropic. As I read
through the GitHub repo, I was surprised to find how simple the code is. As I
dug deeper, I realized it's actually a plugin for Inspect AI, an open-source
Python project by the UK's AI Security Institute.

Inspect AI provides scaffolding for evaluating LLMs. I was pleasantly
surprised to see just how many advanced features are already in place:

- Execution: [provider caching](https://inspect.aisi.org.uk/caching.html),
  [parallelism for multiple models, benchmarks, or
  requests](https://inspect.aisi.org.uk/parallelism.html), and
  [sandboxing across Docker, EC2, or
  Proxmox](https://inspect.aisi.org.uk/sandboxing.html)
- Debugging: [tracing](https://inspect.aisi.org.uk/tracing.html) and tidy [log
  viewers](https://inspect.aisi.org.uk/log-viewer.html)
- Output: built-in [Pydantic structured
  validation](https://inspect.aisi.org.uk/structured.html) and [typed store](https://inspect.aisi.org.uk/typing.html)

All I need to supply are three ingredients:

1. [Datasets](https://inspect.aisi.org.uk/datasets.html) — CSV files with
   `id`, `input`, and `target` columns.
2. [Solvers](https://inspect.aisi.org.uk/reference/inspect_ai.solver.html#generation)
   — chains of Python functions that take the input and produce the model's
   output.
3. [Scorers](https://inspect.aisi.org.uk/reference/inspect_ai.scorer.html) —
   metrics that turn those outputs into scores. Regular expressions, F1,
   statistics like `std` or `stderr`, and even LLM-as-Judge are ready to go.

The tool is well documented, strongly typed, and actively maintained. Next up I
want to use it to rewrite some of the benchmarks end-to-end and see how easily I can
extend it to support more complex evaluation workflows.
