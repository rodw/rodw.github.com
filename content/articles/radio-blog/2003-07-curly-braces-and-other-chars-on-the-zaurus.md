---
active_tab: articles
title: Curly braces, Pipes, Escape and other characters on the Zaurus
---
# Curly braces, Pipes, Escape and other characters on the Zaurus

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 21 July 2003</b>
<p>
If you've ever tried to type code, pseudo-code or shell scripts on the Sharp <a href="http://www.zaurus.com/" title="Zaurus.com: Sharp's Zaurus site">Zaurus</a>, you may have noticed that the little slide-out keyboard is missing some useful keys.  If you've done much typing with this thumb-keyboard, you may have noticed that when you fat-finger a couple of keys, you can get some of those extra characters.  For my reference as much as yours, here's a short list:
</p>
<table border="1" cellpadding="2" cellspacing="0">
<tbody><tr>
 <th>keys</th>
 <th>character</th>
 <th>unicode value</th>
 <th>name</th>
</tr>
<tr>
 <td>[Fn]+z</td>
 <td>&nbsp;</td>
 <td>0x005A(?)</td>
 <td>undo</td>
</tr>
<tr>
 <td>[Fn]+[Shift]+c</td>
 <td>€</td>
 <td>0x20AC</td>
 <td>euro symbol</td>
</tr>
<tr>
 <td>[Fn]+[Shift]+[Backspace]</td>
 <td>[</td>
 <td>0x005B</td>
 <td>left square bracket</td>
</tr>
<tr>
 <td>[Fn]+[Shift]+,</td>
 <td>]</td>
 <td>0x005D</td>
 <td>right square bracket</td>
</tr>
<tr>
 <td>[Fn]+[Shift]+.</td>
 <td>{</td>
 <td>0x007B</td>
 <td>left curly brace</td>
</tr>
<tr>
 <td>[Fn]+[Shift]+[Enter]</td>
 <td>}</td>
 <td>0x007D</td>
 <td>right curly brace</td>
</tr>
<tr>
 <td>[Fn]+[Shift]+'</td>
 <td>^</td>
 <td>0x005E</td>
 <td>caret/circumflex</td>
</tr>
<tr>
 <td>[Fn]+[Shift]+[Space]</td>
 <td>`</td>
 <td>0x0060</td>
 <td>tick/backquote</td>
</tr>
<tr>
 <td>[Shift]+[Space]</td>
 <td>|</td>
 <td>0x007C</td>
 <td>pipe</td>
</tr>
<tr>
 <td>[Shift]+[Tab]</td>
 <td>\</td>
 <td>0x005C</td>
 <td>backslash (note that this is listed incorrectly in the sharp doc)</td>
</tr>
</tbody></table>
<p>
In the table above, "[Fn]" means the purple "function" key, "[Shift]" means the arrow-up "shift" key, "[Backspace] means the white back-arrow/delete key, "[Enter]" means the purple "return" key, "[Space]" means the space bar, "[Tab]" means the purple tab key, and a "+" means hit these keys in combination, typically by holding down the "meta" keys first.
</p><p>
Also notice that the "Cancel" button works like "Escape", which makes VI usable without resorting to the on-screen (virtual) keyboard.
</p><p>
There's <a href="http://www.zaurus.com/dev/support/downloads/sl5600_keycode_v091.pdf" title="Keycode for Java/Qtopia Applications">a full keycode mapping table</a> available on Sharp's site.
</p>
