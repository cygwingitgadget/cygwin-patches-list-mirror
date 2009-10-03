Return-Path: <cygwin-patches-return-6674-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 621 invoked by alias); 3 Oct 2009 13:17:07 -0000
Received: (qmail 607 invoked by uid 22791); 3 Oct 2009 13:17:06 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 13:17:00 +0000
Received: by ewy18 with SMTP id 18so1908441ewy.43         for <cygwin-patches@cygwin.com>; Sat, 03 Oct 2009 06:16:58 -0700 (PDT)
Received: by 10.211.142.11 with SMTP id u11mr4706182ebn.8.1254575817954;         Sat, 03 Oct 2009 06:16:57 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 10sm2128070eyz.42.2009.10.03.06.16.57         (version=SSLv3 cipher=RC4-MD5);         Sat, 03 Oct 2009 06:16:57 -0700 (PDT)
Message-ID: <4AC75235.1070403@gmail.com>
Date: Sat, 03 Oct 2009 13:17:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de>
In-Reply-To: <20091003130644.GJ7193@calimero.vinschen.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00005.txt.bz2

Corinna Vinschen wrote:

> Btw., I also had to set --disable-__cxa_atexit in contrast to your
> --enable-__cxa_atexit.  If I don't do that, I get undefined reference
> errors (some dso_foo and cxa_foo functions) when building libstdc++.

  Yes, that's just a dumbass typo on my part.  I meant to fix it a version or
two ago but it slipped my mind and I didn't remember because it gets
suppressed somehow on a native build.

> Apparently.  There's no line containing __wrap__Znaj in config.log.

  Yeh, that proves I'm using the wrong sort of autoconf test.  Argh, thanks
for finding that out for me.

>> "-DUSE_CYGWIN_LIBSTDCXX_WRAPPERS=1" into the CFLAGS.  Meanwhile, I need to go
> 
> Thanks, I'll try that.

  That really ought to work.  Let me know if it does; I'm still holding back
on committing that patch to the flags.

> While you're at it, there is another problem.  When building gcc-4.3.4
> as cross, the auto-host.h file contains
> 
>   #ifndef USED_FOR_TARGET
>   /* #undef HAVE_GAS_ALIGNED_COMM */
>   #endif
> 
> afterwards.  That's quite unlucky, since options.c contains an
> unconditional
> 
>   int use_pe_aligned_common = HAVE_GAS_ALIGNED_COMM;
> 
> So, right now I had to define HAVE_GAS_ALIGNED_COMM to 1 manually in
> auto-host.h.

  *headdesk*  Right, one more for the to-do list, thanks for finding it.

> And, while we're at it, how do I switch on the TSAWARE flag by default?

  I'm planning to add it to LINK_SPEC in gcc/config/i386/cygwin.h.

  I'll start building 4.3.4-2 on Monday.  Busy this weekend.

    cheers,
      DaveK
