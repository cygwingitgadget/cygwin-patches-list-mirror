Return-Path: <cygwin-patches-return-4864-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26499 invoked by alias); 18 Jul 2004 16:29:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26481 invoked from network); 18 Jul 2004 16:29:32 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Sun, 18 Jul 2004 16:29:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: Gerd Spalink <Gerd.Spalink@t-online.de>
cc: cygwin-patches@cygwin.com
Subject: Re: Fix dup for /dev/dsp
In-Reply-To: <01C46CF2.ACDB11A0.Gerd.Spalink@t-online.de>
Message-ID: <Pine.GSO.4.58.0407181221420.19508@slinky.cs.nyu.edu>
References: <01C46CF2.ACDB11A0.Gerd.Spalink@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q3/txt/msg00016.txt.bz2

On Sun, 18 Jul 2004, Gerd Spalink wrote:

> What I did:
>
> The static open_count is no longer needed because now we consistently
> use the return status from the windows API to decide if we can open or
> not.  This change is not related to dup.
>
> Wave header parsing needed a small fix. It was a +/-1 problem.
>
> To fix all cases of dup, a dup_chain is maintained to keep all duped
> instances consistent. I did not understand how to apply archetypes for
> this problem, and this solution works (test suite contribution is in
> separate patch).
>
>
> ChangeLog:
>
> 2004-07-18 Gerd Spalink <Gerd.Spalink@t-online.de>
>
> 	* fhandler.h (class fhandler_dev_dsp): Remove static open_count,
> 	add members to keep track of duped instances.
> 	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::parsewav): Compare
> 	with <= end for the case that only the header is passed to write.
> 	(fhandler_dev_dsp::open): Remove open_count; instead of query use
> 	start/stop to get wave device status from win32.
> 	(fhandler_dev_dsp::fhandler_dev_dsp): Initialize new members
> 	dup_chain_next and dup_chain_prev.
> 	(fhandler_dev_dsp::write): Insert call to update_duped.
> 	(fhandler_dev_dsp::close): Check dup_chain before stop of audio
> 	device.
> 	(fhandler_dev_dsp::dup): Create dup_chain linked list. Copy members
> 	by calling dup_cpy.
> 	(fhandler_dev_dsp::dup_cpy): New.
> 	(fhandler_dev_dsp::update_duped): New.
> 	(fhandler_dev_dsp::ioctl): Replace all inline return statements by
> 	setting variable rc. At the end, reflect any changes in duped instances
> 	by calling update_duped ().

Gerd,

I don't have time for an in-depth analysis, but after a quick look-over,
it looks like you're effectively keeping a reference_count, though as a
full list of references instead of just a count.  It looks a bit
heavyweight, but otherwise good, and I can't argue with success.  Just my
2c.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
