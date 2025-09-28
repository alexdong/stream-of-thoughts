---
layout: post
title: "Mental Flexibility as a Software Engineering Maturity Metric" 
date: 2025-09-28 18:23
comments: true
categories: 
- software-engineering
- skill-acquisition
---

There are a few orthogonal axis one can use to measure a software engineer’s maturity. The one that easily comes to mind is technical knowledge, whether they have an accurate mental model of the language or technology they use. Can they intuit the boundaries and long-term impact of decisions. Another one is communication skill, whether they can understand and be understood. 

One crucial axis that often gets overlooked is mental flexibility. The ability to know that all “best practices” are context sensitive. To hold back opinions until a good-enough understanding of a problem is completed. Because [nobody knows](https://www.seangoedecke.com/confidence/). This flexibility empowers engineers to shape the technical approaches according to the problem on hand.

In Sean’s most recent essay on [software taste](https://seangoedecke.com/taste/), he mentioned:

> Almost every decision in software engineering is a tradeoff. You’re rarely picking between two options where one is strictly better. Instead, each option has its own benefits and downsides. Often you have to make hard tradeoffs between engineering values: past a certain point, you cannot easily increase performance without harming readability, for instance.
>
> Really understanding this point is (in my view) the biggest indicator of maturity in software engineering. Immature engineers are rigid about their decisions. They think it’s always better to do X or Y. Mature engineers are usually willing to consider both sides of a decision, because they know that both sides come with different benefits. The trick is not deciding if technology X is better than Y, but whether the benefits of X outweigh Y in this particular case.

Go ahead and read the full essay, it’s a great one. 

Now, one thing I believe we should all be doing, not only at the outset of a project, but also regularly every month or every quarter, is to reflect on the values for the current projects we are working on. Once the values trade-offs are explicitly defined and documented, we should then proceed to re-orient our technical decisions and define our standard of **good taste** accordingly. Lastly, these values and standards should be documented into a `AGENTS.md` file so it can be communicated to both the humans and, increasingly, the AI agents that are part of the engineering process.

Here is a simple questionaire to get started (quoted from Sean’s essay):

> * Resiliency. If an infrastructure component fails (a service dies, a network connection becomes unavailable), does the system remain functional? Can it recover without human intervention?
> * Speed. How fast is the software, compared to the theoretical limit? Is work being done in the hot path that isn’t strictly necessary?
> * Readability. Is the software easy to take in at a glance and to onboard new engineers to? Are functions relatively short and named well? Is the system well-documented?
> * Correctness. Is it possible to represent an invalid state in the system? How locked-down is the system with tests, types, and asserts? Do the tests use techniques like fuzzing? In the extreme case, has the program been proven correct by formal methods like Alloy?
> * Flexibility. Can the system be trivially extended? How easy is it to make a change? If I need to change something, how many different parts of the program do I need to touch in order to do so?
> * Portability. Is the system tied down to a particular operational environment (say, Microsoft Windows, or AWS)? If the system needs to be redeployed elsewhere, can that happen without a lot of engineering work?
> * Scalability. If traffic goes up 10x, will the system fall over? What about 100x? Does the system have to be over-provisioned or can it scale automatically? What bottlenecks will require engineering intervention?
> * Development speed. If I need to extend the system, how fast can it be done? Can most engineers work on it, or does it require a domain expert?