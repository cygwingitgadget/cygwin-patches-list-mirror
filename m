Return-Path: <cygwin-patches-return-3076-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 27461 invoked by alias); 21 Oct 2002 18:51:17 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27452 invoked from network); 21 Oct 2002 18:51:16 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Mon, 21 Oct 2002 11:51:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
cc: Steve O <bub@io.com>
Subject: FIXED Re: [PATCH] fhandler_tty deadlock patch
In-Reply-To: <Pine.GSO.4.44.0210211051570.18735-101000@slinky.cs.nyu.edu>
Message-ID: <Pine.GSO.4.44.0210211438100.7250-100000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q4/txt/msg00027.txt.bz2

On Mon, 21 Oct 2002, Igor Pechtchanski wrote:

> On Mon, 21 Oct 2002, Steve O wrote:
>
> > On Sun, Oct 20, 2002 at 11:15:47PM -0400, Igor Pechtchanski wrote:
> > > However, there are a couple of problems with this patch.  For example,
> > > this makes bash run from a command prompt (or a shortcut) treat every
> > > character as a ^D.
> >
> > So every character closes bash?  I'm not able to reproduce this on
> > WinXP, have an strace?
>
> Sure.  I'm attaching an strace for 'bash --rcfile /dev/null'; the
> character pressed was a space.  This affects most programs, btw (vi from a
> command prompt, for example, and tcsh), but not sh, cat or less.  My guess
> is that anything that uses readline is affected.  I'm running Win2k SP2,
> if it makes any difference.

Well, rebuilding cygwin1.dll from scratch seems to have solved this
problem, which probably indicates that some dependence is not computed
correctly.  So, Steve's patch works for me, sorry for the false alarm.

> > > /bin/sh ignores Enter (or ^J, or ^M).
> >
> > Good find.  I've attached a diff that should fix this.  Unsure
> > how to proceed since the original patch hasn't been applied.
> > Do I resubmit the original patch or treat this one as it's own
> > thing?
>
> Thanks, I'll try it out and let you know if it works for me.

This also works.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"Water molecules expand as they grow warmer" (C) Popular Science, Oct'02, p.51


