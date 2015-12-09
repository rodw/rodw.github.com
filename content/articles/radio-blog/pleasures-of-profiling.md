---
active_tab: articles
title: Are concrete parent classes a code smell?
---
# The Pleasures of Profiling

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>21 April 2003</b>

## Introduction

<p>
Prompted by <a href="http://www.nicklothian.com/" title="BadMagicNumber, Nick's Weblog">Nick</a>'s <a href="http://www.nicklothian.com/blog/2003/04/29/#axion1" title="29 Apr 2003: Axion">post</a> about <a href="http://axion.tigris.org/" title="Axion, an Open Source Java Relational Database Engine">Axion</a>'s
 insert performance and some internal product delivery schedules, I've
been doing some profiling and tuning of Axion's performance (with some <a href="http://axion.tigris.org/servlets/ReadMsg?list=dev&amp;msgNo=471" title="Performance of Axion inserts">good</a> <a href="http://axion.tigris.org/servlets/ReadMsg?list=dev&amp;msgNo=478" title="btree index performance improved by ~100x">results</a>).  I'm reminded of how much I truly enjoy this activity.
</p><p>
I can tell you don't believe me, so I took some notes and wrote up this brief account.
</p><p>
We use Axion at my day job as the embedded database within a family of
desktop applications we sell at retail.  Many of Axion's features were
developed in support of these applications.  Driven by retail sales,
these products have a roughly annual release cycle.  We're coming up on
the delivery dates for the 2004 release, and so it's time to revisit
some of the new features and functionality with an eye toward
performance tuning.
</p><p>
In last year's product, roughly the <a href="http://axion.tigris.org/releases/1.0M0/index.html" title="Axion: Releases: 1.0 Milestone 0">Milestone 0</a>
 release of Axion, the primary index type was essentially a sorted
array, held in memory and navigated by binary search.  This simple
strategy was and is quite fast: data can be served at tens of thousands
rows per second on low end desktop hardware.  <a name="simpletest"></a>In
 a simple test that executes a query over a 5,000 row database and reads
 back the first 10 rows in that result set, repeated 5,000 times (the
test that is used throughout this profiling session), I obtain the
following numbers:
</p><p>
Selecting indexed data only (for example, "SELECT val FROM foo WHERE val &gt; ?", where foo.val is the indexed column):
</p>

```
  ~4,668.5 queries/second
 ~46,685.3 rows/second
```

<p>
Selecting both indexed and non-indexed data (for example, "SELECT val,
val2 FROM foo WHERE val &gt; ?", where foo.val is the indexed column,
but foo.val2 is also read):
</p>

```
  ~2,146.8 queries/second
 ~21,468.4 rows/second
```

<p>
In exchange for this performance and simplicity, there are a few
drawbacks to the array index: (1) initializing the database is
relatively slow, since the entire index file must be read into memory on
 startup, (2) the entire index is
held in memory at all times, and (3) as currently implemented, the array
 index must be re-written in its entirety when modified, making it
inappropriate for read/write use.
</p><p>
In the past year, a BTree index type (see Knuth's <i>The  Art  of  Computer  Programming,  Vol.  3: Sorting and Searching</i>, pages 471-480) <a href="http://axion.tigris.org/servlets/NewsItemView?newsItemID=231" title="Axion: News: Oct 23, 2002: New index type for Axion: BTree">was added</a>
 to Axion.  The BTree data structure is more lazily loaded than the
array index, and is more appropriate for mixed read/write operations.
</p><p>
While we've been using the BTree index type for a while (it's part of the <a href="http://axion.tigris.org/releases/1.0M1/index.html" title="Axion: Releases: 1.0 Milestone 1">Milestone 1</a>
 release of Axion) and it will likely be the primary index type used by
our 2004 generation of products, we hadn't yet rigorously profiled or
tuned its performance.
</p>

## The initial profile

<p>
As <a href="#simpletest">above</a>, we'll use a simple test case for
profiling purposes.  We'll use a 5,000 row table of pairs of relatively
short strings, with a btree index on one of the columns:
</p>

```sql
CREATE TABLE mytable ( first VARCHAR2, second VARCHAR2 );
CREATE BTREE INDEX myindex ON mytable ( first );
```

<p>
Once populated, we'll execute a simple comparison query over this table, and read back the first 10 rows of each ResultSet:
</p>

```java
PreparedStatement stmt = conn.createStatement("SELECT first, second FROM mytable WHERE first &gt; ?");
for(int i=0;i&lt;SELECT_COUNT;i++) {
  stmt.setString(1,WORDS[i%WORDS.length]);
  ResultSet rset = stmt.executeQuery();
  for(int j=0;j&lt;ROW_COUNT &amp;&amp; rset.next();j++) {
    rset.getString(1);
    rset.getString(2);
  }
  rset.close();
}
stmt.close();
```

<p>
The block above is timed, with a <code>SELECT_COUNT</code> of <code>5,000</code> and a <code>ROW_COUNT</code> of 10, for each of the profiling runs described below.
</p><p>
In the first pass, I found the following, disappointing, results:
</p>

```
     ~12.0 queries/second
    ~120.5 rows/second
```

<p>
This is roughly 1/200<sup>th</sup> the performance of the array index in the same test.
</p>
<p>
In order to figure out where the application is spending its time, I used <a href="http://java.sun.com/j2se/1.4.1/docs/guide/jvmpi/jvmpi.html#hprof" title="The HPROF Profiler Agent">the hprof tool</a>
 that comes bundled with the JDK.  The CPU SAMPLES profile (which takes
many, many "snapshots" of the running program and counts the number of
times the application is executing a given call stack, providing a rough
 approximation of where the application is spending its time) for this
initial configuration looked like this:
</p>

```
rank   self  accum   count trace
   1 24.55% 24.55%   58855  3521
      o.a.c.c.p.RandomAccessIntList.subList(.java:175)
      o.a.u.ObjectBTree.getAllFrom(.java:686)
      o.a.u.ObjectBTree.getAllFrom(.java:683)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:126)
      o.a.e.r.RebindableIndexedRowIterator.reset(.java:73)
      o.a.e.r.RebindableIndexedRowIterator.<init>(.java:69)
   2 24.30% 48.85%   58254  3527
      o.a.c.c.p.RandomAccessIntList.listIterator(.java:171)
      o.a.c.c.p.RandomAccessIntList.listIterator(.java:167)
      o.a.u.ObjectBTree.getAllFrom(.java:686)
      o.a.u.ObjectBTree.getAllFrom(.java:683)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:126)
      o.a.e.r.RebindableIndexedRowIterator.reset(.java:73)
   3 24.18% 73.03%   57966  3534
      o.a.c.c.p.a.IntListIteratorListIterator.wrap(.java:91)
      o.a.u.ObjectBTree.getAllFrom(.java:686)
      o.a.u.ObjectBTree.getAllFrom(.java:683)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:126)
      o.a.e.r.RebindableIndexedRowIterator.reset(.java:73)
      o.a.e.r.RebindableIndexedRowIterator.<init>(.java:69)
   4 23.82% 96.85%   57102  3524
      o.a.c.c.p.RandomAccessIntList$RandomAccessIntSubList.<init>(.java:362)
      o.a.c.c.p.RandomAccessIntList.subList(.java:175)
      o.a.u.ObjectBTree.getAllFrom(.java:686)
      o.a.u.ObjectBTree.getAllFrom(.java:683)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:126)
      o.a.e.r.RebindableIndexedRowIterator.reset(.java:73)
   5  0.30% 97.16%     730  3535
      j.u.ArrayList.ensureCapacity(.java:165)
      j.u.ArrayList.add(.java:350)
      o.a.u.ObjectBTree.getAllFrom(.java:686)
      o.a.u.ObjectBTree.getAllFrom(.java:683)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:126)
      o.a.e.r.RebindableIndexedRowIterator.reset(.java:73)
```

<p>
Note that roughly 97% of the time is spent in the first four call trees, almost evenly split between them.
</p>

## The first round of refactoring/tuning:

<p>
At a first glance, we see that 97% of our time is spent within the primitives package of <a href="http://jakarta.apache.org/commons/collections/" title="Apache's Jakarta Commons Collections">commons-collections</a>,
 but this is a little misleading.  By inspection alone we can see that
those methods aren't especially wasteful.  I suspect it's not that this
code is extremely expensive, but rather that we execute it often enough
that small inefficiencies begin to add up.
</p><p>
Digging just a little deeper, we see that all four of those top call
trees are executing the ObjectBTree.getAllFrom method, indeed, they all
share the bottom four lines in the tree.  The problematic section of the
 code looks like this (I've broken down line 686 for display here.):
</p>

```java
public ListIterator getAllFrom(Object key)
throws IOException, ClassNotFoundException {
    ListIterator result = null;
    ArrayList its = new ArrayList();
    int i = findNearestKeyAbove(key);
    for ( ; i &lt; size() + 1; i++) {
        if (!isLeaf()) {
          its.add(getChild(i).getAllFrom(key)); // 683
        }
        if (i &lt; size()) {
          its.add(                              // 686
                IntListIteratorListIterator.wrap(
                    getValues()
                        .subList(i, i+1)
                            .listIterator()));
        } else {
            break;
        }
    }
    if (its.isEmpty()) {
        result = Collections.EMPTY_LIST.listIterator();
    } else {
        result = new ListIteratorChain(its);
    }
    return result;
}
```

<p>
As we can see, the common line is doing several things:
</p>

<ul>
 <li>It obtains a one element sublist of the IntList returned by getValues()</li>
 <li>It obtains an IntListIterator from that sublist.</li>
 <li>It adapts that IntListIterator to the ListIterator interface.</li>
 <li>It adds that ListIterator to a List of ListIterators, which is used to populate a ListIteratorChain.</li>
</ul>

<p>
My first reaction is that creating the one element sublist is the
expensive part, and that to remove it it may make sense to have
ListIteratorChain maintain a heterogeneous list of ListIterators and
Integers, to avoid all this wrapping and conversion.  But that sounds
like a fairly complicated change, and there are a number of problems
here.  Let's make a note of the single-element-sublist problem, and see
what we can do about those other problems first.
</p>
<p>
First, consider the ListIteratorChain (which "chains" together a number
of ListIterators into a single ListIterator).  The interface to this
class has been bothering me for a little while now.  We construct a
chain out of a List of ListIterators, but there's nothing in the
directly in the implementation or the interface to enforce that.  More
than once I've run into problems of adding the wrong kind of element to
that List, and when this happens, the problem is reported while walking
the ListIteratorChain--far from the point where the problem was actually
 introduced.  Let's first convert ListIterator chain to build up its own
 list internally by adding a addIterator(ListIterator) method and
deprecating the ListIteratorChain(List) constructor.
</p><p>
Second, if you follow this code through, we see that ListIteratorChain
is always iterating over Integer values (Row identifiers in our case).
We can add more type-safety, and skip the
IntListIterator-to-ListIterator conversion, as well as later
Integer-to-int conversion, by changing ListIteratorChain to
IntListIteratorChain.
</p><p>
After these changes, the ObjectBTree.getAllFrom method looks like this:
</p>

```java
public IntListIterator getAllFrom(Object key)
  throws IOException, ClassNotFoundException {
    IntListIteratorChain result = new IntListIteratorChain();
    int i = findNearestKeyAbove(key);
    for ( ; i &lt; size() + 1; i++) {
        if (!isLeaf()) {
          result.addIterator(getChild(i).getAllFrom(key));                // 699
        }
        if (i &lt; size()) {
          result.addIterator(getValues().subList(i, i+1).listIterator()); // 702
        } else {
            break;
        }
    }
    return result;
}
```

<p>
(Note that by constructing the ListIteratorChain via addIterator, we no
longer need to create an empty iterator as we did in the old line 692.
Instead, we can just rely upon an empty ListIteratorChain.).
</p>
<p>
With these changes in place, let's re-profile.  Here's the performance test:
</p>

```
     ~44.5 queries/second
    ~445.4 rows/second
```

<p>
which shows a good improvement already (a factor 4 or so).  Here's the hprof profile:
</p>

```
rank   self  accum   count trace
   1 32.53% 32.53%   63181  3521
      o.a.c.c.p.RandomAccessIntList.listIterator(.java:171)
      o.a.c.c.p.RandomAccessIntList.listIterator(.java:167)
      o.a.u.ObjectBTree.getAllFrom(.java:702)
      o.a.u.ObjectBTree.getAllFrom(.java:699)
      o.a.u.ObjectBTree.getAllFrom(.java:691)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:127)
   2 31.96% 64.50%   62073  3515
      o.a.c.c.p.RandomAccessIntList.subList(.java:175)
      o.a.u.ObjectBTree.getAllFrom(.java:702)
      o.a.u.ObjectBTree.getAllFrom(.java:699)
      o.a.u.ObjectBTree.getAllFrom(.java:691)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:127)
      o.a.e.r.RebindableIndexedRowIterator.reset(.java:73)
   3 31.77% 96.27%   61706  3518
      o.a.c.c.p.RandomAccessIntList$RandomAccessIntSubList.<init>(.java:362)
      o.a.c.c.p.RandomAccessIntList.subList(.java:175)
      o.a.u.ObjectBTree.getAllFrom(.java:702)
      o.a.u.ObjectBTree.getAllFrom(.java:699)
      o.a.u.ObjectBTree.getAllFrom(.java:691)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:127)
   4  0.24% 96.50%     458  3565
      o.a.e.r.LazyRowRowIterator.setCurrentRow(.java:154)
      o.a.e.r.LazyRowRowIterator.next(.java:110)
      o.a.e.r.DelegatingRowIterator.next(.java:80)
      o.a.e.r.AbstractFilteringRowIterator.setNextRow(.java:221)
      o.a.e.r.AbstractFilteringRowIterator.hasNext(.java:98)
      o.a.e.r.ChainedRowIterator.hasNext(.java:121)
```

<p>
We still spend roughly 97% of the time in the getAllFrom method, but now we're down to three calls instead of four.
</p>

## The second round of refactoring/tuning:

<p>
You may have noticed that the getAllFrom method is recursive.  At each
recursive step, it creates an IntListIteratorChain, and when returned,
it adds this chain to the "parent" chain.  The result is a tree of
IntListIteratorChains, looking like a single IntListIterator.  If we
create a private version of getAllFrom that accepts the
IntListIteratorChain to add to, we can flatten this tree (much like a
String generating method that accepts a StringBuffer to append to).  For
 some reason I neglected to profile this change, I wonder how much of a
difference it made in and of itself.
</p>
<p>
We also find that the vast majority of our time is still spent in that
problematic line (now line 702) of ObjectBTree.getAllFrom, which reads:
</p>

```java
chain.addIterator(getValues().subList(i, i + 1).listIterator());
```

<p>
As before, this creates an IntListIterator over a single element sublist and adds it to the IntListIteratorChain.
</p><p>
Looking at the surrounding code, one finds we do this several times, in
both ObjectBTree and BTree.  A simple refactoring can make this both
cleaner and more efficient:
</p><p>
First, we add a version of IntListIteratorChain.addIterator that accepts a single <code>int</code>
 value, which we could naively stick in an ArrayIntList and obtain its
ListIterator as a first pass.  This removes a tricky bit of duplicated
code, at the very least, and may actually be more performant that
constructing the single-element sublist (I don't really know, I didn't
profile that version.)
</p><p>
Second, let's introduce a new IntListIterator implementation to handle
this special case of iterating over a single element list.  The
implementation is trivial, I'll just stick it in an inner class of
IntListIteratorChain for now.  (It may make sense to move it over to
commons-collections eventually.)
</p><p>
Our getAllFrom method now reads:
</p>

```java
private void getAllFrom(Object key, IntListIteratorChain chain)
  throws IOException, ClassNotFoundException {
    int i = findNearestKeyAbove(key);
    for (; i &lt; size() + 1; i++) {
        if (!isLeaf()) {
          getChild(i).getAllFrom(key,chain);     // 699
        }
        if (i &lt; size()) {
          chain.addIterator(getValues().get(i)); // 702
        } else {
            break;
        }
    }
}
```

<p>
With those two changes implemented, let's profile again.  Now we see an order of magnitude improvement in throughput:
</p>
```
    ~141.6 queries/second
  ~1,415.6 rows/second
```
  
<p>Our CPU SAMPLES dump is looking cleaner as well, we're down to one major bottleneck trace:</p>

```
rank   self  accum   count trace
   1 89.51% 89.51%   61188  3506
      o.a.u.IntListIteratorChain.addIterator(.java:74)
      o.a.u.ObjectBTree.getAllFrom(.java:702)
      o.a.u.ObjectBTree.getAllFrom(.java:699)
      o.a.u.ObjectBTree.getAllFrom(.java:691)
      o.a.e.ObjectBTreeIndex.getRowIterator(.java:127)
      o.a.e.r.RebindableIndexedRowIterator.reset(.java:73)
   2  0.67% 90.18%     460  3509
      j.u.ArrayList.ensureCapacity(.java:165)
      j.u.ArrayList.add(ArrayList.java:350)
      o.a.u.IntListIteratorChain.addIterator(.java:70)
      o.a.u.IntListIteratorChain.addIterator(.java:74)
      o.a.u.ObjectBTree.getAllFrom(.java:702)
      o.a.u.ObjectBTree.getAllFrom(.java:699)
```

## The third round of refactoring/tuning:

<p>
Looking closely at our ObjectBTree.getAllFrom method, we see that we're
still creating a large number of single-element IntListIterators.  We're
 also invoking ObjectBTree.isLeaf() within the inner loop, although that
 doesn't rank very highly in the CPU SAMPLES.
</p><p>
Conceptually, the getAllFrom method is really covering two cases:
</p>
<ul>
<li>When the current ObjectBTree node is a leaf, we need to add all of its value-nodes to the chain.</li>
<li>When the current ObjectBTree node is not a leaf, we still need to
add all of its value-nodes to the chain, but this time interleaved with
all of the "child" value-nodes.</li>
</ul>
<p>
It's the latter case, but not the former, that requires the creation of
single-element IntListIterators, and a large number of calls to
IntListIteratorChain.addIterator.  Let's make those two cases explicit,
and try to reduce the number of single-element IntListIterators.  Then
ObjectBTree.getAllFrom now reads:
</p>

```java
private void getAllFrom(Object key, IntListIteratorChain chain)
  throws IOException, ClassNotFoundException {
    int start = findNearestKeyAbove(key);
    if(isLeaf()) {
        chain.addIterator(getValues().subList(start,size()).listIterator());
    } else {
        for(int i = start; i &lt; size() + 1; i++) {
            getChild(i).getAllFrom(key,chain);
            if(i &lt; size()) {
                chain.addIterator(getValues().get(i));
            } else {
                break;
            }
        }
    }
}
```

<p>
When profiled, we see another order of magnitude improvement:
</p>

```
  ~1,282.0 queries/second
 ~12,820.5 rows/second
```

<p>
and our CPU SAMPLES dump is no longer overwhelmed by a single method:
</p>

```
rank   self  accum   count
   1  6.29%  6.29%    3662  3578
        o.a.e.r.LazyRowRowIterator.setCurrentRow(.java:154)
        o.a.e.r.LazyRowRowIterator.next(.java:110)
        o.a.e.r.DelegatingRowIterator.next(.java:80)
        o.a.e.r.AbstractFilteringRowIterator.setNextRow(.java:221)
        o.a.e.r.AbstractFilteringRowIterator.hasNext(.java:98)
        o.a.e.r.ChainedRowIterator.hasNext(.java:121)
   2  5.22% 11.51%    3044  3583
        o.a.e.DiskTable.getCachedRow(.java:765)
        o.a.e.DiskTable.getRow(.java:349)
        o.a.e.LazyRow.getRow(.java:85)
        o.a.e.LazyRow.get(.java:70)
        o.a.RowDecorator.get(.java:79)
        o.a.ColumnIdentifier.evaluate(.java:98)
   3  4.85% 16.36%    2828  3581
        o.a.c.c.p.RandomAccessIntList.listIterator(.java:171)
        o.a.c.c.p.RandomAccessIntList.listIterator(.java:167)
        o.a.c.c.p.RandomAccessIntList.iterator(.java:163)
        o.a.c.c.p.AbstractIntCollection.contains(.java:103)
        o.a.e.TransactableTableImpl$ExcludeUpdatedOrDeletedRows.acceptable(.java:582)
        o.a.e.r.AbstractFilteringRowIterator.setNextRow(.java:222)
   4  4.43% 20.79%    2579  3582
        o.a.e.TransactableTableImpl$ExcludeUpdatedOrDeletedRows.acceptable(.java:584)
        o.a.e.r.AbstractFilteringRowIterator.setNextRow(.java:222)
        o.a.e.r.AbstractFilteringRowIterator.hasNext(.java:98)
        o.a.e.r.ChainedRowIterator.hasNext(.java:121)
        o.a.e.r.RowIteratorRowDecoratorIterator.hasNext(.java:97)
        o.a.j.AxionResultSet.next(.java:524)
   5  4.15% 24.94%    2420  3603
        o.a.c.c.SequencedHashMap.put(.java:483)
        o.a.c.c.LRUMap.get(.java:133)
        o.a.e.DiskTable.getCachedRow(.java:765)
        o.a.e.DiskTable.getRow(.java:349)
        o.a.e.LazyRow.getRow(.java:85)
        o.a.e.LazyRow.get(.java:70)
```

<p>
Bumping up the number of queries executed to 50,000 which allows the
BTree time to load all of the nodes into memory, gives performance
comparable to the array index case:
</p>

```
  ~2,112.4 queries/second
 ~21,123.8 rows/second
```
 
<p>
While there are a number of other improvements that could be made (for
one instance, we still create a large number of one element
IntListIterators--any "empty" child nodes could be collapsed into a
single IntListIterator; for another, we should be able to revise that
loop a bit so that only one comparision of the loop index to size() is
needed per iteration), and we're still not I/O bound (which is what we'd
 expect and perhaps hope for in this test), we've dramatically improved
both the performance and the readability of this code.  All in all, a
productive couple of hours.
</p>

## Wrapping Up

<p>
I didn't intend for this to be a tutorial, but it almost reads like one,
 so I guess I'll sum up the lessons here as I understand them:
</p>
<ul>
<li>Performance tuning is easier with well factored code, well covered
by unit tests.  If the code doesn't meet these criteria, address that
first. (See <a href="http://c2.com/cgi/wiki?SecondRuleOfOptimization" title="Ward's Wiki: SecondRuleOfOptimization">the second rule of optimization</a>.)</li>
<li>You can go a long way with simple tools.  I've used more elaborate
profiling tools, but hprof and System.currentTimeMillis are usually
sufficient.</li>
<li>Be sure to use simple timings in addition to hprof-style profiling, to confirm that your changes are having a positive impact.</li>
<li>You often need to look deeper into the stack traces to find the true
 bottlenecks--the currently executing method as reported in the CPU
SAMPLES summary isn't always the root cause of slowness.</li>
<li>It may not be necessary to corrupt the design or implement
complicate optimizations.  Concentrate on making the code clean and
readable, and performance often comes along for free.  (Use profiling to
 determine the parts of the code that should be cleanest and most
readable.  This will support more complicated optimizations should they
prove necessary, and may be enough to make the code sufficiently fast.)
</li></ul>
<p>
Finally, don't bother telling me I applied these optimizations out of
order.  Yes, the biggest improvement came with addressing what I
initially believed to be the problem--reducing the number of single
element IntListIterators created.  Please revisit the title of this
article.  Much of the pleasure of this exercise was in cleaning up the
surrounding code and infrastructure.  My ongoing pleasure with working
with this code base depends as much on that refactoring as it does on
these optimizations.
</p>
