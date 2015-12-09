---
active_tab: articles
title: Jason Horman's WikiDoclet
---
# Jason Horman's WikiDoclet

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 9 April 2003</b>
<p>
Found a link to <a href="http://www.jhorman.org/wikidoclet" title="WikiDoclet: wiki formatting for javadoc">WikiDoclet</a> <a href="http://www.thauvin.net/blog/news.jsp?date=2003-04-08#733" title="Erik's Weblog: 2003-04-08: #733">on</a> <a href="http://www.thauvin.net/blog/" title="thauvin.net/blog/">Erik Thauvin's weblog</a>.  This is a custom doclet that allows one to write JavaDoc comments with <a href="http://twiki.org/" title="twiki.org">TWiki</a>-style markup rather than HTML markup.  For example, one could write:
</p>

```java
/**
 * First Para.
 *
 * Second Para.
 *    * bullet one
 *       * _sub_ bullet
 *    * bullet two
 */
```

instead of:


```java
/**
 * First Para.
 * <p/>
 * Second Para.
 * <ul>
 *   <li>
 *    bullet one
 *    <ul>
 *     <li><i>sub</i> bullet</li>
 *    </ul>
 *   </li>
 *   <li>bullet two</li>
 * </ul>
 */
```

<p>Neat, huh?  Wish I'd thought of that.</p><p>

I haven't tried it yet, but it seems like a really useful tool for those who find that HTML formatting within JavaDoc comments interrupts the <a href="http://c2.com/cgi/wiki?MentalStateCalledFlow" title="Mental State Called Flow">flow</a> of coding.
  </p>
