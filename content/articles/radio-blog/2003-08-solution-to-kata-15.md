---
active_tab: articles
title: A Solution to Kata Fifteen
---
# A Solution to Kata Fifteen

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Friday, 22 August 2003</b>
<p>
What fun! <a href="http://pragprog.com/pragdave">Dave</a>'s <a href="http://pragprog.com/pragdave/Practices/Kata/KataFifteen.html,v" title="Kata 15: A Diversion">latest Kata</a> is a little math problem, and it features everyone's second favorite example of recursion.
</p>
<blockquote>
<p>
Think of binary numbers: sequences of 0's and 1's. How many n-digit binary numbers are there that don't have two adjacent 1 bits? For example, for three-digit numbers, five of the possible eight combinations meet the criteria: 000, 001, 010, <strike>011</strike>, 100, 101, <strike>110</strike>, <strike>111</strike>. What is the number for sequences of length 4, 5, 10, n?
</p>
</blockquote>
<p>
Flexing the "proofs" part of my brain for the first time in long while, I think I've got both the solution and a proof for this.  I've developed this solution independently, so there are probably more elegant proofs available.
</p><p>
Spoiler Warning: If you'd like to work this Kata yourself, beware, spoilers follow.  I'll leave some blank space first.
</p><p>

</p><p align="center">&nbsp;</p>
<p align="center">&nbsp;...&nbsp;</p>
<p align="center">&nbsp;</p>
<p align="center"><b>spoilers follow</b></p>
<p align="center">&nbsp;</p>
<p align="center">&nbsp;...&nbsp;</p>
<p align="center">&nbsp;</p><p>

</p><h2>Definitions and Notation</h2>
<p>
First, let's define some terms.
</p><p>
Let <nobr><i>S<sub>n</sub></i></nobr> be the set of binary sequences of length <i>n</i>.  Note that
<nobr>|<i>S<sub>n</sub></i>| = 2<sup><i>n</i></sup></nobr>.
</p><p>
Let <nobr><i>F<sub>n</sub></i></nobr> be the set of sequences of binary sequences of length <i>n</i> that do not contain two consecutive 1 bits.  The Kata asks us to determine <nobr>|<i>F<sub>n</sub></i>|</nobr>.  I'll call that <nobr><i>f(n)</i></nobr>.
</p><p>
By inspection, it's easy to work out the first few values of <i>f(n)</i>.  Note that when <i>n</i>=0, we can count the empty sequence.
</p>
<table border="1" cellspacing="0" cellpadding="2" align="center">
<tbody><tr>
 <th><i>n</i></th>
 <th>|<i>S<sub>n</sub></i>|</th>
 <th><i>f(n)</i></th>
</tr><tr>
 <td align="right">0</td><td align="right">1</td><td align="right">1</td>
</tr><tr>
 <td align="right">1</td><td align="right">2</td><td align="right">2</td>
</tr><tr>
 <td align="right">2</td><td align="right">4</td><td align="right">3</td>
</tr><tr>
 <td align="right">3</td><td align="right">8</td><td align="right">5</td>
</tr><tr>
 <td align="right">4</td><td align="right">16</td><td align="right">8</td>
</tr><tr>
 <td align="right">5</td><td align="right">32</td><td align="right">13</td>
</tr>
</tbody></table>
<p>
To make the proof a little bit easier, I'll introduce some additional notation.
</p><p>
Let <i>concat(a,b)</i> be a
function that maps a pair of sequences to a new sequence by prefixing the first to the second.  For example,
<nobr>concat(1,0) = 10</nobr> and <nobr>concat(10,1101) = 101101</nobr>.
</p><p>
Let <i>CONCAT(a,B)</i> be
function that maps a sequence and a set of sequences to a new set of sequences obtained by prefixing the sequence
<i>a</i> to each sequence in the set <i>B</i>.  In other words,
<nobr>CONCAT(<i>s</i>,<i>T</i>) := { concat(<i>s</i>,<i>t</i>) : <i>t</i> in <i>T</i> }</nobr>.
</p><p>

</p><h2>The Theorem</h2>
<p>
If you're familiar with it, it is easy to recognize <i>f(n)</i> to be the Fibonacci Sequence, at least for small values of <i>n</i>.  So here it is in theorem form:  If <i>f</i>(<i>n</i>) is the number of binary sequences of length <i>n</i> that do not contain two consecutive 1 bits, then:
</p>
<pre>
<i>f</i>(0) = 1
<i>f</i>(1) = 2
<i>f</i>(<i>n</i>) = <i>f</i>(<i>n</i>-1) + <i>f</i>(<i>n</i>-2) for all <i>n</i> &gt; 1
</pre>
<h2>The Proof</h2>
<p>
That <nobr><i>f</i>(0) = 1</nobr> and <nobr><i>f</i>(1) = 2</nobr> can be readily seen by inspection.  We'll only need to demonstrate the part of the theorem that applies to <nobr><i>n</i> &gt;= 2</nobr>.
</p><p>
Note that the set <nobr><i>S<sub>n</sub></i></nobr> can be seen as the union of two disjoint sets derived from  <nobr><i>S<sub>n-1</sub></i></nobr>, those that start with a 0 and those that start with a 1:
</p><pre>
<i>S<sub>n</sub></i> = CONCAT(0,<i>S<sub>n-1</sub></i>) union CONCAT(1,<i>S<sub>n-1</sub></i>)
</pre>
<p>
Similarly, <nobr>CONCAT(1,<i>S<sub>n-1</sub></i>)</nobr> can be seen as the union of two disjoint sets derived from  <nobr><i>S<sub>n-2</sub></i></nobr>, those that start with 11 and those that start with 10:
</p>
<pre>
CONCAT(1,<i>S<sub>n-1</sub></i>) = CONCAT(11,<i>S<sub>n-2</sub></i>) union CONCAT(10,<i>S<sub>n-2</sub></i>)
</pre>
<p>
Hence <nobr><i>S<sub>n</sub></i></nobr> can be seen as the union of three disjoint sets:
</p>
<pre>
<i>S<sub>n</sub></i> = CONCAT(0,<i>S<sub>n-1</sub></i>) union CONCAT(11,<i>S<sub>n-2</sub></i>) union CONCAT(10,<i>S<sub>n-2</sub></i>)
</pre>
<p>
For convenience, let's name each of those three sets:
</p>
<pre>
Let <i>A</i> = CONCAT(0,<i>S<sub>n-1</sub></i>)
Let <i>B</i> = CONCAT(11,<i>S<sub>n-2</sub></i>)
Let <i>C</i> = CONCAT(10,<i>S<sub>n-2</sub></i>)
<i>S<sub>n</sub></i> = <i>A</i> union <i>B</i> union <i>C</i>
</pre>
<p>
Since the sets <i>A</i>, <i>B</i> and <i>C</i> represent a proper partitioning of <nobr><i>S<sub>n</sub></i></nobr>,
we can determine <nobr><i>F<sub>n</sub></i></nobr> by determining the sequences that meet the conditions in each of the sets
independently.
</p><p>
How many sequences in <i>A</i> are in
<nobr><i>F<sub>n</sub></i></nobr>?  The answer must be <nobr><i>f</i>(<i>n-1</i>)</nobr>, since prefixing a 0 bit won't change whether or not a sequence contains two consecutive 1 bits.
</p><p>
How many sequences in <i>B</i> are in
<nobr><i>F<sub>n</sub></i></nobr>?  The answer must be 0, since our prefix alone already rules out all of those sequences.
</p><p>
How many sequences in <i>C</i> are in
<nobr><i>F<sub>n</sub></i></nobr>?  The answer must be <nobr><i>f</i>(<i>n-2</i>)</nobr>, since prefixing 10 won't change whether or not a sequence contains two consecutive 1 bits.
</p>
<p>Hence:</p>
<pre>
<i>F<sub>n</sub></i> = CONCAT(0,<i>F<sub>n-1</sub></i>) union CONCAT(10,<i>F<sub>n-2</sub></i>)
</pre>
<p>and</p>
<pre>
<i>f</i>(<i>n</i>) = |<i>F<sub>n</sub></i>|
     = |CONCAT(0,<i>F<sub>n-1</sub></i>)| + |CONCAT(10,<i>F<sub>n-2</sub></i>)|
     = <i>f</i>(<i>n</i>-1) + <i>f</i>(<i>n</i>-2)
</pre>
<p>Q.E.D.</p>
<h2>Comments</h2>
<p>
For some reason, I had initially thought I'd be clever and reverse the problem.  Why count the number of sequences that <i>don't</i> meet some condition, but instead count those that do?  This yields the sequence 0, 0, 1, 3, 8, 19, ....  Other that starting with the Fibonacci-like 0, 0, it didn't seem recognizable at all to me.  (More generally, this sequence is <nobr>2<sup><i>n</i></sup> - <i>fibonacci</i>(<i>n</i>)</nobr>.)
  </p>
