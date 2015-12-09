---
active_tab: articles
title: Unit tests with log statements are a code smell
---
# Unit tests with log statements are a code smell

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Friday, 2 May 2003</b>

<p>
While this is not an earth shattering realization, I've come hold the opinion that log statements (<a href="http://jakarta.apache.org/log4j/" title="jakarta.apache.org/log4j">log4j</a>, <a href="http://avalon.apache.org/logkit/" title="avalon.apache.org/logkit">logkit</a>, <a href="http://java.sun.com/j2se/1.4.1/docs/api/java/util/logging/package-summary.html" title="javadocs for java.util.logging">java.util.logging</a>, <a href="http://jakarta.apache.org/commons/logging/" title="jakarta.apache.org/commons/logging">commons-logging</a>, what have you) within unit tests are a <a href="http://c2.com/cgi/wiki?CodeSmell" title="Ward's Wiki: CodeSmell">code smell</a>, perhaps universally.
</p><p>
While I'll sometimes add a few System.out.println calls to a unit test while I'm trying to diagnose a particular failure, configuring a full-blown logging setup within a unit test always seemed like more time and trouble than it was worth. From time to time I'll encounter a heavily logged TestCase in some code base I'm working with.  The more I work with such TestCases, the more I find this to be an indication that something is not right.
</p><p>
Here's why:
</p>
<ul>
<li>I find it hard to imagine a test first/test driven development approach that leads to log statements within unit tests (but I can imagine "test last" approaches that will). The presence of logging strongly suggests that the tested code was not developed in a test driven fashion.</li>
<li>The role of logging frameworks and that of automated unit testing frameworks are at odds.  Logging calls provide persistent, if only intermittently used, diagnostic and informational messages, typically intended for manual inspection <sup><a href="#n28.1">*</a></sup>.  Automated unit tests are meant to be self-interpreting, success or failure should be obvious without manual inspection.  The use of diagnostic or informational log messages within unit tests suggests your tests aren't sufficiently self-interpreting.</li>
<li>Anecdotally, the objects being tested by these cases are brittle in the face of change.  This may stem from poor factoring: there are too many subtle and perhaps unplanned interactions between methods, or methods aren't well focused enough to allow for orthogonal changes.</li>
<li>Anecdotally, test failures remain difficult to diagnose and fix despite the log messages. This also stems from poor factoring: the individual test cases and assertions are too coarse grained to help identify the root cause of a test failure.</li>
</ul>
<div class="footnote"><p><a name="n28.1">*</a> If you find yourself wanting programmatic inspection of log messages, I'll suggest you're looking for messaging, not logging.</p></div>
