---
layout: post
title: "Thoughts on Richard Sutton's interview on Dwarkesh Podcast"
date: 2025-09-27 21:56
comments: true
categories: 
---

[Richard Sutton](https://www.dwarkesh.com/p/richard-sutton) is a Turing Award
winner and one of the founding fathers of Reinforcement Learning, so I listened
to his interview on [Dwarkesh
Podcast](https://www.dwarkesh.com/p/richard-sutton) three times, and what
Richard said opened my eyes to a few powerful perspectives, but I also disagree
with some of his points. This post is a collection of my thoughts on his
interview.

## LLM vs RL

> What is intelligence? The problem is to understand your world. Reinforcement
> learning is about understanding your world, whereas large language models are
> about mimicking people, doing what people say you should do. They’re not
> about figuring out what to do.

Sutton is drawing a sharp boundary between modeling reality and imitating
humans, and that distinction is what I want to explore. I think Richard
probably hasn't chosen the most precise word here. Instead of "not about",
maybe he meant was "not the best way to". LLMs *can* and *have been* used to
figure out what to do. In fact, the whole idea of [Evolutionary Test Time
Compute](/llm-evolutionary-test-time-compute.html) is to use LLMs to figure out
what to do, and this approach has made several novel discoveries. But is that
the most efficient way to figure out what to do, given all the known
constraints? Probably not.

> To mimic what people say is not really to build a model of the world at all.
> You’re mimicking things that have a model of the world: people. 
> ... 
> A world model would enable you to predict what would happen. They have the
> ability to predict what a person would say. They don’t have the ability to
> predict what will happen.

I think this is a false dichotomy. He’s contrasting linguistic prediction with
true physical modeling, yet LLMs can be used to build a model of the world.
[Google's Genie
3](https://deepmind.google/discover/blog/genie-3-a-new-frontier-for-world-models/)
is a great example of not learning from what people say but to learn the
fundamental physics of the world. 

> What we want, to quote Alan Turing, is a machine that can learn from
> experience, where experience is the things that actually happen in your life.
> You do things, you see what happens, and that’s what you learn from. 

This is an excellent point that I haven't been able to articulate before. I
think Richard is spot-on here in describing the boundary between RL and LLM.
It's hard to argue that an LLM's long context window is a form of "learning from
experience". 

Having said that, I think LLMs can still provide the foundational substrate for
RL to build upon. RL from zero is conceptually appealing but why not leverage
the world's knowledge encoded in LLMs to bootstrap the learning process? 

To me, these views can harmonize. If we think of the LLM as the DNA, then the
RL is the RNA that expresses the DNA. We can't say that DNA is useless because
it doesn't express itself. Similarly, we can't say DNA is sufficient enough
that RNA is not needed.

(Please refer to  the "Knowledge and Solution" section below to see why 
Richard might be correct.)

## Ground Truth

> There’s no ground truth. You can’t have prior knowledge if you don’t have
> ground truth, because the prior knowledge is supposed to be a hint or an
> initial belief about what the truth is.

This is the part where I disagree the most. Sutton seems to be saying that ground
truth only exists in lived experience. But what is ground truth? If an LLM 
has a way to use **deterministic** tools to verify its own output, then it
has access to truth and prior knowledge. If the compiler can verify the code, 
isn't that "the right thing to do"? Isn't that "ground truth"?


> Making a model of the physical world and carrying out the consequences of
> mathematical assumptions or operations, those are very different things. The
> empirical world has to be learned. You have to learn the consequences.
> Whereas the math is more computational, it’s more like standard planning.
> There they can have a goal to find the proof, and they are in some way given
> that goal to find the proof.

Richard didn't go into details here, but I think he was referring to the fact
that the real world is non-deterministic and stochastic. It's also fractal and
chaotic. So it can be computationally intractable to model the real world. The
combinatorial explosion is real. As such, RL learning from the real world is
not only learning to approximate the model of the world but also learning to
ignore or discard the irrelevant details. 

Still, I disagree. In [Demis Hassabis's interview on Lex Fridman
podcast](https://www.youtube.com/watch?v=-HzgcbRXUK8), he made the case that
an LLM like Veo actually can produce "clean predictions about highly nonlinear
dynamical systems". Can we ignore this example only because the videos generated 
by Veo are not "real world"? What is a "real world" other than a perception
afforded to us by our senses?

## Knowledge and Solution are the Product of the Environment

> In every case of the bitter lesson you could start with human knowledge and
> then do the scalable things. That’s always the case. There’s never any reason
> why that has to be bad. But in fact, and in practice, it has always turned
> out to be bad. People get locked into the human knowledge approach, and they
> psychologically… Now I’m speculating why it is, but this is what has always
> happened. They get their lunch eaten by the methods that are truly scalable.

This is one of the more important points Richard made. I think he is right
here. Human knowledge is bounded, constrained and shaped by our physical
hardware, so it is very likely that there exist many solutions to the same
problem that are beyond our comprehension. 

This also gives the strongest refutation to the "DNA vs RNA" analogy I made
earlier. If I were to steelman Richard's point, I would say that the LLM as the
DNA is bounded by the biochemistry of the earth environment. If we want to
explore the solution space for X environment, we need to use RL to "first
principle" maximise the best performer in the X environment.

> What you learn, your knowledge, is about the stream. Your knowledge is about
> if you do some action, what will happen. Or it’s about which events will
> follow other events. It’s about the stream. The content of the knowledge is
> statements about the stream. 

I find this point very profound. It basically says that knowledge is a product
of interaction with the world. Dragonfly's knowledge is different from a
shark's because they interact with the world differently. The shark's eyes are
specialised for low-light conditions and its gray-scale vision is perfect for
detecting movements in the water. The dragonfly's eyes are specialised for
detecting small insects, and its visual neurons send signals to the
dragonfly's four wings to allow it to make rapid adjustments in flight.

I think Richard made a powerful point that knowledge is not static. Rather,
once the die is cast, RL remains the best way to produce the most efficient
solution to a problem **given a set of constraints**. I think he is also 
right that the solution is *predetermined* by a set of constraints.

> You learn a policy that’s specific to the environment that you’re finding
> yourself in.

Persona. Policy. An environment for evolution. They are all the same thing to
describe the constraints, which fundamentally shape the solution space.


## Transfer Learning

> What we have are people trying different things and they settle on something,
> a representation that transfers well or generalizes well. But we have very
> few automated techniques to promote transfer, and none of them are used in
> modern deep learning.

If knowledge is tuned to an environment, it’s no surprise that porting it
elsewhere is hard. This is another really profound point. I think what Richard
was saying is that we don't know how to "transfer" knowledge from one domain to
another. Or more precisely, it is impossible to transfer knowledge across
domains the same way you can't really translate a poem across different
cultures. One has to leverage RL to find the optimal representation for the new
domain. 
