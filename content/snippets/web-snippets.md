---
file_type: snippet
context:
  template: snippet.dust
  active_tab: snippets
---
===============================================================================
---
tags: [curl,web,tool]
slug: file-upload-from-curl
date: 2015-12-31
title: Uploading a file with curl
---
# Uploading a file with curl

To submit the file at `foo` to a web service as multi-part form data using `curl`:

```bash
curl -X POST -F "file=@\"foo\"" 'https://127.0.0.1/example'
```

The `file` part is the name of the corresponding form field.

Note that you can submit multiple files:

```bash
curl -X POST -F "f1=@\"foo\"&f2=@\"bar\"" 'https://127.0.0.1/example'
```

Or add additional body or query string parameters:

```bash
curl -X POST -F "f1=@\"foo\"&x=y" 'https://127.0.0.1/example?a=b'
```
===============================================================================
---
tags: [color-palette,design]
slug: brewer-colors-spectral11
date: 2014-2-15
title: spectral11 color palette
---
# The *spectral11* brewer color palette

<div class="swatch swatch-dark"  style="background-color: #9e0142"><span>#9e0142</span> <span>rgb(158,&nbsp; 1, 66)</span> <span>Eggplant Violet</span></div>
<div class="swatch swatch-dark"  style="background-color: #d53e4f"><span>#d53e4f</span> <span>rgb(213, 62, 79)</span> <span>Valencia Red</span></div>
<div class="swatch swatch-light" style="background-color: #f46d43"><span>#f46d43</span> <span>rgb(244,109, 67)</span> <span>Crusta (Dark) Orange</span></div>
<div class="swatch swatch-light" style="background-color: #fdae61"><span>#fdae61</span> <span>rgb(253,174, 97)</span> <span>Rajah (Light) Orange</span></div>
<div class="swatch swatch-light" style="background-color: #fee08b"><span>#fee08b</span> <span>rgb(254,244,139)</span> <span>Cream Brulee (Dark) Yellow</span></div>
<div class="swatch swatch-light" style="background-color: #ffffbf"><span>#ffffbf</span> <span>rgb(255,255,191)</span> <span>Lemon Chiffon (Light) Yellow</span></div>
<div class="swatch swatch-light" style="background-color: #e6f598"><span>#e6f598</span> <span>rgb(230,245,152)</span> <span>Tidal (Pale, Yellow-) Green</span></div>
<div class="swatch swatch-light" style="background-color: #abdda4"><span>#abdda4</span> <span>rgb(171,221,164)</span> <span>Moss (Pale) Green</span></div>
<div class="swatch swatch-light" style="background-color: #66c2a5"><span>#66c2a5</span> <span>rgb(102,194,165)</span> <span>Puerto Rico (Blue-) Green</span></div>
<div class="swatch swatch-dark"  style="background-color: #3288bd"><span>#3288bd</span> <span>rgb( 50,136,189)</span> <span>Curious (Muted) Blue</span></div>
<div class="swatch swatch-dark"  style="background-color: #5e4fa2"><span>#5e4fa2</span> <span>rgb( 94, 79,162)</span> <span>Rich (Violet-) Blue</span></div>

via [graphviz.org](http://www.graphviz.org/doc/info/colors.html); more info at [mkweb.bcgsc.ca/brewer/](http://mkweb.bcgsc.ca/brewer/)

===============================================================================
---
tags: [color-palette,design]
slug: brewer-colors-paired12
date: 2014-2-15
title: paired12 color palette
---
# The *paired12* brewer color palette

<div class="swatch swatch-light" style="background-color: #a6cee3"><span>#a6cee3</span> <span>rgb(166,206,227)</span> <span>French Pass (Light) Blue</span></div>
<div class="swatch swatch-dark"  style="background-color: #1f78b4"><span>#1f78b4</span> <span>rgb( 31,120,180)</span> <span>Pelorous (Dark) Blue</span></div>
<div class="swatch swatch-light" style="background-color: #b2df8a"><span>#b2df8a</span> <span>rgb(178,223,138)</span> <span>Feijoa (Light) Green</span></div>
<div class="swatch swatch-dark"  style="background-color: #33a02c"><span>#33a02c</span> <span>rgb( 51,160, 44)</span> <span>La Palma (Dark) Green</span></div>
<div class="swatch swatch-light" style="background-color: #fb9a99"><span>#fb9a99</span> <span>rgb(251,154,153)</span> <span>Rose Bud (Light) Red (Pink)</span></div>
<div class="swatch swatch-dark"  style="background-color: #e31a1c"><span>#e31a1c</span> <span>rgb(227, 26, 28)</span> <span>Fire Engine (Dark) Red</span></div>
<div class="swatch swatch-light" style="background-color: #fdbf6f"><span>#fdbf6f</span> <span>rgb(253,191,111)</span> <span style="font-size:90%">Chardonnay Yellow (Light Orange)</span></div>
<div class="swatch swatch-light" style="background-color: #ff7f00"><span>#ff7f00</span> <span>rgb(255,127,&nbsp; 0)</span> <span>Dark Orange</span></div>
<div class="swatch swatch-light" style="background-color: #cab2d6"><span>#cab2d6</span> <span>rgb(202,178,214)</span> <span>Prelude (Light) Violet</span></div>
<div class="swatch swatch-dark"  style="background-color: #6a3d9a"><span>#6a3d9a</span> <span>rgb(106, 61,154)</span> <span>Royal (Dark) Purple</span></div>
<div class="swatch swatch-light" style="background-color: #ffff99"><span>#ffff99</span> <span>rgb(255,255,153)</span> <span style="font-size:90%">Canary Yellow (Light "Brown")</span></div>
<div class="swatch swatch-dark"  style="background-color: #b15928"><span>#b15928</span> <span>rgb(177, 89, 40)</span> <span style="font-size:80%">Rose of Sharon Orange ("Dark" "Brown")</span></div>

via [graphviz.org](http://www.graphviz.org/doc/info/colors.html); more info at [mkweb.bcgsc.ca/brewer/](http://mkweb.bcgsc.ca/brewer/)

===============================================================================
---
tags: [css,html,web,design]
slug: cross-browser-css-transitions
title: Cross-browser CSS transitions
---
# Cross-browser CSS transitions

```css
.foo {
  transition:         opacity .25s ease-in-out;
  -webkit-transition: opacity .25s ease-in-out;
  -moz-transition:    opacity .25s ease-in-out;
  -o-transition:      opacity .25s ease-in-out;
}
```

Where the right-hand side has the general form:

```
PROPERTY DURATION [TIMING-FUNCTION] [TRANSITION-DELAY]
```

Transitions can chained:

```css
 .foo { transition: opacity .25s ease-in-out, height 1s linear }
```

## Transition timing functions

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

## How to read `cubic-bezier` functions

Imagine the transition as a stepwise function starting at (0,0) and ending at (1,1) and with two steps in between.  The `cubic-bezier(x1,y1,x2,y2)` function specifies the points in the middle. In other words, *x1* and *x2* are the times at which the second and third steps happen, respectively (expressed as a fraction of the total transition duration) and *y1* and *y2* are how far along the transition is at *x1* and *x2*, respectively (expressed as a fraction of the total transition "distance").  Very loosely, the cubic-bezier function "smooths" those steps.

These are nicely demonstrated [here](http://www.the-art-of-web.com/css/timing-function/).

===============================================================================
---
tags: [css,html,web,design]
slug: presentational-css-classes
title: Presentational CSS Classes
---
# Presentational CSS Classes

These are the opposite of semantic markup, but I find them useful:

```css
.align-both   { text-align: justify; }
.align-center { text-align: center; }
.align-left   { text-align: left; }
.align-right  { text-align: right; }
.float-left   { float: left; }
.float-right  { float: right; }
.nobr         { white-space: nowrap; }
.small        { font-size: 80%; } /* should really sync with the <small> tag rules */
```

===============================================================================
---
tags: [css,html,web,design]
slug: fixing-css-resets
title: Fixing CSS Resets
---
# Fixing CSS Resets

CSS reset frameworks often strip out *all* formatting. These CSS rules contain some re-resets:

```css
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
```


===============================================================================
---
tags: [css,html,web,design]
slug: vertical-center-css
title: Vertically centering block elements with CSS
---
# Vertically centering block elements with CSS.

Via [phrogz.net](http://phrogz.net/css/vertical-align/index.html).

```html
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
```
