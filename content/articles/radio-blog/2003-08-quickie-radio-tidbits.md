---
active_tab: articles
title: Quickie Radio Tidbits
---
# Quickie Radio Tidbits

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 11 August 2003</b>
<ul>
<li>Radio now supports <a href="http://www.movabletype.org/trackback/" title="MovableType: TrackBack Development">TrackBack</a>.  See <a href="http://radio.userland.com/discuss/msgReader$26639" title="TrackBack for Radio">TrackBack for Radio</a> for details, but the gist of it is this: (a) enable TrackBack through your <a href="http://127.0.0.1:5335/system/pages/prefs?page=2.17" title="your (localhost) trackback preferences page">TrackBack preferences page</a> then (b) invoke the <tt>&lt;%trackbackLink%&gt;</tt> macro somewhere within your <a href="http://127.0.0.1:5335/system/pages/prefs?page=3.4" title="your (localhost) item template page">item template</a>. </li>
<li>As you can see, I've got trackback links turned on in this blog now.  I've also added direct (non-JavaScript) links to my comments and trackback pages.  I did this by adding <tt>&lt;%radio.weblog.getCommentLink(&lt;%itemNum%&gt;, adrblog)%&gt; </tt>and <tt>&lt;%radio.weblog.getTrackbackLink(&lt;%itemNum%&gt;, adrblog)%&gt;</tt> calls to my item template.</li>
<li>I've finally figured out where many of the built-in Radio macros are stored.  From the Radio application, go to <tt>Window:Radio.Root:system:verbs:radio:weblog</tt>.  The <tt>system/verbs</tt> tree has a number of nifty macros, including <tt>radio.weblog.getUrl</tt>, which generates the absolute URL of your Radio homepage.  This is the answer to a question I had <a href="http://radio.weblogs.com/0122027/stories/2003/04/11/radioTidbits.html#waypathit">previously asked</a>.</li>
<li>Another pair of interesting macros I discovered there are <tt>radio.macros.previousDayLink</tt> and <tt>radio.macros.nextDayLink</tt>, which should generate day-to-day links in your archive pages.  I've got this set up in my archives now, but there seem to be minor problems here and there.  For example, the previous day link from <a href="http://radio.weblogs.com/0122027/2003/07/16.html" title="The [L]GPL, Java and Asymmetry">Wednesday, 16 July 2003</a> goes to <a href="http://radio.weblogs.com/0122027/2003/07/14.html" title="Given enough eyeballs, are all trends shallow?">Monday, 14 July 2003</a>, skipping over the post on <a href="http://radio.weblogs.com/0122027/2003/07/15.html" title="my pet bug, or another example of how sun doesn't get community development">Tuesday, 15 July 2003</a>.</li>
</ul>
<p>
When I get a chance, I'll type these up for my <a href="http://radio.weblogs.com/0122027/stories/2003/04/11/radioTidbits.html" title="Radio Tidbits">Radio Tidbits</a> page.
</p><p>
PS: I'd love it if someone could point me to a definitive reference to Radio's scripting language.
</p>
