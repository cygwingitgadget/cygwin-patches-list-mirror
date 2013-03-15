Return-Path: <cygwin-patches-return-7853-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12130 invoked by alias); 15 Mar 2013 21:56:47 -0000
Received: (qmail 12118 invoked by uid 22791); 15 Mar 2013 21:56:46 -0000
X-SWARE-Spam-Status: No, hits=-5.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_SPAMHAUS_DROP,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 15 Mar 2013 21:56:41 +0000
Received: by mail-ie0-f171.google.com with SMTP id 10so5015047ied.2        for <cygwin-patches@cygwin.com>; Fri, 15 Mar 2013 14:56:41 -0700 (PDT)
X-Received: by 10.50.11.138 with SMTP id q10mr2426249igb.5.1363384601182;        Fri, 15 Mar 2013 14:56:41 -0700 (PDT)
Received: from YAAKOV04 (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id ur12sm388915igb.8.2013.03.15.14.56.39        (version=SSLv3 cipher=RC4-SHA bits=128/128);        Fri, 15 Mar 2013 14:56:40 -0700 (PDT)
Date: Fri, 15 Mar 2013 21:56:00 -0000
From: Yaakov (Cygwin/X) <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Fix ONDEE for 64bit
Message-ID: <20130315165640.14bdcb71@YAAKOV04>
In-Reply-To: <20130315102655.GD1360@calimero.vinschen.de>
References: <20130304105134.GF5468@calimero.vinschen.de>	<20130304053936.49484e71@YAAKOV04>	<20130304131539.GE2481@calimero.vinschen.de>	<20130304144022.GI2481@calimero.vinschen.de>	<20130305000934.66f77aba@YAAKOV04>	<20130305084950.GB16361@calimero.vinschen.de>	<20130305031430.5ff522eb@YAAKOV04>	<20130305093009.GD16361@calimero.vinschen.de>	<20130305093850.GE16361@calimero.vinschen.de>	<20130315051819.2ce99a0b@YAAKOV04>	<20130315102655.GD1360@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00064.txt.bz2

On Fri, 15 Mar 2013 11:26:55 +0100, Corinna Vinschen wrote:
> ftp://ftp.cygwin.com/pub/cygwin/64bit/x86_64-pc-cygwin-gcc-20130305.patch
> 
> I didn't change anything in the toolchain since then.

This hunk doesn't look right (gcc/config/i386/i386.c):

>        if (TARGET_64BIT && DEFAULT_ABI == MS_ABI)
> -       ix86_cmodel = CM_SMALL_PIC, flag_pic = 1;
> +#ifdef TARGET_CYGWIN64
> +       ix86_cmodel = CM_MEDIUM_PIC, flag_pic = 1;
> +#else
> +       ix86_cmodel = CM_MEDIUM_PIC, flag_pic = 1;
> +#endif

It doesn't affect us right now, but this needs to be fixed before
pushing upstream.

Also, in libstdc++-v3/crossconfig.m4:

> +  *-cygwin*)
> +    GLIBCXX_CHECK_COMPILER_FEATURES
> +    GLIBCXX_CHECK_LINKER_FEATURES
> +    GLIBCXX_CHECK_MATH_SUPPORT
> +    GLIBCXX_CHECK_STDLIB_SUPPORT
> +    ;;

I think cygwin should be added to the preceding linux|gnu|k*bsd-gnu
case, as we also have /dev/random, pthreads, and iconv.

BTW, the good news is that I was able to build cygwin-64bit-branch and
gcc (3-stage bootstrap with C/C++) natively on x86_64, albeit with
-j1, so we're officially at the point of self-hosting.  Hopefully your
latest patches will fix parallel make, but that will have to wait until
next week.


Yaakov
