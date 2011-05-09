Return-Path: <cygwin-patches-return-7323-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20312 invoked by alias); 9 May 2011 07:55:56 -0000
Received: (qmail 20255 invoked by uid 22791); 9 May 2011 07:55:35 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 09 May 2011 07:55:18 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AB7DA2C0578; Mon,  9 May 2011 09:55:14 +0200 (CEST)
Date: Mon, 09 May 2011 07:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix /proc/meminfo and /proc/swaps for >4GB
Message-ID: <20110509075514.GB2948@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304708638.5504.5.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1304708638.5504.5.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00089.txt.bz2

Hi Yaakov,

On May  6 14:03, Yaakov (Cygwin/X) wrote:
> As promised, this patch ports the /proc/meminfo code to use sysinfo(2),
> and fixes the case where RAM or swap space totals more than 4GB.  It
> also fixes the /proc/swaps code for paging files larger than 4GB.
> 
> For example:
> 
> $ cat /proc/meminfo
>             total:         used:         free:
> Mem:     4293058560    1828151296    2464907264
> Swap:   12884901888      14680064   12870221824
> MemTotal:        4192440 kB
> MemFree:         2407136 kB
> MemShared:             0 kB
> HighTotal:             0 kB
> HighFree:              0 kB
> LowTotal:        4192440 kB
> LowFree:         2407136 kB
> SwapTotal:      12582912 kB
> SwapFree:       12568576 kB

I'm not sure I understand this new format.  Why do you keep the Mem: and
Swap: lines?  Linux doesn't have them and top appears to work without
them.  And then, why do you print MemShared, HighTotal, and HighFree,
even though they are always 0, but not all the other ~40 lines Linux'
meminfo has, too?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
