---
active_tab: articles
title: Wanted - GUI Wrapper for Text-Based Java Applications
---
# Wanted - GUI Wrapper for Text-Based Java Applications

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 29 July 2003</b>
  <p>
I've got a simple console-based (i.e.,  text interface) Java application that I'd like to expose via Java Web Start or as an Applet.  I can't, however, because System.in and System.out aren't attached to anything useful, so my application runs invisibly and can't collect any input.
</p><p>
What I need is a simple wrapper application that creates a basic text i/o frame that looks like stdin/stdout to my application's main method.  (Or, failing that, to a custom <nobr><code>main(String[] args, InputStream stdin, PrintStream stdout, PrintStream stderr)</code></nobr> method.)  More elaborate interfaces, such as color coded output, distinct stdout and stderr frames, spool to file, etc., are easily imagined.
</p><p>
I believe such an application would have fairly broad utility.  A web search finds quite a few elaborate telnet/ssh oriented terminal emulators, which one might be able to pare down to what I'm looking for, but it seems like someone would have already tackled this problem.  Lazy web to the rescue?
</p>