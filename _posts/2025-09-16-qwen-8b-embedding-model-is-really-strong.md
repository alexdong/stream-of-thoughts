---
layout: post
title: "Qwen-8B Embeddings: Near-SOTA Performance at 600x the Speed"
date: 2025-09-16 22:06
comments: true
categories:
---

TLDR: The Qwen-8B embedding model delivers near state-of-the-art performance on text
classification tasks while running 600x faster than LLM-based approaches.

For the [Kaggle
MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings)
competition I'm working on, I've had a chance to try out different embedding
models for text classification tasks.

The setup is pretty simple. A sentence comes in. I'll use an embedding model to
encode it into a vector, which is then fed into a 3-layer MLP classifier.

I started with
[`sentence-transformers/all-MiniLM-L6-v2`](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2),
a 22.7M parameter model. It was easy to put together (thanks to the
`sentence-transformers` Python package) and I got a proof of concept working in
a few hours. After some Optuna hyperparameter search, the system plateaued at
around 0.908 MAP score. A respectable result but not competitive enough for the
Kaggle leaderboard.

Two weeks ago, DeepMind released
[embedding-Gemma-300M](https://huggingface.co/google/embeddinggemma-300m).
According to the release note, it outperforms `all-MiniLM-L6-v2` on a variety
of tasks. It even beats `multilingual-e5-large`, a model that's almost twice
its size, on all [MTEB
tasks](https://developers.googleblog.com/en/introducing-embeddinggemma/). I did
see some improvement but it wasn't significant.

I thought maybe I had hit the ceiling of what the MLP architecture could do. So I
started playing around with using the LLM itself as the classifier. It did give me
a better score, but each inference takes 10-20 seconds—too slow to process
the entire test dataset within the 9-hour Kaggle time limit.

This past Sunday, it suddenly occurred to me that I could use the Qwen-8B
model purely as an embedding model. This isn't supported out of the
box by `sentence-transformers`, but it was easy to vibe code it through the
`llama-cpp-python` package.

The result? Extraordinarily good. The MAP score jumped to 0.9439, a significant
improvement over the previous two models.

As context, the current top score on the Kaggle Leaderboard is 0.952. This
almost embarrassingly simple MLP approach takes less than 0.03 seconds
per inference, yet achieves a score remarkably close to the top.


  | Model            | Parameters | Embedding Dimensions | MAP@3 Score |
  |------------------|------------|----------------------|-------------|
  | all-MiniLM-L6-v2 | 32M        | 384                  | 0.9082      |
  | Gemma-300M       | 300M       | 768                  | 0.9101      |
  | Qwen3-8B         | 8B         | 4096                 | 0.9439      |


I've long been aware of the hypothesis that if the representation is good
enough, downstream tasks can be solved with really simple models. But this
is the first time I've seen it in action and it's truly impressive to see it
work so well with so little resources.

The concept of [Representation
Learning](https://en.wikipedia.org/wiki/Feature_learning) always fascinates me.
The idea that the entire world's complexity can be squeezed into 10k-dimensional vectors
is mind-boggling. 


