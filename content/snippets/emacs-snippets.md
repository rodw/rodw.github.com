---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [emacs]
slug: emacs-calendar
date: 2013-4-15
title: emacs calendar functions
---

# emacs calendar functions

Open the calendar:

```
M-x calendar
```

(You can close the calendar with `q`, which invokes `(calendar-exit)`.

Movement:

  * `C-f` or arrow-right is `(calendar-forward-day)` and `C-b` or arrow-left is `(calendar-backward-day)`.
  * `C-n` or arrow-down is `(calendar-forward-week)` and `C-p` or arrow-up is `(calendar-backward-week)`.
  * `M-}` or `>` is `(calendar-forward-month)` and `M-{` or `<` is `(calendar-backward-month)`
  * `C-x ]` is `(calendar-forward-year)` and `C-x [` is `(calendar-backward-year)`
  * Use the `M-<n>` prefix to move a multiple of the above.  E.g. `M-90 C-f` (or `M-90 <right-arrow>`) moves forward 90 days.  (In calendar mode, the meta key is optional, simply `90 <right-arrow>` will move forward 90 days, `16 <down-arrow>` will move forward 16 weeks, etc.)
  * `o` will let you interactively select a date.
  * `.` will return to today

Other:
  * (Right-click on the calendar will generally open up a context-menu about these.)
  * `p d` is (calendar-print-day-of-year)
  *  Type`C-<space>`, move to another date and type `M-=` to invoke `(calendar-count-days-region)` (show the number of days between the dates (including the endpoints).
  * Type `H m` or `H y` to generate an html-format calendar (month and year, respectively).  (`t <something>` generates a number of interesting calendars in TeX, if you are so inclined.)
  * Type `h` to see known holidays for the selected date, or `a` to see all holidays for the three month period that is displayed. Use `M-x list-holidays` for even more.  Use `M` to see a list of lunar phases. Use `S` to see sunrise/sunset information.

Also see [the emacs manual](http://www.gnu.org/software/emacs/manual/html_node/emacs/Calendar_002fDiary.html).

===============================================================================
---
tags: [emacs,cheatsheet]
slug: emacs-cursor-movement-shortcuts
date: 2013-3-15
title: emacs cursor movement shortcuts
---

# emacs cursor movement shortcuts

 * `M-g g <N>` or `M-g M-g <N>` -- go to line <N> (`goto-line`)
 * `M-g c <N>` -- go to *character* <N> (`goto-char`)
 * `M-g <TAB> <N>` -- go to column <N> in the current line

 * `M-<` -- `beginning-of-buffer`
 * `M->` -- `end-of-buffer`

 * `C-a` or `<home>` -- `move-beginning-of-line`
 * `C-e` or `<end>` -- `move-end-of-line`

 * `C-f` or `<right>` -- forward one char (`forward-char`) or right one char (`right-char`).   (Note `right-char` moves *backward* when editing right-to-left text.)
 * `M-f` or `M-<right>` or `C-<right>`  -- forward one word (`forward-word`) or right one word (`right-word`).
 * `C-b` or `<left>` -- backward one char (`backward-char`) or left one char (`left-char`).   (Note `left-char` moves *forward* when editing right-to-left text.)
 * `M-b` or `M-<left>` or `C-<left>`  -- back one word (`backward-word`) or left one word (`left-word`).

 * `C-n` or `<down>` -- down one line (`next-line`)
 * `C-v` or `<PageDown>` -- down one page (`scroll-up-command`)
 * `C-p` or `<up>` -- up one line (`previous-line`)
 * `M-v` or `<PageUp>` -- up one page (`scroll-down-command`)

 * `C-x C-n` -- set current column as "goal" column for up/down movement
 * `C-u C-x C-n` -- cancel current goal column

===============================================================================
---
tags: [emacs,cheatsheet]
slug: emacs-searching
date: 2013-3-23
title: Searching in Emacs
---

# Searching in Emacs

 * `C-s` / `C-r` -- search / search backward in current buffer
 * `M-s o` / `M-x occur` / `M-x ioccur` -- list lines in current buffer matching regexp
 * `M-x rgrep` -- recursive grep (find in files)

===============================================================================
---
tags: [emacs]
slug: emacs-c-x-c-x
date: 2013-3-23
title: use C-x C-x to toggle between positions in emacs
---

# C-x C-x to toggle between positions

For example:  Use `C-s foo` to search for something.  Maybe use `C-s` again to step thru. Now use `C-x C-x` to flip back to the point where you started (and `C-x C-x` again to return).

===============================================================================
---
tags: [emacs,elisp]
slug: emacs-font-size
date: 2013-3-23
titel: Change font size in emacs
---
# Change font size in emacs

To change the font size in the current buffer:

 * `C-x C-+` - increase font size

 * `C-x C--` - decrease font size

Follow either with `+`, `-` or `0` for continued adjustment.

To change the font size in all buffers:

```
(set-face-attribute 'default nil :height 120) ;; where `height` is 10x point size
```

===============================================================================
---
tags: [emacs]
slug: paste-in-isearch-with-m-y
date: 2013-3-21
title: how to paste into the emacs i-search prompt
---
# Use `M-y` to yank (paste) into the emacs i-search prompt

```
C-s M-y
```

===============================================================================
---
tags: [emacs]
slug: emacs-change-case
date: 2013-3-25
title: Change Text Case in Emacs
---
# Change Text Case in Emacs

To change the letter case in Emacs:

 * `M-u` - `(upcase-word)` - will convert following word to UPPER case (or the rest of the current word).

 * `M-l` - `(downcase-word)` - will convert following word to lower case (or the rest of the current word).

 * `M-c` - `(capitalize-word)` - will Capitalize the following word (or the rest of the current word).

For example, consider the text `The quick brown fox jumped.`

If you position the cursor on the `q` (fifth column), then `M-u` changes `quick` to `QUICK`, `M-c` changes `quick` to `Quick`, etc.

If you position the cursor on the `u` (sixth column), then `M-u` changes `quick` to `qUICK`, `M-c` changes `quick` to `qUick`, etc.

One could probably write an elisp function based on `(capitalize-word)` and some heuristics or dictionary look-ups to create a true title case function (e.g., not capitalize `a`, `an`, `the` in the middle of a phrase), but `M-c` is a quick and easy approximation.

Also, note that there is a version of upcase and downcase that work on the selection (region) instead of the next word.

 * `C-x C-u` - `(upcase-region)`

 * `C-x C-l` - `(downcase-region)`

Of course, if you're using "CUA Keys", you can't easily type `C-x` without invoking "cut".

===============================================================================
---
tags: [emacs,r-lang,elisp]
slug: ess-for-r-in-emacs
date: 2013-3-26
title: Working with R in emacs
---
# Working with R in emacs

1) [Install R](http://www.r-project.org/).

2) [Install ESS](http://ess.r-project.org/):

```bash
sudo aptitude install ess=12.09-1
```

3) Require `ess-site`:

```
(add-to-list 'load-path "/usr/share/emacs/site-lisp/")
(require 'ess-site)
```

4) Load R within emacs via `M-x R`.

===============================================================================
---
tags: [emacs,elisp]
slug: emacsclient-daemon-default-font
date: 2013-5-11
title: Default fonts with emacsclient/emacs --daemon
---
# Default fonts with emacsclient/emacs --daemon

I've been using `set-default-font` in my `.emacs` file to configure emacs to use my favorite programming font.

```
(set-default-font "Droid Sans Mono Slashed-10") ;;; set default font
```

I use `emacs --daemon` to keep an instance of emacs running as a background process on my development machine so that I can run `emacsclient` to call up an emacs window (frame) instantaneously (and keep the same session running even after a close the emacs frame).

Suddenly (after an `aptitude safe-upgrade`, I think, but I'm not sure what triggered this change), emacs frames that are created by `emacsclient` connecting to the `emacs --daemon` instance no longer used my default font when initially opened. The default font worked properly for stand-alone emacs instances (opened with `emacs`), and for `emacsclient`, executing `(set-default-font)` after startup worked fine, but it no longer worked automatically.

To fix this, I had to set up a `default-frame-alist`, which I believe defines commands to execute whenever a new frame is opened.

```
(set-default-font "Droid Sans Mono Slashed-10") ;;; set default font
(setq default-frame-alist '((font . "Droid Sans Mono Slashed-10"))) ;;; set default font for emacs --daemon / emacsclient
```

By the way, I also discovered the `describe-font` elisp function while trying to diagnose this issue.

```
(describe-font "Droid Sans Mono Slashed-10")
;; or M-x describe-font <RETURN> Droid Sans Mono Slashed-10 <RETURN>
```

which opens a `*Help*` buffer containing:

```
name (opened by): -unknown-Droid Sans Mono Slashed-normal-normal-normal-*-13-*-*-*-m-0-iso10646-1
       full name: Droid Sans Mono Slashed:pixelsize=13:foundry=unknown:weight=normal:slant=normal:width=normal:spacing=100:scalable=true
            size: 13
          height: 17
 baseline-offset:  0
relative-compose:  0
```

===============================================================================
---
tags: [emacs,org-mode,cheatsheet]
slug: various-emacs-shortcuts
date: 2013-5-12
title: various emacs shortcuts
---
# various emacs shortcuts

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

===============================================================================
---
tags: [emacs]
slug: number-lines-emacs
date: 2013-5-13
title: numbering lines in emacs
---
# Numbering lines in emacs

A few ways to add line numbers in emacs:

* `M-x linum-mode <RET>` will annotate the buffer with line numbers. (These numbers are decoration, in the "fringe" rather than part of the buffer text.)  Also see [Linum Plus](http://emacser.com/linum-plus.htm).

* `C-x r N` will *insert* line numbers into the selected region. (These numbers are content, they are added to the text of the buffer.)

* `M-x line-number-mode <RET>` show the line number of the current line in the modeline.

* `C-x l` will report (in the minibuffer) the total number of lines in the current buffer as well as the number of lines before and after the cursor

* `M-x what-line <RET>` will report (in the minibuffer) the current line number

Also see [emacswiki.org/LineNumbers](http://www.emacswiki.org/LineNumbers).

===============================================================================
---
tags: [emacs,elisp,todo]
slug: gitignore-mode
date: 2013-5-13
title: simple emacs mode for .gitignore files
---
# Simple emacs mode for .gitignore files.

Through the power of [generic-mode](http://emacswiki.org/emacs/GenericMode), adding the following lines to your `.emacs` file will add syntax-coloring support for `.gitignore`, `.svnignore`, etc. files.  And by "syntax-coloring" I mean that lines that start with a `#` will be marked as comments.

```
(require 'generic-x)
(add-to-list 'auto-mode-alist '("\\..*ignore$" . hosts-generic-mode))
```

Actually, any text after an un-escaped `#` will be marked as a comment, which isn't the way Git and SVN interpret those files. (TODO: it would be pretty simple to add a dot-ignore-generic-mode that handles this correctly.)

===============================================================================
---
tags: [emacs,cheatsheet]
slug: emacs-spell-keys
date: 2013-5-14
title: spell checking cheat-sheet for emacs
---
# Spell checking cheat-sheet for emacs.

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

Via [the emacs FAQ](http://www.gnu.org/software/emacs/manual/html_node/emacs/Spelling.html).

===============================================================================
---
tags: [emacs]
slug: insert-newline-into-emacs-minibuffer
date: 2013-5-4
title: how to enter a newline character in the emacs minibuffer
---
# Using (quoted-insert), or how to enter a newline character in the emacs minibuffer

To insert a newline character in the mini-buffer, use `(quoted-insert)`
  
```
C-q C-j
```

Via [jwz](http://jeremy.zawodny.com/blog/archives/008872.html).

===============================================================================
---
tags: [emacs]
slug: emacs-dos2unix
date: 2013-5-4
title: dos2unix in emacs
---
# dos2unix in emacs

```
M-% C-q C-m [RETURN] [RETURN]
```

`M-%` is bound to `(query-replace)`. `C-q` is bound to `(quoted-insert)`, which allows `C-m` to insert the control character `^M`.

===============================================================================
---
tags: [emacs]
slug: emacs-case-insensitive-sort
date: 2013-5-7
title: case insensitive sort-lines in emacs
---
# Case insensitive sort-lines in emacs.

```
M-x set-variable [RETURN] sort-fold-case [RETURN] t [RETURN]
M-x sort-lines
```

===============================================================================
---
tags: [emacs,elisp,javascript]
slug: fix-j2s-mode-indent-via-js-mode
date: 2013-5-7
title: using js-mode's indent logic in js2-mode
---
# Using js-mode's indent logic in js2-mode

Steve Yegge's [js2-mode](http://code.google.com/p/js2-mode/) is a sweet major mode for working with JavaScript in Emacs, but its auto-indentation logic is [notoriously frustrating](http://stackoverflow.com/questions/2370028/emacs-js2-mode-disable-indenting-completely).

Here's a somewhat hack-y workaround: switch to `javascript-mode` before calling `indent-region` and then switch back.

```
;; use js-mode's indent logic, by pressing C-M-| (C-M-S-\)
(defun rlw/js-indent-region () (interactive) (js-mode) (indent-region (region-beginning) (region-end)) (js2-mode) )
(define-key js2-mode-map (kbd "C-M-|") 'rlw/js-indent-region)
```

PS: I haven't yet had a chance to sort these out, but there are at least four or five JavaScript modes:

 * [mooz's fork of js2-mode](https://github.com/mooz/js2-mode)
 * [thomblake's js3-mode](https://github.com/thomblake/js3-mode)
 * I think the defunct [espresso-mode](http://www.nongnu.org/espresso/) is now the built-in `js-mode`.
 * I'm not sure where that leaves `javascript-mode`.  Also defunct I think.
 * Steve Yegge's [js2-mode](http://code.google.com/p/js2-mode/)

The first two are supposed to address js2-mode's indentation problems (among other enhancements).
