Return-Path: <cygwin-patches-return-7324-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26602 invoked by alias); 9 May 2011 08:16:52 -0000
Received: (qmail 26505 invoked by uid 22791); 9 May 2011 08:16:25 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 09 May 2011 08:16:10 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0393D2C0578; Mon,  9 May 2011 10:16:07 +0200 (CEST)
Date: Mon, 09 May 2011 08:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_settime
Message-ID: <20110509081607.GC2948@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BANLkTikgd2eKVtG2gVTktwB8zbwn=9awtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BANLkTikgd2eKVtG2gVTktwB8zbwn=9awtg@mail.gmail.com>
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
X-SW-Source: 2011-q2/txt/msg00090.txt.bz2

Hi Yaakov,

On May  8 17:48, Yaakov (Cygwin/X) wrote:
> This implements the POSIX clock_settime function, on top of settimeofday:
> 
> http://pubs.opengroup.org/onlinepubs/9699919799/functions/clock_settime.html
> http://www.kernel.org/doc/man-pages/online/pages/man3/clock_gettime.3.html
> http://www.kernel.org/doc/man-pages/online/pages/man2/settimeofday.2.html
> 
> The fixes to settimeofday are necessary both to match BSD and Linux behaviour,
> and to provide the errnos and return status for clock_settime required by POSIX.
> I also fixed posix.sgml WRT clock_setres.
> 
> Patches for winsup/cygwin and winsup/doc, plus test programs for both
> functions, attached.

Thanks for the patch.

> Index: times.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
> retrieving revision 1.107
> diff -u -r1.107 times.cc
> --- times.cc	2 May 2011 15:28:35 -0000	1.107
> +++ times.cc	8 May 2011 17:55:34 -0000
> @@ -111,6 +111,12 @@
>  
>    tz = tz;			/* silence warning about unused variable */
>  
> +  if (tv->tv_usec < 0 || tv->tv_usec >= 1000000)

Not your fault, but what I'm missing in settimeofday is an EFAULT handler.
Could you please add one, just like in the times() function a couple of
lines earlier?  The `tz = tz;' line can go away, the usage is covered
by the syscall_printf at the end of the function.

Other than that, please apply.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
