---
layout: post
title: "Qwen-8B Embeddings: Near-SOTA Performance at 600x the Speed"
date: 2025-09-16 22:06
comments: true
categories:
---

TLDR: The Qwen-8B embedding model delivers near state-of-the-art performance on text
classification tasks while running 600x faster than LLM-based approaches.

While working on the [Kaggle
MAP](https://www.kaggle.com/competitions/map-charting-student-math-misunderstandings)
competition, I've been experimenting with different embedding models for text
classification tasks. The setup is pretty simple. A sentence gets encoded into
a vector by an embedding model, then the labe and the vector will be used to
train a 3-layer MLP classifier.

I started with
[`sentence-transformers/all-MiniLM-L6-v2`](https://huggingface.co/sentence-transformers/all-MiniLM-L6-v2),
a 22.7M parameter model. It was easy to put together (thanks to the
`sentence-transformers` Python package) and I got a proof of concept working in
a few hours. After some Optuna hyperparameter search, the system plateaued at
around 0.908 MAP score. A respectable result but not competitive enough yet.

Two weeks ago, DeepMind released
[embedding-Gemma-300M](https://huggingface.co/google/embeddinggemma-300m).
According to the release note, it outperforms `all-MiniLM-L6-v2` on on all
[MTEB tasks](https://developers.googleblog.com/en/introducing-embeddinggemma/).
(MTEB is an excellent benchmark suites that measure embedding model's performance
over a range of text search, reranking tasks.) 

After integrating Embedding Gemma 300M, I did see some improvement from 0.9082
to 0.9127. But it was a small bump considering the model is 10x larger (300M vs
32M parameters) and the embedding dimension doubled (768 vs 384). I wasn't
impressed. 

I thought maybe I had hit the ceiling of what the MLP architecture could do. So I
started playing around with using the LLM itself as the classifier. It did give me
a better score, but each inference takes 10-20 seconds - way too slow to process
the entire test dataset within the 9-hour Kaggle time limit.

This past Sunday, I realised I could use the Qwen-8B
model purely as an embedding model. While `sentence-transformers` doesn't support
this out of the box, I was able to quickly implement one using the 
`llama-cpp-python` package.

The result? Extraordinarily good. The MAP score jumped to 0.9439, a significant
improvement over the previous two models. For context, the current top score on
the Kaggle leaderboard is 0.952. This remarkably simple MLP approach
takes less than 0.03 seconds per inference, yet achieves a score very
close to the top.


  | Model            | Parameters | Embedding Dimensions | MAP@3 Score |
  |------------------|------------|----------------------|-------------|
  | all-MiniLM-L6-v2 | 32M        | 384                  | 0.9082      |
  | Gemma-300M       | 300M       | 768                  | 0.9101      |
  | Qwen3-8B         | 8B         | 4096                 | 0.9439      |


I've long been aware of the hypothesis that good representations enable simple
models to solve complex tasks. But this is the first time I've seen it in
action, and it's impressive how well it works with so few moving parts. And so
fast!

For teams building AI products, this approach offers a compelling alternative 
over paying for LLM API calls. Perhaps, for some use cases, we don't need 
complex, expensive models after all. Strong representation + simple model 
might just do the trick.

