Return-Path: <cygwin-patches-return-6678-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13666 invoked by alias); 3 Oct 2009 13:50:07 -0000
Received: (qmail 13653 invoked by uid 22791); 3 Oct 2009 13:50:06 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f218.google.com (HELO mail-ew0-f218.google.com) (209.85.219.218)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 03 Oct 2009 13:49:58 +0000
Received: by ewy18 with SMTP id 18so1921492ewy.43         for <cygwin-patches@cygwin.com>; Sat, 03 Oct 2009 06:49:56 -0700 (PDT)
Received: by 10.211.147.12 with SMTP id z12mr4574636ebn.37.1254577796594;         Sat, 03 Oct 2009 06:49:56 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 7sm260564eyb.13.2009.10.03.06.49.55         (version=SSLv3 cipher=RC4-MD5);         Sat, 03 Oct 2009 06:49:55 -0700 (PDT)
Message-ID: <4AC759F0.4000209@gmail.com>
Date: Sat, 03 Oct 2009 13:50:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] Update build flags for new compiler feature
References: <4AC66C72.7070102@gmail.com> <20091002221933.GB12372@ednor.casa.cgf.cx> <20091003120854.GA22019@calimero.vinschen.de> <4AC74BB5.9060503@gmail.com> <20091003130644.GJ7193@calimero.vinschen.de> <4AC75235.1070403@gmail.com> <20091003133135.GB32613@calimero.vinschen.de>
In-Reply-To: <20091003133135.GB32613@calimero.vinschen.de>
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
X-SW-Source: 2009-q4/txt/msg00009.txt.bz2

Corinna Vinschen wrote:

>>   I'll start building 4.3.4-2 on Monday.  Busy this weekend.
> 
> 'k.  However, if you could give me the required expression, I'll add it
> to my cross gcc today :)

  Just add it to LINK_SPEC, making sure it's at the top level rather than
inside any of the nested braces, e.g.:

> #define LINK_SPEC "\
>   %{mwindows:--subsystem windows} \
>   %{mconsole:--subsystem console} \
    -tsaware \
>   " CXX_WRAP_SPEC " \
>   %{shared: %{mdll: %eshared and mdll are not compatible}} \
>   %{shared: --shared} %{mdll:--dll} \
>   %{static:-Bstatic} %{!static:-Bdynamic} \
>   %{shared|mdll: -e \
>     %{mno-cygwin:_DllMainCRTStartup@12 --enable-auto-image-base} \
>     %{!mno-cygwin:__cygwin_dll_entry@12 --enable-auto-image-base}}\
>   %{!mno-cygwin:--dll-search-prefix=cyg}\
>   %(shared_libgcc_undefs)"

> Oh, another question.  When unpacking your package, there's a file called
> CYGWIN-PATCHES/pr38579.missing.diff.  The patch in that file hasn't been
> applied to the sources.  Should it?

  Yep, I stashed it away there because I forgot to put it in the build.  It's
the fix for a problem someone reported on the main list.

    cheers,
      DaveK
