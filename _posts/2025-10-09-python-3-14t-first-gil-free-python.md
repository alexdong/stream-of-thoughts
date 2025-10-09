---
layout: post
title: "Python@3.14t - First GIL-free Python"
date: 2025-10-10 22:47
comments: true
categories: 
- python
---

Python 3.14 finally released today. The biggest news is that this is the first GIL-free Python. Even though it's slightly slower and it will have rough edges, this is a huge milestone for Python. 

Besides the Free-Threaded Python news, there are a few other highlights worth mentioning:
- Template strings: t-strings as `string.templatelib.Template`.
- `functools.Placeholder` that makes instantiating `partial` much easier
- `concurrent.futures.InterpreterPoolExecutor` for parallelism without GIL
- Much improved REPL with syntax highlighting and autocompletion (these should have been in a long time ago!)

For more details, see the [What's New in Python 3.14](https://docs.python.org/3.14/whatsnew/3.14.html) document.