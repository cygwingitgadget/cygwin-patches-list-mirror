Return-Path: <cygwin-patches-return-4880-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16954 invoked by alias); 26 Jul 2004 01:30:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16943 invoked from network); 26 Jul 2004 01:30:52 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Mon, 26 Jul 2004 01:30:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
cc: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>,
        cygwin-patches@cygwin.com
Subject: RE: Fix dup for /dev/dsp
In-Reply-To: <3.0.5.32.20040724120400.00808b80@incoming.verizon.net>
Message-ID: <Pine.GSO.4.58.0407252124210.6434@slinky.cs.nyu.edu>
References: <3.0.5.32.20040724120400.00808b80@incoming.verizon.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q3/txt/msg00032.txt.bz2

On Sat, 24 Jul 2004, Pierre A. Humblet wrote:

> At 11:52 AM 7/24/2004 +0200, Gerd Spalink wrote:
> >After reading the discussion, I agree to give archetypes a try to fix dup.
> >I'll keep a copy of the linked list solution as a reference.
>
> Gert,
>
> I have the feeling that the main reason dup doesn't work is that
> audioin_/out_ are not "new'ed" in the dup call. That means that when
> the original handle is closed, the storage will go away even though
> the child stills point to it.

That was my original theory - hence the suggestion of reference counting.
But using archetypes should work as well.

> Using an archetype will fix that, but it can probably also be fixed
> very simply without that. I was going to try that today, but I won't
> if you implement the archetype.
> What the archetype buys you is that duped handles can share
> format/bits/freq/channels info. Is that used by any application?
>
> I am wondering if format/bits/freq/channels should be kept separately
> for "in" and "out". The reason is that the "out" values can be modified
> on the fly by the wave header, and this shouldn't affect the "in"
> values.

FWIW, moving the format/bits/freq/channels data into the Audio_in/_out
objects will allow the reference counting solution to work (or the heavier
weight archetype one).

BTW, it is my understanding that archetypes are heavier-weight, but I'm
not quite sure about this.  I based this assumption on the fact that
archetypes were used via structure assignments, so if it's possible to use
archetypes with pointers, then they are just as lightweight as reference
counting.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
