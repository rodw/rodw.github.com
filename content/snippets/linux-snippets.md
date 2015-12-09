---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [linux,tool,xml,css,html,xpath,one-liner,ops]
slug: cli-for-html-extraction
date: 2014-2-11
---

# Command-line tool for spidering sites and extracting XML/HTML content

[**Xidel**](http://videlibri.sourceforge.net/xidel.html) is a robust tool for spidering, extracting and transforming XML/HTML content from the command line.

It's like `wget` or `curl` with a CSS and XPath/XQuery engine (among other features), attached.

`xidel` doesn't seem to be in the package management repositories I normally use, but you can [download it here](http://videlibri.sourceforge.net/xidel.html#downloads).

The following example will (1) download a web page, (2) extract a list of links (specified via CSS selector) from it, (3) download the page corresponding to each of those links and finally (4) extract specific pieces of content (specified by CSS selectors) from each page:

```bash
xidel [URL-OF-INDEX-PAGE] \
  --follow "css('[CSS-SELECTOR-FOR-LINKS]')" \
  --css "[CSS-SELECTOR-FOR-SOME-TEXT]" \
  --extract "inner-html(css('[CSS-SELECTOR-FOR-SOME-HTML]'))"
```

As a concrete example, the command:

```bash
$ xidel http://reddit.com -f  "css('a')" --css title
```

will download every page linked from the reddit.com homepage and print the content of its `title` tag.

There are several more [examples on the Xidel site](http://videlibri.sourceforge.net/xidel.html#examples).

===============================================================================
---
tags: [nodejs,linux,service,ops]
slug: forever-service
date: 2014-2-11
---

# Shell script for service-like CoffeeScript/Node.js apps using forever

This is an example of a (bash) shell script that uses the forever module to start and stop a CoffeeScript application as if it were a service.

<script src="https://gist.github.com/rodw/8947415.js"></script>

(Also at [rodw/coffee-as-a-service-via-forever.sh](https://gist.github.com/rodw/8947415).)

===============================================================================
---
tags: [wget,linux,http,one-liner,web,backup,tool,ops]
slug: download-website-with-wget
date: 2014-2-10
---

# Backup or mirror a website using wget

To create a local mirror or backup of a website with `wget`, run:

```bash
wget -r -l 5 -k -w 1 --random-wait <URL>
```

Where:

 * `-r` (or `--recursive`) will cause `wget` to recursively download files
 * `-l N` (or `--level=N`) will limit recursion to at most N levels below the root document (defaults to 5, use `inf` for infinite recursion)
 * `-k` (or `--convert-links`) will cause `wget` to convert links in the downloaded documents so that the files can be viewed locally
 * `-w` (or `--wait=N`) will cause `wget` to wait N seconds between requests
 * `--random-wait` will cause `wget` to randomly vary the wait time to `0.5x` to `1.5x` the value specified by `--wait`

Some additional notes:

 * `--mirror` (or `-m`) can be used as a shortcut for `-r -N -l inf --no-remove-listing` which enables infinite recursion and preserves both the server timestamps and FTP directory listings.
 * `-np` (`--no-parent`) can be used to limit `wget` to files below a specific "directory" (path).

===============================================================================
---
tags: [wget,linux,http,one-liner,performance,web,tool,ops]
slug: pre-cache-with-wget
date: 2014-2-10
---

# Pre-generate pages or load a web cache using wget

Many web frameworks and template engines will defer the generation the HTML version of a document the first time it is accessed.  This can make the first hit on a given page significantly slower than subsequent hits.

You can use `wget` to pre-cache web pages using a command such as:

```bash
wget -r -l 3 -nd --delete-after <URL>
```

Where:

 * `-r` (or `--recursive`) will cause `wget` to recursively download files
 * `-l N` (or `--level=N`) will limit recursion to at most N levels below the root document (defaults to 5, use `inf` for infinite recursion)
 * `-nd` (or `--no-directories`) will prevent `wget` from creating local directories to match the server-side paths
 * `--delete-after` will cause `wget` to delete each file as soon as it is downloaded (so the command leaves no traces behind.)

===============================================================================
---
tags: [linux,networking,iptables,one-liner,http,tool,ops]
slug: iptables-port-mapping
date: 2014-2-8
---

# Mapping port 80 to port 3000 using iptables

Port numbers less that 1024 are considered "privileged" ports, and you generally must be `root` to bind a listener to them.

Rather than running a network application as `root`, map the privileged port to a non-privileged one:

```bash
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j REDIRECT --to-port 3000
```

Now requests to port 80 will be forwarded on to port 3000.

===============================================================================
---
tags: [linux,debian,tool]
slug: xwindows-caps-lock-ctrl-xmodmap
date: 2014-2-8
---

# Making CAPS-LOCK into a control key in X

Using `xmodmap`:


```bash
$ cat ~/.xmodmap
remove Lock = Caps_Lock
keycode 0x42 = Control_L
add Control = Control_L

$ xmodmap ~/.xmodmap
```

===============================================================================
---
tags: [graphviz,linux,one-liner,tool]
slug: graphviz-txlib
date: 2014-1-1
---

# Quickly render a 'dot' (Graphviz) graph

On Linux and OSX the command:

```bash
dot -Txlib mygraph.gv
```

will quickly launch a lightweight window containing a `dot` rendering of the graph in `mygraph.gv`.

The rendering should automatically refresh when `mygraph.gv` is updated.  (I've occasionally run into small glitches with this that force me to re-launch the window, but they are rare and obvious.)

The same `-Txlib` parameter works for the other Graphviz rendering engines, including `neato`, `twopi`, `fdp`, `sfdp`, `circo`, and `patchwork`.

===============================================================================
---
tags: [gui,debian,linux]
slug: access-google-calendar-from-thunderbird
date: 2014-2-26
---

# Accessing Google Calendar from Thunderbird/Lightning (Icedove/Iceowl)

*Background Note: On [Debian](http://debian.org), Mozilla's email client [Thunderbird](http://www.mozilla.org/thunderbird) is known as [Icedove](https://wiki.debian.org/Icedove), and Mozilla's calendar client [Lightning](http://www.mozilla.org/en-US/projects/calendar) is known as Iceowl. This rebranding has [something to do with the licensing requirements](http://en.wikipedia.org/wiki/Mozilla_Corporation_software_rebranded_by_the_Debian_project) surrounding the "Mozilla" name. As I understand it, Firefox/Iceweasel, Thunderbird/Icedove and Sunbird/Lightning/Iceowl are identical save for the icons and naming.*

Here's how to access Google Calendar using Lightning/Iceowl, whether as a standalone application or as a Thunderbird/Icedove add-on.

**1. Install the application:**

```bash
sudo aptitude install iceowl
```

Or the add-on (assuming you've already installed Thunderbird/Icedove):

```bash
sudo aptitude install iceowl-extension
```

You can install both, but note that they don't share a configuration so you'll need to set up your calendars in both Lightning/Iceowl and Thunderbird/Icedove.

**2. Get the "private URL" for your calendar.**

Go to the web-based [Google Calendar](https://www.google.com/calendar/).

On the left-side navigation bar, notice the `My Calendars` section (expand that if needed). Hover over one of your calendars and click on the little caret/down-arrow menu that appears. Select `Calendar settings` from that menu.

On the `Calendar settings` page, note the section labeled `Private Addresses`.  Copy the URL that is linked to by the orange button labeled `XML`.

**3. Create a new calendar in Lightning/Iceowl.**

In the standalone app, that's `File` > `New Calendar`. Within Thunderbird/Icedove, that's `File` > `New` > `Calendar`.

Select `On the Network` (and click `Next`).

Select `Google Calendar` and paste the URL you copied in step 2 into the `Location` field.  (Then click `Next`.)

Enter your Google username/password and tweak the settings as desired.

**4. Repeat steps 2 and 3 for each calendar you want to integrate.**

===============================================================================
---
tags: [bash,linux]
slug: toggle-line-wrapping-in-terminal
---
# Toggle line-wrapping in terminal with 'tput rmam' and 'tput sram'

The command:

```bash
tput rmam
```

will disable line wrapping so that long lines are truncated to width of the terminal (`$COLUMNS`).

The command:

```bash
tput smam
```

will re-enable it.

This seems to known as "automatic margin" mode, hence `smam` is `enter_am_mode` and `rmam` is `exit_am_mode`.

Some terminals may not support this functionality.

===============================================================================
---
tags: [bash,linux,one-liner,cli]
slug: less-chop-long-lines
---
# Use 'less -S'`' for horizontal scrolling

The flag `-S` (or `--chop-long-lines`) will cause `less` to truncate lines at the screen (terminal) boundary, rather than wrapping as it does by default.  You can then scroll horizontally (with the arrow keys, for example) to view the full lines when needed.

```bash
cat some_file_with_very_long_lines | less -S
```

===============================================================================
---
tags: [linux,debian,cheatsheet,service,ops]
slug: linux-run-level-cheatsheet
---
# Cheat Sheet for Linux Run Levels

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

===============================================================================
---
tags: [linux,debian,service,ops]
slug: disable-services-in-linux
---
# How to disable services in Debian/Linux

The easy way is to install `sysv-rc-conf`:

```bash
aptitude install sysv-rc-conf
sysv-rc-conf
```

Manually, use `update-rc.d` and specify the run levels, like so:

```bash
update-rc.d SERVICE_NAME stop 0 1 6 3 . start 2 4 5 .
```

===============================================================================
---
tags: [bash,linux,cli]
slug: how-to-right-align-bash-prompt
---

# How to right-align text in your bash prompt

## Right aligning text by padding with spaces

To have text in your bash prompt (`$PS1`) hug the right side of the terminal:

```bash
PS1="`printf "%${COLUMNS}s\n" "${TEXT}"`$PS1"
```

(This assumes you want the right-aligned text to appear before the rest of your prompt, if any.  Move the `$PS1` bit to the left side of the string to have the right-aligned text appear after the rest of your prompt.)

The `${COLUMNS}` variable contains the number of columns in the current terminal (it should change if you resize the terminal).  The `${TEXT}` variable is a placeholder for the text you want to right-align.

The trick here is to use `printf` to left-pad the string to given width.  `printf "%ns" "text"` will left-pad the given string (here, `text`) with spaces until the entire string is *n* characters wide.

## Right aligning text by padding with something other than space.

Say you want to pad with `-` instead of space.  Try:

```bash
PS1="`printf -vch "%${COLUMNS}s" "${TEXT}"; printf "%s" "${ch// /-}"`$PS1"
```

This will left-pad the `${TEXT}` with spaces, as above, and then replace any spaces with `-`.

If you have any spaces in `${TEXT}` you want to preserve, one hacky work-around is to mark spaces in `$TEXT` with some other character, say `_`, and then replace `_` with a space (` `) *after* the other substitution:

```bash
$ PS1="$PS1`printf -vch "%${COLUMNS}s" "${TEXT}"; printf -vch "%s" "${ch// /-}"; printf "%s\n" "${ch//_/ }"`"
```

## Drawing a line to the end of the line

I recently added a line containing the date and time to my bash prompt (so I can tell when a given command completed) and wanted to draw a line across the rest of the screen to make it visually easier to tell where a new prompt is displayed.  Something like this:

```
-- Tue 02-Oct-2012 05:19 PM --------------------------------
```

(Assuming the terminal is 60 characters wide.)

Here's how I did it.

Within my `$PROMPT_COMMAND` I execute the following:

```bash
line="`printf -vch "%${COLUMNS}s" ""; printf "%s" "${ch// /-}"`"
dts="`date +"-- %a %d-%b-%Y %I:%M %p "`"
PS1="$PS1\e[1m\e[32m${dts}${line:${#dts}}"
```

The first line creates a variable (`$line`) with `${COLUMNS}` dashes (`-`).  This line would span the length of the terminal.

The second line creates a variable (`$dts`) with my date and time format of choice (prefixed with `--` just for kicks).

The `${dts}${line:${#dts}}` bit in the third line displays my date and time string (`$dts`) and then a substring of `$line`, starting at the length of my date and time string (`${#dts}`).  (In this particular case `${dts}` is always exactly 28 characters long, so that value could be hard-coded but this way it works in the general case too.)

If you are curious, the `\e[1m\e[32m` bit makes the text bold (`\e[1m`) and green (`\e[32m`).

===============================================================================
---
tags: [linux,one-liner,ops]
slug: find-duplicates-on-linux
---
# Find duplicate files on Linux.

Find files that have the same size and MD5 hash (and hence are likely to be exact duplicates):

```bash
find -not -empty -type f -printf "%s\n" | \         # line 1
  sort -rn | \                                      # line 2
  uniq -d | \                                       # line 3   
  xargs -I{} -n1 find -type f -size {}c -print0 | \ # line 4
  xargs -0 md5sum | \                               # line 5
  sort | \                                          # line 6
  uniq -w32 --all-repeated=separate | \             # line 7
  cut -d" " -f3-                                    # line 8
```

You probably want to pipe that to a file as it runs slowly.

1. Line 1 enumerates the real files non-empty by size.
2. Line 2 sorts the sizes (as numbers of descending size).
3. Line 3 strips out the lines (sizes) that only appear once.
4. For each remaining size, line 4 finds all the files of that size.
5. Line 5 computes the MD5 hash for all the files found in line 4, outputting the MD5 hash and file name. (This is repeated for each set of files of a given size.)
6. Line 6 sorts that list for easy comparison.
7. Line 7 compares the first 32 characters of each line (the MD5 hash) to find duplicates.
8. Line 8 spits out the file name and path part of the matching lines.

Some alternative approaches can be found at [the original source](http://www.commandlinefu.com/commands/view/3555/find-duplicate-files-based-on-size-first-then-md5-hash).

===============================================================================
---
tags: [linux,one-liner,tool]
slug: shuf-usr-share-dict-words
---
# Generate a random list of words with `shuf`

`shuf` is (in my experience) a little known GNU utility that selects random lines (or bytes) from a file.

For instance, the command:

```bash
shuf -n 3 /usr/share/dict/words
```

selects three words at random from the `words` dictionary.

===============================================================================
---
tags: [linux,debian]
slug: re-enable-ctrl-alt-backspace
---
# Restore Ctrl+Alt+Backspace as a way to kill X on Linux.

Modern Debian and Ubuntu distributions have this disabled by default.

```bash
setxkbmap -option terminate:ctrl_alt_backspace
```

===============================================================================
---
tags: [linux,backup,tool]
slug: how-to-backup-an-sd-card
---
# Backup an SD card on Linux using 'dd'

```bash
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
```

===============================================================================
---
tags: [linux,one-liner,tool]
slug: find-large-files
---
# Find large files on Linux.

**UPDATE:** Reader Luc Pionchon points out that `sort` often supports a `-h` parameter that sorts by "human" numbers, hence:

```bash
$ du -h * | sort -h | tail
```

is probably a better alternative than any of the following (for the systems that support it).

```bash
du -h * | grep "^[0-9.]*M" | sort -n
```

This finds files at least 1 MB in size and then sorts them by size.  Change `M` to `G` for files at least 1 GB in size.

(Caveat: files 1 GB or larger will be missed by the MB version.  You can use:

```bash
du -h * | egrep "^[0-9.]*(M|G)"
```

to get both, but then the `sort -n` doesn't work quite the way we'd like.)

Of course, you could use `du` without the `-h` to get file sizes by the default block size rather than the human-readable 12.4M or 16K, etc.


===============================================================================
---
tags: [linux,debian,tool]
slug: using-xrandr
---
# Set monitor resolution with xrandr

```bash
$ cvt -r -v 1920 1080
# 1920x1080 59.93 Hz (CVT 2.07M9-R) hsync: 66.59 kHz; pclk: 138.50 MHz
Modeline "1920x1080R"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync

$ xrandr --newmode "1920x1080R"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync

$ xrandr --addmode VGA1 "1920x1080R"

$ xrandr --output VGA1 --mode "1920x1080R"
```

Also handy:

```bash
$ xrandr --output LVDS1 --off --output VGA1 --auto
```

===============================================================================
---
tags: [linux,awk,tool,one-liner]
slug: strip-chars-with-awk
---
# Strip characters from a field in 'awk'

E.g., the following command strips alpha characters from the second (tab delimited) field.

```bash
awk -F"\t" '{gsub(/[A-Za-z]/,"",$2); print $2 }'
```

===============================================================================
---
tags: [linux,sed,tool,one-liner]
slug: strip-chars-with-sed
---
# Strip characters from a string or file with 'sed'

```bash
$ echo "A1B2C3" | sed 's/[A-Z]//g'
123
```

===============================================================================
---
tags: [linux,awk,tool,cheatsheet]
slug: some-awk-basics
---
# Some 'awk' basics

Extract tab delimited fields from a file:

```bash
$ awk -F"\t" '{print "field one=" $1 "; field two=" $2 }' file
```

===============================================================================
---
tags: [linux,sed,tool]
slug: skip-n-lines
---
# Skip the first N lines in file

## using `tail`

To skip the first line of a file (and start piping data at the second line):

```bash
tail -n +2 <FILENAME>
```

More generally:

```bash
tail -n +M <FILENAME>
```

where **`M`** is the number of the first line you want to see (i.e., the number of lines to skip plus one).

## using `sed`

To skip the first line of a file (and start piping data at the second line):

```bash
sed 1d <FILENAME>
```

More generally:

```bash
sed A,Bd <FILENAME>
```

when you want to exclude lines **`A`** through **`B`** from the output.

===============================================================================
---
tags: [linux,debian,tool]
slug: list-fonts
---
# List Available Fonts

To view a list of available fonts, use `fc-list`.

===============================================================================
---
tags: [linux,bash]
slug: always-append-bash-history
---
# Append to ~/.bash_history "immediately"

Bash normally waits until a session (terminal) is closed before it writes commands to the history.

You can add a call to `history -a` to `PROMPT_COMMAND` to make bash to append your history to `~/.bash_history` every time it displays your prompt.

```bash
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
```

The environment variable `PROMPT_COMMAND` is executed when bash is about to display your prompt.

The command `history -a` appends the current history to `~/.bash_history`.
