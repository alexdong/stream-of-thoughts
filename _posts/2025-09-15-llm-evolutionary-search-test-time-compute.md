---
layout: post
title: "LLM-driven Evolutionary Search to squeeze even more value out of Test-Time Compute"
date: 2025-09-15 23:29
comments: true
categories: 
---

Once a LLM model is trained, the main way to squeeze extra juice out of an existing models is to trade time & token for quality. By "thinking" for a minute or two, CoT and reasoning models get to produce better results even though the underlying model remains the same. So what performance uplift can we get if we extend minutes into days or weeks? 

This is where evolutionary search comes in. Evolutionary search takes the good old genetic algorithm and uses LLMs to decide on mutation, crossover and selection. DeepMind is the clear leader in this area. Their most recent paper [AlphaEvolve](https://deepmind.google/discover/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/) shows that the idea has born fruits for many projects within Google: data center scheduling (0.7% total saving), Verilog rewrite for TPUs and a breakthrough in matrix multiplication that leads to 1% reduction in Gemini's training time and 32.5% speedup for FlashAttention kernel implementation.

Very impressive stuff. 

As long as the problem/solution pair can be scored, we should be able to just sprinkle this magic powder over all sorts of problems and get impressive results, right? Why it has taken off like CoT or Reasoning models?  Why aren't more labs doing it? 

My conclusion back in May was that this approach is way too expensive. The compute cost required to get a good process going is about 300x what a single pass would cost. Also, the complexity of developing an async, distributed evolution system seems non-trivial. Basically, you need a big problem to worth bringing on the big gun. In the back of my mind, I've always wanted to come back and see if I could peel off some of the complexities and get a working system without sinking too much time in it.

Last week, I came across a January 2025 paper from Google on [Mind Evolution](https://arxiv.org/abs/2501.05952). The gem is the Ablation Study section that analyses the performance gains across different components. It turns out that with only three key components, we can capture most of the uplift. These three components are:

1. Adopt the Island Model for evolution. Instead of running a single evolution path, the system maintains four parallel "islands" that evolve solutions independently. Best candidates will periodically swim over to other islands to cross pollinate. Performance jumped from 77.4% to 87.5% when moving from one to four islands (while maintaining the same number of total generations) — a 10.1% gain. 

2. Contextual feedback. By giving the LLM enough context about what works and a history, it changes the evolution process from random mutation to guided refinement. After each generation, a critical analysis of what worked, what failed and evolution history get added to the next generation's context. This step adds a 15% improvement, from 76.1% to 91.1%. 

3. Critique through role separation. Rather than having a single agent both evaluate and revise, the system uses two separated agents to produce the mutations over a handful turns of conversations. The critic agent identifying weaknesses and gaps; the design agent then takes this critique and produces a revised mutation. This seemingly simple step achieved the system's largest single gain: from 46.1% to 71.1%, a 25 percentage point improvement. 

Intrigued? I certainly am. I'm looking forward to implementing this and see if it can help me with prompt engineering for the [Kaggle MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings) competition I'm working on. 
