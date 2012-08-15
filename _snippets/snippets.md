######################################################################
tags: [css]
title: Multi-browser CSS transitions
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Through the power of [generic-mode](http://emacswiki.org/emacs/GenericMode), adding the following lines to your `.emacs` file will add syntax-coloring support for `.gitignore`, `.svnignore`, etc. files.  And by "syntax-coloring" I mean that lines that start with a `#` will be marked as comments.

{% highlight cl %}
(require 'generic-x)
(add-to-list 'auto-mode-alist '("\\..*ignore$" . hosts-generic-mode))
{% endhighlight %}

Actually, any text after an un-escaped `#` will be marked as a comment, which isn't the way Git and SVN interpret those files. (TODO: it would be pretty simple to add a dot-ignore-generic-mode that handles this correctly.)

######################################################################
tags: [git,gitignore,coffeescript]
title: .gitignore boilerplate for CoffeeScript/Node.JS projects.
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
A list of patterns for the names of common temporary and noise files, to be used as boilerplate in `.gitignore`, `.hgignore`, `.svnignore` etc.

{% highlight squid %}
# various tmp and noise files
#---------------------------------------------------------------------$RECYCLE.BIN/
*.*~
*.log
*.pid
*.un~
*~
.*.sw[a-z]
.\#*
._*
.directory
.DS_Store
.elc
.Spotlight-V100
.Trashes
/.emacs.desktop
/.emacs.desktop.lock
\#*\#
auto-save-list
Desktop.ini
log
logs
Session.vim
temp
Thumbs.db 
tmp
tramp
{% endhighlight %}

######################################################################
tags: [linux]
title: Find duplicate files on Linux.
credit: Found at <a href="http://www.commandlinefu.com/commands/view/3555/find-duplicate-files-based-on-size-first-then-md5-hash">commmandlinefoo.com</a>
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

From within a Git repository's working directory, run

{% highlight console %}
$ git bundle create FILENAME --all
{% endhighlight %}

to create a single-file backup of the entire repository.


######################################################################
tags: [linux]
title: Restore Ctrl+Alt+Backspace as a way to kill X on Linux.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Modern Debian and Ubuntu distributions have this disabled by default.

{% highlight console %}
$ setxkbmap -option terminate:ctrl_alt_backspace
{% endhighlight %}


######################################################################
tags: [css]
title: Some useful CSS mix-ins
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight console %}
$ du -h * | grep "^[0-9.]*M" | sort -n
{% endhighlight %}

(This finds files at least 1 MB in size and then sorts them by size.  Change `M` to `G` for files at least 1 GB in size.)

######################################################################
tags: [emacs]
title: Spell checking cheat-sheet for emacs.
credit: Via <a href="http://www.gnu.org/software/emacs/manual/html_node/emacs/Spelling.html">the emacs FAQ</a>.
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

To insert a newline character in the mini-buffer, use `(quoted-insert)`:

{% highlight text %}
C-q C-j
{% endhighlight %}

######################################################################
tags: [emacs]
title: dos2unix in emacs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Replace `^M` with nothing:

{% highlight text %}
M-% C-q C-m [RETURN] [RETURN]
{% endhighlight %}

`M-%` is bound to `(query-replace)`. `C-q` is bound to `(quoted-insert)`, which allows `C-m` to insert the control character `^M`.

######################################################################
tags: [emacs]
title: Case insensitive `sort-lines` in emacs.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

{% highlight text %}
M-x set-variable [RETURN] sort-fold-case [RETURN] t [RETURN]
M-x sort-lines
{% endhighlight %}


######################################################################
tags: [pygments,jekyll]
title: Shortlist of language names recognized by pygments.
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
tags: [emacs,javascript]
title: Using js-mode's indent logic in js2-mode.
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
tags: [linux,xrandr]
title: Set monitor resolution with xrandr
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
tags: [html,css]
title: Vertically centering block elements with CSS.
credit: via <a href="http://phrogz.net/css/vertical-align/index.html">phrogz.net</a>.
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

  opt.on("-h","--heading HEADING","a heading to display.") do |pattern|
    options[:tagpattern] = pattern
  end

  opt.on("-v","--verbose","be more chatty") do |pattern|
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Extract tab delimited fields from a file:

{% highlight awk %}
awk -F"\t" '{print "field one=" $1 "; field two=" $2 }' file
{% endhighlight %}


######################################################################
tags: [linux,text-processing,sed,cli]
title: Skip the first N lines in file
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
tags: [linux,rudimentary]
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
To view a list of available fonts, use `fc-list`.

######################################################################
tags: [ruby,idiom]
title: Split a Ruby array into two halves.
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Intuitive thinkers work best when they understand the big picture. 

Try to articulate *why* this task is important,

######################################################################
tags: [mind hack]
title: The first step is to assume success.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Imagine the work is complete and wildly successful. what does that look like? what did you do to get there?

######################################################################
tags: [mind hack]
title: Channel Someone
credit: I'm pretty sure I cribbed this from something, but I can remember what.
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
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
{% highlight console %}
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
{% endhighlight %}

######################################################################
