---
active_tab: articles
title: Wiki + Blog = PIM
---
# Wiki + Blog = PIM

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 22 October 2003</b>
<p>
I'm one of those people who's so obsessed with organization that he's poorly organized.  I'm constantly trying out new ways to manage the notes I scribble on various physical and electronic media, so much so that the frequency of change leads to greater disorganization.
</p><p>
I've tried a number of "information management" tools, including index cards, sticky notes, notebooks, a Franklin planner, Microsoft Outlook, and various outlining, mind-mapping and PIM programs, and found them all wanting in one way or another (maybe it's me).  Paper based systems were too hard to search and too static in their organization.  Lacking a PDA, electronic systems weren't portable enough.  No matter what the system, I'd always spend more time trying to set up organizational categories than I ever saved by using them. In fact I had pretty much broken the habit, falling back to a collection of loosely organized text files that I could easily scp to and from whatever workstation I was currently using.
</p><p>
About a year ago, I got a Sharp Zaurus, and since that addresses one of my recurring PIM complaints--having something that's always readily available, my hopes for finding the perfect PIM system were renewed.  I've played around with a number of the PIM systems available.  Using the bundled Address Book/Calendar/To Do List/Email Client was too jumbled.  The "outliner" <a href="http://iqnotes.kybu.sk/?page=index">IQNotes</a> was promising, but a single hierarchy is inflexible and using it to create dated journal entries requires too much manual effort.  In the end, I came back to a loosely organized collection of text files, this time stored on the Zaurus.
</p><p>
Back in my <a href="http://radio.weblogs.com/0122027/2003/03/28.html#a3" title="28 March 2003: First Post">first post</a>, I mentioned that one of the reasons I was interested in blogging is that I had become interested in journaling in general.  These two concepts--the search for the perfect organizational system and interest in journaling--interrelate.
</p><p>
As I'm sure I'm not the first to suggest, it seems that the ideal PIM system presents at least two perspectives on the information to be managed:
</p><p>
1) A time based view, answering such questions as "what have I been working with recently?" or "what else was I working on around that time?"
</p><p>
2) A "concept network" view, answering such questions as "what's related to this topic?" or "what else do I know about this subject?"
</p><p>
Clearly, I presume, blog-like software is an excellent starting point for the former, and wiki-like software is an excellent starting point for the former.  Fortunately, a number of projects have begun to explore combinations of the two, either by implementing a blog-as-wiki (like <a href="http://snipsnap.org/" title="snipsnap.org">SnipSnap</a> does) or by adding blogging features to a wiki engine (like <a href="http://www.jspwiki.org/" title="jspwiki.org">JspWiki</a> and no doubt others do).
</p><p>
Having a fair amount of Java experience (indeed, I've built a little wiki or two in Java), my first thought was to get a Java based wiki up and running on my Zaurus.  JspWiki looks nice, and like most Java-based wikis is Servlet/JSP based, so I endeavored to get a WAR-friendly Java Servlet engine up and running on my Zaurus.  Having tried both Tomcat and Jetty under both the <a href="http://www.esmertec.com/products/products_jeode.shtm" title="Jeode Java Runtime Environment">Jeode evm</a> and <a href="http://developer.java.sun.com/developer/earlyAccess/pp4zaurus/" title="J2ME Personal Profile for Zaurus">Personal Java cvm</a>, I came close, but fundamentally failed to do this.  (I note that my SL-5500 had just barely enough disk space or memory to do this as well.)
</p><p>
I briefly considered setting up a stand-alone (i.e., non-Servlet/JSP) Java wiki engine on the Zaurus, but without a moderate amount of development that seems like an awkward environment for templating and modification, and non-servlet Java web development feels like dead-end development. (Its only a matter of time before a reasonably micro servlet engine is available.)  That's when I stumbled across <a href="http://c2.com/cgi/wiki?PhlIp" title="Ward's Wiki: PhlIp">PhlIp</a>'s <a href="http://www.xpsd.com/MiniRubyWiki" title="XpSD Wiki: Mini Ruby Wiki">Mini Ruby Wiki</a>, which implements a featureful, stand-alone wiki server in around 1000 lines of Ruby code.
</p><p>
(For the record, one could readily build a similarly featured wiki in Java, and probably a number of languages, in roughly the same number of lines, it might not be as much fun.)
</p><p>
It still took me a while to get a Ruby interpreter up and running on the Zaurus (after trying a few different builds, I finally got the one from <a href="http://blade.nagaokaut.ac.jp/cgi-bin/scat.rb/ruby/ruby-talk/46111" title="Re: Ruby on the Sharp Zaurus PDA">Vincent Fiack</a> working), but the resulting binaries are smaller in terms of disk and memory footprint than the JVMs I was playing with.  Perhaps more importantly, as a purely interpreted language, the engine itself is easier to tweak.  And this gives me a reasonably good excuse to hack out some Ruby code.  I've already added/modified a few minor features, adding some simple blog-like features to the calendar features that already existed.  If I come up with something I'm not to embarrassed to share, I'll post it here or submit it to PhlIp's <a href="http://rubyforge.org/projects/minirubywiki" title="RubyForge: Project Info: MiniRubyWiki">RubyForge</a> project.
</p><p>
My only problem now is resisting the temptation to continually tweak the wiki engine code.
</p>