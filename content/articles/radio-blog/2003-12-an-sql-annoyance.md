---
active_tab: articles
title: An SQL Annoyance
---
# An SQL Annoyance

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 8 December 2003</b>
<p>SQL isn't consistent under row/column transposition.  For example:</p>
<pre>select 3 + NULL</pre>
<p>yields NULL.  Yet,</p>
<pre>create table TEMP ( NUM number );
insert into TEMP values ( 3 );
insert into TEMP values ( NULL );
select sum(NUM) from TEMP</pre>
<p>yields 3 (since NULL valued rows are ignored by aggregate functions).</p>
<p>This inconsistency is all the more annoying since both:</p>
<pre>select sum(NUM) from TEMP where NUM is not NULL</pre>
<p>and</p>
<pre>select sum(coalesce(NUM,0)) from TEMP</pre>
<p>would yield the same result under an "aggregation of NULL is NULL" rule. Yet under the "aggregation function ignores NULL" rule, creating a <i>single</i>, efficient, cross-database query the yields NULL if there's a NULL row and the SUM otherwise is awkward at best.</p>