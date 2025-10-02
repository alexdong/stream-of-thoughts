---
layout: post
title: "Agentic Loop Design"
date: 2025-10-01 22:28
comments: true
categories: 
- software-design
- agentic
---

Even if you have defined the [problem, solution, or implementation](/mental-models-for-ai-along-the-ambiguous-ladder.html) clearly, you might still struggle to get AI to deliver what you want. This is a common challenge I face when working with AI systems. 

[Simon Willison's recent post on Agentic Loop Design](https://simonwillison.net/2025/Sep/30/designing-agentic-loops/) gave us a useful framework for thinking about how we can engineer past this obstacle. The core idea is similar to [Evolutionary Test-Time Compute](/llm-evolutionary-test-time-compute.html), both trade time and tokens for quality.

Simon puts it this way:

> As is so often the case with modern AI, there is a great deal of depth involved in unlocking the full potential of these new tools.
> 
> A critical new skill to develop is designing agentic loops.
> 
> One way to think about coding agents is that they are brute force tools for finding solutions to coding problems. If you can reduce your problem to a clear goal and a set of tools that can iterate towards that goal a coding agent can often brute force its way to an effective solution.
 
The key is treating this as an iterative process. Instead of expecting the right answer on the first try, you design loops where the AI refines its approach through multiple attempts.

Over the next few days, I'll share some useful tools/ideas I'm using daily to ground the AI in reality, avoid context poisoning, and improve the overall quality of its outputs.