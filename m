Return-Path: <cygwin-patches-return-4597-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28447 invoked by alias); 12 Mar 2004 00:38:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28436 invoked from network); 12 Mar 2004 00:37:59 -0000
Message-Id: <3.0.5.32.20040311193641.007f29f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 12 Mar 2004 00:38:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Signal mask handling
In-Reply-To: <20040311054828.GA4587@redhat.com>
References: <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
 <3.0.5.32.20040310232619.007fac50@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q1/txt/msg00087.txt.bz2

At 12:48 AM 3/11/2004 -0500, Christopher Faylor wrote:
>I tried applying this patch and saw a difference in behavior with
>the attached program.  It wasn't setting the signal mask in the handler
>correctly.  I have changes in my sandbox which conflicted with your
>patch, so I probably misapplied something, though since your patch
>looks correct to me otherwise.
>
>Can you confirm the same behavior on the below program before and
>after your change?  If so, I'd say it's ok to check in but I'd like to
>check my changes in first.  I hope to have them completed soon.
>
>Btw, I think that if you check this in, set_process_mask becomes
>obsolete, right?

There was a problem: pause() calls handle_sigsuspend(), which overwrites
the oldmask set by _cygtls::interrupt_setup. It's all fixed, and I have
renamed newmask to deltamask in cygtls.h. I can send you a fresh patch 
(everything, against cvs) now, or wait until you apply yours.

BTW I noticed that Posix and Cygwin diverge on sigpause.

Posix:
int sigpause(int sig);
The sigpause() function removes sig from the calling 
process' signal mask and suspends the calling process
until a signal is received. The sigpause() function 
restores the process' signal mask to its original
state before returning. 

Cygwin
sigpause (int signal_mask)
{
  return handle_sigsuspend ((sigset_t) signal_mask);
}

Pierre
