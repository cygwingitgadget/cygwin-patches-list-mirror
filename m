Return-Path: <cygwin-patches-return-5598-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2047 invoked by alias); 1 Aug 2005 16:50:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1978 invoked by uid 22791); 1 Aug 2005 16:50:51 -0000
Received: from p54941846.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.24.70)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 01 Aug 2005 16:50:51 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 8A73B6D4256; Mon,  1 Aug 2005 18:50:48 +0200 (CEST)
Date: Mon, 01 Aug 2005 16:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix possible segfault creating detached thread
Message-ID: <20050801165048.GJ14783@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.LNX.4.61.0507311501560.1072@mgorse.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0507311501560.1072@mgorse.dhs.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00053.txt.bz2

On Jul 31 15:17, Mike Gorse wrote:
> This patch fixes a seg fault when a thread is created in a detached state 
> and terminates the first time it is scheduled.  pthread::create (the 
> four-parameter version) calls the three-parameter pthread::create function 
> which unlocks the mutex, allowing the called thread to be scheduled, then 
> exits at which point the outer create function calls is_good_objectg(), 
> but this causes a core dump if pthread::exit() has already been called and 
> deleted the pthread object.

Thanks for the patch.  First, please let me point you to
http://cygwin.com/contrib.html.  The important information here is that
you'll need to fill out a copyright assignment form and snail mail it
to Red Hat if you want to get in patches.  The only exception are 
insignificant patches in terms of changed lines of code.  The usual rule of
thumb here is not more than 10 lines.  Well, your patch only changes
roughly 12 lines, so I'd let slip it in.

However, there are three tiny problems:

> 2005-07-31 Michael Gorse <mgorse@alum.wpi.edu>
> 
>         * thread.cc (pthread::create): Make bool.
>         * thread.cc (pthread_null::create): Ditto.

Wrong ChangeLog entry format.  Don't repeat the name of the file for each
change.  Compare with the current ChangeLog file.  And don't add an empty
line for each changed file, unless the changes are unrelated.

>         * thread.h: Ditto.
> 
>         * pthread.cc (pthread_create): Check return of inner create rather
>         than calling is_good_object().

This entry definitely doesn't match your below patch.  Is there really
any change in pthread.cc and did you forget to send it or is that rather
a typo and you meant to note the change to pthread::create(3 args) in
thread.cc?

> Index: thread.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
> retrieving revision 1.190
> diff -u -p -r1.190 thread.cc
> --- thread.cc	6 Jul 2005 20:05:03 -0000	1.190
> +++ thread.cc	31 Jul 2005 02:13:14 -0000
> @@ -491,13 +491,15 @@ pthread::precreate (pthread_attr *newatt
>      magic = 0;
>  }
> 
> -void
> +bool
>  pthread::create (void *(*func) (void *), pthread_attr *newattr,
>  		 void *threadarg)
>  {
> +  bool retval;
> +
>    precreate (newattr);
>    if (!magic)
> -    return;
> +    return false;
> 
>    function = func;
>    arg = threadarg;
> @@ -517,7 +519,9 @@ pthread::create (void *(*func) (void *),
>        while (!cygtls)
>  	low_priority_sleep (0);
>      }
> +  retval =magic;

Please add a space after the '='.  Looks good otherwise.


Thanks in advance,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
