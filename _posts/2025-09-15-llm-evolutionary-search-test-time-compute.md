---
layout: post
title: "LLM-driven Evolutionary Search to squeeze even more value out of Test-Time Compute"
date: 2025-09-15 23:29
comments: true
categories: 
---

Once a LLM model is trained, the main way to squeeze extra juice out of an
existing model is to trade time & token for quality. Through "thinking" for a
minute or two, Reasoning models produce better results even though the
underlying foundation model remains the same. So what performance uplift can we
get if we extend minutes into days? Or even weeks? 

This is where evolutionary search comes in. Evolutionary search takes good
old genetic algorithms and uses LLMs to decide on mutation, crossover and
selection. DeepMind is the clear leader in this area. Their most recent paper
[AlphaEvolve](https://deepmind.google/discover/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/)
shows that the idea has borne fruit for many internal projects: data
center scheduling (0.7% total saving), Verilog rewrite for TPUs and a
breakthrough in matrix multiplication that leads to 1% reduction in Gemini's
training time and 32.5% speedup for FlashAttention kernel implementation.

Very impressive stuff. 

Even better, as long as the problem/solution pair can be scored numerically, we
should be able to just sprinkle this magic powder over all sorts of problems
and expect impressive results. Then why hasn't Evolutionary Search taken off
like CoT or Reasoning models?  Why aren't more labs doing it? 

My conclusion back in May was that this approach is way too expensive. The
compute cost required to have a fair go is about 300x of what a single
pass would cost. Also, the complexity of developing an async, distributed
evolution system seems non-trivial. You really need a big problem to warrant
the cost and effort to bring in the big guns.  In the back of my mind though, I've
always wanted to come back and see if I could peel off some of the complexities
and get a working system without sinking too much time in it.

Last week, I came across a January 2025 paper from Google on [Mind
Evolution](https://arxiv.org/abs/2501.05952). The gem is the Ablation Study
section where the authors analysed the performance gains from different
components. It turns out that three key "features" contribute to most of the
uplift.

They are:

1. Adopt the Island Model for Evolution. Instead of running a single evolution
   path, their approach constructs four islands that evolve independently. The
   best candidates from each island will periodically swim over to other
   islands as a cross pollination. The performance jumped from 77.4% to 87.5%
   when increasing the island count from one to four (while controlling
   the total number of generations) — a 10.1% gain. 

2. Contextual feedback. By giving the LLM enough context about previous
   attempts, the evolution process changed from random mutations to guided
   refinements. After each generation, a critical analysis of what worked, what
   failed and the evolutionary history gets added to the next generation's
   context. This step introduces a further 15% improvement, taking the accuracy
   from 76.1% to 91.1%. 

3. Critique through separate agents. Rather than tasking a single agent with
   both evaluation and revision tasks, the system uses two separate agents to
   produce the mutations over 5 turns of conversations. A critic agent focuses
   on identifying weaknesses and gaps; a design agent then takes the feedback
   and produces a revised mutation. This seemingly simple step achieved the
   system's largest single gain: from 46.1% to 71.1%, a 25 percentage point
   improvement. 

Intrigued? I certainly am. I'm looking forward to implementing this and see if
it can help me with writing better prompts for the [Kaggle
MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings)
competition I'm working on. 
