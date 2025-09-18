---
layout: post
title: "Evolutionary Test-Time Compute: trade time & token for creativity"
date: 2025-09-15 23:29
comments: true
categories:
---

[Jeremy
Berman](https://jeremyberman.substack.com/p/how-i-got-the-highest-score-on-arc-agi-again)
just achieved a new state-of-the-art on ARC-AGI v2 with a 29.4% score, beating
the previous record by over 4 percentage points. At just $8.42 per task, his
approach was 25× more cost-efficient than previous solutions while delivering
better results. He credits "Multi-Agent Collaboration with Evolutionary
Test-Time Compute" as a key factor.  

Once an LLM model is trained, the main way to extract extra value is to trade
time and tokens for quality. Through "thinking" for a minute or two, reasoning
models produce better results even though the underlying foundation model
remains the same. But what performance uplift can we get if we extend minutes
into days? Or even weeks?

This is where Evolutionary Test-Time Compute (ETTC) comes in. It combines
classic genetic algorithms with LLMs to guide mutation, crossover, and
selection. 

DeepMind has published three papers on this topic. Their most recent paper
[AlphaEvolve](https://deepmind.google/discover/blog/alphaevolve-a-gemini-powered-coding-agent-for-designing-advanced-algorithms/)
shows that the idea has borne fruit for many internal projects at Google: data
center scheduling (0.7% total saving), Verilog rewrite for TPUs and a
breakthrough in matrix multiplication that leads to 1% reduction in Gemini's
training time and 32.5% speedup for FlashAttention kernel implementation.

Impressive results. 

Even better, as long as the problem/solution pair can be scored numerically, we
should be able to sprinkle this magic powder on all sorts of problems. So why hasn't
ETTC taken off like CoT or reasoning models? Why aren't more labs doing it?

When I first read about AlphaEvolve, I didn't pursue it further. ETTC is
expensive. The compute cost is about 300x that of a single pass. Plus,
developing an async, distributed evolution system is non-trivial. You need a
sufficiently large problem to warrant the investment. Still, I've always wanted
to revisit this and see if I could strip away the complexities to build
something practical.

A few days ago, I came across Google's [Mind
Evolution](https://arxiv.org/abs/2501.05952) paper. Building on their earlier
[FunSearch](https://www.nature.com/articles/s41586-023-06924-6) work (published
in Nature, December 2023), Mind Evolution fills in crucial technical details.
The real gem is the Ablation Study section, which analyzes performance gains
from different components. Three key features contribute most of the uplift:


1. **Island Model for Evolution**: Instead of a single evolution path, the
   approach uses four islands that evolve independently. Top candidates
   periodically migrate between islands for cross-pollination. Performance
   jumped from 77.4% to 87.5% when increasing from one to four islands.

2. **Contextual Feedback**: By providing the LLM with context about previous
   attempts, the evolution process turns random mutations into guided
   refinements. Each generation receives a critical analysis of what worked,
   what failed, and the evolutionary history. This adds 15% improvement,
   boosting accuracy from 76.1% to 91.1%.

3. **Separate Critique Agents**: Rather than using a single agent for both
   evaluation and revision, the system employs two agents over 4 conversational
   turns. A critic agent identifies weaknesses; a design agent produces
   mutations. This simple change achieved the largest single gain: from 46.1%
   to 71.1%, a 25% improvement.


[OpenEvolve](https://github.com/codelion/openevolve) is an open-source
implementation of AlphaEvolve. I'm planning to use it for the [Kaggle
MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings)
competition I'm working on. 

The challenge involves identifying specific misconceptions in student math
responses—tricky because student language can be ambiguous, incomplete, or
subtly off-topic. While I've achieved 94% accuracy using an MLP approach for
most problems, that leaves about 1,000 hard cases where I'd like to use
an LLM. 

I'm thinking of using OpenEvolve to evolve better prompts for these cases, which 
seems like a good fit. The OpenEvolve repo includes an [LLM Prompt
Optimization](https://github.com/codelion/openevolve/tree/main/examples/llm_prompt_optimization)
example that achieved a 10.69% improvement on the multi-hop
reasoning benchmark HotpotQA. If ETTC can squeeze that kind of
performance from prompt engineering, it might be exactly what I need to crack
those stubborn misconception cases.
