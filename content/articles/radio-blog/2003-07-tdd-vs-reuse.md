---
active_tab: articles
title: "Re: Test Driven Development versus Component Reuse"
---
# Re: Test Driven Development versus Component Reuse

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 1 July 2003</b>

<p>
Over on the <a href="http://www.softwarecraftsmen.com/blog/" title="Software Craftsmen">Software Craftsmen blog</a>, Mike Hogan <a href="http://www.softwarecraftsmen.com/blog/archives/000003.html" title="Test Driven Development versus Component Reuse">asks</a> what is meant by "the simplest thing that could possibly work".  For what it's worth, Beck actually addresses this point directly in <i>Extreme Programming Explained</i> [<a href="http://www.amazon.com/exec/obidos/ASIN/0201616416/rodsradiowebl-20" title="details at amazon (via my associates id)">ISBN:0201616416</a>]:
</p>
<blockquote>
<p>Here is what I mean by simplest--four constraints, in priority order:</p>
<ol>
<li>The system (code and tests together) must communicate everything you want to communicate.</li>
<li>The system must contain no duplicate code. (1 and 2 together constitute the Once and Only Once Rule).</li>
<li>The system should have the fewest possible classes.</li>
<li>The system should have the fewest possible methods.</li>
</ol>
[...]
<p>If you view the design as a communication medium, then you will have objects or methods for every important concept.  You will choose the names of the classes and methods to work together.</p>
</blockquote>
<p>
I have my own issues with that definition that I hope to pick up in a later post. (For starters, define "everything you want to communicate".)
</p>
<p>
Mike goes on to question whether there are times when TSTTCPW conflicts with design for reuse.
</p><p>
I think this misses the test first aspect.  Consider approaching the Grep example test first.  A small set of tests that might lead to the first Grep implementation is:
</p>

```java
static final String TEXT = "This is\na simple test";
Grep grep = null;
BufferedReader reader = null;

void setUp() {
  grep = new Grep();
  reader = new BufferedReader(new StringReader(TEXT));
}

void testDoesContain() {
  assertTrue(grep.contains(reader,"is");
}

void testDoesNotContain() {
  assertFalse(grep.contains(reader,"is not");
}

void testPatternsSplitAcrossMultipleLinesAreNotFound() {
  assertFalse(grep.contains(reader,"is*a");
}
```

<p>
Mike asserts that the Grep implementation would be more useful if it could interoperate with multiple regular expression frameworks, and provides an example "Inversion of Control" approach for doing so.  Want to make that Grep implementation work with multiple regular expression frameworks?  Great.  First, write a test that fails:
</p>

```java
void testGrepWithJakartaRegexp() {
   RegexpProvider rep = new RegexpRegexpProvider();
   ReusableGrep grep = new ReusableGrep(rep);
   assertTrue(grep.contains(reader,"is");
   assertFalse(grep.contains(reader,"is not");
}

void testGrepWithJakartaOro() {
   RegexpProvider rep = new OroRegexpProvider();
   ReusableGrep grep = new ReusableGrep(rep);
   assertTrue(grep.contains(reader,"is");
   assertFalse(grep.contains(reader,"is not");
}
```

<p>
(Alternatively, (1) define a "mock" instance of RegexpProvider for the purpose of this test rather than using specific implementations and (2) define an abstract getRegexpProvider method in your test class, an implement these tests as concrete extensions of that abstract test case, but I digress.)
</p><p>
Now we can justify the creation of the RegexpProvider interface, and ReusableGrep still meets the "simplest" criteria.  (Ignoring that ORO and Regexp likely support slightly different syntaxes.)
</p><p>
I think Mike's first instinct--simple is "the smallest amount of code" that will "get the test case[s] running and refuses to concern itself with any potential future requirement" is the right one.  Have additional requirements you'd like to assert? Then express them as tests and this simple rule allows you to support them.  When approaching development test first I think a lot these questions about "what is simple" simply fade away, as does much premature generalization.  (And I say that without taking a position on whether ReusableGrep represents premature generalization or not.  I recognize that it's meant as a trivial example.)
</p><p>
PS: I can't resist the temptation to plug a <a href="http://jakarta.apache.org/commons/sandbox/functor" title="Apache's Jakarta-Commons Functor">commons-functor</a> approach to this Grep implementation.  How about something like:</p><p>
</p>

```java
Lines.from(reader).contains(RegexpMatch.of("my expression"))
```