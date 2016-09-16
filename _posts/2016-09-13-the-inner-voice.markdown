---
layout: post
title:  The Inner Voice
date:   2016-09-13
categories:
  - devops
  - uplift
tags:
  - Learning
  - Automation
  - Reliability
author: David Walters
images:
excerpt:
  Sometimes it is necessary to forgo the pure awesome of Infrastructure As Code and automate "Most Of The Things".
---
`DRAFT`
# Case Study
## Voice Interface Design

Voice Interface Design produces solutions for logistics and warehousing,
including voice-pick and click-and-collect. Initially a hardware reseller,
VoiceID have recently expanded their field of operation to include software
development and have achieved significant success already. Now, they want to 
prepare for scale.


`rewrite: "About VoiceID"`

    Hand-held devices are used to scan barcodes, place orders, etc in the warehouse
    and messages are sent across the internet to VoiceID servers which act as a
    messaging tier hosted on machines on premise at their HQ in Melbourne, or at
    client sites. Also of note here is their latest tech, in the super-cool
    voice-recognition space.


For their latest project, VoiceID decided they wanted to program scalability into
the project from the beginning, and as this project was largely self-contained
it represented a good opportunity to design a cloud-based infrastructure which
could be deployed across multiple geographic locations.
The client in this case is a global retailer, and click-and-collect features at
scale would best be spread across many datacentres (availability zones).

### AWS was the natural choice.
Amazon Web Services was the natural choice as it offers a range of services
targeted at a growing online presence: from click-create instances (using the
AWS console) to full-blown scriptable managed infrastructure.
As the pilot project was not going to be world-scale, and due to the
(regrettably familiar!) constraints of time and cost it made sense to choose
the lowest barrier to entry and start out with a click-to-create stack that
would serve as the proof of concept and get the project "off the ground"
(pun intended) in the shortest possible time.

This gave VoiceID the opportunity to get their hands dirty and build some cloud
infrastructure manually, which provides a deep insight into the concepts and
patterns in use in cloud-land, and to see how powerful the AWS web console is.
Moreover, they got to see what the road ahead looked like - as it became clear
that everything they were doing with the clickety-click console could be
transformed into a set of scripts (or JSON definitions indeed) which could run
and re-run time and again providing confidence that they could simply
"tear it all down and start again".

### When timeframes are tight, concessions must be made - but that does not mean that corners must be cut.
Given the tight timeframe, it was decided that instead of the "traditional"
delivery pipeline design - INT->TEST->PRE->PROD, we would squash the pipeline
down into two environments only: TEST and PROD.

### Script-as-you-go.
So, when we built the TEST stack, we launched the EC2 instance, RDS, configured
security groups and DNS using the AWS management console, and captured each
step in the deployment process into a bash script - to take care of all the
deployment and configuration for us **next time**. We uploaded the mutable
parts (config files etc) to S3 buckets which the deploy script could pull down
based on an "ENV" conditional. Of note here is that we were optimizing for
project delivery, learning curve, and repeatability.

Because the dev lead at VoiceID was under pressure to complete the application
development, **and** had the responsibility of supporting the platforms during
the pilot, we had to make the "hard choice" to forgo the awesomeness of
CloudFormation or Beanstalk and instead go for an ...
"impure" manual-plus-scripts approach.

This trade-off was made to lower the barriers to entry for the pilot -
not to discard the devops philosophy entirely. We remained mindful that one day
these scripts could be run by a CI management tool (like Jenkins) so we drew
lines of separation around the concerns of infrastructure, configuration and
deployment.

Cevo's primary goal was to deliver knowledge to VoiceID,
*teaching them to fish*, while not completely overwhelming them with
information and causing an overload. We focussed on concepts and practices,
rather than weighing them down with new tools to learn.

In time, the need for those tools will help to inform VoiceID **why** to use
them, rather than simply installing a bunch of shiny stuff and telling them
where the docs where, which would have been an unnecessary burden especially
since the time we had was precious little - now is not the time to learn how to
use All The Devops.

The dev lead was taken through the basics, using the AWS console to create the
simplified infrastructure they would need for a pilot - very simple:
no autoscaling, no HA, no CF templates, etc. We had distilled the process
into the fewest possible (in my mind) steps.

* MANUAL: Create a vertically scalable data store (a mysql RDS)
    * SCRIPT: Seed Data
    * SCRIPT: Backup
    * SCRIPT: Restore


* MANUAL: Create a single app node (EC2)
    * SCRIPT: Install dependencies
    * SCRIPT: Deploy app
    * SCRIPT: Update app


* SIMPLE: Monitoring
    * CRON: netcat to the RDS and make sure it is running
    * CRON: netcat the app node and make sure it is responding
    
We made the recommendation that moving forward they might like to look into
Nagios, the free and open source monitoring awesome. For now - the important
thing is to know **what** to monitor and how to get that done **quickly**.
    
As you can see, there is a key (fundamental) devopsy automation piece missing
here: **Infrastructure As Code**. This is the sacrifice we made in order to
deliver a reliable process for iterating on the pilot application code.

We settled for **Deployment As Code**, and **Site Reliability**. Small steps,
big value.

### So it's not **DevOps** then...
I actually disagree with the statement above. We applied devops philosophy as
far as we dared - building repeatability and reliability into the application
deployment process while being mindful that overburdening the dev lead with
too many new things would cause problems down the track.

Our dev lead was responsible, after all, for supporting All The Things during
the pilot, and we needed to relieve him of as much ops work as possible,
ensure he was across what was actually happening, and leave some of the things
manual for the time being - we chose the things that don't take much time,
don't have as much room for error as deployment, and which build a set of
experiences for the dev lead that he can use moving forward as a base for
further learning in the infrastructure automation space.

### Next steps.
Low hanging fruit would be to script the creation of the EC2, RDS, security
groups and DNS. This can be done pretty quick in python for example, or at a
pinch, using some clever bash scripts and **awscli**.

Another next step is to use CloudFormer to create a CloudFormation template
from the stack created manually, and learn from the JSON artifact that is
produced by that tool.

The learning curve for that is not overwhelmingly steep, and it would allow our
dev lead to click **even fewer** buttons when the time comes to build a new
stack, leading to lower risk of errors and more rapid turnaround when tearing
down / unfurling a new stack becomes a thing for them.

A build pipeline also helps automate quality controls, delivery and
orchestration, and as the project grows the need for a pipeline will bubble to
the top of their list of delivery needs. **Jenkins** is good for this sort of
thing. There are shinier CI tools, like GoCD or even Bamboo for the Atlassian
shops.

Of note here is VoiceID's continued use of on-prem development tools, their SCM,
Wiki and ticketing are all behind the firewall, making it necessary for our
dev lead to ship the artifact(s) manually to S3 - another ripe candidate for
automation.

VoiceID's journey is just beginning, it's exciting to see such enthusiasm for
reliability and I can't wait to see how far they can take their learning.
