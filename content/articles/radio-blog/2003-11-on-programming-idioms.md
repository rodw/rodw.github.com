---
active_tab: articles
title: On Programming Idioms
---
# On Programming Idioms

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Friday, 14 November 2003</b>
<p>
Two things I'm always keen to learn when picking up a new programming language are:
</p>
<ol>
<li>How does one organize large projects?  In other words, how does one partition responsibilities and types across namespaces, modules and files?</li>
<li>What are the common idioms in the language?</li>
</ol>
<p>
I've been doing some string processing work with Ruby recently, and it's got me thinking about examples of the latter.
</p><p>
For example, in Java, the String class doesn't have a direct, boolean-valued method that will tell you whether or not a String contains another String, i.e., there's nothing like:
</p>

```java
if(someString.contains(anotherString)) { ... }
```

<p>
Instead, most Java developers will write:
</p>

```java
if(someString.indexOf(anotherString) != -1) { ... }
```

<p>
where String.indexOf(String) returns the index of the first occurrence of the argument String, or -1 if the given String isn't found.  Most Java developers will immediately recognize that as the "String.contains" idiom, and won't miss a beat.
</p><p>
This idiom is so strong in the Java community that it's almost counter-productive to write a custom utility method:
</p>

```java
public class StringUtils {
  public static boolean contains(String a, String b) {
    return (a.indexOf(b) != -1);
  }
}
```

<p>
since many developers who see
</p>

```java
if(StringUtils.contains(someString,anotherString)) { ... }
```

<p>
are likely to wonder whether the StringUtils.contains method really does what it is implied--Is this equivalent to the String.indexOf idiom?  Is that someString.contains(anotherString) or vice versa? How are null's handled? etc.  Unless the developer is already comfortable and familiar with the StringUtils class being used, this code is probably less readable to an experienced developer than the "indexOf != -1" formulation.
</p><p>
(This is not to say that "String.indexOf(x) != -1" is actually preferable to "String.contains(x)", but rather that in the absence of String.contains, the idiom is more widely recognized than a custom utility method.  Why Sun can't at some point introduce a String.contains method, say in JDK 1.5,  isn't entirely clear to me.)
</p><p>
Now, in the Ruby scripting I've been doing recently, I keep needing to determine whether a String begins with a given prefix.  In Java, that's the String.startsWith method, of course.  The Ruby String class does not have a startsWith method, but one of the neat things about Ruby is that it's possible to literally add such a method the the String class, as follows:
</p>

```ruby
class String
  def startsWith str
    return self[0...str.length] == str
  end
end
```

<p>
after which everything behaves exactly like the built-in String class contained that definition.  For example, one can then write:
</p>

```ruby
if someString.startsWith(anotherString) ...
```

<p>
or even
</p>

```ruby
if "a literal string".startsWith(anotherString) ...
```

<p>
etc.
</p><p>
Of course, the implementation I used for String.startsWith (<code>self[0...str.length] == str</code>) is just one of several possible implementations.  Regular expressions provide one way of implementing such a check.  The Java-like indexOf function provides another (e.g., <code>self.indexOf(str) == 0</code>).
</p><p>
Since there is no built-in String.startsWith (or for that matter String.contains) in Ruby, I wonder if there is some common idiom that experienced Ruby developers find more readable than adding a custom method to String?  If not for String.startsWith, how about String.contains?
</p>
