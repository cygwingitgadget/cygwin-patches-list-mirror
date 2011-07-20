Return-Path: <cygwin-patches-return-7436-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28242 invoked by alias); 20 Jul 2011 07:57:40 -0000
Received: (qmail 28197 invoked by uid 22791); 20 Jul 2011 07:57:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 20 Jul 2011 07:56:57 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 795342CA505; Wed, 20 Jul 2011 09:56:54 +0200 (CEST)
Date: Wed, 20 Jul 2011 07:57:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2)
Message-ID: <20110720075654.GA3667@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1311126880.7796.9.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1311126880.7796.9.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00012.txt.bz2

Hi Yaakov,

On Jul 19 20:54, Yaakov (Cygwin/X) wrote:
> This patchset implements the POSIX clock_nanosleep(2) function:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_nanosleep.html
> http://www.kernel.org/doc/man-pages/online/pages/man2/clock_nanosleep.2.html
> 
> In summary, clock_nanosleep(2) replaces nanosleep(2) as the primary
> sleeping function, with all others rewritten in terms of the former.  It
> also restores maximum precision to hires_ms::resolution(), saving the
> <5000 100ns check for the one place where resolution is rounded off.

I like this, it's probably not only faster but it makes the code better
readable.  But let's talk about the newlib side first.

> Index: libc/include/time.h
> ===================================================================
> RCS file: /cvs/src/src/newlib/libc/include/time.h,v
> retrieving revision 1.19
> diff -u -r1.19 time.h
> --- libc/include/time.h	16 Oct 2008 21:53:58 -0000	1.19
> +++ libc/include/time.h	15 May 2011 19:22:48 -0000
> @@ -168,6 +168,9 @@
>  
>  /* High Resolution Sleep, P1003.1b-1993, p. 269 */
>  
> +int _EXFUN(clock_nanosleep,
> +  (clockid_t clock_id, int flags, const struct timespec *rqtp,
> +   struct timespec *rmtp));
>  int _EXFUN(nanosleep, (const struct timespec  *rqtp, struct timespec *rmtp));
>  
>  #ifdef __cplusplus

This doesn't look right.  In contrast to nanosleep, clock_nanosleep
is not subsumed under the _POSIX_TIMERS option.  In fact it's the only
function under the _POSIX_CLOCK_SELECTION option.  So clock_nanosleep
should be guarded independently of _POSIX_TIMERS, kind of like this:

 #if defined(_POSIX_CLOCK_SELECTION)
 extern "C" {
   int _EXFUN(clock_nanosleep, ...

Additionally _POSIX_CLOCK_SELECTION has to be activated in features.h.

Would you mind to send this patch to the newlib list then?

I haven't much time right now.  If cgf doesn't beat me to it, I'll
review the function later.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
