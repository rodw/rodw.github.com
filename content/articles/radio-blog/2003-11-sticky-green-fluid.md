---
active_tab: articles
title: What's this sticky green fluid?
---
# What's this sticky green fluid?

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 17 November 2003</b>
<p>
Oh, I see, I've been <a href="http://www.jroller.com/page/fate/?anchor=commons_primitives_is_vile_and">biled</a>.
</p><p>
While I think Hani understands <a href="http://jakarta.apache.org/commons/primitives/" title="Apache Jakarta Commons Primitives">commons-primitives</a> better than he lets on, I'm not sure the same is true of the peanut gallery that regularly fill up his comment threads.  Since Hani was nice enough to address me as "dear", I guess I'll go ahead and feed the trolls.
</p><p>
Hani's rants are most amusing when there's some content beyond vulgarity and <i>argumentum ad hominem</i>.  This post is thinner on that point than many, but let's see if we can find some actual, specific complaints to consider.
</p><p>
First, there's one point on which Hani and I are in agreement:
</p>
<blockquote>[F]or most applications, the performance gain is so trivial and insignificant that it really isn't worth the extra jar and complexity of using non-standard collection classes.</blockquote>
<p>
Agreed.  Moreover, the space savings (which in the case of an ArrayList varies from 50% to 94%, depending upon the primitive type being used) is also "trivial and insignificant" in light of the size and number of collections of primitives used by most applications.
</p><p>
So there you go.  Commons-primitives isn't universally applicable.  A damning critique indeed.
</p><p>
The rest of the post is less insightful.
</p><p>
Hani writes:
</p>
<blockquote>How on earth could they have missed that age old adage, 'premature optimisation is the root of all evil'?</blockquote>
<p>
Is this meant to suggest that commons-primitives was developed before there was a demonstrated need for it?  Hani, your omniscience has failed you, as a bit of research would have revealed.
</p><p>
Commons-primitives was initially developed in support of the <a href="http://axion.tigris.org/" title="Axion: Open Source Java Database">Axion database</a> project.  In Axion, we have need to store a significant number of collections of primitives, and at times those collections grow rather large.  Consider, for instance, a table with an integer-valued key field.  In Axion, depending upon the index type and configuration, there may be three primitive values lists created for this table--a list of positive long values representing file offsets by row identifier and a pair of lists of integers, one containing key values and the other the associated row identifier.  As initially developed using the java.util collections, this setup used 48 bytes per row in memory.   The current, commons-primitives based implementation uses only 12 bytes per row in memory, saving 75% of the space.  In my mind, increasing the number of rows that can be efficiently accessed by a factor of 4 (and getting a little performance boost to boot) is neither a "trivial" nor "insignificant" improvement.
</p><p>
Alternatively, perhaps this comment is meant to suggest that some <em>clients</em> might use commons-primitives without a demonstrated need for trying to reduce the size of their collections of primitives.  I'm not sure how this reflects upon commons-primitives itself.  As above, commons-primitives isn't universally applicable.   Perhaps optimistically, I'll continue working from the assumption that most folks have the critical analysis skills necessary to determine if a given library is applicable to their particular situation.
</p><p>
Hani's final group of complaints are concerned with object naming.  He writes:
</p>
<blockquote>Now maybe I'm old fashioned, but in my crazy world [List]Iterator is a [...] lot easier to work with [than] DoubleListIteratorListIterator.</blockquote>
<p>
Really?  That's odd, given that they have literally the same interface.  Perhaps this is meant to suggest that the name is verbose?  Sure, I'll concede that.  But it's also the conventional name, and a type that's rarely used.  Allow me to break it down for you.  &lt;Type&gt;ListIteratorListIterator is an adapter which makes a &lt;Type&gt;ListIterator look like a ListIterator.  That's why you find it in the <tt>adapter</tt> package.  That's why it follows the naming convention used by other Java adapters, like ByteArrayInputStream, StringReader and OutputStreamWriter.  That's also while you'll use it maybe a handful of times in a complete application.
</p><p>
Hani continues:
</p>
<blockquote>If your brain hasn't automatically shut down by now to protect itself from these vile names, then contemplate RandomAccessDoubleList.RandomAccessDoubleListIterator if you will.</blockquote>
<p>
Ah, yes. A protected-scope, inner class of an abstract base class goes right to the heart of the component's usability.  I think if you poke around a bit, you might be able to find an oddly named private variable as well.
</p><p>
Meanwhile, for the methods one actually uses on a regular basis, such as List.add or Iterator.next, the primitive collections allow a more concise, readable, implementation.  Consider, for example, taking the pairwise sum of two lists.  Here's an Object-based implementation:
</p>
<pre>List pairwiseSum(List lista, List listb) {
  List result = new ArrayList();
  for(Iterator a = lista.iterator(), b = listb.iterator(); a.hasNext(); ) {
    <b>result.add(
      new Integer(
        ((Integer)(a.next())).intValue() +
        ((Integer)(b.next())).intValue() ) );</b>
  }
  return result;
}</pre>
<p>
Here's a primitive version:
</p>
<pre>IntList pairwiseSum(IntList lista, IntList listb) {
  IntList result = new ArrayIntList();
  for(IntIterator a = lista.iterator(), b = listb.iterator(); a.hasNext(); ) {
    <b>result.add( a.next() + b.next() );</b>
  }
  return result;
}</pre>
<p>
Hani, I enjoy your rants as much as the next geek, but if the best you can do is troll the <a href="mailto:annoucements@jakarta">annoucements@jakarta</a> list to wait for a chance to say "but there are times when that library isn't helpful" (which, so far, has seems to be the point of every jakarta-commons rant you've posted to date), I may find another use for that slot in my aggregator.  Also, I've noticed an increase in the number of logical fallacies in your rants.  Being a jerk for dramatic effect might be entertaining, but being a misleading jerk is not.
</p>