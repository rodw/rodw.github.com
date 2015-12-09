---
active_tab: articles
title: The Great Wall of China
---
# The Great Wall of China

<div style="color:#333">(Back in 2003 I ran <a href="http://radio.weblogs.com/0122027/">a moderately popular tech blog</a> on the Radio UserLand platform.  This is an archived version of a post from that blog. You can view <a href="/articles/radio-blog/index.html">an index of all the archived posts</a>.)</div><hr>
<b>Wednesday, 23 July 2003</b>
<p>
Although I'm neither old enough nor wise enough to pull it off effectively, I'm a fan of management by narrative: using a brief story or parable to illustrate a point.  Often I find it is sufficient to present the narrative without explicitly connecting the dots--I'll just tell the story and then launch into what I was otherwise going to say.  (As always, you need to understand your audience to use this approach effectively.  I've noticed developers often respond well to leading with the narrative.  Suits, whether management, business or marketing folks, often respond best to hearing the explanation and then the metaphor.)
</p><p>
Yesterday, in the context of the early stages of a fairly large scale development project, I had the opportunity to tell the following.
</p>
<blockquote>
<p>
When the emperor decided to build the 10,000 Li Wall, he didn't amass an army of men to start at one end and build to the other.  Nor did they start at both ends and build toward the middle, the way one might dig a long tunnel.  Rather, they assembled small teams of men and spread them far and wide.  Each crew was responsible for constructing a small section of the wall, separated by many li from the neighboring sections.
</p><p>
Like all ancient construction, the work was difficult, and by the time the section was complete the crew was greatly discouraged.  They had worked so hard, and seemed to have little to show for it but a single, isolated tower.
</p><p>
Yet as the crew made the long journey back to their homes, they would come across other sections of the wall--some complete, others being busily attended to by other work crews.  They came to discover that the wall stretched, section by section, from the Yellow Sea deep into the western desert.  They arrived home in awe of the enormity of what had already been accomplished, and more inspired than ever to complete the construction.
</p>
</blockquote>
<p>
I have no idea if this story is true (never let the facts stand in the way of a good story), my source is a half-remembered parable written by Franz Kafka.  In my limited understanding of Chinese history, the story is a half-truth: the Great Wall was assembled a bit more organically out of a series of smaller fortifications.
</p><p>
I was a little hesitant to tell this story as I think the metaphor can be easily misinterpreted.  I'm not suggesting that large scale systems be built by teams with only local knowledge of the overall system.  Nor am I suggesting that if "isolated towers" aren't useful to you (or your customer) that this approach is a good one.  (This latter case is an example of where the reality makes a better metaphor than the story.  In practice Shih huang-ti connected a number of existing, independently useful fortifications to form the Great Wall.)  In fact, I think laying out a grand vision of the project and working on little bits here and there is a remarkably bad way to approach the development unless those little bits are useful to you in isolation.  Otherwise you're likely to end up with bits that aren't useful to you at all.  But with a little bit of discipline about which "towers" to build first, I think this serves as a useful metaphor for an effective (and not uncommon) development practice.  We're implementing a large and complex system via a series of user stories.  Rather than building out a major subsystem in its entirety and then moving on to the next one, we're implementing the skeleton of the end-to-end system, to which we will add meat (that is, complexity) in subsequent iterations.  We know any given story describes an incomplete subsystem at this stage, but each describes an cohesive unit of functionality, to which we can add complexity and functionality to fill out the walls between the towers.
</p>