---
active_tab: articles
title: my pet bug, or another example of how sun doesn't get community development
---
# my pet bug, or another example of how sun doesn't get community development

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 15 July 2003</b>
 <p>
I've submitted <a href="http://developer.java.sun.com/developer/bugParade/bugs/4292531.html" title="Bug Id 4292531: RFE: Undeprecate java.util.Date(String)">a</a> <a href="http://developer.java.sun.com/developer/bugParade/bugs/4354100.html" title="Bug Id 4354100: Repackage sun.net.www.content.* Classes (java.net.ContentHandler)">few</a>
insignificant bugs to Sun's <a href="http://developer.java.sun.com/developer/bugParade/" title="Sun's Java Bug Database">Bug Parade</a> over the years, most recently <a href="http://developer.java.sun.com/developer/bugParade/bugs/4890211.html" title="Bug Id 4890211">"Collections.ReverseOrder.equals method is lacking"</a>, which I submitted back in January of 2003 and was finally accepted yesterday (14 July).
</p><p>
This isn't a critical bug, of course: It's easy to work around (that is, replace) and frankly it's been an annoyance but not a real problem in my development efforts.  Moreover, it seems like Sun has been pretty busy over the last few months working on <a href="http://java.net/" title="java.net">other things</a>.  Nevertheless, this whole experience has been frustrating.
</p><p>
First, in my limited and anecdotal experience the time to respond to bug reports is getting much worse.  It took six months for the Java team to acknowledge this simple, and if I may say reasonably well documented (including a "patch" and unit test), bug.
</p><p>
Second, this is a good if trivial example of how Sun's community efforts fail in execution.  Here's a trivially simple (it's clear from inspection alone) and readily demonstrated (a complete unit test is provided) defect.  A trivially simple (one line, two if you add hashCode()) patch is provided, and yet it took six months to get the issue acknowledged.  Now I'll wait an indeterminate amount of time to see the problem fixed.  All that and this problem could have been analyzed, patched and regression tested in less time than it took me to write this post.  Even the slowest moving of open source projects would have had this problem patched, if not released, in a matter of weeks.  If Sun can't find a way to move more quickly (and <a href="http://jcp.org/en/jsr/detail?id=176" title="JSR 176: J2SE 1.5 (Tiger) Release Contents">stop chasing the most superficial features of C#</a>) Java seems destined to be eclipsed by community developed languages.
</p><p>
I'll uncharacteristically paraphrase Jerry Seinfeld here: "Sun knows how to take community input, they just don't know what to do with it.  And that's really the most important part of community: the doing." (<a href="http://tomsquotes.amhosting.net/sitcom/seinfeld/jerry/jerry2.htm">text</a>, <a href="http://tomsquotes.amhosting.net/sitcom/seinfeld/jerry/reserve.wav" title=".wav file">audio</a>)
</p>
<p>
PS: Also note that the second bug I linked to above, <a href="http://developer.java.sun.com/developer/bugParade/bugs/4354100.html" title="Bug Id 4354100">"Repackage sun.net.www.content.* Classes (java.net.ContentHandler)"</a>, was already addressed by the time I submitted it, I personally added a comment to this effect nearly two years ago, and yet the bug sits marked "In progress" (and with 3 votes, none of them mine).
</p>
