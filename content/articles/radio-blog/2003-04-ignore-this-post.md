---
active_tab: articles
title: Ignore this post (Demonstrates javablogs bug?)
---
# Ignore this post (Demonstrates javablogs bug?)

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 16 April 2003</b>

<p>
I've been chasing after a minor <a href="http://javablogs.com/">javablogs</a> bug that causes blog entries that aren't in my java channel to appear on the javablogs site, despite the fact that the <a href="http://www.javablogs.com/ViewBlog.jspa?id=10656">javablogs record for this site</a> is pointing to my <a href="http://radio.weblogs.com/0122027/categories/java/rss.xml">java feed</a> not my <a href="http://radio.weblogs.com/0122027/rss.xml">general feed</a>.
<p>

For example, <a href="http://www.javablogs.com/ViewDaysBlogs.jspa?date=15&amp;month=3&amp;year=2003">yesterday's added entries</a> include "Radio Tidbit: Waypath It! Macro" and "The Hundred Year Language (update on "Bruce Eckel has an interesting blog")", even though neither of them were published on <a href="http://radio.weblogs.com/0122027/2003/04/15.html">15 April 2003</a>, and neither of them are published on my <a href="http://radio.weblogs.com/0122027/categories/java/">java channel</a>.</p><p>

My theory is this:  javablogs is correctly tracking the java feed to determine when my blog has changed, but is pulling from the general feed to obtain new entries.  That's why entries that were several days old and unrelated to Java suddenly got pulled in to the javablogs aggregator (because a java related post, "I/O Iterators for Java" finally came along).</p><p>

My test is this.  This entry is only categorized under my main feed.  It will sit here quietly in the <a href="http://radio.weblogs.com/0122027/rss.xml">general feed</a> and not the <a href="http://radio.weblogs.com/0122027/categories/java/rss.xml">java feed</a>, and will not appear on the <a href="http://javablogs.com/">javablogs</a> site until I post a new entry under my Java category, when it will pull in both that new and this old entry.</p><p>

I've noticed other folks posts sometimes bunch up in this way, I wonder if others have the same problem.</p><p>

I suspect the underlying cause for this is some minor bug in the javablogs record update process.  I had originally registered my general feed with javablogs, and later changed that record to only point to my java category.</p><p>

</p><div class="update">Update [16 April 2003]: I've just noticed that some others are <a href="http://dmartin.org/blojsom/blog/Java/?permalink=7390BBB3C66BBAA0C69BD42377883F1B.txt">complaining about the off topic content as well</a>.</div><p>

</p><div class="update">Update [22 April 2003]: This post appeared on javablogs on 18 April 2003 (two days after the initial posting).  I'm not sure why or how, but you can see it <a href="http://www.javablogs.com/ViewDaysBlogs.jspa?date=18&amp;month=3&amp;year=2003" title="JavaBlogs: Day's Blogs: 18 April 2003">here</a></div>