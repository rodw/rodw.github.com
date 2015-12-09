---
active_tab: articles
title:  Java's checked exceptions were a mistake
---
# Java's checked exceptions were a mistake (and here's what I would like to do about it)

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>1 April 2003</b>

Java's checked exceptions were an experiment. While Java borrows most of its try/catch exception handling from C++, the notion of "checked" exceptions, which must either be caught or explicitly thrown, are a Java addition. By and large, this experiment has failed. You won't find checked exceptions in Java-influenced languages like Ruby or C#.

An idea (the idea?) behind C++ style exception handling is a sound one--it allows one to deal with exceptional conditions at an appropriate, perhaps centralized, point in the call stack, which may be far from where the exceptional condition was encountered. Unrecoverable exceptions are common at very low levels of the code--places where we're interacting with I/O and network devices, for example. But these are the very places least likely to know the appropriate response. Do we simply "skip" that action? Try again? Try a different service? Report the problem to the user? To syslog? Allowing the problem to "propagate up" to some caller is a convenient and relatively clean way of dealing with this problem of needing what is essentially out-of-band communication.

At first glance, checked exceptions seem like a good idea too. The major risk with unchecked exceptions is that no one will catch them--problems might bubble clear off the stack. Checked exceptions require that callers either deal with the exception or make it known what they are not dealing with. It forces the caller to consider the exceptional case: If you're opening a file, be prepared to handle FileNotFound. If you're connecting to a server, there may be NoRouteToHost.

The problem that's introduced here is the impedance between the intention of try/catch exception handling in general (allow exceptional conditions to be handled far from their source) and the implication of checked exceptions in particular (everyone between the thrower and the handler must be aware of the exception that passes through).

Even at a second glance, checked exceptions work fairly well. This approach is adequate for self-contained systems, where the distance between the thrower and catcher is small, or for "bottom tier" subsystems, which act as a source for exceptions, but rarely as a sink or pipe (think of basic networking, file I/O, JDBC, etc.).

Checked exceptions are pretty much disastrous for the connecting parts of an application's architecture however. These middle-level APIs don't need or generally want to know about the specific types of failure that might occur at lower levels, and are too general purpose to be able to adequately respond to the exceptional conditions that might occur.

Jakarta-Commons Pool provides a good example of this phenomenon. The first release of pool didn't allow checked exceptions:

```java
class ObjectPool {
  Object borrowObject();
  void returnObject(Object obj);
}
```

But when the generator of pooled objects may throw a checked exception (like Jakarta-Commons DBCP does), extensions of pool were left with two undesirable options--either quietly swallow the checked exception:

```java
class ConnectionFactory implements PoolableObjectFactory {
  void makeObject() {
    try {
      // ...
    } catch(SQLException e) {
      return null;
    }
  }
}
```

or wrap it with some RuntimeException:

```java
class ConnectionFactory implements PoolableObjectFactory {
  void makeObject() {
    try {
      // ...
    } catch(SQLException e) {
      throw new RuntimeException(e.toString());
    }
  }
}
```

(JDK 1.4's chained exceptions make this better (throw new RuntimeException(e)), but still not great, for reasons I'll discuss below).

Both options undermine the utility of the exception handling mechanism.

The current (cvs HEAD) version of Jakarta-Commons Pool allows for arbitrary checked exceptions:

```java
class ObjectPool {
  Object borrowObject() throws Exception;
  void returnObject(Object obj) throws Exception;
}
```

which feels cleaner in some respects, but similarly undermines the utility of the exception handling mechanism. Clients of ObjectPool instances that don't throw checked exceptions in practice still need to behave as if they do. Clients of ObjectPool instances that do throw checked exceptions lose any compile-time checking that exceptions of a given type are handled in some meaningful way (i.e., we lose all indications that we expect a specific exception--SQLException--and instead must deal with the most generic case). This situation isn't any better than it would be if DriverManager.getConnection() simply threw a RuntimeException, and in some respects, is a bit worse since now I have to litter my code with seemingly extraneous "throws Exception" clauses.

The DBCP case is unique, since the client of the ObjectPool is also a SQLException-aware type. (Generally DBCP is a pool masquerading as a Driver or DataSource. Pool plugs-in to DBCP, but it is fully encapsulated by it.) In this scenario, a RuntimeException envelope would be sufficient:

```java
class RuntimeSQLException extends RuntimeException {
  RuntimeSQLException(SQLException e) {
    exception = e;
  }
 
  SQLException getSQLException() {
    return exception;
  }
 
  private SQLException exception = e;
}
 
class PoolingDriver {
  Connection connect(String url, Properties props) throws SQLException {
     try {
       return (Connection)(pool.borrowObject());
     } catch(RuntimeSQLException e) {
       throw e.getSQLException();
     }
  }
 
  private ObjectPool pool;
}
 
class ConnectionFactory implements PoolableObjectFactory {
  void makeObject() {
    try {
      // ...
    } catch(SQLException e) {
      throw new RuntimeSQLException(e);
    }
  }
}
```

but this approach only works when there is somebody upstream from ConnectionFactory who knows what to do with a RuntimeSQLException--i.e., when we have control over the code on both sides of the code that the exception passes through.

The problem is thornier when the source for the checked exceptions (which creates the "envelope") may be a different component than the one that wants to open the envelope. Jakarta-Commons Functor is a good example of this. The generic functor interfaces don't want to (and hopefully don't need to) be aware of the various checked exceptions that an implementation of that interface might encounter. At the same time, much of the point of an API like Functor is to allow a client of the functor interfaces to interoperate with disparate implementations of those interfaces, so an approach that requires clients to be aware of every functor implementation's RuntimeXXXException subtype (RuntimeIOException, RuntimeSAXException, etc.) isn't desirable either.

I'll suggest that what we need is a single uniform mechanism for tunneling checked Exceptions through APIs that only allow RuntimeException. The exception chaining mechanism in JDK 1.4 supports this, but not in a backwards compatible fashion. Jakarta-Commons Lang has a NestedException type that works in earlier JREs, but not in a forward compatible fashion. But exception chaining is really a different concept. Using chained exceptions alone makes it impossible to distinguish the "chain of exceptions" case from the "tunneling Exception through RuntimeException" case. What we really need is a dedicated adapter type:

```java
class ExceptionRuntimeException extends RuntimeException {
  ExceptionRuntimeException(Exception e) {
    exception = e;
  }
  void rethrowException() throws Exception {
    throw e;
  }
  /* ...etc... */
  Exception e;
}
```

Such a type could delegate methods like printStackTrace appropriately, could be used for the exclusive purpose of tunneling checked Exceptions, and is equally valid in JDK 1.3 and JDK 1.4. Placing this type in a small, standalone utility component (of Jakarta-Commons for example), would be a rather minor imposition on clients of components that use it (ExceptionRuntimeException would be a run-time dependency if ever instantiated, but clients who choose to could simply treat at a code level like any other RuntimeException.)

Here's an example. Jakarta-Commons Functor has a UnaryPredicate type:

```java
interface UnaryPredicate {
  boolean test(Object obj);
}
```

and methods for filtering a Collection according to some UnaryPredicate:

```java
class CollectionAlgorithms {
  static Collection select(Iterator iter, UnaryPredicate pred, Collection col) {
    while(iter.hasNext()) {
      Object obj = iter.next();
      if(pred.test(obj)) {
        col.add(obj);
      }
    }
    return col;
  }
 
  static Collection select(Iterator iter, UnaryPredicate pred) {
    return select(iter,pred,new ArrayList());
  }
}
```

which might be used as:

```java
Collection allFiles = getListOfFiles();
Collection directoriesOnly =
   CollectionAlgorithms.select(allFiles.iterator(),new IsDirectory());
```

The implementation of the IsDirectory predicate might have need for checked exceptions of course:

```java
/**
 * Given a String representing a file URI, determines
 * whether the given file is a Directory or not.
 * @throws ExceptionRuntimeException for a URISyntaxException
 */
class IsDirectory implements UnaryPredicate {
  boolean test(Object obj) {
    URI uri;
    try {
      uri = new URI((String)obj);
    } catch(URISyntaxException e) {
      throw new ExceptionRuntimeException(e);
    }
    File file = new File(uri);
    return file.isDirectory();
  }
}
```

but using ExceptionRuntimeException allows us to tunnel through the RuntimeException-based functor API without losing information and without adding "throws Exception" to every method in the Functor API.

Whenever we're ready, we can unwrap the underlying checked Exception, and can easily distinguish that case from other instances of RuntimeException:

```java
boolean flag;
try {
  flag = isDirectory.test(someObject);
} catch(ClassCastException e) {
  // thrown when someObject is not a String
} catch(NullPointerException e) {
  // thrown when someObject is null
} catch(IllegalArgumentException e) {
  // thrown when someObject isn't a file URI
} catch(ExceptionRuntimeException ere) {
  // thrown only if some Exception was thrown
  try {
    ere.rethrowException();
  } catch(URISyntaxException e) {
    // thrown when someObject isn't a valid URI
  } catch(Exception e) {
    // other checked exceptions, which we
    // could throw as checked or unchecked
    // as needed   
    throw ere;
  }
}
```

I've grown increasingly fond of this approach, and think I'll try to put something together in the Jakarta Commons sandbox for it.

By the way, I still think checked exceptions offer some advantage in the cases I enumerated above. Consider Axion's AxionException for example. By design, the use of AxionException is fully encapsulated within the Axion API. Clients to Axion's external interface should never encounter an AxionException, it's only used internally. But similarly, clients to AxionException should generally never encounter an Axion-specific RuntimeException either--Axion's external interface should throw SQLException almost exclusively. Making AxionException a checked exception makes this constraint much easier to enforce (the JDBC-tier of Axion can easily tell which methods may result in an AxionException and which methods may not), even if it means that many of Axion's internal methods are declared to throw AxionException. Having an ExceptionRuntimeException adapter makes it possible to tunnel AxionExceptions through third-party APIs like Commons Functor.

Post script:

Thinking it unlikely that I was the first person to have this frustration with checked exceptions I consulted with some of my usual sources. One can find a number of related articles and postings, including Bruce "Thinking in Java" Eckel's Does Java need Checked Exceptions? and Checked Exceptions Are Of Dubious Value and Exception Tunneling on Ward's Wiki.

A somewhat contrary position can be found in Alan Griffith's Exceptional Java. Among other guidelines, Alan suggests exception "translation" to wrap or chain exceptions to a predictable, component- or API-specific type. This seems similar to exception tunneling, and perhaps sometimes appropriate, but the thought of having to walk arbitrarily deep exception chains to find the relevant exception gives me pause.
