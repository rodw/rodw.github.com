---
active_tab: articles
title: LGPL and Java - More confused than ever
---
# LGPL and Java - More confused than ever

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Friday, 18 July 2003</b>
<p>
After <a href="http://linuxintegrators.com/hl30/blog/technology/?permalink=LGPL+in+Java.html&amp;page=comments" title="comments on Andy's 'LGPL in Java'">reading</a> <a href="http://www.rollerweblogger.org/comments/roller/Weblog/for_java_lgpl_is_viral" title="comments on Dave's 'For Java, LGPL is viral.'">the</a> <a href="http://www.intertwingly.net/blog/1519.html" title="comments on Sam's 'Two paths'">various</a> <a href="http://radiocomments2.userland.com/comments?u=122027&amp;p=56" title="comments on Rod's 'The [L]GPL, Java and Asymmetry'">comment</a> <a href="http://developers.slashdot.org/developers/03/07/17/2257224.shtml" title="comments on Slashdot's 'LGPL is Viral for Java'">threads</a>, and seeing Andy and David's exchange in <a href="http://superlinksoftware.com/text/lgpl.txt">a bit more context</a>, I'm more confused than ever.
</p><p>
As quoted by Andy, Roy wrote:
</p>
<blockquote>What the FSF needs to say is that inclusion of the external interface names (methods, filenames, imports, etc. defined by an LGPL jar file, so that a non-LGPL jar can make calls to the LGPL jar's implementation, does not cause the including work to be derived from the LGPL work even though java uses late-binding by name (requiring that names be copied into the derived executable), and thus does not (in and of itself) cause the package as a whole to be restricted to distribution as (L)GPL or as open source per section 6 of the LGPL.</blockquote>
<p>
and Andy asked:
</p>
<blockquote>Is this statement true with regards to the use of LGPL Java libraries by non-LGPL Java libraries?</blockquote>
<p>
To which David replied:
</p>
<blockquote>If I understand the statement correctly, yes -- that's exactly what section 6 is for.</blockquote>
<p>
Seen in context, my reading is that LGPL does not infect Java code that simply references, invokes methods of, or extends an LGPL'ed class.  Brad Kuhn's comments mentioned in the slashdot "update" seem to be reiterating that position.  I see this as saying all of my <a href="http://radio.weblogs.com/0122027/2003/04/07.html#a12" title="7 April 2003: A Question on Applying the LGPL to Java">examples</a> are not infectious.  Joe's <a href="http://radiocomments2.userland.com/comments?u=122027&amp;p=12" title="comments on 'A Question on Applying the LGPL to Java'">comments</a> on that post focus on the word "distribute" in what may be a clarifying way (i.e., the in-memory, late-bound version of code that combines LGPL and non-LGPL code is not distributed, it is assembled at runtime, and therefore not in violation).
</p><p>
I hesitate to ask but the question seems inevitable: what does it mean to apply aspects to LGPL'ed code?  If I hook in code to a cut-point in some LGPL'ed code, is my cut-point code infected?  Does it matter if my AOP-system is implemented with byte-code manipulation, reflection or composition?  Does it matter if this happens at runtime or at compile time?  It seems that it would, and that feels like a fairly arbitrary distinction in some ways.
</p><p>
IANAL and this makes my head spin.  I'm going back to writing code.  Someone let me know when there's a clear answer here.  (Unfortunately I think it may take a court to decide that.  Let's hope it never comes to that.)
</p>