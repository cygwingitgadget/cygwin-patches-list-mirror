Return-Path: <cygwin-patches-return-7368-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11012 invoked by alias); 17 May 2011 05:59:37 -0000
Received: (qmail 10870 invoked by uid 22791); 17 May 2011 05:59:16 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 17 May 2011 05:59:01 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 59BAE2C02D5; Tue, 17 May 2011 07:58:58 +0200 (CEST)
Date: Tue, 17 May 2011 05:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] CPU-time clocks
Message-ID: <20110517055858.GA9013@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1305484641.6124.31.camel@YAAKOV04> <20110515191123.GC21667@calimero.vinschen.de> <1305487887.6000.1.camel@YAAKOV04> <20110516104304.GA5248@calimero.vinschen.de> <1305587458.4248.3.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1305587458.4248.3.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00134.txt.bz2

On May 16 18:10, Yaakov (Cygwin/X) wrote:
> On Mon, 2011-05-16 at 12:43 +0200, Corinna Vinschen wrote:
> > Thanks for this patch.  It looks good to me with two exceptions:
> > [...]
> Revised patch attached.

Thank you.  You can apply it, but while I was looking into it,
this occured to me:

> +      FILETIME creation_time, exit_time, kernel_time, user_time;
> +      long long x;
> +      [...]
> +      GetProcessTimes (hProcess, &creation_time, &exit_time, &kernel_time,
> +                       &user_time);
> +
> +      x = ((long long) kernel_time.dwHighDateTime << 32)
> +          + ((unsigned) kernel_time.dwLowDateTime)
> +          + ((long long) user_time.dwHighDateTime << 32)
> +          + ((unsigned) user_time.dwLowDateTime);
> +      tp->tv_sec = x / (long long) NSPERSEC;
> +      tp->tv_nsec = (x % (long long) NSPERSEC) * 100LL;

This conversion arithmetic from FILETIME to long long happens a lot
in times.cc, even though it's absolutely not necessary.

The FILETIME struct is actually a LARGE_INTEGER in which just the
QuadPart member is missing, unfortunately.  What we can do is to
replace the bit shifting stuff with a simple cast:

  x = ((PLARGE_INTEGER) &kernel_time)->QuadPart
      + ((PLARGE_INTEGER) &user_time)->QuadPart;

Alternatively we can define kernel_time etc as LARGE_INTEGER and cast in
the call to GetProcessTimes or just call NtQueryInformationProcess.

What do you think?  If you don't care, just apply your patch as is.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
