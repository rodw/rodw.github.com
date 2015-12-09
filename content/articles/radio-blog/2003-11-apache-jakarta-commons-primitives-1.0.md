---
active_tab: articles
title: Apache Jakarta Commons Primitives 1.0 Released
---
# Apache Jakarta Commons Primitives 1.0 Released

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Thursday, 6 November 2003</b>
<p>
I've blogged a bit about the <a href="http://jakarta.apache.org/commons/primitives/" title="Apache Jakarta Commons Primitives">Primitives Component</a>
in <a href="http://radio.weblogs.com/0122027/2003/04/15.html#a22" title="Tuesday, 15 April 2003: I/O Iterators for Java">the</a> <a href="http://radio.weblogs.com/0122027/2003/04/07.html#a13" title="Monday, 7 April 2003: Rod's Open Source To Do List">past</a>, and I'm happy to note that <a href="http://article.gmane.org/gmane.comp.jakarta.commons.devel/34432" title="[ANN] Jakarta Commons Primitives 1.0 Released">commons-primitives now has an official 1.0 release</a>
(<a href="http://jakarta.apache.org/site/binindex.cgi#commons-primitives" title="links to download primitives from a mirror">binaries</a>) (<a href="http://jakarta.apache.org/site/sourceindex.cgi#commons-primitives" title="links to download primitives from a mirror">source</a>).
</p><p>
Currently Primitives provides Java-primitive based versions of various Collection interfaces, which is substantially smaller and faster than working with the Object-wrapper equivalents.  For instance, an ArrayShortList requires 1/10th the space of an ArrayList of Shorts, and an ArrayLongList requires 2/5ths the space of an ArrayList of Longs.  There's a substantial time savings as well, in that one isn't constantly "boxing" and "unboxing" the primitives and their Object equivalents when moving them in and out of the Collection.  There are readability and <a href="http://radio.weblogs.com/0122027/2003/04/15.html#a22" title="Tuesday, 15 April 2003: I/O Iterators for Java">other</a> advantages as well.
</p><p>
(And, no, as I understand it, neither the auto-boxing nor the generics features of JDK 1.5 will obviate the need for this library.  You could use auto-boxing to emulate the syntax of list.add(int), but the internal representation will still be Object based.)
</p><p>
We use the primitive collections fairly extensively within the <a href="http://axion.tigris.org/" title="Axion Java Database Engine">Axion database</a> project for things like indices and lists of row identifiers or data file offsets, indeed the code was originally developed there.
</p>
