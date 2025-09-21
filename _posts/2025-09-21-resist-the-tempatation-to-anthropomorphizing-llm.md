---
layout: post
title: "Resist the tempatation to anthropomorphizing LLM"
date: 2025-09-21 20:33
comments: true
categories: 
---

[Chollet](https://fchollet.substack.com/p/how-i-think-about-llm-prompt-engineering) 
writes a great piece on why we even need prompt engineering and what's the right 
mental model to have when we write prompts. 

Instead of thinking of LLMs as intelligent agents that understand our intent,
we should think of them as massive databases of programs, and our prompts are
just keys to look up those programs.  (Emphasis mine.)

> There are thousands of variations you could have used, each resulting in a
> similar-yet-slightly-different program. And that’s why prompt engineering is
> needed. There is no a-priori reason why your first, naive program key would
> result in the optimal program for the task. The LLM is not going to
> “understand” what you meant and then perform it in the best possible way —
> it’s merely going to fetch the program that your prompt points to, among many
> possible locations you could have landed on.
> 
> **Prompt engineering is the process of searching through program space to find
> the program that empirically seems to perform best on your target task.** It's
> no different than trying different keywords when doing a Google search for a
> piece of software.
> 
> If LLMs actually understood what you told them, there would be no need for
> this search process, since the amount of information conveyed about your
> target task does not change whether your prompt uses the word “rewrite”
> instead “rephrase”, or whether you prefix your prompt with “think steps by
> steps”. Never assume that the LLM “gets it” the first time — keep in mind
> that your prompt is but an address in an infinite ocean of programs, all
> captured as a by-product of organizing tokens into a vector space via an
> autoregressive optimization objective.
> 
> As always, the most important principle for understanding LLMs is that you
> should resist the temptation of anthropomorphizing them.
