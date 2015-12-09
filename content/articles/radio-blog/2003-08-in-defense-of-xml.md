---
active_tab: articles
title: In Defense of XML
---
# In Defense of XML

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Friday, 8 August 2003</b>
<p>
Recently I've read a number of comments (some <a href="http://www.toolshed.com/blog/News/LastArtima.html,v" title="/\ndy's Weblog: Forensic Analysis and Plain Text">old</a> and some <a href="http://www.freeroller.net/page/fate/20030801#as_stable_and_maintanable_as" title="Bile Blog: As stable and maintainable as jelly">new</a>) that take issue with the use of XML for one purpose or another (in the above examples, Ant and Jelly scripts, respectively).  In fact, it seems all the cool kids are <a href="http://www.google.com/search?q=xml+sucks" title="Google on &quot;xml sucks&quot;">XML detractors</a> these days, although the coolness may have peaked a few months ago, when even Tim Bray was <a href="http://www.tbray.org/ongoing/When/200x/2003/03/16/XML-Prog" title="ongoing: XML Is Too Hard For Programmers">admitting</a> that XML may not be as nifty as first thought.
</p><p>
Now, I'll certainly admit that XML has its drawbacks.  Is it overly verbose?  Often.  <a href="http://okmij.org/ftp/Scheme/xml.html#SXML-spec" title="XML and Scheme: SXML specification">An equivalent s-expression syntax</a> would be more concise and (for Lisp developers at least) more useful.  Is it hard to read? At times.  It's certainly better suited for documents where the ratio of text to tags is high.  Is XML often used for developer convenience at the expense of user convenience? Is there information that has no business being in an XML format, but that developers or vendors insist on making XML anyway? Yes, yes, of course.
</p><p>
(On a related note, if "executable XML" is such a bad idea, how does one explain the longevity of Lisp?)
</p><p>
Despite these limitations, there is some value in selecting XML over, say (as Andy Hunt suggested for Ant) some arbitrary context-free grammar.
</p><p>
Part of this value is the ease with which a developer can drop in an XML parser, but that's only an indirect source of value.  Part of this value is the comfort that users familiar with popular SGML applications (read "HTML") have with the angle bracket notation, but that may only explain the quick adoption.
</p><p>
The real value of XML is in the tool chain.
</p><p>
Suppose Ant had been based upon some custom, non-XML grammar.  What would we lose?
</p><p>
Well for one, nearly every programmer's editor has a syntax coloring, well-formedness-checking mode for XML (certainly emacs and vi, or at least vim, and nearly anything that calls itself an IDE).  Moreover, many editors support DTD or Schema validation as well, perhaps even tag and attribute completion.  Using an XML format means a host of editors can handle Ant scripts smartly.  The same would probably not have been true, at least initially, with some arbitrary grammar.
</p><p>
How does this come about?  Well in part because XML is a popular format, but also because of the ease with which a developer can drop in an XML parser and other libraries.
</p><p>
For another advantage, consider <a href="http://www.wdvl.com/Authoring/Languages/XML/XMLFamily/BigPicture/bigpix20a.html" title="Big Picture of the XML Family of Specifications">the plethora of XML-based or XML-extending specifications</a>.  Many commentators have looked at that dense diagram and scoffed: not everything is well suited for an XML representation.  Yet few would deny that at least some of those technologies do something truly useful.
</p><p>
Similarly, consider the number of tools, libraries and technologies that implement those specifications or provide other XML utilities.  Want a pretty printer?  There's a tool for that (indeed you're probably using one right now).  Want an API for processing arbitrary XML?  There's several, in nearly any language you can name.  Want portable validation?  Want to combine dialects?  Want to translate one schema to another?  Want simple macro support?  Want to embed or link sub-documents?  Want to generate hyperlinked documentation for a script or it's syntax?  There's a tool for that too.
</p><p>
Sometimes it's sufficient to be adequate and popular, when that means a strong tool chain comes along for the ride.  Sometimes <a href="http://www.ai.mit.edu/docs/articles/good-news/good-news.html" title="Richard P. Gabriel: Lisp: Good News, Bad News, How to Win Big">worse really is better</a>, or at least good enough.
</p>
