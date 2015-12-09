---
active_tab: articles
title: Experimenting with Jester
---
# Experimenting with Jester

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 25 June 2003</b>

<p>
In a <a href="http://radio.weblogs.com/0122027/2003/06/24.html#a34" title="24 June 2003: Testing Testing">previous post</a> I alluded to the use of mutation testing to evaluate the completeness of a test suite, rather than relying upon pure test coverage metrics.  In a <a href="http://radiocomments2.userland.com/comments?u=122027&amp;p=34" title="comments on &quot;Testing Testing&quot;">comment</a> to that post <a href="http://www.oshineye.com/" title="Adewale Oshineye's homepage">Adewale Oshineye</a> suggested that I check out Ivan Moore's <a href="http://jester.sourceforge.net/" title="Jester: the JUnit test tester">Jester</a>, a Java/JUnit based mutation testing tool.  I'd seen Jester before, but I'd never used it nor looked at it in much detail.  The anecdote about <a href="http://groups.yahoo.com/group/extremeprogramming/message/32277" title="jester shows bowling scoring could be simpler">what Jester uncovered</a> in Bob Martin's and Robert Koss's <a href="http://www.objectmentor.com/resources/articles/xpepisode.htm" title="Engineer Notebook: An Extreme Programming Episode">test driven bowling score calculator example</a> was certainly interesting, so this morning I bit the bullet and downloaded a copy.
</p><p>
Getting Jester up and running was a minor hassle (and it seems like much of that hassle could be alleviated), but I've written my share of open source projects with quirky configuration and installation, so I'll leave that alone.  Once my files were placed in the proper position and after tweaking the python scripts to get them to run on whatever version of python I've got on my RedHat box, Jester ran slowly (waiting on javac) but well.  It ran much faster once I figured out how to tell Jester to stop mutating my comments (set <code>shouldRemoveComments=true</code> in <code>jester.cfg</code>).  The result was a basic HTML report like <a href="http://jester.sourceforge.net/jester.html" title="example Jester report">this one</a>.
</p><p>
(On an unrelated note, is there something more or less equivalent to <code>python -version</code>?)
</p><p>
As an experiment, I took a small component (196 non-blank, non-comment lines of code spread over 34 methods) I knew to be well tested (100% coverage of statements and conditional expressions) and ran it through Jester.  It found 21 mutations total, 2 of which didn't lead to a test failure.  Those were (with the modified code in bold):
</p>
<pre>if(<b>TRUE ||</b> MESSAGE_LOG.isDebugEnabled()) {
   MESSAGE_LOG.debug("Broadcasting " + msg);
}</pre>
<p>and</p>
<pre>List list = new ArrayList(_listeners.size() + <b><strike>1</strike>2</b>);
list.addAll(_listeners);
list.add(<i>...</i>);</pre>
<p>
In the first case, believe it or not, I actually had unit tests that confirm that MESSAGE_LOG generates log events when set to the DEBUG priority, and no log events when set to higher than DEBUG priority.  (I wouldn't normally do that, except this is the single log message in that component, and I really wanted 100% coverage.  Besides, it wasn't that hard, I just added a mock Appender to that Category, and checked to see if a message was added or not.)  Of course, both of these tests still pass, even without the isDebugEnabled call, since the debug method won't generate a log event when using a higher priority.  Adding a test that fails as a result of this mutation isn't particularly useful, but it isn't difficult either--I just pass in a mock instance of the <i>msg</i> object and check whether or not the toString method is invoked.  Not invoking toString is indeed the reason for this if(isDebugEnabled()) block, so maybe that's not such an odd test to have after all.
</p><p>
The second case is the kind of thing Ivan Moore describes as a "false positive" in his <a href="http://www.xp2001.org/xp2001/conference/papers/Chapter20-Moore.pdf" title="Jester - a JUnit test tester">writeup on Jester</a>.  This code initializes that ArrayList to the precise size it knows will need.  Allocating it a little bit bigger or a little bit smaller doesn't alter the functional behavior of the method (although it will be slightly less efficient).  Maybe that indicates a premature optimization on my part, but it seems like a pretty small one.  In any event I don't see any way to confirm that that List was allocated to precisely the right size without breaking encapsulation profoundly, so I think I'll let that one go.
</p><p>
I had hoped to run Jester on some larger, more complicated but less well tested code (3,287 nc,nb lines, roughly 77% coverage) to get a feel for how it works in a more useful scenario, but I've been unable to get it to complete a run on the this larger component.  I may poke around with something in-between, but 4,000 lines is on the smallish side for the kinds of modules I'd want to run this on.  I may have better luck mutating a single class at a time.
</p><p>
In short, I think Jester meets <a href="http://www.intertwingly.net/blog/" title="intertwingly.net: Sam Ruby's Weblog">Sam Ruby</a>'s criteria for a successful open source project--it's a good idea with a bad implementation.  I have some thoughts on how to improve that implementation (mainly obvious ones--e.g., use a ClassLoader and an actual parser, or consider mutating the byte code rather than the source) that maybe I'll cover in a later post.  All in all, Jester is an interesting project, and like a lot of things, I wish it worked a bit better.
</p>
