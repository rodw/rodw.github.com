---
active_tab: articles
title: Testing Testing
---
# Testing Testing

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 24 June 2003</b>

<p>
My fear, and perhaps it's not a well founded one, is that <a href="http://radio.weblogs.com/0122027/2003/06/23.html#a32" title="23 June 2003: A Frog Boiling Approach to Increasing Test Coverage">the pursuit of pure test coverage</a>--the percentage of lines, statements, methods, etc. tested--will provide a false sense of completeness.  If "percent executed by test code" is your sole metric, it's easy to write superficial tests that execute statements, but actually "test" very little.
</p><p>
For example, a couple of weeks ago I added the following test to one of our suites:
</p>

```java
public void testStartStop() {
  AppMain app = new AppMain();
  assertFalse(app.isStarted());
  app.start();
  assertTrue(app.isStarted());
  app.stop();
  assertFalse(app.isStarted());
}
```

<p>
This single test--directly invoking just four distinct methods and comprising only three assertions--executed an additional 1,500 lines or so, roughly 10% of the code for this module.  You can be sure that the bulk of the functionality provided by those 1,500 lines is not actually tested here.  Indeed, the following (test first) implementation would suffice:
</p>

```java
class AppMain {
  void start() {
    started = true;
  }
  void stop() {
    started = false;
  }
  boolean isStarted() {
    return started;
  }
  boolean started = false;
}
```

<p>
Is this test useless?  At this point I'll argue it isn't.  Superficial testing of these 1,500 lines is better than no testing at all.  This test at least confirms that we've got the classpath right (including any resources loaded on application startup) and that there aren't any uncaught exceptions being thrown on startup.  (When better tests are in place, this superficial test may indeed become useless.) But the resulting test coverage metric is certainly misleading.
</p><p>
One solution, probably the right one, is to simply <a href="http://www.junit.org/news/article/test_first/index.htm" title="JUnit.org: Test First Articles">develop the code test first</a>.  If every change to production code was made to address a failing test (or to refactor under a unchanging test suite) then one certainly wouldn't find himself in this situation.  But this solution doesn't address my (our) current situation, in which we have 100,000 lines of "legacy" code and perhaps 60% of that code was developed "test last" if test at all.  The lack of tests has become a drag on our ability to refactor or simply work with that code.  If it was sufficient to simply tell folks to develop test first, I wouldn't be as concerned with measuring test coverage in the first place.
</p><p>
Mutation testing--in which we randomly change some piece of production code and check to see if our test suite detects the change--is another approach I've seen proposed before, but I'm having trouble buying into that.  If we start with poorly factored code, it seems likely that a random change is going to break something, probably profoundly (like leading to an exception being thrown).  Even superficial testing will detect those sort of problems.
</p><p>
Alternative but indirect metrics may be a better approach.  Tracking the number of distinct tests or facts being asserted might give a rough idea of how robust the test suite is.  To do this right I think I'd need some numbers from well tested portions of the code base that correlate size or complexity metrics with the number of tests or assertions in the test suite.  These might be interesting numbers to collect.
</p>