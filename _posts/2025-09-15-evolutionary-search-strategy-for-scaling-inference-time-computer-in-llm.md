---
layout: post
title: "LLM-driven Evolutionary Search to squeeze even more value out of Test-Time Compute"
date: 2025-09-15 23:29
comments: true
categories: 
---

One interesting trend in LLM is the two parallel tracks most of the big labs take. One track is to build bigger models. Roughly speaking, every 7 months, there is a new breed of models that push the perato frontier forward. THis is big boys playing big toys. 

The other track is where people tries to squeeze as much juice out of the existing models. This is where CoT, reasoning models and, lately, evolutionary search come in. They are more or less asking the same question: what can we achieve by trading response time/token count? CoT and reasoning models "thinking" for a minute or two and produces a better result. But what if you can "explore" for days or weeks? This is where evolutionary search comes in.

Evolutionary search takes the good-old genetic algorithm and use LLM to decide on mutation, cross-over and selection. Of all the labs, DeepMind is clearly the leader in this area. Their first paper on Nature [FunSearch(2023]](https://deepmind.google/discover/blog/funsearch-making-new-discoveries-in-mathematical-sciences-using-large-language-models/) talks in details about the "island" model they settle down on. Their most recent paper [Alpha Evolve](https://deepmind.google/discover/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/) shows that the same system has been applied to a much wider areas within google: data center scheduling (0.7% total saving at Google's scale), Verilog rewrite for TPUs and a break-through in matrix multiplication that leads to 1% reduction in Gemini's training time and 32.5% speedup for FlaskAttention kernel implementation.

Very impressive stuff. 

What's even better is that as long as the problem/solution pair can be scored, we can just spread this magic powder over the problems and get an impressive results out of it. So why aren't more labs doing it? And more importantly, how can a sole practitioner like me leverage this?

When I looked into this carefully back in May 2025, my conclusion was that the approach is way too expensive to be practical. Compare to a single-pass, the compute cost required to get a good evolutionary process going is about 300x. This is way too expensive for any practical use case. Further, the complexity to develop an async, distributed tracking is just too much work. But back in my mind, I've always wanted to come back and see if I can peel off some of the complexity and see if I can get a reasonable ROI out of it.

Last week, I came across a January 2025 paper from Google on [Mind Evolution](https://arxiv.org/abs/2501.05952). The gem is the Ablation Study section that breaks down the performance gain across many different components.  It turns out that with only three components, we can gain pretty much all uplifts. These three components are:

1. The island model for evolution. Instead of running a single evolution path, the system maintains four parallel "islands" that evolve solutions independently, periodically sharing their best candidates via a "swim over" event. Performance jumped from 77.4% to 87.5% when moving from one to four islands (while maintinaing the same number of total generations) — a 10.1 percentage point gain. 

2. Contextual feedback. Basically giving LLM enough context about what works and a history, it changes the evolution process from random mutation to guided refinement. After each generation, a "review" model produces a reflection — essentially a critical analysis of what worked and what failed. This feedback gets feed into the "evolutionary designer agent" as part of the next generation's context, creating what amounts to a working memory across iterations. This step adds 15 percentage points improvement, from 76.1% to 91.1%. 

3. Critique through role separation. Rather than having a single agent both evaluate and revise (which often leads to confirmation bias), the design assigns these tasks to different agents. One agent acts purely as a critic, identifying weaknesses and gaps. A separate agent then takes this critique and produces a revised solution. The system achieved its largest single gain: from 46.1% to 71.1%, a 25 percentage point improvement. 

I'm looking forward to implementing this for the [Kaggle MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings) competition tosee if I can replace the manual prompt engineering with an evolutionary search.
