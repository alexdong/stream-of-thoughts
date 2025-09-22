---
layout: post
title: "Tests for Fit and Tests for Correctness"
date: 2025-09-22 08:51
comments: true
categories: 
---

AI has nudged me to rethink how I practice test-driven development (TDD). TDD
has been one of the foundational practices for me for years: write the test, then write the
code that makes it pass. That rhythm still holds, but with an AI assistant in
the loop, I am finding myself changing the kinds of tests I write and when I
write them.

The loop still starts with tests, but now I make these tests part of the planning
session. I use them as a sketch of the interface I want. I sometimes hand-write 
those interface code, sometimes ask AI to suggest 3-5 options, focusing on
the shape of the data, how the code will be called, and the timing how how the 
API works hand-in-hand with other parts of the system. 

When the generated tests look wrong, it often means that my description was off 
or I haven't really captured the essence of what I want to achieve. So I will go 
back and rewrite the prompt until the test code reads right.

I call these "Tests for Fit". Their job is to help me think through the
interface before I write the implementation. They are not meant to be exhaustive
or cover every edge case. They are a sketch of the happy path and a few common
error cases. They help me validate that the API I am imagining is usable and
makes sense. 

With that first batch of tests lives in the plan .md file, I would kick off the
implementation process with AI. The AI will run through a checklist, context to
keep in mind, guardrails I care about. Once the AI writes the code, it will
automatically run style checkers, type checkers and those first tests. Those
initial tests prevents the AI from drifting into its own hallucination land. 

Once the code is in a good place, I will move to the next set of tests. These
are "Tests for Correctness". Their job is to, referring to the internal
implemnetation, for the AI to probe the code for edge cases, error handling
within the constraints of the interface we designed.

To do this, I often start a new session with the AI, feeding it the public API
and the implementation and ask it to break the code through the interface. The
goal is not so much about optimising code coverage. Left to itself, the AI will
happily generate piles of mocked, repetitive tests. They look impressive, but
they are miserable to maintain.

Rather, the goal is to create a **minimal** set of tests that proves that the
code handles the expected inputs correctly. Further, instead of worrying about
edge cases, I very much prefer to sprinkle a generous amount of logging and
`assert` statements in the implementation so I know that any unexpected inputs
will cause immediate crashes. [Fail fast and noisely creates resilient software](/2025/09/22/fail-fast-and-noisely-creates-more-resilient-software/)
