Return-Path: <cygwin-patches-return-7366-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8524 invoked by alias); 16 May 2011 10:43:53 -0000
Received: (qmail 8434 invoked by uid 22791); 16 May 2011 10:43:27 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 16 May 2011 10:43:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 5F94D2C00B8; Mon, 16 May 2011 12:43:04 +0200 (CEST)
Date: Mon, 16 May 2011 10:43:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] CPU-time clocks
Message-ID: <20110516104304.GA5248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1305484641.6124.31.camel@YAAKOV04> <20110515191123.GC21667@calimero.vinschen.de> <1305487887.6000.1.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1305487887.6000.1.camel@YAAKOV04>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00132.txt.bz2

Hi Yaakov,

On May 15 14:31, Yaakov (Cygwin/X) wrote:
> On Sun, 2011-05-15 at 21:11 +0200, Corinna Vinschen wrote:
> > I just applied a patch to implement pthread_attr_setstack etc.
> 
> Yes, I just saw that, thank you.
> 
> > This affects your patch in that it won't apply cleanly anymore.
> > Would you mind to regenerate your patches relative to CVS HEAD?
> 
> Attached.

Thanks for this patch.  It looks good to me with two exceptions:

>  extern "C" int
>  clock_gettime (clockid_t clk_id, struct timespec *tp)
>  {
> [...]
> +      hProcess = OpenProcess (PROCESS_QUERY_INFORMATION, 0, p->dwProcessId);
> +      GetProcessTimes (hProcess, &creation_time, &exit_time, &kernel_time, &user_time);
> +
> +      x = ((long long) kernel_time.dwHighDateTime << 32) + ((unsigned) kernel_time.dwLowDateTime)
> +          + ((long long) user_time.dwHighDateTime << 32) + ((unsigned) user_time.dwLowDateTime);

Can you please collapse these lines into 80 columns?

> [...]
> +      GetThreadTimes (hThread, &creation_time, &exit_time, &kernel_time, &user_time);
> +      x = ((long long) kernel_time.dwHighDateTime << 32) + ((unsigned) kernel_time.dwLowDateTime)
> +          + ((long long) user_time.dwHighDateTime << 32) + ((unsigned) user_time.dwLowDateTime);

Ditto.

> Index: winsup.h
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/winsup.h,v
> retrieving revision 1.235
> diff -u -r1.235 winsup.h
> --- winsup.h	19 Apr 2011 10:02:06 -0000	1.235
> +++ winsup.h	15 May 2011 19:24:12 -0000
> @@ -220,6 +220,13 @@
>  void *hook_or_detect_cygwin (const char *, const void *, WORD&) __attribute__ ((regparm (3)));
>  
>  /* Time related */
> +#define PID_TO_CLOCKID(pid) (pid * 8 + CLOCK_PROCESS_CPUTIME_ID)
> +#define CLOCKID_TO_PID(cid) ((cid - CLOCK_PROCESS_CPUTIME_ID) / 8)
> +#define CLOCKID_IS_PROCESS(cid) ((cid % 8) == CLOCK_PROCESS_CPUTIME_ID)
> +#define THREADID_TO_CLOCKID(tid) (tid * 8 + CLOCK_THREAD_CPUTIME_ID)
> +#define CLOCKID_TO_THREADID(cid) ((cid - CLOCK_THREAD_CPUTIME_ID) / 8)
> +#define CLOCKID_IS_THREAD(cid) ((cid % 8) == CLOCK_THREAD_CPUTIME_ID)
> +

I think these definitions should go into hires.h.  That's the nearest
thing to a time-specific header file we have.

As for the newlib thingy, I follow up on the newlib list.


Thanks,
Corinna
