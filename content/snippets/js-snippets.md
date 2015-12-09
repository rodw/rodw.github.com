---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [javascript,coffeescript,nodejs,http,dev]
slug: node-https-ssl
date: 2014-3-13
---

# Launching an SSL (HTTPS) Server in Node.js

JavaScript:

```javascript
var https      = require("https");
var fs         = require("fs");
var key_file   = "/path/to/file.pem";
var cert_file  = "/path/to/file.crt";
var passphrase = "this is optional";
var config     = {
  key: fs.readFileSync(key_file),
 cert: fs.readFileSync(cert_file)
};
if(passphrase) {
  config.passphrase = passphrase;
}

https.createServer(config,app).listen(443);
```

CoffeeScript:

```coffeescript
https      = require "https"
fs         = require "fs"
key_file   = "/path/to/file.pem"
cert_file  = "/path/to/file.crt"
passphrase = "this is optional"
config     = {
  key:  fs.readFileSync(key_file)
  cert: fs.readFileSync(cert_file)
}
config.passphrase = passphrase if passphrase?

https.createServer(config,app).listen(443)
```

Where `/path/to/file.pem` is the path to a file containing an RSA key, generated (for example) by:

```bash
openssl genrsa 1024 > /path/to/file.pem
```

and  `/path/to/file.crt` is the path to a file containing an SSL certificate, generated (for example) by:

```bash
openssl req -new -key /path/to/file.pem -out csr.pem
openssl x509 -req -days 365 -in csr.pem -signkey /path/to/file.pem -out /path/to/file.crt
```

===============================================================================
---
tags: [javascript,coffeescript,nodejs,expressjs,dev]
slug: redirect-domain-in-expressjs
date: 2014-3-13
---

# Redirect www.example.com to example.com in Node.js and Express.js

To redirect all paths on the "www" version of a hostname to the "non-www" (domain only) version using Express.js (or Connect):

JavaScript:

```javascript
app.all('/*', function(req, res, next) {
 if(/^www\./.test(req.headers.host)) {
  res.redirect(req.protocol + '://' + req.headers.host.replace(/^www\./,'') + req.url,301);
 } else {
  next();
 }
});
```

CoffeeScript:

```coffeescript
app.all '/*', (req, res, next)->
  if /^www\./.test req.headers.host
    res.redirect "#{req.protocol}://#{req.headers.host.replace(/^www\./,'')}#{req.url}",301
  else
    next()
```

===============================================================================
---
tags: [javascript,coffeescript,nodejs,expressjs,dev]
slug: redirect-http-to-https-in-expressjs
date: 2014-3-13
---

# Redirect http: to https: in Node.js and Express.js

To redirect all HTTP requests to the equivalent HTTPS requests using Express.js you can create a simple Express instance that listens on the HTTP port and performs the redirect.

JavaScript:

```javascript
var http       = require('http');
var express    = require('express');
var HTTP_PORT  = 80;
var HTTPS_PORT = 443;

var http_app = express();
http_app.set('port', HTTP_PORT);

http_app.all('/*', function(req, res, next) {
  if (/^http$/.test(req.protocol)) {
    var host = req.headers.host.replace(/:[0-9]+$/g, ""); // strip the port # if any
    if ((HTTPS_PORT != null) && HTTPS_PORT !== 443) {
      return res.redirect("https://" + host + ":" + HTTPS_PORT + req.url, 301);
    } else {
      return res.redirect("https://" + host + req.url, 301);
    }
  } else {
    return next();
  }
});

http.createServer(http_app).listen(HTTP_PORT).on('listening', function() {
  return console.log("HTTP to HTTPS redirect app launched.");
});
```

CoffeeScript:

```coffeescript
http       = require 'http'
express    = require 'express'
HTTP_PORT  = 80
HTTPS_PORT = 443

http_app = express()
http_app.set 'port', HTTP_PORT

http_app.all '/*', (req, res, next)->
  if /^http$/.test req.protocol
    host = req.headers.host.replace /:[0-9]+$/g, "" # strip the port # if any
    if HTTPS_PORT? and HTTPS_PORT isnt 443
      res.redirect "https://#{host}:#{HTTPS_PORT}#{req.url}", 301
    else
      res.redirect "https://#{host}#{req.url}", 301
  else
    next()

http.createServer(http_app).listen(HTTP_PORT).on 'listening',()->
  console.log "HTTP to HTTPS redirect app launched."
```
===============================================================================
---
tags: [javascript,web,html,performance,dev]
slug: prefetching-images-with-js
date: 2014-3-13
---

# Preloading images with JavaScript

If your web app dynamically displays certain images and you don't want to make sure that the images are downloaded before they are first displayed, you can pre-fetch the images using some simple javascript.

For single-page apps, this should be sufficient:

```javascript
function preload_images(urls) {
  urls.forEach( function(i, url ) {
    (new Image()).src = url;
  });
}

preload_images( [ 'image1.jpg', 'image2.png', 'image3.tiff' ] );
```

If you want to add a slight delay (so other web assets can load first) use something like:

```javascript
setTimeout( function() { preload_images( [ 'image1.jpg', 'image2.png', 'image3.tiff' ] ); }, 500) ;
```

The single-page-app method above loads each image in the array into memory.  *However*, browsers generally won't cache these images, so if the user navigates to another page without viewing the images, they will be lost.

To make the images cachable, it helps to add the image that is created into the actual DOM tree for the page. Here's one way:

```javascript
function preload_images(urls) {
  var newdiv = document.createElement("div")
  if(newdiv.setAttribute) {
    newdiv.setAttribute("style","display:none;")
  } else if(newdiv.style && newdiv.style.setAttribute) {
    newdiv.style.setAttribute("cssText","display:none;")
  } else if(newdiv.style) {
    newdiv.style.cssText = "display:none;";
  } else {
    newdiv.style = "display:none;"
  }
  urls.forEach( function(i, url ) {
    var newimg = new Image();
    newimg.src = url
    newdiv.appendChild(newimg)
  });
  document.body.appendChild(newdiv)
}
```

===============================================================================
---
tags: [coffeescript,nodejs,dev]
slug: mocha-coffeescript-unexpected-string-error
date: 2014-2-11
---

# Fixing "Unexpected string" errors with CoffeeScript 1.7 and Mocha 1.17

Recently I've been running into the following error when testing CoffeeScript files using Mocha:


    (exports, require, module, __filename, __dirname) { should  = require 'should'
                                                                          ^^^^^^^^
    SyntaxError: Unexpected string


[The fix is described here on the mocha site.](http://visionmedia.github.io/mocha/#compilers-option)

> coffee-script is no longer supported out of the box. CS and similar transpilers may be
> used by mapping the file extensions (for use with --watch) and the module name. For example
> --compilers coffee:coffee-script with CoffeeScript 1.6- or
> --compilers coffee:coffee-script/register with CoffeeScript 1.7+.

In other words, to fix the problem change the argument:

    --compilers coffee:coffee-script

on your Mocha command line to:

    --compilers coffee:coffee-script/register

===============================================================================
---
tags: [coffeescript,javascript,nodejs,sql,database,mysql,html,web,dev]
slug: node-js-sql-to-html
date: 2014-2-8
---

# A General Purpose SQL-to-HTML Routine for CoffeeScript/JavaScript/Node.js

Using [node-mysql](https://github.com/felixge/node-mysql) or similar, the following CoffeeScript routine will generate an HTML table containing the data in a SQL result set, including column headings:

```coffeescript
sql_to_html:(connection,query,bindvars,callback)->
  connection.query query, bindvars, (err,rows,fields)->
    if err?
       callback(err)
    else
      buffer = '<table border=1><tr>'
      for field in fields
        buffer += "<th>#{field.name}</th>"
      buffer += '</tr>'
      for row in rows
        buffer += '<tr>'
        for field in fields
          buffer += "<td>#{row[field.name]}</td>"
        buffer += '</tr>'
      buffer += '</table>'
      callback(null,buffer)
```

===============================================================================
---
tags: [regexp,javascript,coffeescript,dev]
slug: escape-for-regexp
date: 2013-6-19
---

# escape a string for use in a regular expression

The following function converts reserved characters into backslash-escaped patterns.  This allows a literal string to be used within a regular expression.

```coffeescript
escape_for_regexp=(str)->
  return str.replace(/([.?*+^$[\]\\(){}|-])/g, "\\$1")
```

For example:

```javascript
var literal = "Who said that?";
var escaped = escape_for_regexp(literal); // yields "Who said that\?"
var regexp = new RegExp(escaped);
console.log(regexp);                      // yields /Who said that\?/
```

===============================================================================
---
tags: [javascript,coffeescript,dev]
slug: coffeescript-flatten-array
date: 2013-1-23
---

# flatten an array in coffeescript

```coffeescript
flatten_array = (a)->
  unless a?
    return null
  else if a.length is 0
    return []
  else
    return ( a.reduce (l,r)->l.concat(r) )
```

===============================================================================
---
tags: [nodejs,javascript,coffeescript,cli,linux,ops,dev]
slug: node-js-process-on-sigint
date: 2013-1-8
---
# gracefully closing node.js applications via signal handling

To make your node.js application gracefully respond to shutdown signals, use `process.on(SIGNAL,HANDLER)`.

For example, to respond to `SIGINT` (typically *Ctrl-c*), you can use:

```js
process.on( "SIGINT", function() {
  console.log('CLOSING [SIGINT]');
  process.exit();
} );
```

Note that without the `process.exit()`, the program will not be shutdown.  (This is you chance to override or "trap" the signal.)

Some common examples (in CoffeeScript):

```coffeescript
process.on 'SIGHUP',  ()->console.log('CLOSING [SIGHUP]');  process.exit()
process.on 'SIGINT',  ()->console.log('CLOSING [SIGINT]');  process.exit()
process.on 'SIGQUIT', ()->console.log('CLOSING [SIGQUIT]'); process.exit()
process.on 'SIGABRT', ()->console.log('CLOSING [SIGABRT]'); process.exit()
process.on 'SIGTERM', ()->console.log('CLOSING [SIGTERM]'); process.exit()
```

PS: On Linux (and similar) you can enter `kill -l` on the command line to see a list of possible signals, and `kill -N PID` to send signal *N* to the process with process ID *PID*.

===============================================================================
---
tags: [javascript,coffeescript,regexp,cheatsheet,dev]
slug: js-regexp-cheat-sheet
date: 2013-1-18
---
# Cheat Sheet for JavaScript Regular Expressions

## flags
 * `/pattern/g` - global
 * `/pattern/i` - case-insensitive
 * `/pattern/m` - multi-line

## patterns

 * `\s` - any whitespace character (`[\f\n\r\t\v\u00A0\u2028\u2029]`)
 * `\S` - any non-whitespace character (`[^\f\n\r\t\v\u00A0\u2028\u2029]`)
 * `[\s\S]` - commonly used for "anything including newlines (alternative `[^]`)
 * `\S` - any non-whitespace character (`[^\f\n\r\t\v\u00A0\u2028\u2029]`)

 * `\w` - any word character (alpha, numeric or underscore) (`[a-zA-Z0-9_]`)
 * `\W` - any non-word character (`[^a-zA-Z0-9_]`)
 * `\d` - any digit (`[0-9]`)
 * `\D` - any non-digit (`[^0-9]`)
 * `\cX`- control character X (e.g. `\cM` matches `control-M` (`^M`))
 * `\b` - word boundary (the position between a word char and whitespace)
 * `\B` - not a word boundary (`[^\b]`).
 * `\xhh` - the character with hex code `hh`
 * `\uhhhh` - the character with hex code `hhhh`

===============================================================================
---
tags: [nodejs,javascript,coffeescript,cli,dev]
slug: nodejs-require-main
date: 2013-3-3
---
# Check `require.main` to test if a Node.js file is run directly

In Node, when a file is run directly from the command line, `require.main` is set to its `module`. Hence `require.main === module` tells you whether or not your script was invoked directly or required by another file.

A JavaScript "main" idiom:

```javascript
//#!/usr/bin/env node
// file: example.js

function main() {
  // ...
}

if(require.main === module) {
  main();
}
```

The `main` method will run if `example.js` is invoked via `node example.js` or `./example.js` but not when required within another script (via `require('./example')`, for example).

A CoffeeScript "main" idiom (using classes, although it doesn't have to):

```coffeescript
#!/usr/bin/env coffee
# file: example.coffee
class Example
  main:()->
    # ...

if require.main is module
  (new Example()).main()
```

The `main` method will run if `example.coffee` is invoked via `coffee example.coffee` or `./example.coffee` but not when required within another script (via `require('./example')`, for example).

Also see [the nodejs.org docs](http://nodejs.org/docs/v0.4.8/api/all.html#accessing_the_main_module).

===============================================================================
---
tags: [nodejs,javascript,coffeescript,cli,dev]
slug: argv-underscore-in-optimist
date: 2013-3-3
---
# In node-optimist, `argv._` is an array of the "extra" parameters

In substack's [node-optimist](https://github.com/substack/node-optimist), you can use `argv._` to fetch any parameters remaining after optimist has done its parsing.

For example (in CoffeeScript):

```coffeescript
# file: example.coffee
optimist = require 'optimist'
options = {
  'help' : { description:'Show this message and exit.', boolean:true, alias:'h' }
}
argv = optimist.usage('Usage: $0 [--help]', options).argv

# Now argv._ contains an array "extra" parameters, if any
console.log argv._
```

For example

```bash
coffee example.coffee --help
```

yields

```json
[ ]
```

but either of

```bash
coffee example.coffee --help foo.txt bar.png
```

or

```bash
coffee example.coffee foo.txt bar.png
```

yield

```json
[ "foo.txt", "bar.png" ]
```
===============================================================================
---
tags: [nodejs,javascript,coffeescript,cli,ruby,dev]
slug: argf-for-nodejs
date: 2013-3-3
---
# Ruby-like ARGF for Node.js

tokuhirom's [node-argf](https://github.com/tokuhirom/node-argf) module offers a Ruby-like ARGF for Node.js.

Install via:

```bash
npm install argf
```

or by adding

```json
{
  "dependencies" : {
    "argf" : "latest"
  }
}
```

to your `package.json` file.

Use ARGF like this:

```javascript
ARGF = require('argf');
argf = new ARGF();  // create argf based on current
                    // command line parameters or
                    // input streams.

// register a callback for when all input data has been read
argf.on('finished', function() {
  console.log("Done processing all inputs.");
});

// process the input(s)
argf.forEach( function(line) {
  console.log("Read:",line);
  console.log("From source:",argv.stream.path);
}
```

Like Ruby's `ARGF`, the module assumes any elements in `process.argv` represent files to process (and uses the input stream if no files are provided.

You can also pass an array to `new ARGF()` to provide the list of files, which is handy if you're using something like [node-optimist](https://github.com/substack/node-optimist).  (Note that in node-optimist you can use `argv._` to get the remaining parameters after parsing.)  For example:

```javascript
optimist = require('optimist');
ARGF = require('argf');

options = {
  # ...
}
argv = optimist.usage('Usage: $0 ...', options).argv;

argf = new ARGF(argv._);

argf.on('finished', function() {
  console.log("Done processing all inputs.");
});

// process the input(s)
argf.forEach( function(line) {
  console.log("Read:",line);
  console.log("From source:",argv.stream.path);
}
```
===============================================================================
---
tags: [javascript,dev]
slug: rectangles-intersect
date: 2013-3-3
---

# How to determine if two rectangles overlap.

```javascript
// Assuming that x1,y1 and x2,y2 give the upper left and
// lower right coordinates of the rectangles (respectively).
function rectangles_dont_intersect(Ax1,Ay1,Ax2,Ay2,Bx1,By1,Bx2,By2) {
  return (Ax1 < Bx2) && (Ax2 > Bx1) && (Ay1 < By1) && (Ay2 > By2);
}

function rectangles_intersect(Ax1,Ay1,Ax2,Ay2,Bx1,By1,Bx2,By2) {
  return !rectangles_dont_intersect(Ax1,Ay1,Ax2,Ay2,Bx1,By1,Bx2,By2);
}
```
