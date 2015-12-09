---
active_tab: articles
title: Ruby Userland
---
# Ruby Userland

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Friday, 21 November 2003</b>
<p>
As I <a href="http://radio.weblogs.com/0122027/2003/11/04.html#a95" title="Custom Radio UserLand Clients?">previously mentioned</a>, I've been toying with custom clients to the <a href="http://www.soapware.org/xmlStorageSystem">XmlStorageSystem</a> XML-RPC protocol used by <a href="http://radio.userland.com/">Radio Userland</a> and <a href="http://www.myelin.co.nz/wcswiki/w/CommunityServerWiki">several open source blog servers</a>, with the ultimate goal of hosting a custom blog on the radio.weblogs.com host.
</p><p>
Over the past couple of evenings I've hacked out <a href="/articles/radio-blog/xmlStorageSystem.rb.txt" title="xmlStorageSystem.rb">xmlStorageSystem.rb</a>, a reasonably functional Ruby-based client to the XmlStorageSystem system protocol.  It works like this:
</p>
<p>
To create a new instance of the client, use:
</p>
<pre>XmlStorageSystem.new(<i>&lt;usernumber&gt;</i>,<i>&lt;md5-hash-of-password&gt;</i>,<i>&lt;root-directory&gt;</i>)</pre>
<p>
For instance, I use:
</p>
<pre>XmlStorageSystem.new('122027','8c8034f5c9d68564e155c67a6d4e4612','/0122027/')</pre>
<p>
although that's not my actual password.
</p>
<p>
Actually, my local copy of xmlStorageSystem.rb has these value specified as the defaults, so I just user XmlStorageSystem.new, and I'll use that form in the rest of these examples.  The constructor also accepts an number of arguments that should allow one to connect to the <a href="http://www.pycs.net/">Python Community Server</a> and others, although Radio is the only server I've tried.
</p>
<p>
To get a listing of the files currently stored on the server, use:
</p>
<pre>XmlStorageSystem.new.getMyDirectory</pre>
<p>
To download all those files to a local directory
</p>
<pre>XmlStorageSystem.new.backupMyDirectory 'backupdir'</pre>
<p>
To upload a file (or files) to the server, use:
</p>
<pre>XmlStorageSystem.new.saveMultipleFiles( 'local-base-dir', [ 'file1', 'file2', 'etc' ])</pre>
<p>
To delete a file (or files)  from the server, use:
</p>
<pre>XmlStorageSystem.new.deleteMultipleFiles( [ 'file1', 'file2', 'etc' ])</pre>
<p>
Finally, the really handy one:
</p>
<pre>XmlStorageSystem.new.updateFromLocalDirectory 'localdir'</pre>
<p>
Which will compare the list of files in the local directory with those on the server, delete the ones that don't appear locally, and load/update the rest.
</p><p>
Since this is Ruby, it's easy to set up little shell scripts that invoke those commands in ways useful to your personal work style.
</p><p>
If one wanted to be clever, there is metadata available via XmlStorageSystem.getMyDirectory that would allow one to determine whether or not a file has changed since it was last uploaded, but I haven't gotten around to that yet.
</p><p>
I'm still pretty much a Ruby neophyte, so there's probably substantial room for improvement there.  In particular, (1) there's no error handling present just yet and (2) the current implementation supports hackablity (changing the script itself) more than extensibility.  Nevertheless, it's neat that a Ruby neophyte can write a basic XmlStorageSystem client in 150 lines of readable code.
</p>
