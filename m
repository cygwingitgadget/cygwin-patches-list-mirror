Return-Path: <cygwin-patches-return-4865-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13136 invoked by alias); 19 Jul 2004 11:45:34 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13099 invoked from network); 19 Jul 2004 11:45:31 -0000
Date: Mon, 19 Jul 2004 11:45:00 -0000
From: Corinna Vinschen <vinschen@redhat.com>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: Re: Fix dup for /dev/dsp
Message-ID: <20040719114535.GA1660@cygbert.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
References: <01C46CF2.ACDB11A0.Gerd.Spalink@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01C46CF2.ACDB11A0.Gerd.Spalink@t-online.de>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2004-q3/txt/msg00017.txt.bz2

On Jul 18 18:11, Gerd Spalink wrote:
> What I did:
> 
> The static open_count is no longer needed because now we consistently
> use the return status from the windows API to decide if we can open or not.
> This change is not related to dup.
> 
> Wave header parsing needed a small fix. It was a +/-1 problem.
> 
> To fix all cases of dup, a dup_chain is maintained to keep all duped instances
> consistent. I did not understand how to apply archetypes for this problem,
> and this solution works (test suite contribution is in separate patch).

Well... don't get me wrong but the doubely linked list looks a bit overly
complicated to me.  What is the problem you have with the archetype idea?
Did you have a look into fhandler_tty_slave::open/close/dup?  The archetype
really just adds a few lines of code and seems pretty straightforward to me.

Other than that, the code looks ok to me.  But I really think you should
give the archetype idea another try.


Corinna

> ChangeLog:
> 
> 2004-07-18 Gerd Spalink <Gerd.Spalink@t-online.de>
> 
> 	* fhandler.h (class fhandler_dev_dsp): Remove static open_count,
> 	add members to keep track of duped instances.
> 	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::parsewav): Compare
> 	with <= end for the case that only the header is passed to write.
> 	(fhandler_dev_dsp::fhandler_dev_dsp): Initialize new members
> 	dup_chain_next and dup_chain_prev.
> 	(fhandler_dev_dsp::open): Remove open_count; instead of query use
> 	start/stop to get wave device status from win32.
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

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
