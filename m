Return-Path: <cygwin-patches-return-4852-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18437 invoked by alias); 15 Jul 2004 18:57:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18415 invoked from network); 15 Jul 2004 18:57:18 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 15 Jul 2004 18:57:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] Reference counting on Audio objects for /dev/dsp
In-Reply-To: <20040715183335.GB12149@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.58.0407151449040.24064@slinky.cs.nyu.edu>
References: <Pine.GSO.4.58.0407150928040.29800@slinky.cs.nyu.edu>
 <20040715183335.GB12149@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q3/txt/msg00004.txt.bz2

On Thu, 15 Jul 2004, Christopher Faylor wrote:

> On Thu, Jul 15, 2004 at 09:44:34AM -0400, Igor Pechtchanski wrote:
> >Gerd,
> >
> >I'd really like your comments on this patch.  As I reported before, it
> >didn't quite work for me, but with the recent problems in testing another
> >(presumably working) patch, I suspect my test procedure isn't quite
> >correct anyway.  The patch basically adds a (very problem-specific)
> >reference count to the Audio object(s), and doesn't delete the shared ones
> >until all pointers are gone.  It doesn't seem to fix the bash redirection
> >problem, but does allow the "dsp_dup_close" testcase to run (again, I'd
> >like your opinion on whether it runs correctly).
> >
> >The ChangeLog below is just for the record -- as I said, I don't expect
> >this to be checked in yet.
> >	Igor
> >==============================================================================
> >ChangeLog:
> >2004-07-06  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
> >
> >	* fhandler_dsp.cc (fhandler_dev_dsp::Audio::reference_count_):
> >	New instance variable.
> >	(fhandler_dev_dsp::Audio::inc): New function.  Increment the
> >	reference_count_.
> >	(fhandler_dev_dsp::Audio::dec): New function.  Decrement the
> >	reference_count_ and delete if zero.
> >	(fhandler_dev_dsp::close): Replace delete with a call to dec().
> >	(fhandler_dev_dsp::dup): Copy audio_in_ and audio_out_ and call
> >	inc() on each.
>
> Thanks for the patch.  I have two problems, though.
>
> 1) Some minor problems with GNU formatting:
>
>   fhc->audio_out_ = audio_out_; if (audio_out_) audio_out_->inc ()
>   audio_out_ -> dec ();

Thanks for the review.

Yep.  Once we determine whether this works (or if it doesn't, why), I'll
get the formatting in order before resubmitting.  As I said before, I
don't expect this to be checked in for now.

> 2) The other problem is that I find it sort of odd to see the dec()
> method performing a deletion.  Couldn't this be handled where, IMO,
> it should logically be handled, in the close function, e.g.,
>
>   if (!audio_out_->dec ())
>     delete audio_out_;
> ?

Umm, that's actually a rather standard construct in reference counting
(called "object suicide" -- you should get some references if you Google
for "object suicide reference counting").
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
