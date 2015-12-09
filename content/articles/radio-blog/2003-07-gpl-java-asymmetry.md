---
active_tab: articles
title: The [L]GPL, Java and Asymmetry
---
# The [L]GPL, Java and Asymmetry

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 16 July 2003</b>
<p>
<a href="http://linuxintegrators.com/hl30/blog/" title="Andy Oliver's Blog">Andy</a> has finally <a href="http://article.gmane.org/gmane.comp.jakarta.poi.devel/5900" title="poi-dev@jakarta.apache.org: Re: [Followup] RE: Possibly Include HTMLParser Jar in contribcode?">tracked down</a> some answers on <a href="http://linuxintegrators.com/hl30/blog/technology/?permalink=LGPL+in+Java.html" title="LGPL in Java">applying the LGPL to Java</a>.  <a href="http://www.rollerweblogger.org/page/roller/20030716#for_java_lgpl_is_viral" title="For Java, LGPL is viral">Dave</a> and <a href="http://www.intertwingly.net/blog/1519.html" title="Two paths">Sam</a> had some additional comments.
</p><p>
A few points:
</p>
<ol>
<li><p>In his <a href="http://www.rollerweblogger.org/comments/roller/Weblog/for_java_lgpl_is_viral" title="Comments on For Java, LGPL is viral">comment thread</a> Dave suggests that "Class.forName() might also be a workaround", echoing <a href="http://radio.weblogs.com/0122027/2003/04/07.html#a12" title="7 April 2003: A Question on Applying the LGPL to Java">questions on the LGPL in Java I previously mentioned</a>.  The answers to those questions still aren't entirely clear to me, although the position of simply steering clear of LGPL/GPL code for Java is seems increasingly rational.</p></li>
<li><p>Sam writes "An example of something that does solve the issue: JDBC" but I'm not sure I follow.  Does this mean Class.forName?  In other words, I can use a LGPL'd database code as long as I never directly invoke the LGPL code?</p></li>
<li><p>Andy writes "Thus we need a license for Java that guarantees contributors will donate back to the library that does not infect the outside code."</p>
<p>Do we?  Why?  I think there is sufficient incentive to release most derivative works anyway, and if someone doesn't, who cares?  The open source project still gets more users, more support, more field testing, mo' better, than it otherwise would.  If you make a few bucks selling proprietary extensions to my open source code, more power to you.  (You run the threat, of course, of the community re-implementing your proprietary extensions in an open source fashion, thus destroying your business model.  This disincentive to selling proprietary derivatives augments the incentives for releasing those derivatives to the community for further extension, testing, maintenance and support.)</p></li>
</ol>
<p>
A big issue I have with the [L]GPL is the asymmetry of the license.  If Company X releases code under the [L]GPL, I'm less troubled by the need to similarly open my derivative works (although the people who sign my paycheck quite reasonably have a different perspective on that--there is some work that is best kept proprietary, if only because it pays the bills) than by the fact that Company X, typically acting as the "umbrella" copyright holder (to both their original work and my contributions) now has more rights to my contributions than I do.  Under the viral GPL, I <i>cannot</i> use the larger work under any terms but those provided by the GPL, and in isolation my contributions are probably pretty much useless.  Yet Company X (as the holder of the collective copyright) is free to take my (donated) work and theirs and release (or sell) it under whatever terms they choose.  I wonder if Stallman had foreseen this consequence when constructing the GPL.
</p><p>
The "umbrella" copyright holder on a BSD- or ASF-type license has the same rights of course, but the license grants me the ability to do pretty much whatever I want with the larger work, short of claiming it all to be my own.  There is very little that the copyright holder can do that I, as a user let alone contributor, cannot also do.  It seems to me that the license with the least restrictive terms is the one that is most "free".
</p>
