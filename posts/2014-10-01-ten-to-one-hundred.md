---
title: Ten to One Hundred
description: The evolution of a Haskell program
author: <a href="http://kyle.marek-spartz.org">Kyle Marek-Spartz</a>
---


Learning how to grow programs from ten to one hundred lines is difficult. There are plenty of resources for going from [one to ten](http://learnyouahaskell.com/) or [10,000 to 100,000](http://www.cafeaulait.org/books/secrets/), but in between you are often out of luck.[^1] To that end, at our last [monthly meeting](http://www.haskell.mn/posts/2014-09-23-september-haskellmn-meetup.html), I led a discussion on this problem, using an [implementation](https://github.com/HaskellMN/haskell-mn-presentations/tree/master/2014/09/echo-server) of an [echo server](https://en.wikipedia.org/wiki/Echo_protocol) as an example[^2]. We grew the program from [six](https://github.com/HaskellMN/haskell-mn-presentations/blob/master/2014/09/echo-server/1.hs) to [51](https://github.com/HaskellMN/haskell-mn-presentations/blob/master/2014/09/echo-server/8.hs) lines, stopping along the way to discuss topics as they came up.

[^2]: I've been working through [Parallel and Concurrent Programming in Haskell](http://chimera.labs.oreilly.com/books/1230000000929/index.html), previously blogging about [an implementation of the DayTime protocol](http://kyle.marek-spartz.org/posts/2014-08-26-concurrent-implementation-of-the-daytime-protocol-in-haskell.html). These examples are based on [Chapter 12 ](http://chimera.labs.oreilly.com/books/1230000000929/ch12.html#sec_server-trivial) of the book.

[^1]: I'm forgetting the source of this observation. If you know it, please let [me](mailto:kyle.marek.spartz@gmail.com) know, or file a [pull request](https://github.com/HaskellMN/www.haskell.mn)!
