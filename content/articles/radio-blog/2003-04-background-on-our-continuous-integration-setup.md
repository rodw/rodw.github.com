---
active_tab: articles
title: A Little Background on our Continuous Integration Setup
---
# A Little Background on our Continuous Integration Setup

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 28 April 2003</b>

<p>
I've been tinkering with a long post on some experiences with <a href="http://www.martinfowler.com/articles/continuousIntegration.html" title="Continuous Integration by Martin Fowler and Matthew Foemmel">continuous integration</a>, but since I'm having trouble finding the time to put it all together, I'll try splitting it up into multiple posts (as seems to be all the rage these days). At the very least this should help me get something posted.
</p><p>
Part 1, a little background.
</p><p>
At the shop where I work we've been running an increasingly continuous integration service for a little over two years.
Our first fully automated, detect-a-change, build-and-smoke-test occurred on 15 October 2001.  Prior to that we had been running a complete build-and-smoke test at least nightly for several months.
</p><p>
Through fits and starts, this CI process has grown to be pretty comprehensive. It performs a complete build-and-unit-test, and in limited circumstances, deploy-and-functional-test across nearly 100 modules (roughly 200,000 non-blank, non-comment lines of code) supporting various internal and external, server, web-based and desktop applications being developed full time by more than 20 developers.  The service is based upon a modified version of <a href="http://cruisecontrol.sf.net/" title="CruiseControl's SourceForge Page">CruiseControl</a> (1.2.1) driving a common <a href="http://ant.apache.org/" title="Apache Ant">Ant</a> build script, <a href="http://junit.org/" title="JUnit.org">JUnit</a> unit tests, <a href="http://jakarta.apache.org/commons/latka/" title="Apache's Jakarta Commons Latka">Latka</a> and <a href="http://jfcunit.sourceforge.net/" title="jfcUnit's SourceForge Page">jfcUnit</a> functional tests.  Build results are reported through email and on our intranet.  Clean builds are tagged, and the generated artifacts are placed in a repository that serves as the foundation for both production deployments and sandbox development.  (Curiously, we've found <a href="http://cvshome.org" title="CVS Home">CVS</a> to be one of the weakest links in that tool chain, but that's a topic for another day.)
</p><p>
It has its problems, but all in all, it's an admirable, perhaps even enviable, setup.  In later posts I hope to discuss some of those problems and some observations we've made along the way.
</p>