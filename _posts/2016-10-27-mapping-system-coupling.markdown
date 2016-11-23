---
layout: post
title:  "Mapping system couplings and dependencies for discovery and profit"
date:   2016-10-27
categories:
    - tools
    - devops
    - methods
tags:
    - graphviz
    - discovery
author: Colin Panisset
images:
excerpt:
    Have you ever wondered just what would break if _that system_ (you know the one) went down?  Do you actually _know_ what systems depend on it? How do the reports get from it to Marketing? In this post, I'll describe a simple technique I've developed to surface and share all this juicy, interesting information.
---

Have you ever wondered just what would break if <em>that system</em>
(you know the one) went down?  Do you actually <em>know</em> what systems
depend on it? How do the reports get from it to Marketing? In this post,
I'll describe a simple technique I've developed to surface and share
all this juicy, interesting information.

## The Problem, Restated

Systems grow and morph over time, quite naturally. This happens for a
variety of reasons: lack of time or experience are the most common
causes, and neither of them are cause for blame.  Even in environments
that are strictly controlled (I'm talking here about systems that come
under the aegis of external regulators), these systems end up being
coupled to others in ways that some might find surprising. In most older
environments, there are human elements to this coupling: Bob, over there,
is a critical part of the deployment process, or Karen up on Level 15
is how all the reports get from her `Z:` drive over to Marketing, and
that's the way it's always been.

The risks to the business here are many:

* system changes or interruptions can have unforseen consequences; how
  many times have you heard the phrase "it was supposed to be a simple
  upgrade", usually followed by "but ..." and then a tale of horror
  unfolds?
* individual people who are critical parts of processes can become sick,
  leave, or worse; in the industry, we refer to this somewhat morbidly
  as the "bus factor" (what happens if Bob goes under a bus?);
* knowledge of how an environment actually works is held as "oral
  tradition" which fades over time, leading to expensive and
  time-consume discovery prior to enacting change;
* perhaps worst, the perceived risk of change becomes so great that it
  exceeds the organisational appetite, and the system ossifies in
  place. At that point, the organisation is effectively dead in the
  water.

## What to do?

The solution is simple to state, but challenging to enact: you have to get
a representation of the system, the _real_ system, how it actually
works _right now_, out of people's heads and into some kind of map.

It sounds easy, right? And it can be, although it must be understood
that this takes time, it takes effort, and above all, it takes the
ability to engage with the people who hold the knowledge in an
atmosphere of trust and openness, because if the ones who really know
how things work fear recrimination for the _way_ those things work,
you'll never get the real picture.

There are 4 stages:

### Stage 1: Capture some raw data

1. Get a few knowledgeable people in a room, with a large enough
   whiteboard (or butchers paper, or post-it notes, or whatever). This
   doesn't have to be the whole team, and (unless they built the
   system and have run it themselves), it shouldn't be anyone with
   Solution Architect, Manager, or Analyst in their title. You need
   folks who map to "Engineer", "Operations", or "Support" in that
   room.
1. Start a conversation about a system that those people own and run
   in production. Resist the temptation to try and describe your whole
   production environment in one session; if you can do that, you
   don't need this method.
1. Draw boxes on the whiteboard for hardware, people, individual
   pieces of software (programs), databases, message queues, messages,
   and external third parties. Connect them with arrows that indicate
   coupling. These are usually "sends data to", or "depends on".
   The direction of the arrows indicate the direction of the data flow
   or dependency. You can annotate arrows with the type of connection,
   if you want (HTTP, SQL, etc)
1. Resist the temptation to make it too neat. That'll be fixed later.
1. When your session is done, take a photo for reference. You'll need
   it.

### Stage 2: Create a directed graph

1. Using Your Favourite Directed Graph Mapping Software (I like
   [GraphViz](http://graphviz.org) and my examples will use it),
   turn the whiteboard scrawl into a directed graph of nodes and edges. 
1. Apply colours and annotations to the nodes and edges to distinguish
   types of nodes (databases, humans, etc) and types of edges (HTTP,
   SQL, email, USB stick, etc)

### Stage 3: The Most Important Stage

1. Print the graph out and stick it up in a highly-visible common
   space. Put a sign next to it. The sign says "This map is probably
   wrong. Please help fix it". Stick a permanent marker next to the
   map. Draw one correction line on it (I'm sure you can find one
   mistake, right?)
1. Encourage people to _draw on the map_. This is critical! This is
   how you capture the "oh, I just remembered" and the "I was too
   ashamed to say it before" details.
1. Before the map becomes illegible, take it off the wall and capture
   the changes in Your Favourite Directed Graph Mapping Software.
1. Print it out, stick it up again, and repeat until people stop
   changing it.

### Stage 4: The Payoff

If it's all gone according to plan (of course it has!), you now have a
map that's the best approximation of the territory that really exists.
You can, with a glance, see:

* points of high coupling and dependency. Some of these may be humans!
* bizarre, unexpected, and previously uncaught dependencies between
  systems
* just what a tangled mess your system is

Take heart: _every_ organisation's systems are a tangled mess. I have
yet to see one that doesn't have, somewhere, either a specific person
as a critical point of coupling, or a service that turns out to be
a synchronous dependency that wasn't expected. Remember: you haven't
made them be like this by mapping it, you've just uncovered what's
already there!

Now you can decide whether you want to address some of the things
you've uncovered; if you'd like a hand, please give us a call!
