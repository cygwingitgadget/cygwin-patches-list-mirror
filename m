Return-Path: <cygwin-patches-return-4594-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25303 invoked by alias); 11 Mar 2004 05:48:29 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25294 invoked from network); 11 Mar 2004 05:48:28 -0000
Date: Thu, 11 Mar 2004 05:48:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Signal mask handling
Message-ID: <20040311054828.GA4587@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00084.txt.bz2


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-length: 1077

On Wed, Mar 10, 2004 at 11:26:19PM -0500, Pierre A. Humblet wrote:
>2004-02-11  Pierre Humblet <pierre.humblet@ieee.org>
>	
>	* gendef (_sigdelayed): Replace the call to 
>	set_process_mask by a call to set_process_mask_delta.
>	* exceptions.cc (_cygtls::interrupt_setup): Set oldmask
>	to the delta and don't set newmask.
>	(set_process_mask_delta): New function.
>	(_cygtls::call_signal_handler): Replace the first call to 
>	set_process_mask by a call to set_process_mask_delta.

I tried applying this patch and saw a difference in behavior with
the attached program.  It wasn't setting the signal mask in the handler
correctly.  I have changes in my sandbox which conflicted with your
patch, so I probably misapplied something, though since your patch
looks correct to me otherwise.

Can you confirm the same behavior on the below program before and
after your change?  If so, I'd say it's ok to check in but I'd like to
check my changes in first.  I hope to have them completed soon.

Btw, I think that if you check this in, set_process_mask becomes
obsolete, right?

cgf

--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sigmask.cc"
Content-length: 651

#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <signal.h>

void
ouch (int sig)
{
  sigset_t set, oset;
  sigemptyset (&set);
  sigprocmask (SIG_SETMASK, &set, &oset);
  sigprocmask (SIG_SETMASK, NULL, &set);
  printf ("sig %d, set 0%x, oset 0%x\n", sig, set, oset);
}

int
main (int argc, char **argv)
{
  sigset_t set, oset;
  sigemptyset (&set);
  sigaddset (&set, SIGUSR1);
  sigaddset (&set, SIGINT);
  sigprocmask (SIG_SETMASK, &set, &oset);
  printf ("set 0%x, oset 0%x\n", set, oset);
  signal (SIGALRM, ouch);
  alarm (1);
  pause ();
  sigprocmask (SIG_SETMASK, NULL, &oset);
  printf ("oset 0%x\n", oset);
  exit (0);
}

--ZPt4rx8FFjLCG7dd--
