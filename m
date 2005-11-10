Return-Path: <cygwin-patches-return-5675-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13322 invoked by alias); 10 Nov 2005 09:12:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13303 invoked by uid 22791); 10 Nov 2005 09:12:36 -0000
Received: from mail-n.franken.de (HELO ilsa.franken.de) (193.175.24.27)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Thu, 10 Nov 2005 09:12:36 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])
	by ilsa.franken.de (Postfix) with ESMTP id 99CE9245D4
	for <cygwin-patches@cygwin.com>; Thu, 10 Nov 2005 10:12:33 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])
	by aqua.hirmke.de (Postfix) with ESMTP id 09FE1AAFF8
	for <cygwin-patches@cygwin.com>; Thu, 10 Nov 2005 10:12:33 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id DCCDA544001; Thu, 10 Nov 2005 10:12:32 +0100 (CET)
Date: Thu, 10 Nov 2005 09:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Patch to fix defined but undeclared sigrelse() function.
Message-ID: <20051110091232.GA4864@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4372BDD6.6060109@pacom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4372BDD6.6060109@pacom.com>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q4/txt/msg00017.txt.bz2

On Nov 10 14:26, Scott Finneran wrote:
> Hello,
> 
> Below is a single line patch to fix what I assume is an issue with 
> sigrelse(). The function is correctly defined in 
> winsup/src/cygwin/exceptions.cc. However, the function is not declared 
> in signal.h.
> 
> Of course I don't know the history of support for this function within 
> cygwin other than the fact that it was added recently. As such, I am 
> assuming that this missing declaration is indeed a bug and not a way of 
> preventing people from using the function at this time.
> 
> Any feedback would be appreciated.

You're right, sigrelse is defined and exported from the DLL, just the
prototype is missing.  What's missing is just a ChangeLog entry, but
for this simple case, I added one myself:

	* include/cygwin/signal.h: Add missing sigrelse prototype.

> Index: cygwin/include/cygwin/signal.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/signal.h,v
> retrieving revision 1.7
> diff -u -p -r1.7 signal.h
> --- cygwin/include/cygwin/signal.h	28 Sep 2005 22:56:47 -0000	1.7
> +++ cygwin/include/cygwin/signal.h	10 Nov 2005 03:13:44 -0000
> @@ -222,6 +222,7 @@ struct sigaction
>  int sigwait (const sigset_t *, int *);
>  int sigwaitinfo (const sigset_t *, siginfo_t *);
>  int sighold (int);
> +int sigrelse (int);
>  int sigqueue(pid_t, int, const union sigval);
>  int siginterrupt (int, int);
>  #ifdef __cplusplus


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat, Inc.
