---
layout: post
title: "Codex knows Python"
date: 2025-09-28 21:07
comments: true
categories: 
- python
- open-ai
---

I have been using [Codex instead of Claude Code](/due-to-odd-jax-issues.html)
for over a week now. One nice surprise is how ubiquitously Python is used
as a sidekick, a common scripting language to build task-specific tools.

Here are two examples where, instead of reaching for pre-built MCP servers,
Codex creates its own tools by writing purpose-built Python scripts.

## Example 1: What are the types of a Python package

Many Python packages don't have type annotations. If I want to know how to call
a function in a package, I either try to find the answer in the documentation
or read the source code. Below is a Codex-generated script that does this
without me asking. It first installs the package in the system temporary
directory, then uses `inspect` to extract type information from a package.
Codex then picks up the output from the script to answer my question.

```bash
pip install openevolve --target /tmp/openevolve

PYTHONPATH=/tmp/openevolve python - <<'PY'
import inspect
from openevolve import OpenEvolve

print(OpenEvolve)
print(OpenEvolve.run)
print(inspect.getsource(OpenEvolve.run))
PY
```

## Example 2: Quick-and-dirty docs link lister

I asked Codex to find all links on the topic of "Batch Processing" in Modal's
docs. Instead of using a web search tool, Codex wrote a quick Python script to
scrape the links from `https://modal.com/docs` and then use regular expressions
to find the topics I was looking for.


```python
#!/usr/bin/env python3
"""Quick-and-dirty Modal docs link lister."""

from __future__ import annotations

import re
import ssl
import urllib.request


def fetch_text(url: str) -> str:
  """Download a page as text, skipping certificate checks for convenience."""
  ssl._create_default_https_context = ssl._create_unverified_context  # nosec - CLI helper
  with urllib.request.urlopen(url) as resp:  # noqa: S310 (urllib ok for one-off script)
      return resp.read().decode("utf-8")


def list_docs(pattern: str, text: str) -> list[str]:
  """Extract unique documentation links matching `pattern`."""
  matches = re.findall(pattern, text)
  return sorted(set(matches))


if __name__ == "__main__":
  base = "https://modal.com"
  docs_root = f"{base}/docs"

  # Fetch the main docs page and pull out top-level /docs/... links.
  root_html = fetch_text(docs_root)
  top_links = list_docs(r'href="(/docs/[^"]+)"', root_html)
  print("Top-level docs links:")
  for href in top_links:
      print(f"  {base}{href}")

  # Drill into the Guide section to enumerate guide topics.
  guide_html = fetch_text(f"{docs_root}/guide")
  guide_links = list_docs(r'href="(/docs/guide/[^"]+)"', guide_html)
  print("\nGuide topics:")
  for href in guide_links:
      print(f"  {base}{href}")

  # Example: fetch the CLI reference page and show any code snippets.
  cli_app_html = fetch_text(f"{docs_root}/reference/cli/app")
  code_snippets = re.findall(r'<code class="[^"]*">(modal [^<]+)</code>', cli_app_html)
  print("\nCLI `modal app` snippets:")
  for snippet in sorted(set(code_snippets)):
      print(f"  {snippet}")
```

Groundbreaking? Not really. But it does point to a potential future where LLMs
increasingly build its own deterministic tools to augment its capabilities and
interact with the physical world. Our job as a hybrid human-AI team is to
provide the right abstractions, libraries or even SDKs that LLM can use to
build its own tools. 

Maybe in the not so far future, instead of [Software Tools
Engineer](https://www.citadelsecurities.com/careers/details/software-developer-tools-engineer)
who builds software for other humans, we'll have a new position called
`AI Tools Engineer` who builds libraries mainly for LLMs.
