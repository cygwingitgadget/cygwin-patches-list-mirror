Return-Path: <cygwin-patches-return-7564-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16266 invoked by alias); 13 Dec 2011 11:40:44 -0000
Received: (qmail 16205 invoked by uid 22791); 13 Dec 2011 11:40:24 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 13 Dec 2011 11:40:08 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 719EB2C01F7; Tue, 13 Dec 2011 12:40:05 +0100 (CET)
Date: Tue, 13 Dec 2011 11:40:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch,1.7.10] clock_setres returns zero
Message-ID: <20111213114005.GI6320@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4EE686D5.3080905@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4EE686D5.3080905@gmail.com>
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
X-SW-Source: 2011-q4/txt/msg00054.txt.bz2

On Dec 12 22:57, Dave Korn wrote:
>   This happens because on my PC, QueryPerformanceFrequency returns 2511600000,
> so the following code in times.cc#hires_ns::prime()

Wow.  I can reproduce this on my 2K3R2 64 bit system on which
QueryPerformanceFrequency returns 2601000000.

> 	* times.cc (hires_ns::resolution): Don't return less than 1.

> Index: winsup/cygwin/times.cc
> ===================================================================
> RCS file: /cvs/src/src/winsup/cygwin/times.cc,v
> retrieving revision 1.112
> diff -p -u -r1.112 times.cc
> --- winsup/cygwin/times.cc	3 Dec 2011 21:43:27 -0000	1.112
> +++ winsup/cygwin/times.cc	12 Dec 2011 08:23:20 -0000
> @@ -718,7 +718,7 @@ hires_ns::resolution ()
>        return (long long) -1;
>      }
>  
> -  return (LONGLONG) freq;
> +  return (freq <= 1.0) ? 1ll : (LONGLONG) freq;
>  }
>  
>  UINT


Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
