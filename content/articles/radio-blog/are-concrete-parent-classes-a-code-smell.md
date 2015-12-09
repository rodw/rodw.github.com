---
active_tab: articles
title: Are concrete parent classes a code smell?
---
# Are concrete parent classes a code smell?

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>21 April 2003</b>

Recently I realized that I've almost subconsciously been following a
design heuristic that even I found surprising--I avoid concrete parent
classes.  Since coming to this realization, I've been struggling (and
failing) to come up with a good case for an instantiable parent class.
Is there a case for classes that are neither abstract nor final?  Could
concrete parent classes be a <a href="http://c2.com/cgi/wiki?CodeSmell" title="Ward's Wiki: CodeSmell">code smell</a>?

In fact, I tend to take this approach one step further--I avoid instance-scope variables in parent classes.

Instead, I've found it best to adhere to the following idiom:

 * use interfaces to define, well, interfaces--a cohesive collection of methods to be supported by a given type (or a given "aspect" of some type)
 * Use abstract classes to define "common" algorithms/behaviors/methods in terms of attributes supplied by abstract methods.
 * Use final classes that supply those attributes/methods as the only instantiable types in the system.

I'm not going to use the phrases "sucks" or "considered harmful". I
don't think I can offer a formal indictment of extending from concrete
types or from types with instance scope attributes.  I can't even point
to many problems that seem to be directly caused by them.  I can however
 present some things that seem to be made more complicated or less
useful in the presence of concrete parent types.  I am becoming
increasingly convinced that concrete parent classes represent a code
smell--a hint that something has gone wrong somewhere in the code.

## Strike One: Parent/Child Equality

One set of problems triggered by concrete parent classes relates to equality and object identity.  Since the <a href="http://java.sun.com/j2se/1.4.1/docs/api/java/lang/Object.html#equals%28java.lang.Object%29" title="method java.lang.Object.equals">equals</a> method should be symmetric (that is, that the value returned by <code>a.equals(b)</code> should equal the value returned by <code>b.equals(a)</code>), it can be difficult to define a meaningful and robust equals method when <code><i>a</i></code> is a subclass of <code><i>b</i></code>.

One approach, and probably the proper one, is that taken by most of the <a href="http://java.sun.com/j2se/1.4.1/docs/api/java/util/package-summary.html" title="package java.util">java.util</a> Collection types--define equality as a contract at the base level.  For instance, two <a href="http://java.sun.com/j2se/1.4.1/docs/api/java/util/Set.html" title="interface java.util.Set">Sets</a> are equal whenever they are the same size and they contain the same  elements, which makes it easy to ensure the symmetry of the equals  method, but hobbles the utility of that method in some ways as well.  It is not possible (or at least not contractually valid), to consider the <a href="http://java.sun.com/j2se/1.4.1/docs/api/java/util/Comparator.html" title="interface java.util.Comparator">Comparator</a> being used in two <a href="http://java.sun.com/j2se/1.4.1/docs/api/java/util/SortedSet.html" title="interface java.util.SortedSet">SortedSets</a>, or the <a href="http://jakarta.apache.org/commons/collections/apidocs/org/apache/commons/collections/Predicate.html" title="interface org.apache.commons.collections.Predicate">Predicate</a> filtering two <a href="http://jakarta.apache.org/commons/collections/apidocs/org/apache/commons/collections/SetUtils.html#predicatedSet%28java.util.Set,%20org.apache.commons.collections.Predicate%29" title="method org.apache.commons.collections.SetUtils.predicatedSet">PredicateSets</a>, or more generally, to assert that when <code>s.equals(t)</code> then the same will be true after adding some element <i>e</i> to both.  The equals method devolves into lowest common denominator comparison, and that denominator can often be pretty low.  As the <a href="http://java.sun.com/j2se/1.4.1/docs/api/java/util/Collection.html#equals%28java.lang.Object%29" title="method java.util.Collection.equals">Collection JavaDocs</a> note, it is not possible to compare a SortedSet with a List in any useful way.

Perhaps more common, if less proper, is a desire for the equality method that to be more specific in the more specific types.  Consider some generic business bean:


```java
class SomeBean {
  String getAttribute() {
    return attribute;
  }
  
  void setAttribute(String str) {
    attribute = str;
  }

  boolean equals(Object that) {
    if(that instanceof SomeBean) {
      return attribute.equals(((SomeBean)that).getAttribute());
    } else {
      return false;
    }
  }

  int hashCode() {
    return attribute.hashCode();
  }

  String attribute;
}
```

When extended with additional attributes, we either can't use those attributes as part of our equality definition, or we break the symmetric property of equals:


```java
class ChildBean extends SomeBean {
  String getAnotherAttribute() {
    return anotherAttribute;
  }

  void setAnotherAttribute(String str) {
    anotherAttribute = str;
  }


  boolean equals(Object that) {
    if(that instanceof ChildBean) {
      ChildBean bean = (ChildBean)that;
      return attribute.equals(bean.getAttribute()) &amp;&amp;
             anotherAttribute.equals(bean.getAnotherAttribute());
    } else {
      return false;
    }
  }

  int hashCode() {
    return attribute.hashCode() ^ anotherAttribute.hashCode();
  }

  String anotherAttribute;
}
```

One especially awkward idiom for restoring the symmetric property of equals is to define `SomeBean.equals` as:

```java
  boolean equals(Object that) {
    if(that.getClass().equals(this.getClass())) {
      return attribute.equals(((SomeBean)that).getAttribute());
    } else {
      return false;
    }
  }
```


but that's as hobbling as anything.  The value of the SomeBean.equals method, and the relationship between SomeBean and ChildBean, is close to minimal.  A coarse-grained contract on the SomeBean.equals method would at least provide consistent behavior across the SomeBean hierarchy.

If a different definition of equality is desired for ChildBean, it <i>may</i> be better to allow interfaces to express the inheritance relationship:

```java
interface ISomeBean {
  String getAttribute();
  void setAttribute(String str);
}

interface IChildBean extends ISomeBean {
  String getAnotherAttribute();
  void setAnotherAttribute(String str);
}
```

and define the concrete types as <i>unrelated</i> <code>final</code> classes.  Depending upon the size and complexity of the implementations, a protected abstract type could serve as a basis for shared code.

Alternatively, if a coarse-grained definition of equality is desired, then SomeBean.equals and SomeBean.hashCode should be declared <code>final</code> to enforce that contract.

## Strike Two: implements Serializable

Consider the <a href="http://jakarta.apache.org/commons/collections/apidocs/org/apache/commons/collections/Bag.html" title="interface org.apache.commons.collections.Bag">Bag</a> type supplied by <a href="http://jakarta.apache.org/commons/collections/" title="Apache's Jakarta-Commons Collections">Jakarta-Commons Collections</a>. Bag defines a simple "multiset" interface--one can add elements to the bag, and query it to determine the number of times a given element has been added.  Something like (although not literally the same as):


```java
interface Bag {
  void add(Object obj);
  int getCount(Object obj);
}
```

One straightforward implementation of this interface is to use a `java.util.Map` to map elements to the number of occurrences in the bag. In fact, <a href="http://jakarta.apache.org/commons/collections/apidocs/org/apache/commons/collections/DefaultMapBag.html" title="class org.apache.commons.collections.DefaultMapBag">`DefaultMapBag`</a> does just this, accepting the specific `Map` instance via a protected `setMap` method. For example:

```java
class DefaultMapBag implements Bag {
  void add(Object obj) {
    Integer count = (Integer)(map.get(obj));
    if(null == count) {
      count = new Integer(0);
    }
    map.put(new Integer(count.intValue() + 1));
  }

  int getCount(Object obj) {
    Integer count = (Integer)(map.get(obj));
    return (null == count) ?
      0 : count.intValue();
  }

  void setMap(Map map) {
    this.map = map;
  }

  private Map map = null;
}
```
Commons Collections adds two subclasses of this type, <a href="http://jakarta.apache.org/commons/collections/apidocs/org/apache/commons/collections/HashBag.html" title="class org.apache.commons.collections.HashBag">HashBag</a> (essentially <code>new DefaultMapBag().setMap(new HashMap())</code>) and <a href="http://jakarta.apache.org/commons/collections/apidocs/org/apache/commons/collections/TreeBag.html" title="class org.apache.commons.collections.TreeBag">TreeBag</a> (essentially <code>new DefaultMapBag().setMap(new TreeMap())</code>).

Recently there has been <a href="http://nagoya.apache.org/bugzilla/show_bug.cgi?id=18068" title="HashBag not Serializable">a request</a> (and a quite reasonable one at that) to make HashBag serializable.  Of course, declaring HashBag to implement Serializable isn't sufficient here--the data to be serialized is contained in the DefaultMapBag instance.  Declaring DefaultMapBag to be serializable would be sufficient, but that forces Serializablity on all subclasses of DefaultMapBag as well.  (As someone will no doubt point out so it might as well be me, in C# the Serializable attribute/aspect isn't inherited, one could declare DefaultMapBag to allow serialization, but specific subclasses would need to explicitly allow it as well.)

A cleaner implementation, in my opinion, would be for the base MapBag to delegate the management of the Map implementation down to the subclasses, like this:

```java
abstract class MapBag implements Bag {
  abstract Map getMap();
  
  void add(Object obj) {
    Integer count = (Integer)(getMap().get(obj));
    if(null == count) {
      count = new Integer(0);
    }
    getMap().put(new Integer(count.intValue() + 1));
  }
  
  int getCount(Object obj) {
    Integer count = (Integer)(getMap().get(obj));
    return (null == count) ?
      0 : count.intValue();
  }
}
```

Then the implementation of HashBag is still quite small:

```java
class HashBag extends MapBag {
  Map getMap() {
    return map;
  }
  Map map = new HashMap();
}
```

but since MapBag is only defining behaviors (methods) and not data (attributes), HashBag is free to make itself Serializable without impacting anyone else.

(Actually, in this particular case it may be cleaner still to make MapBag a leaf in the hierarchy and simply accept the Map instance in a constructor.)

## Strike Three: Bean or Value Object?

Serializiblity is just one example of the problems posed by hierarchies like DefaultMapBag/HashBag.  Maintaining the Map reference in the parent type also forces us down one of two paths--either require that some Map instance be specified in the DefaultMapBag constructor or provide a setMap(Map) method that allows subtypes to provide an instance (or both).  The former isn't very bean-friendly and the later doesn't support immutablity (there is no way to prohibit <code>class MyHashBag extends HashBag { public setMap(Map map) { super.setMap(map); } }</code>).  Delegating the attribute management to subclasses allows us to defer those design decisions and in fact to support either.

## Are concrete parent classes out?

I realize that there are workarounds to the issues raised above and that, indeed, many of these issues are as applicable to abstract object hierarchies as to concrete ones.  I'm not suggesting that concrete parent classes are by definition inappropriate, but rather that, like any code smell, the presence of concrete parent classes is often an indication that something is not right about the design.  Maybe I'm just a budding <a href="http://www.c2.com/cgi/wiki?SmugLispWeenies" title="Ward's Wiki: SmugListWeenies">smug lisp weenie</a>, but it seems to me that all of those issues are more cleanly addressed by the composition of abstract interfaces than by any hierarchy involving intermediate concrete types.  Please tell me I'm missing something obvious here.
