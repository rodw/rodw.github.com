---
active_tab: articles
title: A Frog Boiling Approach to Increasing Test Coverage
---
# A Frog Boiling Approach to Increasing Test Coverage

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 23 June 2003</b>

<p>
Some thinking out loud about concrete goals for increasing test coverage:
</p><p>
The production (i.e., non-test) Java code base at my day job consists of roughly 103,000 non-comment, non-blank lines of code, split over 132 "modules".  Our automated unit test suite exercises roughly 29% of those lines.
</p><p>
(That 29% figure sounds a little bit worse than it feels to me.  Some areas of the code base are well tested, several are even at 100% coverage.  Others have few if any tests, but as a result of remaining essentially untouched since before a formal unit testing initiative was launched 30 months or so ago.  Yet many modules are woefully under-tested, and probably not coincidentally several of those have substantial bloat--the number of lines in those modules is way out of proportion with the functionality they provide.)
</p><p>
Whether that 29% figure is indicative or not, it's clearly much lower than desirable.  (Personally I've been striving for and generally achieving 100% coverage for new development.)   I've been thinking a bit about laying out concrete goals for increasing this coverage.
</p><p>
We've talked a bit about simply targeting some figure, say 80% coverage, and perhaps some intermediate goals (for example, 40%, then 60%, then 80%).
</p><p>
While the "frog boiling" approach--slowly raising the temperature on test coverage--appeals to me, something about the arbitrary "percent coverage" goals doesn't seem right.  I think I'd prefer goals that call for complete (100%) coverage of something, perhaps with different values of "something".  I'm not entirely sure why.
</p><p>
Specifically, I'm thinking of the following stages:
</p>
<ol>
<li>All modules have tests.  Conveniently, this can be easily and quickly tested at build time.  We can make the absence of tests a build failure.  It is possible to programmatically evaluate the remaining goals, but not as quickly.  We'd have to execute the test coverage check on every continuous integration build, something that may take too much time.</li>
<li>All packages have tests.  This should be relatively easy to achieve once the first goal is reached.</li>
<li>All classes have tests.</li>
<li>All methods have tests.</li>
</ol>
<p>
I'm not sure where to go from that point.  Complete coverage of conditionals (every boolean expression is evaluated at least once to true and at least once to false) may be a good next step, but isn't as pithy as the other goals.  It may be that once we've reached 100% method coverage, 100% line/statement coverage is within easy reach.  I suspect that once we've reached that fourth goal, the next step will be pretty clear.
</p><p>
I wonder if any reader has some experience with similar strategies for increasing test coverage through a series of concrete goals.  What goals did you select, and why?  Did a given step turn out to be too large or too small?
</p>