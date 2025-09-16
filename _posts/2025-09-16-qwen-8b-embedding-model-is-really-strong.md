---
layout: post
title: "Qwen-8B Embeddings: Near-SOTA Performance at 600x the Speed"
date: 2025-09-16 22:06
comments: true
categories:
---

TLDR: The Qwen-8B embedding model is so strong that you really should give it a
go for your next text classification task.

For the [Kaggle
MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings)
competition I'm working on, I have a chance to try out different embedding
models for text classification tasks.

The setup is pretty simple. A sentence comes in. I'll use an embedding model to
encode it into a vector, which is then fed into a 3-layer MLP classifier.

I started with
[`sentence-transformers/all-MiniLM-L6-v2`](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2)
which was a 22.7M parameter model. It was easy to put together (thanks to the
`sentence-transformers` Python package) and I got a proof of concept working in
a few hours. With a bit of tweaking, the system plateaued at around 0.908 MAP score.
Ok result but not good enough to win a place on the Kaggle leaderboard.

Two weeks ago, DeepMind released
[embedding-Gemma-300M](https://huggingface.co/google/embeddinggemma-300m).
According to the release note, it outperforms `all-MiniLM-L6-v2` on a variety
of tasks. It even beats `multilingual-e5-large` on all [MTEB
tasks](https://developers.googleblog.com/en/introducing-embeddinggemma/).
I did see some improvement but it wasn't significant.

I thought maybe I had hit the ceiling of what the MLP architecture can do. So I
started playing around with using the LLM itself as the classifier. It suddenly occurred
to me that I can use the Qwen-8B model as the embedding model. This is not supported
out of the box by `sentence-transformers` but it's easy to access it through
`llama-cpp-python` package.

The result? Extraordinarily good. The MAP score jumped to 0.9439, a significant
improvement over the previous two models.

As context, the current top score on the Kaggle Leaderboard is 0.952. It's implemented
using LLM and each inference call takes about 10-20 seconds. Whereas this MLP
approach takes less than 0.03 seconds per inference yet it's able to achieve a score
that's so close to the top score.


  | Model            | Parameters | Embedding Dimensions | MAP@3 Score |
  |------------------|------------|----------------------|-------------|
  | all-MiniLM-L6-v2 | 32M        | 384                  | 0.9082      |
  | Gemma-300M       | 300M       | 768                  | 0.9101      |
  | Qwen3-8B         | 8B         | 4096                 | 0.9439      |


I've always found the concept of Representation Learning fascinating. The idea
that the entire world's complexity can be represented as 10k-vectors in a high
dimensional space is just mind-blowing. I've long been aware of the hypothesis
that if the representation is good enough, the downstream tasks can be solved
with really simple models. But this is the first time I've seen it in action and
it's truly impressive to see it work so well and so efficiently.