---
active_tab: articles
title: A is for Axion ... Z is for Zaurus
---
# A is for Axion ... Z is for Zaurus

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Thursday, 24 July 2003</b>
<p>
I've got <a href="http://axion.tigris.org/" title="Axion Java Relational Database">Axion</a> up and running on my <a href="http://www.zaurus.com/" title="Zaurus.com: Sharp's Zaurus site">Zaurus</a>.
</p><p>
If you'd like to do the same, here's how:
</p><ul>
<li><p>Obtain a build of the Axion HEAD (1.0M3-dev).  See the <a href="http://axion.tigris.org/building.html" title="Building Axion">instructions on building Axion</a> for details.</p></li>
<li><p>Obtain binaries of Axion's runtime dependencies, namely <a href="http://jakarta.apache.org/commons/collections/" title="Jakarta Commons Collections">Jakarta Commons Collections</a> (currently a <a href="http://jakarta.apache.org/builds/jakarta-commons/nightly/commons-collections/" title="Commons-Collections nightlies">nightly</a> build is required) and <a href="http://jakarta.apache.org/commons/logging/" title="Jakarta Commons Logging">Jakarta Commons Logging</a> (you'll want release 1.0.3, earlier versions don't work on the Jeode VM).</p>
<p>If you want to use the LIKE operator, you'll also need <a href="http://jakarta.apache.org/regexp/" title="Jakarta Regexp">Jakarta Regexp</a>.</p>
<p>If you want to use the BASE64ENCODE or BASE64DECODE functions, you'll also need <a href="http://jakarta.apache.org/commons/codec" title="Jakarta Commons Codec">Jakarta Commons Codec</a>.</p></li>
<li>Ensure that you have the java.util Collections and java.sql JDBC packages available on your platform.  Since the Insignia Jeode VM installed on the Zaurus by default is JDK 1.1 based, I had to copy over the JDK Collections manually.  I had thought the Collections package was available as a standalone JAR to drop in to JDK 1.1 environments but as I was unable to find it.  I just copied over the rt.jar from a JDK 1.3 installation, but I think the java.util package would suffice.</li>
<li><p>Obtain a copy of axiondb.properties.  You can pull this out of the Axion JAR or from <a href="http://axion.tigris.org/source/browse/axion/conf/axiondb.properties" title="axion/conf/axiondb.properties">CVS</a>.  Normally Axion loads this file out of the JAR automatically, but the Jeode VM seems to always return null for getClassLoader so we had to add a mechanism for specifying the configuration as an external file.</p></li>
<li><p>Now simply copy those files over to the Zaurus, add the JARs to your classpath, and you are ready to go.  For example to run the Axion console I use:</p>
<pre>evm
 -Dorg.axiondb.engine.BaseDatabase.properties=axiondb.properties
 -classpath axion-1.0-M3-dev.jar:
            commons-collections.jar:
            commons-logging.jar:
            commons-codec.jar:
            regexp.jar:
            rt.jar
 org.axiondb.tools.Console $1 $2</pre>
</li>
</ul><p>
Similar steps should get Axion up and running on other micro or J2ME platforms or for that matter, other JDK 1.1 environments.
If the console is any indication, Axion seems to run rather well on the Zaurus (even running off a compact flash card rather than the RAM disk).
</p><p>
If folks were interested, it wouldn't be difficult to create an IPK installer for Axion, although my interest here, and others as well I imagine, is in using Axion within other apps on the Zaurus, rather than playing with Axion via the console.
</p><p>
If you're curious, I did have to make a few minor changes to Axion to get it run on the Jeode/JDK 1.1 VM.  Here's a brief list of what I had to change:
</p><ul>
<li><p>The Jeode VM always seems to return null for getClassLoader (rather than throwing a security exception), so I had to add checks for null, and provide an alternative mechanism for loading the properties file.</p></li>
<li><p>We had used File.createNewFile in several places, which is a JDK 1.2 method.  These calls turned out to be unnecessary anyway, so I simply removed them.</p></li>
<li><p>Although it's easy to add java.util.Comparable and java.util.Comparator to the classpath, none of the core objects (Number, String, etc.) actually implement Comparable in JDK 1.1, so I had to add custom Comparators replacing ComparableComparator for those DataTypes.</p></li>
<li><p>For reasons I don't understand, in several places where we had an hierarchy like this:</p>
<pre>interface Foo {
  void someMethod();
}
&nbsp;
abstract class AbstractBar implements Foo {
  void anotherMethod() {
    doSomething();
  }
}
&nbsp;
class Bar extends AbstractBar {
  void someMethod() {
    doSomethingElse();
  }
}</pre>
<p>I had to declare the interface methods in the abstract class:</p>
<pre>abstract class AbstractBar implements Foo {
  <b>abstract void someMethod();</b>
&nbsp;
  void anotherMethod() {
    doSomething();
  }
}</pre><p>
to make various AbstractMethodErrors go away.
</p></li>
</ul><p>
These changes have already been checked into the HEAD version of Axion, and should be part of the Milestone 3 release.
</p><p>
There are few Axion-based apps I've been thinking of tinkering with on my Zaurus, some for personal use, others for my day job.  That may shake out a few issues I haven't yet encountered, but so far I've got feature I've tried working without too much trouble.
</p>