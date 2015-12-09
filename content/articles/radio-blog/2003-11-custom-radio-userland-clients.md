---
active_tab: articles
titel: Custom Radio UserLand Clients?
---
# Custom Radio UserLand Clients?

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 4 November 2003</b>
<p>
<a href="http://radio.userland.com/" title="Radio UserLand">Radio</a> is a reasonably nifty weblog client,
sporting an easy-to-use, web-based content management tool, a workable server-based news aggregator and a
fairly robust weblog hosting infrastructure for USD$3.33 a month.
</p><p>
Things I find annoying about Radio include the fact that it won't run on a Unix-based OS (although there
are <a href="http://radio.weblogs.com/0102385/2003/04/24.html" title="Chris Double's Radio Weblog">reports</a>
of folks who've got the Windows version up and running under Wine on Linux), it's got a fairly large footprint, and
it uses a relatively cumbersome and under-documented scripting framework.
</p><p>
All in all, the biggest appeal of Radio Userland to me is that I can get quick, easy and generally adequate weblog
hosting for monthly cost less than a trip to Starbucks.  If only I could continue to use the hosting service and
replace the Windows-based client--I'd be happy to generate the weblog HTML via some homegrown software and simply
upload the content via FTP or SCP.
</p><p>
Well, it's not quite as easy as FTP, but after poking around a bit, I've figured out how to "manually" update a
Radio hosted site, or more generally,
<a href="http://www.myelin.co.nz/wcswiki/w/CommunityServerWiki" title="Community Server Wiki">any of a number of servers</a>
that supports the
<a href="http://www.soapware.org/xmlStorageSystem" title="SoapWare.org: xmlStorageSystem">xmlStorageSystem</a> XML-RPC protocol.
</p><p>
Here's a relatively crude but functional example using <a href="http://jakarta.apache.org/commons/httpclient">HttpClient</a>.
</p><p>
First, the basic framework for processing a request and it's response.  This method takes a request "body" and returns the response.  Typically both the request and the response will be XML-RPC documents.
</p>

```java
String processRequest(String body) throws IOException, HttpException {
    PostMethod method = new PostMethod();
    method.setRequestHeader("Content-type","text/xml");
    method.setRequestBody(body);
    method.setPath("/RPC2");
    method.setRequestContentLength(body.length());

    HttpClient client = new HttpClient();

    HostConfiguration host = new HostConfiguration();
    host.setHost("radio.xmlstoragesystem.com");

    client.executeMethod(host,method);

    return method.getResponseBodyAsString();
}
```

<p>
Typically we pass an xmlStorageSystem request to this method as the String parameter.  Here's one simple example, a sort of
"status" query:
</p>

```xml
<?xml version="1.0"?>
<methodCall>
  <methodName>xmlStorageSystem.getServerCapabilities</methodName>
  <params>
    <param><value><!-- your radio user number, e.g., mine is "122027" --></value></param>
    <param><value><!-- the md5 hash of your radio password as ASCII bytes --></value></param>
  </params>
</methodCall>
```

<p>
To create or update a file (or files), we use <code>saveMultipleFiles</code>, for example:
</p>

```xml
<?xml version="1.0"?>
<methodCall>
  <methodName>xmlStorageSystem.saveMultipleFiles</methodName>
  <params>
    <param><value><!-- your radio user number, e.g., mine is "122027" --></value></param>
    <param><value><!-- the md5 hash of your radio password as ASCII bytes --></value></param>
    <param>
      <value>
        <array>
          <data><value>/rpctest/test.html</value></data> <!-- location of file -->
        </array>
      </value>
    </param>
    <param>
      <value>
        <array>
          <data><value>Hello World!</value></data> <!-- contents of file -->
        </array>
      </value>
    </param>
  </params>
</methodCall>
```

<p>
To delete a file (or files), we use <code>deleteMultipleFiles</code>, for example:
</p>

```xml
<?xml version="1.0"?>
<methodCall>
  <methodName>xmlStorageSystem.saveMultipleFiles</methodName>
  <params>
    <param><value><!-- your radio user number, e.g., mine is "122027" --></value></param>
    <param><value><!-- the md5 hash of your radio password as ASCII bytes --></value></param>
    <param>
      <value>
        <array>
          <data><value>/rpctest/test.html</value></data> <!-- location of file -->
        </array>
      </value>
    </param>
  </params>
</methodCall>
```

<p>
etc.
</p><p>
See <a href="http://www.soapware.org/xmlStorageSystem" title="SoapWare.org: xmlStorageSystem">Dave Winer's writeup</a> for more
procedures, details and <a href="http://www.soapware.org/stories/storyReader$16">examples</a>.
</p><p>
Now that I know how to manipulate my radio.weblogs.com site without using the Radio client, I'm tempted to roll my own weblogging software, if only so I don't have to keep a Windows box around to support my blog.  As I mentioned above, there are <a href="http://www.myelin.co.nz/wcswiki/w/CommunityServerWiki" title="Community Server Wiki">a number of servers</a> that support the xmlStorageSystem protocol.  Anyone know of any non-Radio clients for xmlStorageSystem?  At minimum, something that syncs an arbitrary local directory with a remove xmlStorageSystem server should be easy enough to implement, which would allow anything that you can "publish" locally to be used as a client to a Community Server implementation.
</p>
