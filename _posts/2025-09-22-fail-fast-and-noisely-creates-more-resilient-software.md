---
layout: post
title: "Fail fast and noisily creates more resilient software"
date: 2025-09-22 16:07
comments: true
categories: 
---

If you ask me what is the **one** single secret of writing reliable and
maintainable software, I'd say "Let your code crash noisily and fast." A
corollary of this is "defensive programming is a practice that is wrong."

Erlang is the programming language that Ericsson created to build the telecom
systems that needed to be always available. Counterintuitively, one of the key
principles of Erlang is "let it crash", which means that instead of trying to
handle every possible error, you should let your processes fail and restart
them in a known good state.

The view is that you don't need to program defensively. If there are any
errors, the process is automatically terminated, and this is reported to any
processes that were monitoring the crashed process. In fact, defensive
programming in Erlang is frowned upon. This is a very different approach from
most programming languages, where the common advice is to "fail silently" and
handle errors gracefully. 

The philosophy is not just to write code without error checks and expect
higher-level supervisors to save the day; it is to avoid defensive coding,
namely to detect and correct what is appropriate, and allow other errors to
cause process termination and propagate up to the supervisor. If the
supervision hierarchy is well-designed, you can end up with an extremely
fault-tolerant system. That's in addition to other fault-tolerance techniques
such as hardware redundancy.

In the age of AI, with a clear traceback of what went wrong, and with the AI
automatically adding tests and fixing bugs, the "fail fast and noisily"
approach enables resilient systems that are easy to maintain. You just need to
get the architecture pieces right, and watch the AI do its magic.
