---
layout: post
title: "Make sense of \"Codex produces 13x Merged PR than Claude Code\""
date: 2025-10-02 21:51
comments: true
categories: 
- open-ai
- anthropic
---

I just saw these numbers in [Simon Willison's write-up](https://simonwillison.net/2025/Oct/1/prarena/):

| Tool           | Search term                                        | Total PRs | Merged PRs | % Merged |
|----------------|-----------------------------------------------------|-----------|------------|----------|
| Claude Code    | is:pr in:body "Generated with Claude Code"          | 146,000   | 123,000    | 84.2%    |
| GitHub Copilot | is:pr author:copilot-swe-agent[bot]                 | 247,000   | 152,000    | 61.5%    |
| Codex Cloud    | is:pr in:body "chatgpt.com" label:codex             | 1,900,000 | 1,600,000  | 84.2%    |

I [switched from Claude Code to Codex](https://alexdong.com/due-to-odd-jax-issues.html) two weeks ago. I do prefer Codex, but seeing it claim 13x more merged PRs than Claude still made me pause.

Before reading that as a productivity verdict, it's worth sanity-checking the size of each user base. ChatGPT reportedly has 700M weekly users, while Claude draws about 12M ([ZDNet](https://www.zdnet.com/article/how-people-actually-use-chatgpt-vs-claude-and-what-the-differences-tell-us/)). Coding is the top use case for Claude at 36%, whereas ChatGPT sits near 4% ([decision.substack.com](https://decision.substack.com/p/how-does-the-world-use-chatgpt-and)).

If we use those ratios as a rough proxy, Claude ends up with roughly 3.4M weekly coding users (12M * 36%) and Codex lands closer to 28M (700M * 4%). That would mean Codex has about eight times as many developers creating PRs using it. Even after accounting for that, Codex users would still appear to produce about 60% more Merged PRs than Claude users (13x vs. 8x).

This is the first cross-service metric I've seen that hints at Codex users shipping more merged PRs than Claude. Whether that's down to product quality, distribution, or different usage patterns is still an open question. But it's a striking data point either way.
