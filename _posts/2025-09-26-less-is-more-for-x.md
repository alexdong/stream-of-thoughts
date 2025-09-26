---
layout: post
title: "Less is More for X"
date: 2025-09-26 22:58
comments: true
categories: 
- ai-training
---

[Joe](https://x.com/joecole) turned me onto a series of papers by [Pengfei
Liu](https://scholar.google.com/citations?hl=en&user=oIz_CYEAAAAJ&view_op=list_works&sortby=pubdate)
that challenge the conventional wisdom that "more data is always better" for
post-training LLMs. 

Collectively, these papers show that for
[RL](https://arxiv.org/pdf/2502.11886),
[Reasoning](https://arxiv.org/pdf/2502.03387) and
[Agentic](https://arxiv.org/pdf/2509.17567) tasks, a smaller yet higher-quality
training dataset can outperform similar-scale ones, like OpenAI-o1-preview. For
example, in the case of Reasoning, using only 1% of the training data yields
a 45.8% absolute improvement on math and programming tasks. I thought it was
worth sharing a few details from the reasoning paper. 

On the hypothesis:

> We hypothesize that successful reasoning emerges from the synergy of rich
> pre-trained knowledge and sufficient computational resources at inference
> time. These developments suggest that if models possess rich reasoning
> knowledge and adequate computational space, activating their reasoning
> capabilities may require only a small number of high-quality samples that
> encourage extended deliberation, rather than massive fine-tuning datasets. We
> propose the Less-Is-More Reasoning (LIMO) Hypothesis, identifying two
> critical factors determining the elicitation threshold for complex reasoning:
> (1) the latent presence of prerequisite knowledge within the model’s
> parameters, and (2) the effectiveness of minimal exemplars in demonstrating
> problem-solving processes that encourage extended deliberation. The sample
> efficiency of eliciting advanced reasoning is thus bounded by the model’s
> encoded knowledge foundation and its exposure to training samples that
> effectively utilize inference-time computation space.

When they describe how they constructed the smaller, higher-quality dataset,
they emphasize that the "higher quality" label refers to the most difficult
problems. Rather than gradually increasing difficulty as in
[Curriculum Learning](https://en.wikipedia.org/wiki/Curriculum_learning), they
focus on that challenging tail. 

> We implemented a systematic multi-stage filtration pipeline ... we first
> applied a baseline difficulty filter using a short-CoT mathematical model.
> Problems that this model solved correctly within four attempts were excluded,
> ensuring that only non-trivial problems remained. Next, we sampled 32
> solution attempts and used the empirical success rate as a difficulty
> indicator. Problems that were successfully solved in only 1–3 out of 32
> attempts were retained. 

After refining the dataset this way, they constructed the training trace with
larger reasoning models and a set of heuristics:

> Elaborated Reasoning: Comprehensive exploration of logical steps without
> premature conclusions 
>
> Self-Verification: Regular validation of intermediate results and logical
> consistency 
>
> Exploratory Approach: Consideration of multiple possibilities before reaching
> conclusions 
>
> Adaptive Granularity: Appropriate detail level across simple and complex
> deductions 
>
> To quantify these qualities, we implemented a rule-based scoring system that
> calculated weighted metrics for each dimension. Elaborated Reasoning was
> measured by solution length (30% weight); Self-Verification through frequency
> of validation-related words like "check" and "verify" (20% weight);
> Exploratory Approach by counting tentative expressions such as "perhaps" and
> "might" (25% weight); and Adaptive Granularity via connective phrases like
> "therefore" and "since" (25% weight). All keyword frequencies were normalized
> by text length to ensure fair comparison across solutions of different sizes.

Taken together, the results are quite impressive. Still, the more I think about
it, the more I feel that this process of curating a smaller, higher-quality
dataset is essentially a manual distillation process that transfers the
capability from larger reasoning models to smaller ones. Because none of the
papers include an ablation study, it's unclear to me how much of the improvement
is due to the curated dataset vs. the fact that the larger models are used to
generate the training trace.
