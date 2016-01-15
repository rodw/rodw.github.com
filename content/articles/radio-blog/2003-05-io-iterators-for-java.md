---
active_tab: articles
title: I/O Iterators for Java
---
# I/O Iterators for Java

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 15 April 2003</b>
<p>
While fleshing out the remaining parts of the <a href="http://cvs.apache.org/viewcvs/jakarta-commons/collections/src/java/org/apache/commons/collections/primitives/" title="package org.apache.commons.collections.primitives">primitives</a> package in <a href="http://jakarta.apache.org/commons/" title="Apache's Jakarta Commons Collections">Commons Collections</a>, a simple but potentially powerful feature became apparent.  Using the byte-based primitive collections, it's not only easy but also efficient to bring together the I/O and Collections APIs via <a href="http://cvs.apache.org/viewcvs.cgi/jakarta-commons/collections/src/java/org/apache/commons/collections/primitives/adapters/io/" title="package org.apache.commons.collections.primitives.adapters.io">ByteIterator/InputStream adapters</a>. <p>
This allows one to treat any InputStream as a ByteIterator (and hence as an Iterator over Bytes)  without resorting to a byte array buffer.  This means that Iterator-based APIs like the <a href="http://jakarta.apache.org/commons/sandbox/functor/" title="Apache's Jakarta Commons Functor">functor</a> <a href="http://jakarta.apache.org/commons/sandbox/functor/apidocs/org/apache/commons/functor/core/collection/CollectionAlgorithms.html" title="CollectionAlgorithms">algorithms</a> can be applied to I/O streams.  Similarly, this allows one to treat any ByteCollection (or Collection of Bytes) as a source for InputStreams.  This means that stream-based APIs can be applied to ByteCollections and Collections of Bytes.</p><p>

This brings Java one small step closer to the conceptual uniformity and resulting combinatorial expressiveness enjoyed by languages like Lisp.  This is reason enough in my mind to extend the primitive collections to Char/char and to Reader-adapters as well.</p><p>

(Also see <a href="http://radio.weblogs.com/0122027/2003/04/07.html#a13" title="Rod's Open Source To Do List">this related post</a>.)</p><p>

</p><div class="update">Update: [17 April 2003] I've added char types to the primitives package, as well as CharIterator/Reader adapters.</div>