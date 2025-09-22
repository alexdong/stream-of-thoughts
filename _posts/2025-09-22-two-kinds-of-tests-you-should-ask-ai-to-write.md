---
layout: post
title: "Tests for Fit and Tests for Correctness"
date: 2025-09-22 08:51
comments: true
categories: 
---

AI has nudged me to rethink how I practice test-driven development (TDD). TDD
has been one of my foundational practices for years. Write the test, then write
the code that makes it pass. That rhythm still holds, but with an AI assistant
in the loop, I am changing the kinds of tests I write and when I write them.

The loop still starts with tests, but now I make these tests part of the
planning session. I use them as a sketch of the interface I want. I sometimes
hand-write that interface code, sometimes ask AI to suggest three to five
options, focusing on the shape of the data, how the code will be called, and
the timing of how the API works hand in hand with other parts of the system.

When the generated tests look wrong, it often means that my description was off
or I haven't really captured the essence of what I want to achieve. I go back
and rewrite the prompt until the test code reads right.

I call these "Tests for Fit". Their job is to help me think through the
interface before I write the implementation. They are not meant to be exhaustive
or cover every edge case. They are a sketch of the happy path and a few common
error cases. They help me validate that the API I am imagining is usable and
makes sense. 

That first batch of tests lives in the plan.md file. I kick off the
implementation process with AI, and it works through a checklist of context to
keep in mind and guardrails I care about. Once the AI writes the code, it
automatically runs style checkers, type checkers, and those first tests. Those
initial tests prevent the AI from drifting into its own hallucination land.

Once the code is in a good place, I move to the next set of tests. These are
"Tests for Correctness." Their job is to refer to the internal implementation
and guide the AI to probe the code for edge cases and error handling within the
constraints of the interface we designed.

To do this, I often start a new session with the AI, feed it the public API and
the implementation, and ask it to break the code through the interface. The
goal is not so much about optimizing code coverage. Left to itself, the AI will
happily generate piles of mocked, repetitive tests. They look impressive, but
they are miserable to maintain.

Rather, the goal is to create a **minimal** set of tests that prove that the
code handles the expected inputs correctly. Further, instead of worrying about
edge cases, I very much prefer to sprinkle a generous amount of logging and
`assert` statements in the implementation so I know that any unexpected inputs
will cause immediate crashes. [Fail fast and noisily creates resilient software](/fail-fast-and-noisely-creates-more-resilient-software.html)
