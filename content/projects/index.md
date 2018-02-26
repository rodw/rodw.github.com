---
title: Projects
active_tab: projects
file_type: delimited
template: two-column
---
==========
# Team-One

I was the VP of Engineering at **[Intellinote](https://www.intellinote.net/)**, a team communication and collaboration platform for the web, desktop and mobile. Intellinote features: video conferencing, screen sharing, real-time messaging (chat), note taking, task management, file sharing, dozens of built-in integrations and an extensive REST API.

Intellinote was acquired by telcom-infrastructure giant [BroadSoft](https://www.broadsoft.com/) in May of 2016 and is now known as [BroadSoft Team-One](https://www.team-one.com/).  

BroadSoft was in turn acquired by [Cisco](https://www.cisco.com) in February of 2018. Team-One remains a key component of the BroadCloud platform.

Prior to Intellinote I worked in a number of digital product development roles at several large and small firms, including the **[Society for Human Resource Management](http://www.shrm.org/)** and **[Encyclop&aelig;dia Britannica](http://www.britannica.com/)**.  

See **<a href="/files/Waldhoff-Rodney-resume-2014-02.pdf" onclick=”var that=this;_gaq.push([‘_trackEvent’,’Download’,’PDF’,this.href]);setTimeout(function(){location.href=that.href;},200);return false;”>Rod's resume (PDF)</a>** for more detailed information but be warned that that document may not be up-to-date.

# Recent Open Source Stuff

Some public repositories and other things I've worked on relatively recently:

 * **[dust-engine](https://github.com/DocumentAlchemy/dust-engine)** - a Dust.js template processor that can be run from the command-line, invoked from code, or registered with Express.js as a rendering engine. (Via DocumentAlchemy.)

 * **[SwaggerDSL](https://www.npmjs.com/package/swagger-dsl)** - a CoffeeScript-based domain-specific language for generating JSON documents for [Swagger](http://swagger.io/). At [Team-One](https://www.team-one.com) (formerly Intellinote) we use SwaggerDSL to generate the documentation for our [REST API](https://app.us.team-one.com/rest/api/v2/).  (Via Intellinote/Team-One.)

 * **[sql-client](https://github.com/intellinote/sql-client)** - a dirt-simple SQL-client abstraction for Node.js supporting PostgreSQL, MySQL and SQLite.  (Via Intellinote/Team-One.)

 * **[Common Dust.js Helpers](https://github.com/rodw/common-dustjs-helpers)** - a small library of "standard" helper functions for the Dust.js web templating framework.  (Personal project.)

 * **[stew](https://github.com/rodw/stew)** - JavaScript library that implements the complete CSS Selector syntax, and extends it to add support for regular expressions in tag names, ids, class names, attribute names and attribute values. (Personal project.)

* **[gvpr-lib](https://github.com/rodw/gvpr-lib)** - a small library of common functions for gvpr, Graphviz's awk-like language for transforming and processing graphs. It includes **[gvpr-mode](https://github.com/rodw/gvpr-lib/blob/master/extra/gvpr-mode.el)**, a simple emacs lisp major mode for working with gvpr. gvpr-mode is available on the [Marmalade](https://marmalade-repo.org/packages/gvpr-mode/) and [MELPA](http://melpa.org/#/gvpr-mode) package repositories. In modern versions of emacs you can run `M-x package-install <RET> gvrp-mode <RET>`` to install it.  (Personal project.)

* **[pandox](https://github.com/rodw/pandox)** is an implementation of the [pandoc](http://johnmacfarlane.net/pandoc/) filter API in JavaScript/CoffeeScript.  (Personal project.)

* **[paper-forms](https://github.com/rodw/paper-forms)** - a set of printable forms, templates and worksheets.  (Personal project.)

* **[inote-util](https://github.com/intellinote/inote-util)** - a collection of generic utility functions and classes for JavaScript/CoffeeScript.  (Via Intellinote/Team-One.)

* **[termstyle](https://github.com/rodw/termstyle)** - a (server-side) JavaScript library that provides utility functions supporting styled console (terminal) output.  (Personal project.)

# Apache Software Foundation

I used to be quite active in the Java corners of the **[Apache Software Foundation](http://www.apache.org/)**. I had a pretty big role the creation of **[Jakarta-Commons](http://commons.apache.org/)** (which eventually morphed into Apache-Commons) and a lesser role in the founding of the **[Apache DB](http://db.apache.org/)** project. A fair bit of my code can still be found in the **[Apache Commons](http://commons.apache.org/)**, **[Apache-Tomcat](http://tomcat.apache.org/)**, and (through a number of migrations of HttpClient) in **[HttpComponents](http://hc.apache.org/)**, among other places.

==========
# The Graphviz Cookbook

To be candid progress has slowed quite a bit since my [day job](https://www.intellinote.net/) took off, but I had been working on a how-to book about [Graphviz](http://www.graphviz.org/), a powerful, open-source, graph visualization and processing framework.

***[The Graphviz Cookbook](/projects/gv-cookbook.html)***, like a regular cookbook, is meant to be a practical guide that shows you how to create something tangible and, hopefully, teaches you how to improvise your own creations using similar techniques. You can **[find out more information and download sample chapters here](/projects/gv-cookbook.html)**.

# DocumentAlchemy

I've been experimenting with [DocumentAlchemy](https://documentalchemy.com/), a document-processing-as-a-service platform. DocumentAlchemy provides [REST APIs](https://documentalchemy.com/api-doc) for parsing, writing, processing and transforming documents in many formats, including Microsoft Word, Excel and PowerPoint, OpenOffice Writer, Calc and Impress, PDF, HTML, Markdown and other text formats, and PNG, JPEG, GIF and WebP image formats.

A [large number of online demonstrations](https://documentalchemy.com/demo) are available and with [a free registration](https://documentalchemy.com/pricing?c=nbsu&target=%2Fapi-doc) you can obtain an API key you can use with the [interactive API documentation](https://documentalchemy.com/api-doc) or within your own programs.

# The Axion RDMS

Once upon a time I created a fully-functional relational database from scratch (with more than a bit of help from collaborators). I was a major developer behind Axion, a small, fast, open source relational database system written in and for Java. **[Axion](http://axion.tigris.org/)** has been dormant for quite a while, but it was and still is a fairly robust and complete system. Axion had and as far as I know still has some features no other RDBMS provides. Axion...

* is embedded (it runs in-process within the same JVM as the client code),
* supports both persistent (on-disk) and transient (in-memory) modes,
* supports both ANSI SQL and several extensions from Oracle's SQL dialect (circa 10g or whatever was released at the time),
* is fully transactional,
* is fully ACID (providing Atomicity, Consistency and Isolation and Durability),
* can be easily extended with custom "pluggable" table, index, column (field) and function types.
* can be found in commercial products containing millions of rows and gigabytes of data, processing thousands of transactions per second (while not a toy database by any standards, this certainly isn't "big data" volumes, but bear in mind that this was 10-15 years ago on what even then were low-end consumer models).
* was nominated as a Program to Read on the venerable C2 Wiki (a.k.a. "Ward's Wiki" or, notably, "the original wiki").

Building this wasn't as impractical as it might sound. The first version of Axion was created by a tiny team in less than 5 months in support of a top-selling, award-winning, shrink-wrapped retail CD/DVD-ROM product, and was successfully used in support of that product for nearly a decade.

# Brightspoke, a search engine for bikes.

The last time I was on the market for a new bicycle I created a tool for comparing bikes that I think is pretty nifty. The bike data is now stale, but the stem fit calculator remains popular. The calculator can help you determine how your handlebars will move when you change your stem. (The stem being the bit on a bike that connects the handlebars to the fork.) *(Offline)*
