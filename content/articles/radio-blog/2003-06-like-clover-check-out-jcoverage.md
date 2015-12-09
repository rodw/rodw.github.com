---
active_tab: articles
title: Like Clover? Check out JCoverage
---
# Like Clover? Check out JCoverage

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 30 June 2003</b>

<p>
Like <a href="http://www.thecortex.net/clover/" title="Clover: a code coverage tool for Java">Clover</a>, <a href="http://jcoverage.com/" title="JCoverage: a code coverage tool for Java">JCoverage</a> is a code coverage analyzer for Java.  "Instrument" your code with either of these tools, run your unit test suite (really, execute the code in any way), and one can generate a report on what was executed (lines, methods, branches, etc.), and more importantly, what wasn't.
</p><p>
Unlike Clover:
</p><ul>
<li>JCoverage is <a href="http://www.gnu.org/copyleft/gpl.html" title="GNU General Public License">GPL</a>'ed</li>
<li>JCoverage instruments the byte code (via <a href="http://jakarta.apache.org/bcel/" title="Apache's BCEL: Byte Code Engineering Library">BCEL</a>) rather than the source, which seems substantially faster, at least under casual observation.</li>
<li>JCoverage is clever enough to not instrument select lines--lines that invoke <a href="http://jakarta.apache.org/log4j/" title="Apache's Log4J">log4j</a> for example--which means that logging calls don't pollute your coverage metrics, whether or not you run the test suite with logging on.</li>
<li>JCoverage can generate a complete, parsable coverage report in XML from which you can render custom reports or derived statistics.</li>
<li>JCoverage includes custom <a href="http://ant.apache.org/" title="Apache Ant: a Java-based build tool">Ant</a> tags for instrumentation, reporting and even asserting levels of coverage at a fine grained level.</li>
<li>JCoverage makes it easy to merge coverage databases across several runs--for unit and functional tests, for example, or to create a single report for independently built components. (Of course, given the XML report, it may be tedious but shouldn't be difficult to do this sort of merge on "manually" either.)</li>
</ul><p>
With JCoverage, I think I'll need to reconsider <a href="http://radio.weblogs.com/0122027/2003/06/23.html#a32" title="23 June 2003: A Frog Boiling Approach to Increasing Test Coverage">my position</a> that coverage analysis may be too slow to execute with every continuous integration build.
</p>