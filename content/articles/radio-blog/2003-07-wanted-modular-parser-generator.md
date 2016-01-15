---
active_tab: articles
title: "Wanted: Modular/Extensible Parser Generator"
---
# Wanted: Modular/Extensible Parser Generator

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 7 July 2003</b>

<p>
Over at the <a href="http://axion.tigris.org/" title="Axion: Open Source Java RDBMS">Axion</a> project, we're using a <a href="http://javacc.dev.java.net/" title="JavaCC:  Java Compiler Compiler">JavaCC</a> <a href="http://axion.tigris.org/source/browse/axion/grammars/AxionSqlParser.jj" title="Axion's AxionSqlParser.jj">grammar</a> to implement the SQL parser.
</p><p>
One of things we've found Axion to be good for is unit testing database applications.  In other words, one can use an in-memory, in-process Axion database as a "mock" replacement for a regular production database.  In this case, it's quite useful to have Axion closely mimic the syntax of other RDBM systems.  For example, Axion supports <code>LIMIT</code> and <code>OFFSET</code> clauses like <a href="http://www.postgresql.com/" title="PostgeSQL open source database">PostgeSQL</a> and <a href="http://www.mysql.com/" title="MySQL open source database">MySQL</a> as well as a <code>ROWNUM</code> pseudo-column like <a href="http://www.oracle.com/" title="Oracle closed source database">Oracle</a>.  Similarly, Axion supports the ISO SQL 99 syntax for outer joins (<code>FROM a LEFT OUTER JOIN b ON a.id = b.id</code>) , but it would be nice to support Oracle's custom syntax (<code>FROM a, b WHERE a.id = b.id(+)</code>) as well.
</p><p>
Supporting the idiosyncrasies of several of the popular database engines in a single grammar file seems cumbersome at best. and probably impossible. It tends to bloat our keyword namespace.  Eventually, it must lead to conflicts.  (For example, if I'm trying to unit test code that eventually interacts with an Oracle database, then the "mock" database shouldn't accept LIMIT and OFFSET clauses, and shouldn't consider those to be keywords either.)
</p><p>
Axion's design is modular enough to allow for pluggable parser implementations.  Indeed, anything that implements:
</p>

```java
interface Parser {
  AxionCommand parse(String sql) throws AxionException;
}
```

<p>
can be dropped right in.  Hence it is straightforward to define, for example, MySqlSyntax.jj, OracleSyntax.jj, SqlServerSyntax.jj, etc. to support a specific SQL dialect.  The trouble is, each of those files is going to be 90% or more the same.  What I'd like is a clean mechanism for either:
</p>
<ul>
<li>declaring SpecializedGrammar to extend from GeneralizedGrammer, perhaps with abstract productions and the like, or</li>
<li>declaring SpecializedGrammar to be the composition of SubGrammarA and SubGrammarB</li>
</ul>
<p>
or both.  I'm especially interested in being able to combine grammars at runtime.  Anyone have any suggestions?  Can you point to an example?
</p>
<p>
(I'll be honest, I'm not much of a *CC expert.  This might be straightforward in JJTree or ANTLR, I just haven't dug into it much.  I'm pretty sure it's not straightforward in plain old JavaCC.)
</p>