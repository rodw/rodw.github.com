---
active_tab: articles
title: Adaptive vs. Predictive Planning
---
# Adaptive vs. Predictive Planning

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Monday, 18 August 2003</b>
<p>
At my day job, we develop what seems to be a wide variety of systems: several subscription based web sites, a suite of desktop applications, an e-commerce system for selling both subscriptions and physical products, and various financial, administrative, content management, editorial and reporting systems for supporting them.  We've been developing most of those systems under a locally adapted form of XP for about three years now.
</p><p>
For a lot of what we do an agile process works well.  We're often making "small" modifications to a running (production) system, so a process that allows the customer to say "here's a set of changes, implement and deploy them in the next couple of weeks" fits our needs rather  well.  Even the least imaginative customer is typically able to break down large changes into an incremental series of small ones, and is often happy to see the intermediate steps in a running (although not always production) system.
</p><p>
Allow me to call this approach "adaptive" planning. (I don't think I'm the first to do so.)  An interesting feature, perhaps the defining feature, of this adaptive approach is that customer is often defining new requirements as we're implementing the old ones, so that we're not always exactly sure where we're going when we start.  It's sort of like a hill climbing approach: we take a few steps in what seems to be the right direction and then reevaluate.  Our plan adapts to changing business requirements and generally doesn't try to look very far ahead in any detail.
</p><p>
It doesn't take a lot of insight to see that an adaptive approach is well suited to what might be called "product" as opposed to "project" management.  If one conceives of the system as long-lived, constantly improving entity, it's easier to be comfortable with an iterative development process. No one can really foresee where the system is going to end up anyway, so the urge to ask "when is it going to be done?" is lessened.
</p><p>
On the other hand, there are times when the customer wants, or at least thinks he wants, a more predictive planning process:  "Here's a large set of requirements, when are they going to be met?"  This question is important because the answer will often drive business deals, strategic planning, and revenue projections.  Depending upon the time sensitivity of the opportunity, the answer may determine whether the project is worth initiating at all.
</p><p>
Frankly, I don't think our process is very good at answering this sort of question.  In practice, the way we approach such a question is quite similar to most "traditional" methodologies: we'll collect coarse grained requirements and prepare coarse grained estimates for them.  This process is often time consuming--the customer team will spend weeks struggling to define and communicate a "base" set of requirements for estimation purposes.  The result is often unsatisfactory--poorly understood and poorly articulated requirements lead to poor estimates.
</p><p>
One solution is to somehow dissuade the customer from believing that he needs detailed planning or long term predictions.  Sometimes it really is a distinction without a difference--we're going to do the work anyway, so knowing precisely what features make it into the version 1.0 release or precisely when this release will occur are details that can be determined later.  Most projects end with some negotiation of scope and schedule anyway.  The trouble is, sometimes accurate predictions really do matter.
</p><p>
Another solution is to accept the limitations of this predictive approach--we don't really know how long it will take to complete the project, or what "complete" really means in the first place, so the best we can do is take an educated guess and know that the margin of error (and therefore the risk) is high.  True as it may be, this answer is unsatisfactory at best, and unacceptable at worst.  The fact that traditional planning approaches don't fare much better is little consolation.
</p><p>
We've been through this "predictive" planning exercise perhaps four times in the past three years, and have found it to be successful, but only moderately so.  Increasingly I am beginning to believe that the adaptive process may be a more effective way of arriving at accurate predictions anyway.  Through a lack of information, insight, or political capital, I've never seen it played this way, but I'm beginning to think this is the right approach:
</p><p>
Rather than spending a couple of weeks (or more) trying to determine a rough but "complete" estimate for the total cost of the project, spend that time developing an implementation of some of the base features (call it a "spike solution" or prototype if that helps, but it's really neither of those things).  The requirements will certainly be incomplete, maybe even wrong.  The implementation is likely to be wrong too, or will be when the requirements are better understood.  I think that that may not matter.
</p><p>
Part of what leads me to this conclusion is that this is what we really do anyway.  Although the thought is "let's not go down this road until we're sure that's what we want to do", in practice what we'll struggle to determine what the "total cost" of the project is going to be until it becomes clear that if we don't initiate the development soon, we won't be able to hit the requisite dates anyway.  We may only be 60% sure that the project is worth pursuing, but the schedule eventually makes the decision for us.  Indeed, this is how we first adopted an XP practice: as a way out of the "analysis paralysis" threatening a major product initiative.
</p><p>
(This last-minute adaptive approach is expensive in at least a couple of ways.  Firstly, by the time a deadline is looming, we no longer have the luxury of slowly ramping up size the development team, we need to throw all our developers at the system immediately.  This is a chaotic way of doing green-field development.  Secondly, when we follow this approach, it's rarely the most important features we attack first, it's the ones that are easiest to define.)
</p><p>
I think this "just get started" approach may bring several benefits over a predict-then-implement one.  Having a working system, however rudimentary...
</p>
<ul>
<li><p>makes the total cost estimate more accurate simply by virtue of having some of the requirements already implemented.  We don't need to guess what those will cost--they're already done.</p></li>
<li><p>makes the development team more confident about their ability to address the remaining requirements.</p></li>
<li><p>makes the development team better able to predict what's going to be tricky and what isn't.  We have some measure of the team's velocity when working on the system in question.  As a result, estimates should be more accurate.</p></li>
<li><p>provides the customer team with a reference point to work from.  Rather than saying "here's what the final system will look like", they can be begin to express requirements as "here's how I want to you change the existing system."</p></li>
<li><p>may give the customer team enough confidence in the development team's ability to deliver the end product to follow an iterative/evolutionary approach.  Once it's clear that we can deliver <i>something</i> by the deadline, it may be less important precisely what that something is.</p></li>
</ul>
<p>
Of course, the customer team can in parallel continue to define and refine the requirements and seek a "total cost" estimate, but at least for these first few iterations, we don't need to worry too much about the total scope of the project
</p><p>
There is some risk here, namely that after a couple of weeks of development it becomes clear that this is not a project worth pursuing and hence the development effort in those first few weeks is wasted.  I can't imagine that this cost is significantly greater than the cost of the predictive analysis, but for better or worse in my environment there is a general impression that development resources are precious and hence need to be conserved--it's better to waste "analysis" time than "development" time.  Overcoming this impression may be the key to selling this approach.
</p><p>
Looking over what I've written here, it looks like I'm describing a straight-forward XP process, and perhaps I am.  In some ways, the distinction may be in the <i>reasons</i> for the adaptive approach.  In our typical agile project, we sell the just-in-time requirements definition process as a way to get development moving while the business is still working out requirements.  When predictive questions are asked, the business often believes that the requirements are already defined (although in practice they're often not as well defined as the customer may believe), only the technical cost needs to be determined.  In this case the iterative development cycle may be more valuable to the technical team than to the business.
</p><p>
It may be interesting to explore how to use an adaptive planning process to answer predictive planning questions.
</p>