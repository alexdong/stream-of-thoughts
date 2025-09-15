---
layout: post
title: "LLM-driven Evolutionary Search to squeeze even more value out of Test-Time Compute"
date: 2025-09-15 23:29
comments: true
categories: 
---

One interesting trend in LLMs is the two parallel tracks most of the big labs take. One track is to build bigger models. Roughly speaking, every 7 months, there is a new breed of models that push the Pareto frontier forward. This is big boys playing with big toys. 

The other track is where people try to squeeze as much juice out of existing models. This is where CoT, reasoning models and, lately, evolutionary search come in. They are more or less asking the same question: what can we achieve by trading response time for quality? CoT and reasoning models "think" for a minute or two and produce better results. But what if you could "explore" for days or weeks? This is where evolutionary search comes in.

Evolutionary search takes the good old genetic algorithm and uses LLMs to decide on mutation, crossover and selection. Of all the labs, DeepMind is clearly the leader in this area. Their first paper in Nature [FunSearch (2023)](https://deepmind.google/discover/blog/funsearch-making-new-discoveries-in-mathematical-sciences-using-large-language-models/) talks in detail about the "island" model they settled on. Their most recent paper [AlphaEvolve](https://deepmind.google/discover/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/) shows that the same system has been applied to much wider areas within Google: data center scheduling (0.7% total saving at Google's scale), Verilog rewrite for TPUs and a breakthrough in matrix multiplication that leads to 1% reduction in Gemini's training time and 32.5% speedup for FlashAttention kernel implementation.

Very impressive stuff. 

What's even better is that as long as the problem/solution pair can be scored, we can just sprinkle this magic powder over the problems and get impressive results out of it. So why aren't more labs doing it? And more importantly, how can a solo practitioner like me leverage this?

When I looked into this carefully back in May 2024, my conclusion was that the approach is way too expensive to be practical. Compared to a single pass, the compute cost required to get a good evolutionary process going is about 300x. This is way too expensive for any practical use case. Furthermore, the complexity of developing async, distributed tracking is just too much work. But in the back of my mind, I've always wanted to come back and see if I could peel off some of the complexity and get a reasonable ROI out of it.

Last week, I came across a January 2025 paper from Google on [Mind Evolution](https://arxiv.org/abs/2501.05952). The gem is the Ablation Study section that breaks down the performance gains across many different components. It turns out that with only three components, we can capture pretty much all the uplift. These three components are:

1. The island model for evolution. Instead of running a single evolution path, the system maintains four parallel "islands" that evolve solutions independently, periodically sharing their best candidates via a "swim over" event. Performance jumped from 77.4% to 87.5% when moving from one to four islands (while maintaining the same number of total generations) — a 10.1 percentage point gain. 

2. Contextual feedback. By giving the LLM enough context about what works and a history, it changes the evolution process from random mutation to guided refinement. After each generation, a "review" model produces a reflection — essentially a critical analysis of what worked and what failed. This feedback gets fed into the "evolutionary designer agent" as part of the next generation's context, creating what amounts to a working memory across iterations. This step adds a 15 percentage point improvement, from 76.1% to 91.1%. 

3. Critique through role separation. Rather than having a single agent both evaluate and revise (which often leads to confirmation bias), the design assigns these tasks to different agents. One agent acts purely as a critic, identifying weaknesses and gaps. A separate agent then takes this critique and produces a revised solution. This achieved the system's largest single gain: from 46.1% to 71.1%, a 25 percentage point improvement. 

I'm looking forward to implementing this for the [Kaggle MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings) competition to see if I can replace manual prompt engineering with evolutionary search.
