Return-Path: <cygwin-patches-return-4851-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27203 invoked by alias); 15 Jul 2004 18:34:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27187 invoked from network); 15 Jul 2004 18:34:01 -0000
Date: Thu, 15 Jul 2004 18:34:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] Reference counting on Audio objects for /dev/dsp
Message-ID: <20040715183335.GB12149@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.58.0407150928040.29800@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0407150928040.29800@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q3/txt/msg00003.txt.bz2

On Thu, Jul 15, 2004 at 09:44:34AM -0400, Igor Pechtchanski wrote:
>Gerd,
>
>I'd really like your comments on this patch.  As I reported before, it
>didn't quite work for me, but with the recent problems in testing another
>(presumably working) patch, I suspect my test procedure isn't quite
>correct anyway.  The patch basically adds a (very problem-specific)
>reference count to the Audio object(s), and doesn't delete the shared ones
>until all pointers are gone.  It doesn't seem to fix the bash redirection
>problem, but does allow the "dsp_dup_close" testcase to run (again, I'd
>like your opinion on whether it runs correctly).
>
>The ChangeLog below is just for the record -- as I said, I don't expect
>this to be checked in yet.
>	Igor
>==============================================================================
>ChangeLog:
>2004-07-06  Igor Pechtchanski  <pechtcha@cs.nyu.edu>
>
>	* fhandler_dsp.cc (fhandler_dev_dsp::Audio::reference_count_):
>	New instance variable.
>	(fhandler_dev_dsp::Audio::inc): New function.  Increment the
>	reference_count_.
>	(fhandler_dev_dsp::Audio::dec): New function.  Decrement the
>	reference_count_ and delete if zero.
>	(fhandler_dev_dsp::close): Replace delete with a call to dec().
>	(fhandler_dev_dsp::dup): Copy audio_in_ and audio_out_ and call
>	inc() on each.

Thanks for the patch.  I have two problems, though.

1) Some minor problems with GNU formatting:

  fhc->audio_out_ = audio_out_; if (audio_out_) audio_out_->inc ()

should be:

  fhc->audio_out_ = audio_out_;
  if (audio_out_)
    audio_out_->inc ()

nor is this:

  audio_out_ -> dec ();

should be:

  audio_out_->dec ();

2) The other problem is that I find it sort of odd to see the dec()
method performing a deletion.  Couldn't this be handled where, IMO,
it should logically be handled, in the close function, e.g.,

  if (!audio_out_->dec ())
    delete audio_out_;

?

cgf
