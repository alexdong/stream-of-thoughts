---
layout: post
title: "Due to odd JAX issues"
date: 2025-09-18 21:34
comments: true
categories: 
---

Anthropic published a [blog
post](https://www.anthropic.com/engineering/a-postmortem-of-three-recent-issues)
detailing three recent issues that affected a significant portion of their API users.
This technical postmortem provides rare insight into the challenges of running
large-scale AI services, and I appreciate their transparency. However, the details
raised serious concerns about Anthropic's engineering rigor.

Consider this code snippet from their postmortem:

![December 2024 patching jax's dropping token bug issue](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fefee0d3d25f6b03cbfc57e70e0e364dcd8b82fe0-2000x500.png&w=2048&q=75)

What a crude way to patch a third-party library bug!

After eight months, the team deployed a rewrite to address the root cause that
necessitated this patch, which unfortunately exposed a deeper bug that had been
masked by the temporary fix. 

This cascade of failures reveals both inadequate testing infrastructure and
insufficient post-deployment monitoring. They mention implementing more
sensitive evaluations and expanding quality checks, but this reads like a car
manufacturer promising to watch for accidents more carefully.

I've been a paying 20x Max member since the program
launched. Despite the postmortem's openness, I'm not convinced
these issues have been resolved. In fact, I received several disappointing
responses from Claude Code today that made me question my subscription.

Starting tomorrow, I'm switching to GPT-5-Codex as my main coding assistant, based on
strong recommendations from engineers I trust. Time to see if the grass really is
greener on the other side. 
