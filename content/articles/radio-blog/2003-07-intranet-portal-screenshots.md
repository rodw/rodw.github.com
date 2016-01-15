---
active_tab: articles
title: Do you have an intranet portal?
---
# Do you have an intranet portal?

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 9 July 2003</b>
<p>
I'll show you <a href="/img/articles/sysarch_1000x746.png" title="screenshot">mine</a> if you show me yours.
</p><p>
<a href="/img/articles/sysarch_1000x746.png" title="full size screenshot"><img src="/img/articles/sysarch_1000x746.png" width="333" height="249" align="right" alt="screenshot"></a>
</p><p>
For the curious, here's where those links go:
</p>
<dl>
<dt>Links</dt>
<dd>
<dl>
<dt>Iteration Documents</dt>
<dd>index to our current and historical iteration status documents with some summary statistics.</dd>
<dt>Publications</dt>
<dd>various internal whitepapers, HOWTOs, and articles. Most of the interesting content has moved to the wiki we introduced a couple of years ago.</dd>
<dt>Wiki</dt>
<dd>the aforementioned wiki.</dd>
<dt>JavaDocs</dt>
<dd>JavaDoc documentation for our codebase, updated as part of the continuous integration process. The "(more)" link points to a wiki page that links to various external JavaDocs.</dd>
<dt>CVS Tree</dt>
<dd>our <a href="http://viewcvs.sourceforge.net/" title="ViewCVS: browse a CVS repository via a web interface">ViewCVS</a> instance.</dd>
<dt>Build Results</dt>
<dd>our <a href="http://cruisecontrol.sourceforge.net/" title="CruiseControl: a continuous integration service">CruiseControl</a> build servlet.</dd>
<dt>Test Coverage Reports</dt>
<dd>a <a href="http://jcoverage.com/" title="JCoverage: a code coverage analyzer for Java">JCoverage</a> report across our (Java) codebase, updated as part of the continuous integration process.</dd>
<dt>Latka Test Suite</dt>
<dd>a <a href="http://jakarta.apache.org/commons/latka" title="Apache's Jakarta Commons Latka: a functional testing tool for HTTP and more">Latka</a> webapp instance, which allows one to execute our Latka functional test suite against various development, integration, QA and production environments.</dd>
<dt>TrackNet</dt>
<dd>a defect tracking database.</dd>
<dt>Reports</dt>
<dd>web traffic analysis and similar reports.</dd>
<dt>Headlines</dt>
<dd>a simple RSS browsing web application.</dd>
</dl>
</dd>
<dt>Recent Wiki Changes</dt>
<dd>lists the last few changed pages on our internal wiki.</dd>
<dt>SysArch Intranet Traffic</dt>
<dd>web traffic analysis for the portal site itself (just below the fold in the screenshot).</dd>
<dt>Current Build Results</dt>
<dd>a one line summary of our continuous integration build status.</dd>
<dt>Iteration <i>N</i> Status</dt>
<dd>current status of the current and previous development iterations, in summary form.</dd>
</dl>
<p>
This "portal" is largely cobbled together out of server side includes.  It'd be nice to upgrade to a true <a href="http://www.jcp.org/en/jsr/detail?id=168" title="JSR 168: Portlet Specification">portlet</a> implementation, or at least use RSS (or <a href="http://www.intertwingly.net/wiki/pie/EchoProject" title="Sam's Weblog: EchoProject">whatever the "better" RSS is these days</a>).  In fact, I've been looking into introducing a number of blogging inspired ideas.
</p>