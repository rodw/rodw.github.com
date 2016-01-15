---
active_tab: articles
title: A Timely Bug
---
# A Timely Bug

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 22 October 2003</b>
  <p>
I'm a sucker for quirky bugs.  Recently, I've been hacking around with <a href="http://c2.com/cgi/wiki?PhlIp" title="Ward's Wiki: PhlIp">PhlIp</a>'s excellent <a href="http://www.xpsd.com/MiniRubyWiki" title="XpSD Wiki: Mini Ruby Wiki">Mini Ruby Wiki</a> (more on that later), and discovered one such bug.
</p><p>
There's a block of code in MiniRubyWiki that renders a small calendar in HTML, not unlike your typical blog calendar widget.  Here's a small subset (the actual code is more interesting that this) which is largely although not completely unchanged from the original miniWiki.rb source.  See if you can spot the bug.
</p>

```ruby
  # here's a constant, declared elsewhere in the program
  SecondsInDay = 60 * 60 * 24

  # ...

  # In this loop we're rendering a four-week calendar,
  # from the beginning of last week until the end of the week after next.
  # "beginningOfLastWeek" is a Time indicating the Sunday of last week

  today = Time.now()
  (0...28).each do |day|
    dayOnCalendar = beginningOfLastWeek + day * SecondsInDay
    # break the row every seven days
    calendar += '&lt;/tr&gt;&lt;tr&gt;' if day.divmod(7)[1] == 0
    calendar += '&lt;td'
    # highlight today
    if today.mday() == dayOnCalendar.mday() then
      calendar += ' bgcolor="#88ff88"'
    end
    calendar += '&gt;'
    # show the month for the first day in the calendar or in the month
    calendar += dayOnCalendar.strftime('%b') + ' ' if dayOnCalendar.mday == 1 or day == 0
    calendar += dayOnCalendar.mday.to_s()

    # ...snip some stuff displayed within the calendar...

    calendar += '&lt;/tr&gt;'
  end
```

<p>
I've been running this code on my Zaurus, sometimes launching it from the EmbeddedKonsole on the Zaurus itself, and sometimes from an ssh terminal running on a remote machine.  Eventually I noticed something funky about this.  When I launch the server from the ssh terminal, 1 November 2003 is listed, correctly, as a Saturday.  When I launch the server from a terminal on the Zaurus itself, 1 November isn't listed at all (the last day on the calendar is 31 October 2003, listed, incorrectly, as a Saturday).  In fact, when I launch the server from the Zaurus, Sunday, 26 October 2003 is listed twice.
</p><p>
Adding a "puts curDay.to_s" line inside that loop makes the problem obvious.  This output like the following:
</p>

```
Sun Oct 19 00:00:00 CDT 2003
Mon Oct 20 00:00:00 CDT 2003
Tue Oct 21 00:00:00 CDT 2003
Wed Oct 22 00:00:00 CDT 2003
Thu Oct 23 00:00:00 CDT 2003
Fri Oct 24 00:00:00 CDT 2003
Sat Oct 25 00:00:00 CDT 2003
Sun Oct 26 00:00:00 CDT 2003
Sun Oct 26 23:00:00 CST 2003
Mon Oct 27 23:00:00 CST 2003
Tue Oct 28 23:00:00 CST 2003
Wed Oct 29 23:00:00 CST 2003
Thu Oct 30 23:00:00 CST 2003
Fri Oct 31 23:00:00 CST 2003
```
<p>
That's right, sometimes 24x60x60 is the wrong value for SecondsInDay.  Due to the switch from CDT to CST, 26 October 2003 has 25 hours, so adding SecondsInDay to the midnight time isn't sufficient to advance the day.
</p><p>
For whatever reason, when launched via remote ssh terminal, the interpreter doesn't seem to be aware of the locale (it shows the times as UTC), but when launched from EmbeddedKonsole, Time.now() is aware of the locale and manages the switch from CDT to CST automatically, leading to the bug.
</p><p>
Cute, no?
</p>