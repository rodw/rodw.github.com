---
active_tab: articles
title: Literate Programming with JUnit
---
# Literate Programming with JUnit

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 31 March 2003</b>

I've long been a fan of telling folks "if you want examples, take a look at the unit tests". Folks have long been disappointed with that response.

I've found maintaining a distinct "examples" tree problematic, for a number of reasons but fundamentally due to my own laziness. One set of forces pulls us toward maintaining the examples as documentation--we want the examples linked in to the other documentation and to include explanatory prose. Another set of forces pulls us toward maintaining the examples as source code--we want to make sure the examples will compile, are up-to-date with the rest of the API, and can be refactored with the rest of the codebase (so that, for example, a "Rename Method" refactoring applies to the examples as well as everything else).

Recently I've been experimenting with what seems to be a viable approach to this problem--writing examples as "[literate](http://www.c2.com/cgi/wiki?LiterateProgramming)" unit tests. In short, I keep the examples directly within the test source tree, implementing them as true JUnit TestCases, and using plain old C-style (not JavaDoc) comments to provide the prose. The JXR Java-to-HTML cross-reference generating tool can produce a hyper-linked version of those source files, and it's already built into [Maven](http://maven.apache.org/)'s `site` goal.

You can see [some examples](http://jakarta.apache.org/commons/sandbox/functor/examples.html) of this approach within [Commons Functor](http://jakarta.apache.org/commons/sandbox/functor/).

([Literate Programming purists](http://www.literateprogramming.com/) are likely to take issue with calling this "literate programming", but there don't seem to be many of those around these days.)

I've found this approach leads me to create a lot more inner classes in those unit tests than in my typical code. The heavy use of inner classes may be disorienting for some readers, but I suppose it isn't strictly necessary (the alternative may be to "pollute" the test tree with more files). On the positive side, this approach does a good job of allowing one to express the code in a "[test first](http://www.junit.org/news/article/test_first/)" style without resorting to showing the code as a time-series. If I can find the time I'll probably be adding some more Commons Functor examples in the next few days, so if you're interested you may want to check back then too.

It might be interesting to try to find or build greater tool support for this approach, perhaps with some custom JavaDoc doclet or java2html tool. (I keep wanting to move beyond simple text in those descriptions, although the simplicity has its appeal.)

(I'm very interested in what others think about this approach, by the way. Feel free to comment or otherwise contact me.)
