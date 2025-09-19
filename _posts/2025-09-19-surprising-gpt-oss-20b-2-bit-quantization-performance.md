---
layout: post
title: "Surprising GPT-OSS 20B 2-bit Quantization Performance"
date: 2025-09-19 22:13
comments: true
categories: 
---

Today I benchmarked the GPT-OSS 20B model at different quantization levels using [unsloth/gpt-oss-20b-GGUF](https://huggingface.co/unsloth/gpt-oss-20b-GGUF). The results caught me off guard. Here are the details:

| Model       | Quantization | Size    | MAP@3 |
|-------------|--------------|---------|-------|
| gpt-oss-20b | Q2_K_L       | 11.8 GB | 0.68  |
| gpt-oss-20b | Q5_K_M       | 11.7 GB | 0.53  |
| gpt-oss-20b | Q3_K_M       | 11.5 GB | 0.41  |
| gpt-oss-20b | Q4_K_M       | 11.6 GB | 0.41  |
| gpt-oss-20b | Q4_K_XL      | 11.9 GB | 0.61  |

As a reminder, `Q2_K_L` means 2-bit quantization with large context, `Q5_K_M`
means 5-bit quantization with medium context, and so on. `MAP@3` is the metric
I use to evaluate classification performance. I ran these tests on an NVIDIA RTX 3000 with 14GB VRAM.

It's somewhat understandable that lower precision models (like `Q2_K_L`)
perform better in tasks requiring long context, as they can handle more tokens.
Still, `Q2_K_L` managed to outperform `Q4_K_XL`, which has higher precision and
a larger context window.

Here is ChatGPT Pro's explanation of how this could be possible:

> ### 1. **Hardware-Specific Optimizations**
>
> At very long context lengths, performance becomes memory-bandwidth-bound
> rather than compute-bound - the GPU constantly reads the entire KV cache from
> VRAM, and a larger cache means more data to move, which can slow down
> tokens-per-second output. With 2-bit quantization, you're moving less data
> per operation, which can result in:
> - **Better cache utilization**: Smaller models fit better in CPU/GPU cache
>   hierarchies
> - **Reduced memory bandwidth pressure**: Less data transfer between memory
>   and compute units
> - **Higher throughput** on memory-constrained systems, which can translate into
>   better MAP@3 scores in practice
> 
> ### 2. **Special Properties of GPT-OSS Architecture**
> 
> According to Unsloth documentation, any quant smaller than F16, including
> 2-bit, has minimal accuracy loss for GPT-OSS models because only some parts
> (e.g., attention layers) are lower bit while most remain full-precision. This
> is unique to the MoE architecture where over 90% of the models' total
> parameter count consists of MoE layers using MXFP4 format (4.25 bits per
> parameter).

I'm not sure if the explanation fully accounts for the performance difference,
but it seems plausible that the memory headroom might have played a far more
significant role compared to the precision difference. I'm curious to see if
others have observed similar results with different models or setups. If you
have, please drop me an email. I'd love to hear about it!

I suppose the key takeaway is that we really need to benchmark models in the
specific context and task we care about, rather than relying on general
assumptions about precision and context size.
