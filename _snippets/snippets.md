
######################################################################
tags: [emacs,calendar]
title: emacs calendar functions
slug: emacs-calendar
note: 2013-04-15
credit: Also see <a href="http://www.gnu.org/software/emacs/manual/html_node/emacs/Calendar_002fDiary.html">the emacs manual</a>.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Open the calendar:

    M-x calendar


(You can close the calendar with `q`, which invokes `(calendar-exit)`.

Movement:

  * `C-f` or arrow-right is `(calendar-forward-day)` and `C-b` or arrow-left is `(calendar-backward-day)`.
  * `C-n` or arrow-down is `(calendar-foward-week)` and `C-p` or arrow-up is `(calendar-backward-week)`.
  * `M-}` or `>` is `(calendar-forward-month)` and `M-{` or `<` is `(calendar-backward-month)`
  * `C-x ]` is `(calendar-foward-year)` and `C-x [` is `(calendar-backward-year)`
  * Use the `M-<n>` prefix to move a multiple of the above.  E.g. `M-90 C-f` (or `M-90 <right-arrow>`) moves forward 90 days.  (In calendar mode, the meta key is optional, simply `90 <right-arrow>` will move forward 90 days, `16 <down-arrow>` will move forward 16 weeks, etc.)
  * `o` will let you interactively select a date.
  * `.` will return to today

Other:
  * (Right-click on the calendar will generally open up a context-menu about these.)
  * `p d` is (calendar-print-day-of-year)
  *  Type`C-<space>`, move to another date and type `M-=` to invoke `(calendar-count-days-region)` (show the number of days between the dates (including the endpoints).
  * Type `H m` or `H y` to generate an html-format calendar (month and year, respectively).  (`t <something>` generates a number of interesting calendars in TeX, if you are so inclined.)
  * Type `h` to see known holidays for the selected date, or `a` to see all holidays for the three month period that is displayed. Use `M-x list-holidays` for even more.  Use `M` to see a list of lunar phases. Use `S` to see sunrise/sunset information.

######################################################################
tags: [node.js,javascript,coffeescript]
title: flatten an array in coffeescript
slug: coffeescript-flatten-array
note: 2013-01-23
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight coffeescript %}
flatten_array = (a)->
  unless a?
    return null
  else if a.length is 0
    return []
  else
    return ( a.reduce (l,r)->l.concat(r) )
{% endhighlight %}

######################################################################
tags: [node.js,javascript,coffeescript]
title: gracefully closing node.js applications via signal handling
slug: node-js-process-on-sigint
note: 2013-01-08
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To make your node.js application gracefully respond to shutdown signals, use `process.on(SIGNAL,HANDLER)`.

For example, to respond to `SIGINT` (typically *Ctrl-c*), you can use:

{% highlight javascript %}
process.on( "SIGINT", function() {
  console.log('CLOSING [SIGINT]');
  process.exit();
} );
{% endhighlight %}

Note that without the `process.exit()`, the program will not be shutdown.  (This is you chance to override or "trap" the signal.)

Some common examples (in CoffeeScript):

{% highlight coffeescript %}
process.on 'SIGHUP',  ()->console.log('CLOSING [SIGHUP]');  process.exit()
process.on 'SIGINT',  ()->console.log('CLOSING [SIGINT]');  process.exit()
process.on 'SIGQUIT', ()->console.log('CLOSING [SIGQUIT]'); process.exit()
process.on 'SIGABRT', ()->console.log('CLOSING [SIGABRT]'); process.exit()
process.on 'SIGTERM', ()->console.log('CLOSING [SIGTERM]'); process.exit()
{% endhighlight %}

PS: On Linux (and similiar) you can enter `kill -l` on the command line to see a list of possible signals, and `kill -N PID` to send signal *N* to the process with process ID *PID*.


######################################################################
tags: [html,latex]
title: breaking non-space (zero-width space)
slug: zero-width-space-char
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To insert a zero-width space character (as a hint to the layout engine that it *could* insert a line break here) in HTML:

{% highlight html %}
&#x200B;
{% endhighlight %}

Or in Latex:

{% highlight latex %}
\hspace{0pt}
{% endhighlight %}


######################################################################
tags: [emacs]
title: M-x occur
slug: emacs-m-x-occur
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`M-x occur` is nifty.

######################################################################
tags: [emacs]
title: C-x C-x to toggle between positions
slug: emacs-c-x-c-x
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

For example:  Use `C-s foo` to search for something.  Maybe use `C-s` again to step thru. Now use `C-x C-x` to flip back to the point where you started (and `C-x C-x` again to return).

######################################################################
tags: [javascript,coffeescript,regexp]
title: Cheat Sheet for JavaScript Regular Expressions
slug: js-regexp-cheat-sheet
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

### flags
 * `/pattern/g` - global
 * `/pattern/i` - case-insensitive
 * `/pattern/m` - multi-line

### patterns

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

######################################################################
tags: [emacs]
title: Change font size in emacs
slug: emacs-font-size
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To change the font size in the current buffer:

 * `C-x C-+` - increase font size

 * `C-x C--` - descrease font size

Follow either with `+`, `-` or `0` for continued adjustment.

To change the font size in all buffers:

{% highlight cl %}
(set-face-attribute 'default nil :height 120) ;; where `height` is 10x point size
{% endhighlight %}

######################################################################
tags: [bash,linux]
title: Toggle line-wrapping in terminal with `tput rmam` and `tput sram`
slug: toggle-line-wrapping-in-terminal
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The command:

{% highlight console %}
tput rmam
{% endhighlight %}

will disable line wrapping so that long lines are truncated to width of the terminal (`$COLUMNS`).

The command:

{% highlight console %}
tput smam
{% endhighlight %}

will re-enable it.

This seems to known as "automatic margin" mode, hence `smam` is `enter_am_mode` and `rmam` is `exit_am_mode`.

Some terminals may not support this functionality.

######################################################################
tags: [bash,linux]
title: Use `less -S` for horizontal scrolling
slug: less-chop-long-lines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The flag `-S` (or `--chop-long-lines`) will cause `less` to truncate lines at the screen (terminal) boundary, rather than wrapping as it does by default.  You can then scroll horizonally (with the arrow keys, for example) to view the full lines when needed.

{% highlight console %}
cat some_file_with_very_long_lines | less -S
{% endhighlight %}

######################################################################
tags: [node.js,javascript,coffeescript,cli]
title: Check `require.main` to test if a Node.js is run directly
slug: nodejs-require-main
credit: Via <a href="http://nodejs.org/docs/v0.4.8/api/all.html#accessing_the_main_module">the nodejs.org docs</a>.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In Node, when a file is run directly from the command line, `require.main` is set to its `module`. Hence `require.main === module` tells you whether or not your script was invoked directly or required by another file.

A JavaScript "main" idiom:

{% highlight javascript %}
#!/usr/bin/env node
# file: example.js

function main() {
  // ...
}

if(require.main === module) {
  main();
}
{% endhighlight %}

The `main` method will run if `example.js` is invoked via `node example.js` or `./example.js` but not when required within another script (via `require('./example')`, for example).

A CoffeeScript "main" idiom (using classes, although it doesn't have to):

{% highlight coffeescript %}
#!/usr/bin/env coffee
# file: example.coffee
class Example
  main:()->
    # ...

if require.main is module
  (new Example()).main()
{% endhighlight %}

The `main` method will run if `example.coffee` is invoked via `coffee example.coffee` or `./example.coffee` but not when required within another script (via `require('./example')`, for example).

######################################################################
tags: [emacs]
title: Use `M-y` to yank (paste) into the emacs i-search prompt
slug: paste-in-isearch-with-m-y
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

    C-s M-y

######################################################################
tags: [node.js,javascript,coffeescript,node-optimist]
title: In node-optimist, `argv._` is an array of the "extra" parameters
slug: argv-underscore-in-optimist
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In substack's [node-optimist](https://github.com/substack/node-optimist), you can use `argv._` to fetch any parameters remaining after optimist has done its parsing.

For example (in CoffeeScript):

{% highlight coffeescript %}
# file: example.coffee
optimist = require 'optimist'
options = {
  'help' : { description:'Show this message and exit.", boolean:true , alias:'h' }
}
argv = optimist.usage('Usage: $0 [--help]', options).argv

# Now argv._ contains an array "extra" parameters, if any
console.log argv._
{% endhighlight %}

For example

{% highlight console %}
coffee example.coffee --help
{% endhighlight %}

yields

{% highlight javascript %}
[ ]
{% endhighlight %}

but either of

{% highlight console %}
coffee example.coffee --help foo.txt bar.png
{% endhighlight %}

or

{% highlight console %}
coffee example.coffee foo.txt bar.png
{% endhighlight %}

yield

{% highlight javascript %}
[ 'foo.txt', 'bar.png' ]
{% endhighlight %}

######################################################################
tags: [node.js,javascript,coffeescript,ruby]
title: Ruby-like ARGF for Node.js
slug: argf-for-nodejs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

tokuhirom's [node-argf](https://github.com/tokuhirom/node-argf) module offers a Ruby-like ARGF for Node.js.

Install via:

{% highlight console %}
npm install argf
{% endhighlight %}

or by adding

{% highlight json %}
{
  ...
  "dependencies" : {
    ...
    "argf" : "latest"
  }
  ...
}
{% endhighlight %}

to your `package.json` file.

Use ARGF like this:

{% highlight javascript %}
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
{% endhighlight %}

Like Ruby's `ARGF`, the module assumes any elements in `process.argv` represent files to process (and uses the input stream if no files are provided.

You can also pass an array to `new ARGF()` to provide the list of files, which is handy if you're using something like [node-optimist](https://github.com/substack/node-optimist).  (Note that in node-optimist you can use `argv._` to get the remaining parameters after parising.)  For example:

{% highlight javascript %}
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
{% endhighlight %}

######################################################################
tags: [tips,chromium/google chrome]
title: Ctrl-Back opens the referring page in a new tab in Chrome
slug: chrome-go-back-in-new-tab
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

### TIL you can press the ctrl-click on the back button to "go back" in a new tab.

In Chromium/Google Chrome, holding down the `Ctrl` button while clicking on the back button will open a new tab with the appropriate page (`history.go(-1)`) in a new tab.

I don't know how long this has been a feature, but I accidentally stumbed across this today.  Very useful for me. I often open many links from a single page (a directory page or SERP for example). When I fail to Ctrl-click, I need to go back, and ctrl-click the link, which is tedious when it results in two spurious page loads (loading the new page, re-loading the list page and then re-loading the new page again).

######################################################################
tags: [emacs]
title: Change Case in Emacs
slug: emacs-change-case
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To change the letter case in Emacs:

 * `M-u` - `(upcase-word)` - will convert following word to UPPER case (or the rest of the current word).

 * `M-l` - `(downcase-word)` - will convert following word to lower case (or the rest of the current word).

 * `M-c` - `(capitalize-word)` - will Capitalize the following word (or the rest of the current word).

For example, consider the text `The quick brown fox jumped.`

If you position the cursor on the `q` (fifth column), then `M-u` changes `quick` to `QUICK`, `M-c` changes `quick` to `Quick`, etc.

If you position the cursor on the `u` (sixth column), then `M-u` changes `quick` to `qUICK`, `M-c` changes `quick` to `qUick`, etc.

One could probably write an elisp function based on `(capitalize-word)` and some heurstics or dictionary lookups to create a true title case function (e.g., not capitalize `a`, `an`, `the` in the middle of a phrase), but `M-c` is a quick and easy approximation.

Also, note that there is a version of upcase and downcase that work on the selection (region) instead of the next word.

 * `C-x C-u` - `(upcase-region)`

 * `C-x C-l` - `(downcase-region)`

Of course, if you're using "CUA Keys", you can't easily type `C-x` without invoking "cut".

######################################################################
tags: [emacs,ess,R]
title: Working with R in emacs
slug: ess-for-r-in-emacs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

1) [Install R](http://www.r-project.org/).

2) [Install ESS](http://ess.r-project.org/):

{% highlight console %}
sudo aptitude install ess=12.09-1
{% endhighlight %}

3) Require `ess-site`:

{% highlight cl %}
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(require 'ess-site)
{% endhighlight %}

4) Load R within emacs via `M-x R`.

######################################################################
tags: [linux,debian,reference]
title: Cheat Sheet for Linux Run Levels
slug: linux-run-level-cheatsheet
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

"Standard" Linux uses the following run levels:

 * ***Run Level 0*** is halt (shutdown).
 * ***Run Level 1*** is single-user mode.
 * ***Run Level 2*** is multi-user mode (without networking)
 * ***Run Level 3*** is multi-user mode (with networking). This is the normal "terminal" mode. (I.e., before the display manager is run).
 * ***Run Level 4*** is undefined.
 * ***Run Level 5*** is multi-usermode with a GUI display manager (X11).
 * ***Run Level 6*** is reboot.

In Debian and its derivatives run levels 2 thru 5 are the same: multi-user mode with networking, and with a display manager if available.

 * ***Run Level 0*** is halt (shutdown).
 * ***Run Level 1*** is single-user mode.
 * ***Run Level 2-5*** is multi-user mode with networking and a GUI display manager when available.
 * ***Run Level 6*** is reboot.

Debian also adds ***Run Level S***, which is executed when the system first boots.

Also see [Wikipedia's article on run levels](http://en.wikipedia.org/wiki/Runlevel).

######################################################################
tags: [linux,debian]
title: How to disable services in Debian/Linux
slug: disable-services-in-linux
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The easy way is to install `sysv-rc-conf`:

{% highlight console %}
aptitude install sysv-rc-conf
sysv-rc-conf
{% endhighlight %}

Manually, use `update-rc.d` and specify the run levels, like so:

{% highlight console %}
update-rc.d SERVICE_NAME stop 0 1 6 3 . start 2 4 5 .
{% endhighlight %}

######################################################################
tags: [bash,bash-prompt,linux]
title: How to right-align text in your bash prompt
slug: how-to-right-align-bash-prompt
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

### Right aligning text by padding with spaces

To have text in your bash prompt (`$PS1`) hug the right side of the terminal:

{% highlight console %}
PS1="`printf "%${COLUMNS}s\n" "${TEXT}"`$PS1"
{% endhighlight %}

(This assumes you want the right-aligned text to appear before the rest of your prompt, if any.  Move the `$PS1` bit to the left side of the string to have the right-aligned text appear after the rest of your prompt.)

The `${COLUMNS}` variable contains the number of columns in the current terminal (it should change if you resize the terminal).  The `${TEXT}` variable is a placeholder for the text you want to right-align.

The trick here is to use `printf` to left-pad the string to given width.  `printf "%ns" "text"` will left-pad the given string (here, `text`) with spaces until the entire string is *n* characters wide.

### Right aligning text by padding with something other than space.

Say you want to pad with `-` instead of space.  Try:

{% highlight console %}
PS1="`printf -vch "%${COLUMNS}s" "${TEXT}"; printf "%s" "${ch// /-}"`$PS1"
{% endhighlight %}

This will left-pad the `${TEXT}` with spaces, as above, and then replace any spaces with `#`.

If you have any spaces in `${TEXT}` you want to preserve, one hacky work-around is to mark spaces in `$TEXT` with some other character, say `_`, and then replace `_` with ` ` *after* the other substitution:

{% highlight console %}
PS1="$PS1`printf -vch "%${COLUMNS}s" "${TEXT}"; printf -vch "%s" "${ch// /-}"; printf "%s\n" "${ch//_/ }"`"
{% endhighlight %}

### Drawing a line to the end of the line

I recently added a line containing the date and time to my bash prompt (so I can tell when a given command completed) and wanted to draw a line across the rest of the screen to make it visually easier to tell where a new prompt is displayed.  Something like this:

{% highlight text %}
-- Tue 02-Oct-2012 05:19 PM --------------------------------
{% endhighlight %}

(Assuming the terminal is 60 characters wide.)

Here's how I did it.

Within my `$PROMPT_COMMAND` I execute the following:

{% highlight text %}
line="`printf -vch "%${COLUMNS}s" ""; printf "%s" "${ch// /-}"`"
dts="`date +"-- %a %d-%b-%Y %I:%M %p "`"
PS1="$PS1\e[1m\e[32m${dts}${line:${#dts}}"
{% endhighlight %}

The first line creates a variable (`$line`) with `${COLUMNS}` dashes (`-`).  This line would span the length of the terminal.

The second line creates a variable (`$dts`) with my date and time format of choice (prefixed with `--` just for kicks).

The `${dts}${line:${#dts}}` bit in the third line displays my date and time string (`$dts`) and then a substring of `$line`, starting at the length of my date and time string (`${#dts}`).  (In this particular case `${dts}` is always exactly 28 characters long, so that value could be hard-coded but this way it works in the general case too.)

If you are curious, the `\e[1m\e[32m` bit makes the text bold (`\e[1m`) and green (`\e[32m`).

######################################################################
tags: [emacs]
title: Default fonts with emacsclient/emacs --daemon
slug: emacsclient-daemon-default-font
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I've been using `set-default-font` in my `.emacs` file to configure emacs to use my favorite programming font.

{% highlight cl %}
(set-default-font "Droid Sans Mono Slashed-10") ;;; set default font
{% endhighlight %}

I use `emacs --daemon` to keep an instance of emacs running as a background process on my development machine so that I can run `emacsclient` to call up an emacs window (frame) instantaneously (and keep the same session running even after a close the emacs frame).

Suddenly (after an `aptitude safe-upgrade`, I think, but I'm not sure what triggered this change), emacs frames that are created by `emacsclient` connecting to the `emacs --daemon` instance no longer used my default font when initially opened. The default font worked properly for stand-alone emacs instances (opened with `emacs`), and for `emacsclient`, executing `(set-default-font)` after startup worked fine, but it no longer worked automatically.

To fix this, I had to set up a `default-frame-alist`, which I believe defines commands to execute whenever a new frame is opened.

{% highlight cl %}
(set-default-font "Droid Sans Mono Slashed-10") ;;; set default font
(setq default-frame-alist '((font . "Droid Sans Mono Slashed-10"))) ;;; set default font for emacs --daemon / emacsclient
{% endhighlight %}

By the way, I also discovered the `describe-font` elisp function while trying to diagnose this issue.

{% highlight cl %}
(describe-font "Droid Sans Mono Slashed-10")
;; or M-x describe-font <RETURN> Droid Sans Mono Slashed-10 <RETURN>
{% endhighlight %}

which opens a `*Help*` buffer containing:

{% highlight text %}
name (opened by): -unknown-Droid Sans Mono Slashed-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1
       full name: Droid Sans Mono Slashed:pixelsize=13:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true
            size: 13
          height: 17
 baseline-offset:  0
relative-compose:  0
{% endhighlight %}

######################################################################
tags: [emacs,shortcut]
title: various emacs shortcuts
slug: various-emacs-shortcuts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 * In org-mode, `<s[tab]` inserts a BEGIN_SRC/END_SRC block. (Think "insert source".)
 * Bookmarks
    * `C-x r b` - jump to bookmark
    * `C-x r m` - create (make) bookmark
 * `M-o M-s` / `M-o M-S` - center line / center paragraph
 * `M-<Home>`, `M-<Page Up>`, etc. - move in other window/frame (without losing focus on the current window/frame)
 * cursor movement
    * `C-a` / `C-e` - beginning of line / end of line
    * `M-a` / `M-e` - beginning of sentence / end of sentence
    * `C-b` / `C-f` - backward one character / forward one character
    * `C-p` / `C-n` - previous line / next line

 * `C-l` - recenter top/bottom
 * `C-j` - newline and indent
 * `C-c h` - hide lines matching
 * `C-h e` - show echo area messages

######################################################################
tags: [emacs,shortcut]
title: Numbering lines in emacs
slug: number-lines-emacs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

A few ways to add line numbers in emacs:

* `M-x linum-mode <RET>` will annotate the buffer with line numbers. (These numbers are decoration, in the "fringe" rather than part of the buffer text.)  Also see [Linum Plus](http://emacser.com/linum-plus.htm).

* `C-x r N` will *insert* line numbers into the selected region. (These numbers are content, they are added to the text of the buffer.)

* `M-x line-number-mode <RET>` show the line number of the current line in the modeline.

* `C-x l` will report (in the minibuffer) the total number of lines in the current buffer as well as the number of lines before and after the cursor

* `M-x what-line <RET>` will report (in the minibuffer) the current line number

Also see [emacswiki.org/LineNumbers](http://www.emacswiki.org/LineNumbers).

######################################################################
tags: [javascript,algorithm]
title: How to determine if two rectangles overlap.
slug: rectangles-intersect
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight js %}
// Assuming that x1,y1 and x2,y2 give the upper left and
// lower right coordinates of the rectangles (respectively).
function rectangles_dont_intersect(Ax1,Ay1,Ax2,Ay2,Bx1,By1,Bx2,By2) {
  return (Ax1 < Bx2) && (Ax2 > Bx1) && (Ay1 < By1) && (Ay2 > By2);
}

function rectangles_intersect(Ax1,Ay1,Ax2,Ay2,Bx1,By1,Bx2,By2) {
  return !rectangles_dont_intersect(Ax1,Ay1,Ax2,Ay2,Bx1,By1,Bx2,By2);
}
{% endhighlight %}


######################################################################
tags: [multimedia,sources,links]
title: Short list of sources for Creative Commons images and media.
slug: test-slug
draft: true
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* [Search for Creative Commons content via cc.org](http://search.creativecommons.org/)
* [Search for Creative Commons content on Flickr](http://www.flickr.com/search/?q=kitten&l=commderiv) or use this [alternative interface from PhotoPin](http://photopin.com/search/kitten).
* [Search for Creative Commons content via Google](https://www.google.com/search?q=kitten&tbs=sur:f&tbm=isch)

######################################################################
tags: [css]
title: Cross-browser CSS transitions
slug: cross-browser-css-transitions
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight css %}
.foo {
  transition:         opacity .25s ease-in-out;
  -webkit-transition: opacity .25s ease-in-out;
  -moz-transition:    opacity .25s ease-in-out;
  -o-transition:      opacity .25s ease-in-out;
}
{% endhighlight %}

Where the right-hand side has the general form:

{% highlight text %}
PROPERTY DURATION [TIMING-FUNCTION] [TRANSITION-DELAY]
{% endhighlight %}

Transitions can chained:

{% highlight css %}
transition: opacity .25s ease-in-out, height 1s linear
{% endhighlight %}

### Transition timing functions

 * `linear` - constant rate of change between states.

   `cubic-bezier(0.0, 0.0, 1.0, 1.0)`

 * `ease` -  (the default) slow acceleration, then faster, before rapidly slowing again at the end.

   `cubic-bezier(0.25, 0.1, 0.25, 1.0)`

 * `ease-in-out` - like ease but accelerating/decelerating more rapidly (with a shorter transition between acceleration and deceleration).

   `cubic-bezier(0.42, 0, 0.58, 1.0)`

 * `ease-in` - equivalent to the first half of ease-in-out; rapid accelerating then transitioning to a constant rate of change at the end.

   `cubic-bezier(0.42, 0, 1, 1.0)`

 * `ease-out` - equivalent to the second half of ease-in-out; a constant rate of change transitioning rapid deceleration at the end.

   `cubic-bezier(0.42, 0, 0.58, 1.0)`

 * `cubic-bezier(x1,y1,x2,y2)` - follows [cubic Bézier curve](http://en.wikipedia.org/wiki/B%C3%A9zier_curve) using the control points (0,0), (x1,y1), (x2,y2) and (1,1).

 * `steps( n, [start|end] )` - stepwise function with *n* steps

### How to read `cubic-bezier` functions

Imagine the transition as a stepwise function starting at (0,0) and ending at (1,1) and with two steps in between.  The `cubic-bezier(x1,y1,x2,y2)` function specifies the points in the middle. In other words, *x1* and *x2* are the times at which the second and third steps happen, respectively (expressed as a fraction of the total transition duration) and *y1* and *y2* are how far along the transition is at *x1* and *x2*, respectively (expressed as a fraction of the total transition "distance").  Very loosely, the cubic-bezier function "smooths" those steps.

These are nicely demonstrated [here](http://www.the-art-of-web.com/css/timing-function/).

######################################################################
tags: [emacs,todo]
title: Simple emacs mode for .gitignore files.
slug: gitignore-mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Through the power of [generic-mode](http://emacswiki.org/emacs/GenericMode), adding the following lines to your `.emacs` file will add syntax-coloring support for `.gitignore`, `.svnignore`, etc. files.  And by "syntax-coloring" I mean that lines that start with a `#` will be marked as comments.

{% highlight cl %}
(require 'generic-x)
(add-to-list 'auto-mode-alist '("\\..*ignore$" . hosts-generic-mode))
{% endhighlight %}

Actually, any text after an un-escaped `#` will be marked as a comment, which isn't the way Git and SVN interpret those files. (TODO: it would be pretty simple to add a dot-ignore-generic-mode that handles this correctly.)

######################################################################
futuretags: [coffeescript]
tags: [git,gitignore]
title: .gitignore boilerplate for CoffeeScript/Node.JS projects.
slug: gitignore-for-coffee
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight squid %}
# node.js / coffeescript
#--------------------------------------------------------------------
docs/*.html
docs/docco
lib-cov
lib/*.js
node_modules
README.html
test/*.js
{% endhighlight %}

######################################################################
tags: [git,gitignore]
title: .gitignore boilerplate for common temporary files.
slug: gitignore-boilerplate
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A list of patterns for the names of common temporary and noise files, to be used as boilerplate in `.gitignore`, `.hgignore`, `.svnignore` etc.

{% highlight squid %}
# various tmp and noise files
#---------------------------------------------------------------------
$RECYCLE.BIN/
*.*~
*.log
*.pid
*.un~
*~
.*.sw[a-z]
.DS_Store
.Spotlight-V100
.Trashes
.\#*
._*
.directory
.elc
/.emacs.desktop
/.emacs.desktop.lock
Desktop.ini
Session.vim
Thumbs.db
\#*\#
auto-save-list
log
logs
temp
tmp
tramp
{% endhighlight %}

######################################################################
tags: [linux]
title: Find duplicate files on Linux.
credit: Found at <a href="http://www.commandlinefu.com/commands/view/3555/find-duplicate-files-based-on-size-first-then-md5-hash">commmandlinefoo.com</a>
slug: find-duplicates-on-linux
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Find files that have the same size and MD5 hash (and hence are likely to be exact duplicates):

{% highlight console linenos %}
$ find -not -empty -type f -printf "%s\n" | \
> sort -rn | \
> uniq -d | \
> xargs -I{} -n1 find -type f -size {}c -print0 | \
> xargs -0 md5sum | \
> sort | \
> uniq -w32 --all-repeated=separate | \
> cut -d" " -f3-
{% endhighlight %}

You probably want to pipe that to a file as it runs slowly.

If I understand this correctly:

1. Line 1 enumerates the real files non-empty by size.
2. Line 2 sorts the sizes (as numbers of descending size).
3. Line 3 strips out the lines (sizes) that only appear once.
4. For each remaining size, line 4 finds all the files of that size.
5. Line 5 computes the MD5 hash for all the files found in line 4, outputting the MD5 hash and file name. (This is repeated for each set of files of a given size.)
6. Line 6 sorts that list for easy comparison.
7. Line 7 compares the first 32 characters of each line (the MD5 hash) to find duplicates.
8. Line 8 spits out the file name and path part of the matching lines.

Some alternative approaches can be found at [the original source](http://www.commandlinefu.com/commands/view/3555/find-duplicate-files-based-on-size-first-then-md5-hash).

######################################################################
tags: [linux]
title: Generate a random list of words with `shuf`
slug: shuf-usr-share-dict-words
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`shuf` is (in my experience) a little known GNU utility that selects random lines (or bytes) from a file.

For instance, the command:

{% highlight console %}
$ shuf -n 3 /usr/share/dict/words
{% endhighlight %}

selects three words at random from the `words` dictionary.

######################################################################
tags: [git]
title: Backup a git repository (via git bundle).
slug: git-repo-backup
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

From within a Git repository's working directory, run

{% highlight console %}
$ git bundle create FILENAME --all
{% endhighlight %}

to create a single-file backup of the entire repository.


######################################################################
tags: [linux]
title: Restore Ctrl+Alt+Backspace as a way to kill X on Linux.
slug: re-enable-ctrl-alt-backspace
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Modern Debian and Ubuntu distributions have this disabled by default.

{% highlight console %}
$ setxkbmap -option terminate:ctrl_alt_backspace
{% endhighlight %}


######################################################################
tags: [css]
title: Some useful CSS mix-ins
slug: some-css-mixins
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

## Presentational Classes

These are the opposite of semantic markup, but I find them useful:

{% highlight css %}
.align-both   { text-align: justify; }
.align-center { text-align: center; }
.align-left   { text-align: left; }
.align-right  { text-align: right; }
.float-left   { float: left; }
.float-right  { float: right; }
.nobr         { white-space: nowrap; }
.small        { font-size: 80%; } /* should really sync with the <small> tag rules */
{% endhighlight %}

## "Fixing" resets

CSS reset frameworks often strip out *all* formatting. These CSS rules contain some re-resets:

{% highlight css %}
/* I understand the theory behind replacing <i> and <b> with <em> and <strong>, but c'mon, really? */
i     { font-style: italic; }
b     { font-weight: bold; }
small { font-size: 80%; }

/* Make superscripts and subscripts actually do something: */
sup, sub { height: 0; line-height: 1; vertical-align: baseline; _vertical-align: bottom; position: relative; }
sup      {	bottom: 1ex; }
sub      {	top: .5ex; }

/* Mono-spaced types. */
pre, code, kbd, samp, tt { font-family: 'droid sans mono slashed', 'droid sans mono dotted', 'droid sans mono', monospace, monospace; }
{% endhighlight %}


######################################################################
tags: [linux]
title: Backup an SD card on Linux using dd
slug: how-to-backup-an-sd-card
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight bash %}
#!/bin/bash
if [ -b "/dev/$1" ]
then
  outfile="sdcard-backup-`date +"%s"`.dd"
  echo "cloning /dev/$1 to $outfile"
  dd if=/dev/$1 of=$outfile
  echo "tgz-ing $outfile"
  tar zcvf $outfile.tgz $outfile
  echo "done."
else
  echo "Usage: $0 /dev/<device>"
fi
echo "to restore, unmount(?), then use:"
echo "tar Ozxf <file> | dd of=<device>"
{% endhighlight %}

######################################################################
tags: [linux,bash]
title: Find large files on Linux.
slug: find-large-files
credit: Thanks to Luc Pionchon for pointing me to `sort -h`.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

**UPDATE:** Reader Luc Pionchon points out that `sort` supports a `-h` parameter that sorts by "human" numbers, hence:

{% highlight console %}
$ du -h * | sort -h | tail
{% endhighlight %}

is probably a better alternative than any of the following.

<strike>

{% highlight console %}
$ du -h * | grep "^[0-9.]*M" | sort -n
{% endhighlight %}

This finds files at least 1 MB in size and then sorts them by size.  Change `M` to `G` for files at least 1 GB in size.

(Caveat: files 1 GB or larger will be missed by the MB version.  You can use:

{% highlight console %}
$ du -h * | egrep "^[0-9.]*(M|G)"
{% endhighlight %}

to get both, but then the `sort -n` doesn't work quite the way we'd like.)

Of course, you could use `du` without the `-h` to get file sizes by the default block size rather than the human-readable 12.4M or 16K, etc.
</strike>

######################################################################
tags: [emacs]
title: Spell checking cheat-sheet for emacs.
credit: Via <a href="http://www.gnu.org/software/emacs/manual/html_node/emacs/Spelling.html">the emacs FAQ</a>.
slug: emacs-spell-keys
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* `M-$` - `ispell-word` or `ispell-region` (depending on whether something is selected)
* `[SPACE]` - Skip this word—continue to consider it incorrect, but don't change it here.
* `r newword [RETURN]` - Replace the word, just this time, with new. (The replacement string will be rescanned for more spelling errors.)
* `R new [RETURN]` - Replace the word with new, and do a query-replace so you can replace it elsewhere in the buffer if you wish. (The replacements will be rescanned for more spelling errors.)
* `a` - Accept the incorrect word—treat it as correct, but only in this editing session.
* `A` - Accept the incorrect word—treat it as correct, but only in this editing session and for this buffer.
* `i` - Insert this word in your private dictionary file so that Aspell or Ispell or Hunspell will consider it correct from now on, even in future sessions.
* `m` - Like `i`, but you can also specify dictionary completion information.
* `u` - Insert the lower-case version of this word in your private dictionary file.
* `l word [RETURN]` - Look in the dictionary for words that match word. These words become the new list of “near-misses”; you can select one of them as the replacement by typing a digit. You can use `*` in word as a wildcard.
* `C-g X` - Quit interactive spell checking, leaving point at the word that was being checked. You can restart checking again afterward with `C-u M-$`.
* `x` - Quit interactive spell checking and move point back to where it was when you started spell checking.
* `q` - Quit interactive spell checking and kill the spell-checker subprocess.
* `?` - Help


######################################################################
tags: [emacs]
title: Using (quoted-insert), or how to enter a newline character in the emacs minibuffer.
credit: Via <a href="http://jeremy.zawodny.com/blog/archives/008872.html">jwz</a>.
slug: insert-newline-into-emacs-minibuffer
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To insert a newline character in the mini-buffer, use `(quoted-insert)`:

{% highlight text %}
C-q C-j
{% endhighlight %}

######################################################################
tags: [emacs]
title: dos2unix in emacs
slug: emacs-dos2unix
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Replace `^M` with nothing:

{% highlight text %}
M-% C-q C-m [RETURN] [RETURN]
{% endhighlight %}

`M-%` is bound to `(query-replace)`. `C-q` is bound to `(quoted-insert)`, which allows `C-m` to insert the control character `^M`.

######################################################################
tags: [emacs]
title: Case insensitive `sort-lines` in emacs.
slug: emacs-case-insensitive-sort
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight text %}
M-x set-variable [RETURN] sort-fold-case [RETURN] t [RETURN]
M-x sort-lines
{% endhighlight %}


######################################################################
tags: [pygments,jekyll,markdown]
title: Short list of language names recognized by pygments.
slug: pygments-language-identifiers
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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


######################################################################
futuretags: [javascript]
tags: [emacs]
title: Using js-mode's indent logic in js2-mode.
slug: fix-j2s-mode-indent-via-js-mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Steve Yegge's [js2-mode](http://code.google.com/p/js2-mode/) is a sweet major mode for working with JavaScript in Emacs, but its auto-indentation logic is [notoriously frustrating](http://stackoverflow.com/questions/2370028/emacs-js2-mode-disable-indenting-completely).

Here's a a somewhat hack-y workaround: switch to `javascript-mode` before calling `indent-region` and then switch back.

{% highlight cl %}
;; use js-mode's indent logic, by pressing C-M-| (C-M-S-\)
(defun rlw/js-indent-region () (interactive) (js-mode) (indent-region (region-beginning) (region-end)) (js2-mode) )
(define-key js2-mode-map (kbd "C-M-|") 'rlw/js-indent-region)
{% endhighlight %}

PS: I haven't yet had a chance to sort these out, but there are at least four or five JavaScript modes:

 * [mooz's fork of js2-mode](https://github.com/mooz/js2-mode)
 * [thomblake's js3-mode](https://github.com/thomblake/js3-mode)
 * I think the defunct [espresso-mode](http://www.nongnu.org/espresso/) is now the built-in `js-mode`.
 * I'm not sure where that leaves `javascript-mode`.  Also defunct I think.
 * Steve Yegge's [js2-mode](http://code.google.com/p/js2-mode/)

The first two are supposed to address js2-mode's indentation problems (among other enhancements).

######################################################################
tags: [linux]
title: Set monitor resolution with xrandr
slug: using-xrandr
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight console %}
$ cvt -r -v 1920 1080
# 1920x1080 59.93 Hz (CVT 2.07M9-R) hsync: 66.59 kHz; pclk: 138.50 MHz
Modeline "1920x1080R"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync
$ xrandr --newmode "1920x1080R"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync
$ xrandr --addmode VGA1 "1920x1080R"
$ xrandr --output VGA1 --mode "1920x1080R"
{% endhighlight %}

Also handy:

{% highlight console %}
$ xrandr --output LVDS1 --off --output VGA1 --auto
{% endhighlight %}

######################################################################
tags: [css]
title: Vertically centering block elements with CSS.
credit: via <a href="http://phrogz.net/css/vertical-align/index.html">phrogz.net</a>.
slug: vertical-center-css
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight html %}
<style type="text/css">
	#wrapper { position:relative; } /* position:absolute is also ok */
	#wrapped { position:absolute; top:50%; height:10em; margin-top:-5em; }  /* margin-top = -1 * height/2 */
</style>
...
<div id="wrapper">
	<div id="wrapped">
		<p>Block content.</p>
		<p>But still vertically centered.</p>
	</div>
</div>
{% endhighlight %}

######################################################################
tags: [ruby,rudimentary]
title: Sorting a Ruby hash by key or value.
slug: ruby-hash-sort
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

### by key

{% highlight ruby %}
h.sort
{% endhighlight %}

### by value

{% highlight ruby %}
h.sort_by {|k,v| v}
{% endhighlight %}

Note both forms return an array of key-value pairs (i.e., an array of arrays).

######################################################################
tags: [ruby,rudimentary]
title: Using Ruby arrays as stacks and queues.
slug: ruby-stack-queue
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

 * `array.push` appends an element to the array.
 * `array.pop` removes (and returns) the last element in the array.
 * Hence `array.last` (and `array[-1]`) operates like `array.peek` would if it existed--it returns (but does not remove) the item on the top of the stack.
 * `array.shift` removes (and returns) the first element in the array.
 * Hence `array.shift` "pops" an element in a queue-like way--first in, first out.  `array.first` (and `array[1]`) allow one to "peek" at this element.

{% highlight irb %}
> a = [ 1, 2, 3 ]         # => [1, 2, 3]
> a.push 4                # => [1, 2, 3, 4]
> a.pop                   # => 4
> a                       # => [1, 2, 3]
> a.last                  # => 3
> a                       # => [1, 2, 3]
> a.shift                 # => 1
> a                       # => [2, 3]
> a.first                 # => 2
{% endhighlight %}

######################################################################
tags: [ruby,cli,rudimentary]
title: Reading from input files or STDIN in Ruby using ARGF.
slug: ruby-argf-basics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

`ARGF` makes it easy for a Ruby script to read from STDIN, a file specified on the command-line argument or multiple files specified on the command line, all through the same interface.

Recall that `ARGV` array contains the arguments passed to your Ruby script on the command line.

`ARGF` assumes that any elements that remain in `ARGV` represent files.  Methods like `ARGF.each` (accepting a block) and `ARGF.readlines` (returning an array) operate on the concatenation of all files found in `ARGV`.  If `ARGV` is empty, then `ARGF` operates on STDIN instead.

For example, a `cat`-like program could be implemented in Ruby as:

{% highlight ruby %}
ARGF.each_line { |line| puts line }
{% endhighlight %}

When working with `optparse`, use the `parse!` method to strip recognized "flag" parameters from `ARGV`, leaving only the files you want to operate so that `ARGF` works just like you want it to. For example:

{% highlight ruby %}
require 'optparse'

options = { }
opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: #{$0} [OPTIONS]"
  opt.separator  ""
  opt.separator  "OPTIONS"

  opt.on("-h","--heading HEADING","a heading to display.") do |heading|
    options[:heading] = heading
  end

  opt.on("-v","--verbose","be more chatty") do
    options[:verbose] = true
  end
end
opt_parser.parse!

puts options[:heading] unless options[:heading].nil?
ARGF.each_line { |line| puts line }
{% endhighlight %}

######################################################################
tags: [linux,text-processing,sed,cli]
title: Strip characters from a string or file
slug: strip-chars-with-sed
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight console %}
$ echo "A1B2C3" | sed 's/[A-Z]//g'
123
{% endhighlight %}

######################################################################
tags: [linux,text-processing,awk,cli]
title: Strip characters from a field in awk
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

E.g., the following command strips alpha characters from the second (tab delimited) field.

{% highlight awk %}
awk -F"\t" '{gsub(/[A-Za-z]/,"",$2); print $2 }'
{% endhighlight %}

######################################################################
tags: [linux,text-processing,awk,cli]
title: Some `awk` basics
slug: some-awk-basics
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Extract tab delimited fields from a file:

{% highlight awk %}
awk -F"\t" '{print "field one=" $1 "; field two=" $2 }' file
{% endhighlight %}


######################################################################
tags: [linux,text-processing,sed,cli]
title: Skip the first N lines in file
slug: skip-n-lines
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

### using `tail`

To skip the first line of a file (and start piping data at the second line):

{% highlight console %}
$ tail -n +2 FILENAME
{% endhighlight %}

More generally:

{% highlight console %}
$ tail -n +M FILENAME
{% endhighlight %}

where **`M`** is the number of the first line you want to see (i.e., the number of lines to skip plus one).

### using `sed`

To skip the first line of a file (and start piping data at the second line):

{% highlight console %}
$ sed 1d FILENAME
{% endhighlight %}

More generally:

{% highlight console %}
$ tail A,Bd filename
{% endhighlight %}

when you want to exclude lines **`A`** through **`B`** from the output.

######################################################################
title: List Availble Fonts
tags: [linux,rudimentary]
slug: list-fonts
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To view a list of available fonts, use `fc-list`.

######################################################################
tags: [ruby,idiom]
title: Split a Ruby array into two halves.
slug: split-ruby-array-in-half
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To split a Ruby array in two two equally-sized (+/-1) parts:

{% highlight ruby %}
left,right = a.each_slice( (a.size/2.0).round ).to_a
{% endhighlight %}

For example:

{% highlight irb %}
a = [1,2,3,4,5]
=> [1, 2, 3, 4, 5]
a.each_slice( (a.size/2.0).round ).to_a
=> [[1, 2, 3], [4, 5]]
{% endhighlight %}

######################################################################
tags: [ruby,idiom]
title: Split a Ruby array into N equally-sized parts.
slug: split-ruby-array-equally
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To split a Ruby array `a` into `n` equally-sized parts:

{% highlight ruby %}
a.each_slice( (a.size/n.to_f).round ).to_a
{% endhighlight %}

For example:

{% highlight irb %}
a = [1,2,3,4,5]; n = 3
=> 3
a.each_slice( (a.size/n.to_f).round ).to_a
=> [[1, 2], [3, 4], [5]]
{% endhighlight %}

######################################################################
tags: [mind hack]
title: Begin with the end in mind.
slug: begin-with-the-end-in-mind
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Intuitive thinkers work best when they understand the big picture.

Try to articulate *why* this task is important,

######################################################################
tags: [mind hack]
title: The first step is to assume success.
slug: assume-success
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Imagine the work is complete and wildly successful. what does that look like? what did you do to get there?

######################################################################
tags: [mind hack]
title: Channel Someone
credit: I'm pretty sure I cribbed this from something, but I can remember what.
slug: channel-someone-else
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Why limit yourself to asking, "What would Jesus do?" (WWJD?) when you can not only ask "WWBD?" ("What would Buddha do?") or "WWMD?" ("What would Mohammed do?"), but also:

 * WWBBD? - What would Bugs Bunny do?
 * WWMAD? - What would Marcus Aurelius do?
 * WWMPD? - What would Mary Poppins do?
 * WWRMSD? - What would Richard M. Stallman do?
 * WWSOHD? - What would Scarlett O'Hara do?
 * WWYMD? - What would your mom do?

######################################################################
tags: [bash,linux]
title: Append to ~/.bash_history "immediately"
slug: always-append-bash-history
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Bash normally waits until a session (terminal) is closed before it writes commands to the history.

You can add a call to `history -a` to `PROMPT_COMMAND` to make bash to append your history to `~/.bash_history` every time it displays your prompt.

{% highlight console %}
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
{% endhighlight %}

The environment variable `PROMPT_COMMAND` is executed when bash is about to display your prompt.

The command `history -a` appends the current history to `~/.bash_history`.

######################################################################
tags: [markdown,pygments]
title: Syntax coloring of code blocks in various flavors of Markdown.
slug: markdown-syntax-coloring
draft: true
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

In [strict Markdown](http://daringfireball.net/projects/markdown/), code blocks are indicated by lines indented by 4 (or more) spaces.  At render-time, the first four columns are stripped and the remainder is wrapped in an HTML `<PRE>` element.

E.g., the block:

             111111111122222222223
    123456789012345678901234567890

        This is an example.

######################################################################