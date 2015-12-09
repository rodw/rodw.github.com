---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [tex-latex,design]
slug: latex-condensed-letter-spacing
date: 2014-2-8
---

# Tweak letter spacing in TeX/LaTeX

Using the `microtype` package:

```
\usepackage{microtype}
%% [...]
Normal Text
\textls[-40]{Condensed Text}
\textls[140]{Expanded Text}
```

===============================================================================
---
tags: [tex-latex]
slug: latex-fix-name-collision
date: 2014-2-8
---

# Avoiding naming collisions in TeX/LaTeX

Both the `pifont` and `marvosym` package define a macro named `cross`, so a simple `\usepackage` pair like:

```
\usepackage{pifont}
\usepackage{marvosym}
```

generates an error.  The `savesym` package is here to save the day:

```
\usepackage{savesym}
\usepackage{pifont}
\savesymbol{cross}
\usepackage{marvosym}
\restoresymbol{PIF}{cross}
```

Now both packages are loaded safely (and the `pifont` `\cross` macro is now available under the name `\PIFcross`).

===============================================================================
---
tags: [tex-latex,design]
slug: latex-page-margins
date: 2014-2-8
---

# Setting page margins in TeX/LaTeX

Use the `geometry` package. For example:

```
\usepackage[top=0.75in,left=0.75in,right=0.75in,bottom=0.75in]{geometry}
```

===============================================================================
---
tags: [tex-latex,design]
slug: latex-tab-align-hfill
date: 2014-2-8
---

# Tab-like alignment in TeX/LaTeX using \hfill

To right-align text:

```
\null\hfill Lorem Ipsum
```

Left and right aligned text:

```
Lorem \hfill Ipsum
```

Multiple columns:

```
Left \hfill Center \hfill Right
```

or

```
Left \hfill Center-Left \hfill Center-Right \hfill Right
```

etc.

===============================================================================
---
tags: [tex-latex,design]
slug: latex-font-sizes
date: 2014-2-8
---

# TeX/LaTeX Font Sizes

To change the font size of text in a TeX/LaTeX document, use:

```
{\size Text to change the size of.}
```

where `\size` is one of:

```
\tiny
\scriptsize
\footnotesize
\small
\normalsize
\large
\Large
\LARGE
\huge
\Huge
```

Also see <http://en.wikibooks.org/wiki/LaTeX/Fonts#Sizing_text> for font size metrics and other details.


===============================================================================
---
tags: [html,tex-latex,web]
slug: zero-width-space-char-in-html-and-latex
date: 2014-4-6
---

# breaking non-space (zero-width space)
 
To insert a zero-width space character (as a hint to the layout engine that it *could* insert a line break here) in HTML:

```html
&#x200B;
```

Or in Latex:

```
\hspace{0pt}
```
