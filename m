Return-Path: <cygwin-patches-return-4866-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14694 invoked by alias); 20 Jul 2004 21:58:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14669 invoked from network); 20 Jul 2004 21:58:32 -0000
Message-ID: <01C46EB5.719F55A0.Gerd.Spalink@t-online.de>
From: Gerd.Spalink@t-online.de (Gerd Spalink)
Reply-To: "Gerd.Spalink@t-online.de" <Gerd.Spalink@t-online.de>
To: "'cygwin-patches@cygwin.com'" <cygwin-patches@cygwin.com>
Subject: RE: Fix dup for /dev/dsp
Date: Tue, 20 Jul 2004 21:58:00 -0000
Organization: privat
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-ID: G5+H1uZUQeDAuv0Oa5IasKOvJDUIGieYZBKvWj6OuLE4HP4kf6lLoO
X-SW-Source: 2004-q3/txt/msg00018.txt.bz2

Hello Corinna, (and all other listeners)

Yes, I have had a look at archetypes, and I just checked again.
What I see is one instance counter (usecount) and a pointer (archetype)
and a dependency into cygheap (cygheap->fdtab.find_archetype and others).
My patch needs two additional pointers, so in terms of member variables,
it is cheap.
Also, I don't understand why archetypes work for any close sequence of
duped instances?
Is the archetype pointer always valid?
It it pointing to the heap? and where/when is it freed?
Is the fhandler object's data in the object or on the heap?
How to keep consistency after a state change?
I also found discouraging comments in the code, like
  // FIXME: Do this better someday

Personally, I prefer not to spread dependencies too much, so I would 
suggest to leave fhandler_dsp as I suggested in the patch. Most of the
changes were done in the ioctl function, which is not affected whether
we use archetypes or a linked list.

Gerd

On Monday, July 19, 2004 1:46 PM, Corinna Vinschen [SMTP:vinschen@redhat.com] wrote:
> On Jul 18 18:11, Gerd Spalink wrote:
> > What I did:
> > 
> > The static open_count is no longer needed because now we consistently
> > use the return status from the windows API to decide if we can open or not.
> > This change is not related to dup.
> > 
> > Wave header parsing needed a small fix. It was a +/-1 problem.
> > 
> > To fix all cases of dup, a dup_chain is maintained to keep all duped instances
> > consistent. I did not understand how to apply archetypes for this problem,
> > and this solution works (test suite contribution is in separate patch).
> 
> Well... don't get me wrong but the doubely linked list looks a bit overly
> complicated to me.  What is the problem you have with the archetype idea?
> Did you have a look into fhandler_tty_slave::open/close/dup?  The archetype
> really just adds a few lines of code and seems pretty straightforward to me.
> 
> Other than that, the code looks ok to me.  But I really think you should
> give the archetype idea another try.
> 
> 
> Corinna
> 
> > ChangeLog:
> > 
> > 2004-07-18 Gerd Spalink <Gerd.Spalink@t-online.de>
> > 
> > 	* fhandler.h (class fhandler_dev_dsp): Remove static open_count,
> > 	add members to keep track of duped instances.
> > 	* fhandler_dsp.cc (fhandler_dev_dsp::Audio_out::parsewav): Compare
> > 	with <= end for the case that only the header is passed to write.
> > 	(fhandler_dev_dsp::fhandler_dev_dsp): Initialize new members
> > 	dup_chain_next and dup_chain_prev.
> > 	(fhandler_dev_dsp::open): Remove open_count; instead of query use
> > 	start/stop to get wave device status from win32.
> > 	(fhandler_dev_dsp::write): Insert call to update_duped.
> > 	(fhandler_dev_dsp::close): Check dup_chain before stop of audio
> > 	device.
> > 	(fhandler_dev_dsp::dup): Create dup_chain linked list. Copy members
> > 	by calling dup_cpy.
> > 	(fhandler_dev_dsp::dup_cpy): New.
> > 	(fhandler_dev_dsp::update_duped): New.
> > 	(fhandler_dev_dsp::ioctl): Replace all inline return statements by
> > 	setting variable rc. At the end, reflect any changes in duped instances
> > 	by calling update_duped ().
> 
> -- 
> Corinna Vinschen                  Please, send mails regarding Cygwin to
> Cygwin Co-Project Leader          mailto:cygwin@cygwin.com
> Red Hat, Inc.
