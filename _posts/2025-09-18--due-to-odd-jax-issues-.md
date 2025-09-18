---
layout: post
title: "Due to odd jax issues"
date: 2025-09-18 21:34
comments: true
categories: 
---

Anthropic published a [blog
post](https://www.anthropic.com/engineering/a-postmortem-of-three-recent-issues)
detailing three recent issues that affected a significant portion of their API users.
This technical postmortem gives rare insight into the challenges of running
large-scale AI services, and I appreciate their openness in sharing
this information. However, what I saw in the post raised concerns about the engineering
rigor at Anthropic.

Particularly the following code snippet:

![December 2024 patching jax's dropping token bug issue](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fefee0d3d25f6b03cbfc57e70e0e364dcd8b82fe0-2000x500.png&w=2048&q=75)

What a crude and blunt way to patch a bug in a third-party library!

After eight months, the team deployed a rewrite to address the root cause that
causes this patch,  which unfortunately led to a deeper bug that had been
masked by the temporary patch. 

This cascade of issues reveals both the absence of robust testing
infrastructure and inadequate post-deployment quality monitoring. While they
did mention implementing more sensitive evaluations and expanding quality
checks, it reads like a car manufacturer promising to watch for accidents
more carefully in the future.

I've been a paying customer for their 20x Max membership since the program
launched. While I appreciate the openness of the postmortem, I'm not convinced
that all issues have been resolved. In fact, I received several disappointing
responses from Claude Code today that made me question my subscription.

Starting tomorrow, I'm switching to GPT-5-Codex as my main coding AI, based on
strong recommendations from engineers I trust. Time to see if the grass really is
greener on the other side. 
