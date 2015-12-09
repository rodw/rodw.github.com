---
active_tab: articles
title: Everything new is old again
---
# Everything new is old again

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 27 August 2003</b>
<p>
Recently, <a href="http://ww.telent.net/diary/2003/8/#24.85680" title="Daniel Barlow -- Diary: Sun, 24 Aug 2003 23:48:00 GMT">Daniel</a>, <a href="http://www.sauria.com/blog/2003/08/27#527" title="Yep, time to stop copying">Ted</a>, <a href="http://linuxintegrators.com/hl40/blog/blog/?permalink=0021.html" title="OT: Everyone in open source/free software should read this like 10 times">Andy</a> and <a href="http://www.cincomsmalltalk.com/blog/blogView?showComments=true&amp;entry=3239427426" title="Time to invent">James</a> all point to a <a href="http://lists.fifthvision.net/pipermail/arch-users/2003-May/027591.html" title="[arch-users] [OT] Red Hat falls into ultimate hypocrisy?">post</a> by Tom Lord over on the <a href="http://lists.fifthvision.net/pipermail/arch-users/" title="The arch-users Archives">arch-users</a> mailing list.
</p><p>
Tom's comments are made in the context of <a href="http://www.sun.com/smi/Press/sunflash/2003-05/sunflash.20030519.4.html" title="Sun to Distribute Red Hat Enterprise Linux, Red Hat to Distribute Sun's Java">Red Hat's agreement to distribute Sun's JVM as part of their "Enterprise Linux" offering</a>, a story that (although I regularly program in Java and I'm writing this post on Red Hat box) quite frankly I haven't been following at all.  Much of what is interesting about Tom's comments may be a function of reading them outside of this context.
</p>
<p>
I find this a striking post, among other reasons, because it raises several distinct responses from me:
</p>
<dl><p>

<dt><b>1. What are we building?</b></dt>
<dd>
</dd></p><p>
Tom suggests:
</p>
<blockquote>
<p>There has been a sort of tension in the commercial free operating system world:</p>
<p>(a) Are we building a free alternative to proprietary software?</p>
<p>or</p>
<p>(b) Are we building a commodity, $0-price OS component to lower the cost of proprietary applications?</p>
</blockquote>
<p>For my part, this is a false dichotomy.  In my open source efforts I'm not trying to do either of these, but rather to simply <b>build something useful</b>.  Whether this something is an alternative or adjunct to proprietary software is incidental at best.  For that matter, whether this something is truly innovative or just a more useful variation of a component that already exists isn't terribly significant either (although the utility of copying something that's already readily available is limited of course).
</p><p>
I wonder if this a symptomatic of differing perspectives between the BSD-style and GPL-style camps of open source development.
</p>
<p>

<dt><b>2. How do we build it?</b></dt>
<dd>
</dd></p><p>
Tom writes:
</p>
<blockquote>
<p>
If the goal is (a), then we need an architect.  We need to come up with an inexpensive-to-develop architecture that, nevertheless, contains viable solutions for the needs of our markets.
</p><p>
If the goal is (b), then we need an anti-architect.  We need to come up with impossibly-expensive-to-fully-develop clone projects of proprietary software to draw off the energy of volunteer contributors who might otherwise undermine the value of the proprietary applications we expect to drive revenues for our distro.
</p>
</blockquote>
<p>
Here option B is obviously a straw-man, so of course I'll follow option A.  But while I agree we need "an inexpensive-to-develop architecture", and the word "architect" appears in my job title, I'll suggest a evolutionary approach is the best way to get there.  Inexpensive-to-develop systems of any interesting size, let alone federations of such systems, are rarely "architected" in a traditional sense.  <b>What we need is an environment where diverse ideas are allowed to compete, cooperate and breed</b>.
</p>
<p>

<dt><b>3. How hard is a Java implementation, really?</b></dt>
<dd>
</dd></p><p>
Running throughout Tom's post is the notion that a reasonably complete Java environment is simply too complicated to implement in an open source fashion:
</p>
<blockquote>
<p>
For example, under (a), we would probably have to admit that trying to
clone all the Java libraries _and_ build a competitive Java
implementation is too expensive a course of action.  While we might be
perfectly happy to ship a low-end, incomplete implementation to help
the low-end of the market, in the long run, we'd want to look for a
more clever solution: something that can compete with Java and Java
libraries on functionality, but that is cheaper to build in the first
place (and cheaper and more effective to apply, of course).
</p>
<p>[...]</p>
<p>
[Y]ou can also make things expensive to
develop by structuring them as an object oriented framework that you
then spend zillions on filling out with subclasses, or by making
really hard components (like finely tuned JIT compilers and garbage
collectors) critical to implementations.
</p>
<p>[...]</p>
<p>
Some architectures, such as the Java environments and the
view-tree/component-based GUI frameworks, are ideal for large
proprietary software companies with large command-and-control armies
of developers and QA practitioners.   Those architectures are a
terrible fit for the loose confederation of generally underresourced
developers in the free and open source software world.
</p>
</blockquote>
<p>
Putting aside questions of productivity and effectiveness, and the "enterprise" libraries for the moment, how hard is the core Java environment to implement, really?  More difficult than a Lisp implementation, for example, but I suspect it's not substantially more difficult to implement than, say, a C implementation, and probably on par with something like Ruby.
</p>
<p>

<dt><b>4. Where are the alternative Java implementations then?</b></dt>
<dd>
</dd></p><p>
Well, <a href="http://dmoz.org/Computers/Programming/Languages/Java/Implementations/" title="DMOZ: Computers/Programming/Languages/Java/Implementations">there are several</a> actually, although relatively few complete or robust ones.  Why?  Perhaps one compelling reason is that proprietary yet free (as in beer) Java runtime environments are readily available for most platforms.
</p>
<p>Besides, who really wants another Java platform anyway...</p>
<p>

<dt><b>5. "Yep, time to stop copying"</b></dt>
<dd>
</dd></p><p>
Like Daniel and Ted, I find the general call for innovation dead on:
</p>
<blockquote>
<p>
For a long time, the right strategy for GNU was to build a basic unix replacement differentiated primarily by licensing. [...]</p><p>
Well, that part's done and the strategy won.
</p><p>
[...]
</p><p>
If the goal is still "(a) build a free alternative to proprietary software", then a new strategy is called for: competition on <i>software architecture</i>, not just licensing.
</p>
</blockquote>
<p>
Here Tom and I are in violent agreement.  If I were building an open source compiler and/or language-platform, I'd certainly think twice about doing it on <a href="http://www.tbray.org/ongoing/When/200x/2003/07/12/WebsThePlace" title="The Webs the Place">Sun's plantation</a>--not because it's too hard; in part (as before) because the utility of copying something that's already readily available is limited; but mostly because I think you could construct more useful environments.
</p><p>
It's worth applying this, independently, to the "enterprise libraries" I set aside earlier.  Are J2EE implementations like <a href="http://incubator.apache.org/projects/geronimo.html">Apache Geronimo</a> or <a href="http://jboss.org">JBoss</a> building something "useful" or a "$0-price OS component to lower the cost of proprietary applications"?  From my perspective, I've found some pieces of the J2EE suite to be quite useful, and others seem to fit Tom's "proprietary vendor" strategy.
</p>
<p>

<dt><b>6. Except when it isn't</b></dt>
<dd>
</dd></p><p>
It's interesting to observe how quickly the arch-users thread evolves from "we need a new architecture" to "we need a Lisp platform".  (It's doubly interesting to note how often that seems to be the case.)  And perhaps that really is what we need.  But there's a big difference between "time to stop copying" and "time to stop copying Java".
</p><p>
(Actually, although I think one could do much better than to copy Java, you could also do much worse.  It would be naive to think that Java's success is purely coincidental or purely the result of marketing muscle.  They must be doing something right.)
</p><p>
More generally, it would be naive to think that what we need is innovation for innovation's sake, and I think deciding we need to resurrect a 40 year old platform is evidence of this fact.
</p><p>

<dt><b>7. What are we building, revisited.</b></dt>
<dd>
</dd></p><p>Tom writes:</p>
<blockquote>
Nowadays, the proprietary competition is about databases, and
productivity apps, and browsers, and middleware layers.  The software
we're competing against is not like unix: it isn't simple; it wasn't
built by a small number of people; it's a moving target.  It
isn't a tractable project to clone this proprietary software under
different licensing.
</blockquote>
<p>
This point is puzzling.  Certainly we don't mean to assert that it is impossible to successfully build
<a href="http://www.mysql.com/" title="MySQL, &quot;the world's most popular open source database&quot;">open</a>
<a href="http://www.postgresql.org/" title="PostgreSQL, &quot;the world's most advanced open source database software&quot;">source</a>
<a href="http://axion.tigris.org/index.html" title="Axion, the Java Database">databases</a>,
<a href="http://mozilla.org/" title="Mozilla.org">web</a>
<a href="http://www.konqueror.org/" title="Konqueror - Web Browser, File Manager - and more!">browsers</a>,
or <a href="http://zope.org/" title="Zope: an open source application server">middleware</a>
<a href="http://www.mico.org/" title="MICO: a freely available and fully compliant implementation of the CORBA standard">servers</a>,
do we?
Do we assert it is a bad idea to do so?
</p><p>
While I certainly think we should look for innovative ways to solve the sorts of problems these projects do,
it would be a mistake to believe that the existing approaches don't offer something of value simply because they have strong proprietary implementations as well--just as it would have been a mistake for the GNU project to reject a pipe-and-filter architecture simply because a strong implementation was once controlled by Bell Labs.  I don't think it is tractable to create a wholly new software paradigm--one that doesn't contain variations of n-tier, database and web technologies--out of thin air.  We need new ideas, but we need old ones too.
</p>