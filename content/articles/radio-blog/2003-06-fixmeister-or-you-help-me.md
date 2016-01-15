---
active_tab: articles
title: the fixmeister role, or "you, help me"
---
# the fixmeister role, or "you, help me"

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Tuesday, 17 June 2003</b>

<p>
In some <a href="http://radio.weblogs.com/0122027/2003/04/28.html#a26" title="28 April 2003: A Little Background on our Continuous Integration Setup">previous</a> <a href="http://radio.weblogs.com/0122027/2003/04/29.html#a27" title="29 April 2003: build cycles, development cycles, and the nag server">posts</a>, I discussed some of the challenges we've experienced maintaining a <a href="http://www.martinfowler.com/articles/continuousIntegration.html" title="Continuous Integration by Martin Fowler and Matthew Foemmel">continuous integration</a> discipline at my day job.  In my last post on this topic, I alluded to "additional measures" which we adopted.  Time to describe what I was talking about.
</p><p>
Although I hadn't seen it at the time of the events described below, I recently ran across a comment on <a href="http://c2.com/cgi/wiki" title="Ward's Wiki: Front Page">Ward's Wiki</a> that accurately captures the problem we encountered and its solution:
</p><blockquote>
<p><i>There was an interesting psych study along these lines. There is one "victim" and several "bystanders". Each of the bystanders individually would be perfectly capable of helping the victim, but since they <a href="http://c2.com/cgi/wiki?NeverVolunteer" title="Ward's Wiki: Never Volunteer">NeverVolunteer</a>, none of them do. This happens in real life situations. If you are the victim and want help, what you need to do is to pick one person from the bystanders and say to them specifically "you help me". If you just do "somebody help me" it won't work. -- <a href="http://c2.com/cgi/wiki?AndyPierce" title="Ward's Wiki: Andy Pierce">AndyPierce</a></i> [from <a href="http://c2.com/cgi/wiki?NeverVolunteer" title="Ward's Wiki: Never Volunteer">Never Volunteer</a>]</p>
</blockquote>
<p>
Toward the end of April, in the midst of one of the longer low points in our <a href="http://radio.weblogs.com/0122027/2003/04/29.html#a27" title="29 April 2003: build cycles, development cycles, and the nag server">development cycle</a>, I sent the following (slightly edited) email to my peers on the technology management team.  At the time it felt a bit like a failure.
</p>
<blockquote>
<p>
<b>Subject:</b> build failures, and what to do about them
<br>
<b>Sent:</b> Wed 4/23/2003 10:29 AM
</p><p>
There was a time, not so long ago, when we would regularly see a dozen or more good integration builds per day. In fact the vast majority of builds were clean ones. (See <i>[internal link to an historical report on continuous integration builds]</i>.)  Recently (meaning the past few months) we're lucky to see a dozen good builds in a week.
</p><p>
As we've seen rather directly the past couple of weeks, our inability to regularly integrate changes across the entire code base slows our development process, delays production releases and may threaten our ability to deliver products according to schedule.  Moreover, integration problems compound themselves.  When we go several hours (let alone several days) without a clean build, it's no longer just one problem we need to fix, but several problems that are hidden behind the first one, masked because problems in some dependent library stops the build before it discovers the later problems.
</p><p>
These integration problems are real problems.  A "broken build" means that there is some code that either doesn't work at all, doesn't work in relation to other libraries, or doesn't work outside a particular developer's (or developers') sandbox.  These problems may not impact every developer at all times, but it is quite likely they impact some developer.  It is guaranteed that they will impact the entire technology team and for that matter the entire enterprise when it comes time to release a product (and as I understand it, we have a few of those queued up in the near future).  By and large, the way in which developers avoid this problem is to simply not update their local repositories.  That's a false sense of progress if there ever was one.
</p><p>
Some developers have complained about this problem.  Some managers have as well.  We've made increasingly obnoxious efforts (<i>[internal link to our nag servlet, as described in a <a href="http://radio.weblogs.com/0122027/2003/04/29.html#a27" title="29 April 2003: build cycles, development cycles, and the nag server">previous entry</a>]</i>) to increase the visibility of this problem, but it's not getting better.  And due to the compounding behavior described above, when it's not getting better, it's getting worse.
</p><p>
I propose we do the following:  For each series of build failures (that is, for every continuous sequence of failures, no matter how many underlying causes they might have) we name one arbitrarily selected developer to be "on point" for achieving a clean build.  Achieving a clean build becomes this developer's top priority (if they need to weasel out of it in order to something that is "more important", they do that by finding someone else willing to trade slots with them).  In exchange for this responsibility, we give this developer the authority to grab whomever they need to do whatever they need to accomplish this goal.  If Alice, being on point, needs Jose's help to diagnose a problem, or needs Jose to make changes to some library in order to bring said library into sync, then this becomes Jose's top priority as well (see the "weaseling out of it" strategy above).  Similarly, if Alice, being on point, needs Jose to take over some task Alice would otherwise be working on, she is empowered to do that as well.
</p><p>
Why?
</p><p>
1) Having a code base that is not integrated is costing us a substantial amount of developer time, which means it's costing the company a substantial amount of money and threatening release schedules.
</p><p>
2) Things that are everyone's responsibility become no one's responsibility.  Actually, this isn't really it.  More accurately, when we fail to send a message that things that are everyone's responsibility are important, those things become the responsibility of a handful of truly responsible people.  There are developers who take build failures seriously, and make a well above average effort to address them.  These efforts are undermined by those who don't take build failures seriously (or insufficiently seriously), and eventually, the patience of those good Samaritans wears thin.  I know mine did several weeks ago and I've noticde a degradation in the integration quality since that time.  It was my hope that others would step up to take greater responsibility for integration builds, some did, but seemingly not enough.
</p><p>
<i>[It may seem that I'm overestimating my contribution there, but I literally, personally, addressed perhaps 30% of the build failures for several months.  I looked at each and every build failure, and when it seemed no one was making progress in addressing it, I'd fix it myself.  Frankly, I did this because (a) when our CI process was first initiated, there were a number of detractors that claimed this simply wouldn't work, and (b) it seems like this simply the right approach to a CI process--I'd expect everyone to do more or less the same thing.]</i>
</p><p>
3) Making fixing the build a top priority sends the message that we take continuous integration seriously, as a management team, as a development team, and as an enterprise.
</p><p>
4) Selecting an arbitrary developer to be on point offers a number of advantages:
</p><p>
a) It increases the visibility of build issues, the kinds of problems that cause them, and an effective strategy for resolving them, across the whole team.  Folks who may have never before thought about how to diagnose an arbitrary problem reported by the CI server are forced to do so.  Folks who may have never reflected on the kinds of changes that are problematic, or how to make changes in an incremental and backwards compatible way are exposed to those sorts of issues and those sorts of solutions.
</p><p>
b) It applies stronger peer pressure.  For quite some time I would personally "nag" folks to fix build issues, even sit down with them to explain the nature or the problem and the needed fix.  After a while, this nagging decreases in effectiveness, since "Rod's always complaining about the build".  When several different folks in a week are nagging you to fix problems you've caused, the pressure not to cause such problems (or to fix them on you own initiative) is increased.  When several different folks find themselves nagging the same person over and over again, the pressure on that person to improve their personal process is increased.
</p><p>
c) It causes greater knowledge sharing.  When put on point to fix a problem in some otherwise unknown library, a developer is forced to learn something about it, probably by pairing with someone more knowledgeable about it.  When a developer finds that they are consistently being "bothered" to update a library because they are the only ones that understand it, the pressure to make it more understandable or to share some of that understanding is increased.
</p><p>
d) Indirectly, it sends the message that fixing the build really is everyone's responsibility.  The arbitrary developer "on point" is simply putting a face on the team's concerns.
</p><p>
I'd very much like to start putting people "on point" for fixing the build today, probably by calling an all developer meeting to explain this protocol.  I'd also very much like to not have this protocol undermined by some direct or indirect message of "well, that's important, but this is more important" (where "this" is some more urgent, but not necessarily more important task).  We have more than enough developers to manage both the urgent and important tasks on our plate, and I'll argue that an approach that doesn't make integration a top if not the top priority is going to cost us in the long run.  If anyone has objections or an alternative strategy, I'd love to hear about it.
</p></blockquote>
<p>
This strategy was well received by the management team, and was implemented almost immediately.  This strategy was less well received by some members of the development team, but there was at least grudging acceptance from everyone.
</p><p>
The team has come to call this role the "fixmeister" (a name which I'm personally not very fond of).  The first fixmeister had the excellent suggestion that each subsequent fixmeister be selected by the current one, which has led to an interesting variety of selection algorithms, some whimsical, some instructional, some a bit malicious.
</p><p>
In the eight weeks or so since this process was initiated, we've been around the team slightly more than once.  It's been effective in achieving the primary goal--increasing the ratio of build successes to build failures.  I'd like to think it's been effective in achieving some of the harder-to-measure goals as well. (It's certainly increased awareness of the CI process among the less process oriented members of the team, and perhaps taken away some of the mystery of the process.)  Maybe time will tell on the other points.
</p>