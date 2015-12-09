---
active_tab: articles
title: A Question on Applying the LGPL to Java
---
# A Question on Applying the LGPL to Java

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>7 April 2003</b>

Assume org.gnu.foo is an LPGL'ed Java package. Which of the following can I do without applying the LGPL to my code:

## A. Import and use a type from org.gnu.foo:

```java
import org.gnu.foo.Bar;
class ClientCode {
  public static void main(String[] args) {
    Bar bar = new Bar();
    bar.someMethod(args[0]);
  }
  /* ... */
}
```

or

```java
import org.gnu.foo.Bar;
class MoreClientCode {
  void clientMethod(Bar bar) {
    bar.someMethod("xyzzy");
  }
  /* ... */
}
```

## B. Extend from a type in org.gnu.foo:

```java
import org.gnu.foo.Bar;
class ClientCode extends Bar {
  /* ... */
}
```

## C. Specialize a type from org.gnu.foo, but via composition rather than inheritance:


```java
import org.gnu.foo.Bar;
class ProxyBar {
  ProxyBar(Bar bar) {
    this.bar = bar;
  }
 
  void someMethod(String str) {
    return bar.someMethod(str.toUpperCase());
  }
 
  /* ... */
 
  private Bar bar;
}
```

## D. Invoke a method from org.gnu.foo using "hard-coded" reflection:

```java
class ClientCode {
  public static void main(String[] args) throws Exception {
    Class klass = Class.forName("org.gnu.foo.Bar");
    Method method = klass.getMethod("someMethod", new Class[] { String.class });
    Object obj = klass.newInstance();
    method.invoke(obj,new String[] { args[0] });
  }
}
```

## E. Invoke a method from org.gnu.foo using runtime-determined reflection:

```java
class ClientCode {
  public static void main(String[] args) throws Exception {
    Class klass = Class.forName(args[0]);
    Method method = klass.getMethod(args[1], new Class[] { String.class });
    Object obj = klass.newInstance();
    method.invoke(obj,new String[] { args[2] });
  }
}
```

invoked via


```bash
java ClientCode org.gnu.foo.Bar someMethod xyzzy
```

## F. Invoke a method from org.gnu.foo as an external process:

```java
class ClientCode {
  public static void main(String[] args) throws Exception {
    Process p = Runtime.getRuntime().exec("java org.gnu.foo.Bar xzyyz");
    /* ... */
  }
}
```

How do these answers change if org.gnu.foo is licensed under the "regular" GPL?
