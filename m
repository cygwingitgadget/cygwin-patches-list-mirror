Return-Path: <cygwin-patches-return-4595-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16617 invoked by alias); 11 Mar 2004 14:15:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 16608 invoked from network); 11 Mar 2004 14:15:23 -0000
Message-ID: <4050747A.D43819DE@phumblet.no-ip.org>
Date: Thu, 11 Mar 2004 14:15:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Signal mask handling
References: <3.0.5.32.20040310232619.007fac50@incoming.verizon.net> <20040311054828.GA4587@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q1/txt/msg00085.txt.bz2

OK, will do that tonight. Let me say that what motivated me
is that I saw your new how-to and that got me interested again.

Since I sent the patch two things happened;
- I saw that _cygtls::fixup_after_fork () uses oldmask. I am
  not sure what case it tries to cover (a fork happening just
  as a handler has started, between the moment where it sets 
  the new mask and the moment it has cleared sig?)
  but that wouldn't work well with my patch.
- I slept and somehow started to wonder how we can have handlers
  running in several tasks (and not just the main one, as before)
  while maintaining consistency in a single process mask. It
  seems to me that if handlers run in several tasks we have to move
  to the Posix model of per thread masks only. The code seems ready
  for that, but something must be holding you up.

I was also hoping that set_process_mask would become obsolete but
it's still needed in sigreturn. We need an absolute mask there.   

Pierre


Christopher Faylor wrote:
> 
> On Wed, Mar 10, 2004 at 11:26:19PM -0500, Pierre A. Humblet wrote:
> >2004-02-11  Pierre Humblet <pierre.humblet@ieee.org>
> >
> >       * gendef (_sigdelayed): Replace the call to
> >       set_process_mask by a call to set_process_mask_delta.
> >       * exceptions.cc (_cygtls::interrupt_setup): Set oldmask
> >       to the delta and don't set newmask.
> >       (set_process_mask_delta): New function.
> >       (_cygtls::call_signal_handler): Replace the first call to
> >       set_process_mask by a call to set_process_mask_delta.
> 
> I tried applying this patch and saw a difference in behavior with
> the attached program.  It wasn't setting the signal mask in the handler
> correctly.  I have changes in my sandbox which conflicted with your
> patch, so I probably misapplied something, though since your patch
> looks correct to me otherwise.
> 
> Can you confirm the same behavior on the below program before and
> after your change?  If so, I'd say it's ok to check in but I'd like to
> check my changes in first.  I hope to have them completed soon.
> 
> Btw, I think that if you check this in, set_process_mask becomes
> obsolete, right?
> 
> cgf
> 
>   --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
> 
>    sigmask.ccName: sigmask.cc
>              Type: Plain Text (text/plain)
