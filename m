Return-Path: <cygwin-patches-return-7315-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1730 invoked by alias); 6 May 2011 08:12:39 -0000
Received: (qmail 1568 invoked by uid 22791); 6 May 2011 08:11:51 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 06 May 2011 08:11:17 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 9E5B02C0578; Fri,  6 May 2011 10:11:14 +0200 (CEST)
Date: Fri, 06 May 2011 08:12:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] sysinfo
Message-ID: <20110506081114.GH8245@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304658552.5468.7.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1304658552.5468.7.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00081.txt.bz2

On May  6 00:09, Yaakov (Cygwin/X) wrote:
> This implements sysinfo(2), a GNU extension:
> 
> http://www.kernel.org/doc/man-pages/online/pages/man2/sysinfo.2.html
> 
> The code is partially based on our /proc/meminfo and /proc/uptime code.
> (My next patch will port the former to use sysinfo(2), but the latter
> cannot as it uses .01s resolution, more than sysinfo's 1s.  That patch
> will also fix /proc/meminfo and /proc/swaps for RAM and paging files
> larger than 4GB.)
> 
> Patches for winsup/cygwin and winsup/doc, plus a test program, attached.
> 
> 
> Yaakov
> 

> 2011-05-05  Yaakov Selkowitz  <yselkowitz@...>
> 
> 	* sysconf.cc (sysinfo): New function.
> 	* cygwin.din (sysinfo): Export.
> 	* posix.sgml (std-gnu): Add sysinfo.
> 	* include/sys/sysinfo.h (struct sysinfo): Define.
> 	(sysinfo): Declare.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

That looks good to me.  Just a question...

> +  /* FIXME: unsupported */
> +  info->loads[0] = 0UL;
> +  info->loads[1] = 0UL;
> +  info->loads[2] = 0UL;
> +  info->sharedram = 0UL;
> +  info->bufferram = 0UL;

Isn't bufferram the sum of paged and non-paged pool?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
