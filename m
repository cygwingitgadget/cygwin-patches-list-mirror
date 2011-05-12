Return-Path: <cygwin-patches-return-7344-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18641 invoked by alias); 12 May 2011 03:58:32 -0000
Received: (qmail 18626 invoked by uid 22791); 12 May 2011 03:58:32 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 May 2011 03:58:17 +0000
Received: by yie16 with SMTP id 16so527159yie.2        for <cygwin-patches@cygwin.com>; Wed, 11 May 2011 20:58:17 -0700 (PDT)
Received: by 10.236.110.176 with SMTP id u36mr11312488yhg.360.1305172697132;        Wed, 11 May 2011 20:58:17 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id h35sm440760yhm.42.2011.05.11.20.58.15        (version=SSLv3 cipher=OTHER);        Wed, 11 May 2011 20:58:16 -0700 (PDT)
Subject: Re: [PATCH] Fix /proc/meminfo and /proc/swaps for >4GB
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 12 May 2011 03:58:00 -0000
In-Reply-To: <20110509075514.GB2948@calimero.vinschen.de>
References: <1304708638.5504.5.camel@YAAKOV04>	 <20110509075514.GB2948@calimero.vinschen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Message-ID: <1305172698.4700.0.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00110.txt.bz2

On Mon, 2011-05-09 at 09:55 +0200, Corinna Vinschen wrote:
> I'm not sure I understand this new format.  Why do you keep the Mem: and
> Swap: lines?  Linux doesn't have them and top appears to work without
> them.  And then, why do you print MemShared, HighTotal, and HighFree,
> even though they are always 0, but not all the other ~40 lines Linux'
> meminfo has, too?

Actually, my patch makes no attempt to change the actual format
of /proc/meminfo; it changes only what is necessary to handle RAM or
swap larger than 4GB by using ULLs instead of ULs.

As for modernizing/fixing the format, true, the Mem: and Swap: lines do
not exist in modern Linux, nor does the MemShared: line.  I would like
to actually define at least HighTotal and HighFree; I'll try to look
into that further soon.  As for the rest of Linux's /proc/meminfo, I'll
have to see how many other lines can be reasonably determined (if they
would exist at all) on Windows.

So with the ULL changes, if I remove the Mem, Swap, and MemShared lines,
will that do for now?


Yaakov

