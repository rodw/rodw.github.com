---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [python,json,cli,one-liner]
slug: python-pretty-print-json-tool
date: 2014-2-15
---
# Pretty-print JSON with Python's json.tool

Pretty-print a JSON file using Python (v2.5+)'s built-in `json.tool` module:

```bash
cat MYFILE.json | python -m json.tool
```

===============================================================================
---
tags: [python,json,cli,one-liner]
slug: python-csv-to-json-array
date: 2014-2-15
---
# Python one-liner for reading a CSV file into a JSON array of arrays

Reading a CSV file into 2-d Python array (an array of arrays):

```python
import csv
array = list(csv.reader(open( MYFILE.csv )))
```

Dumping that as JSON (via the command-line):

```bash
$ python -c "import json,csv;print json.dumps(list(csv.reader(open( CSV-FILENAME ))))"
```

===============================================================================
---
tags: [pygments,markdown,python,tool]
slug: pygments-language-identifiers
---
#  Short list of language names recognized by pygments.

`pygments` language identifiers I use or have had to look up at one time or another.

* Antlr-Ruby - `antlr-ruby`/`antlr-rb`
* awk - `awk`/`gawk`/`mawk`/`nawk`
* Bash - `bash`/`sh`/`ksh` for shell scripts, `console` for interactive session captures
* Clojure - `clj`/`closure`
* CoffeeScript - `coffee-script`/`coffeescript`
* CSS - `css`
* diff output - `diff`/ `udiff`
* Haml/Sass/Scss - `haml`, `sass`, `scss`
* HTML - `html`
* HTTP transcripts - `http`
* JavaScript - `js`/`javascript`
* JSON - `json`
* Lisp - `cl`/`common-lisp`
* make - `make`/`makefile`/`mf`, `cmake`, `basemake`, `bsdmake`
* nginx configuration files - `ngnix`
* Postscript - `postscript`
* Ruby - `ruby` for .rb files, `irb` for interactive console captures
* Scheme - `scm`/`scheme`
* SQL - `sql`, `mysql`, `psql`, `postgresql-console`/`postgres-console`, `sqlite3`
* TeX/LaTeX - `tex`, `latex`
* Text - `text` (the no-op highlighter)
* XML/XSLT/XQuery - `xml`, `xslt`, `xquery`
* Yaml - `yaml`

Also see [the list of languages supported by Pygments](http://pygments.org/languages/) and [the list of lexers included with Pygments](http://pygments.org/docs/lexers/).

===============================================================================
---
tags: [python,http,cli,one-liner,ops,tool]
slug: python-static-web-server
date: 2014-2-20
---
# Launch an HTTP server serving the current directory using Python

The Python `SimpleHTTPServer` module makes it easy to launch a simple web server using a current working directory as the "docroot".

With Python 2:

```bash
python -m SimpleHTTPServer
```

or with Python 3:

```bash
python3 -m http.server
```

By default, each will bind to port 8080, hence `http://localhost:8080/` will serve the top level of the working directory tree.  Hit `Ctrl-c` to stop.

Both accept an optional port number:

```bash
python -m SimpleHTTPServer 3001
```

or

```bash
python3 -m http.server 3001
```

if you want to bind to something other than port 8080.
