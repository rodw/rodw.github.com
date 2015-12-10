---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [git,backup,ops]
slug: github-backup
date: 2014-1-1
title: Backup an entire GitHub repository
---

# Backup an entire GitHub repository

The following shell script will back up an organization's GitHub repositories, including the all branches of the source tree and the GitHub wiki and issue list (if any).

<script src="https://gist.github.com/rodw/3073987.js"></script>

(Also at [rodw/backup-github.sh](https://gist.github.com/rodw/3073987).)

===============================================================================
---
tags: [sql,sqlite,database,cheatsheet,ops]
slug: sqlite-cheat-sheet
date: 2013-9-18
title: A Cheat Sheet for SQLite
---
# A Cheat Sheet for SQLite

## General

 * Most of the SQLite "meta" commands begin with a dot.  When in doubt, try `.help`
 * Use `Ctrl-d` or  `.exit` or `.quit` to exit (and `Ctrl-c` to terminiate a long-running SQL query).
 * Enter `.show` to see current settings.

## Meta-data

 * Enter `.databases` to see a list of mounted databases.
 * Enter `.tables` to see a list of table names.
 * Enter `.index` to see a list of index names.
 * Enter `.schema TABLENAME` to see the create table statement for a given table.

## Import and Export

 * Enter `.output FILENAME` to pipe output to the specified file.  (Use `.output stdout` to return to the default behavior or printing results to the console.)
 * Enter `.mode [csv|column|html|insert|line|list|tabs|tcl]` to change the way in which query results are printed.
 * Enter `.separator DELIM` to change the delimiter used in  (`list`-mode) exports and imports. (Defaults to `|`.)
 * Enter `.dump [TABLEPATTERN]` to create a collection of SQL statements for recreating the database (or just those tables with naames matching the optional TABLEPATTERN).
 * Enter `.read FILENAME` to execute the specified file as a SQL script.

===============================================================================
---
tags: [gui]
slug: chrome-go-back-in-new-tab
title: Ctrl-Back opens the referring page in a new tab in Chrome
---
# Ctrl-Back opens the referring page in a new tab in Chrome

In Chromium/Google Chrome, holding down the `Ctrl` button while clicking on the back button will open a new tab with the appropriate page (`history.go(-1)`) in a new tab.

I don't know how long this has been a feature, but I accidentally stumbled across this today.  Very useful for me. I often open many links from a single page (a directory page or SERP for example). When I fail to Ctrl-click, I need to go back, and ctrl-click the link, which is tedious when it results in two spurious page loads (loading the new page, re-loading the list page and then re-loading the new page again).

===============================================================================
---
tags: [bookmark,media,cc,design]
slug: creative-commons-media-search
title: list of sources for Creative Commons images and media
---
# Short list of sources for Creative Commons images and media.

* [Search for Creative Commons content via cc.org](http://search.creativecommons.org/)
* [Search for Creative Commons content on Flickr](http://www.flickr.com/search/?q=kitten&l=commderiv) or use this [alternative interface from PhotoPin](http://photopin.com/search/kitten).
* [Search for Creative Commons content via Google](https://www.google.com/search?q=kitten&tbs=sur:f&tbm=isch)

===============================================================================
---
tags: [git,coffeescript,javascript,nodejs]
slug: gitignore-for-coffee
title: .gitignore boilerplate for Node.JS projects
---
# '.gitignore' boilerplate for CoffeeScript/Node.JS projects.

```
# node.js / coffeescript
#--------------------------------------------------------------------
docs/*.html
docs/docco
lib-cov
lib/*.js
node_modules
README.html
test/*.js
```

===============================================================================
---
tags: [git]
slug: gitignore-for-coffee
title: .gitignore boilerplate
---
# '.gitignore' boilerplate for common temporary files.

A list of patterns for the names of common temporary and noise files, to be used as boilerplate in `.gitignore`, `.hgignore`, `.svnignore` etc.

```
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
```

===============================================================================
---
tags: [git,backup,one-liner,ops,tool]
slug: git-bundle
title: backup a git repository with 'git bundle'
---
# backup a git repository with 'git bundle'

Run:

```bash
cd REPOSITORY_WORKING_DIRECTORY
git bundle create PATH_TO_BUNDLE.git --all
```

to create a single-file backup of the entire repository.

Note that the bundle file is a functional Git repository:

```
git clone PATH_TO_BUNDLE.git MY_PROJECT
```

===============================================================================
---
tags: [mind-hack]
slug: begin-with-the-end-in-mind
title: Begin with the end in mind
---
# Begin with the end in mind.

Intuitive thinkers work best when they understand the big picture.

Try to articulate *why* this task is important,

===============================================================================
---
tags: [mind-hack]
slug: assume-success
title: The first step is to assume success
---
# The first step is to assume success.

Imagine the work is complete and wildly successful. what does that look like? what did you do to get there?

===============================================================================
---
tags: [mind-hack]
slug: channel-someone-else
title: Channel Someone Else
---
# Channel Someone

Why limit yourself to asking, "What would Jesus do?" (WWJD?) when you can not only ask "WWBD?" ("What would Buddha do?") or "WWMD?" ("What would Mohammed do?"), but also:

 * WWBBD? - What would Bugs Bunny do?
 * WWMAD? - What would Marcus Aurelius do?
 * WWMPD? - What would Mary Poppins do?
 * WWRMSD? - What would Richard M. Stallman do?
 * WWSOHD? - What would Scarlett O'Hara do?
 * WWYMD? - What would your mom do?
 
(Credit: I'm pretty sure I cribbed this from something, but I can remember what. If anyone happens to know the source for this please drop me a note.)
