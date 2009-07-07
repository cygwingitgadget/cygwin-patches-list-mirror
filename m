Return-Path: <cygwin-patches-return-6566-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 14050 invoked by alias); 7 Jul 2009 23:59:21 -0000
Received: (qmail 14040 invoked by uid 22791); 7 Jul 2009 23:59:20 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=AWL,BAYES_00,SARE_URI_CONS7,SPF_PASS,URI_NOVOWEL
X-Spam-Check-By: sourceware.org
Received: from mail-ew0-f213.google.com (HELO mail-ew0-f213.google.com) (209.85.219.213)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 07 Jul 2009 23:59:15 +0000
Received: by ewy9 with SMTP id 9so5825798ewy.2         for <cygwin-patches@cygwin.com>; Tue, 07 Jul 2009 16:59:12 -0700 (PDT)
Received: by 10.210.86.1 with SMTP id j1mr7873935ebb.27.1247011151541;         Tue, 07 Jul 2009 16:59:11 -0700 (PDT)
Received: from ?192.168.2.99? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id 5sm594661eyh.20.2009.07.07.16.59.10         (version=SSLv3 cipher=RC4-MD5);         Tue, 07 Jul 2009 16:59:11 -0700 (PDT)
Message-ID: <4A53E449.4020504@gmail.com>
Date: Tue, 07 Jul 2009 23:59:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: Dave Korn <dave.korn.cygwin@googlemail.com>
CC: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Re: 1.7 winbase.h (ilockcmpexch) compile error
References: <Pine.CYG.4.58.0906241239470.2248@PC1163-8460-XP.flightsafety.com> <4A53BC5D.7010401@gmail.com>
In-Reply-To: <4A53BC5D.7010401@gmail.com>
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
X-SW-Source: 2009-q3/txt/msg00020.txt.bz2

Dave Korn wrote:

>   It doesn't do anything about the reload failure, which is a bug in GCC-3,
> since the usage is a standard usage supported by the documentation.  It's
> possible that it may disappear as a side-effect, in which case all the better.

  Nope, no such luck.

  Also, the libstdc++ patch has really done for compiling it with gcc-3, which
doesn't support the weak attribute.  It also has a bug that for some reason
two of the wrapper functions in libstdcxx_malloc.cc are emitted under their
real names, rather than the asm("__real__*") name specified.  There's also the
inline asm bug and there's a number of other warnings about type conversions.

  All of these could in theory be worked around.  We could compile the files
using the inline asm with -O0, and fix the type conversion warnings(*), and we
would have to work around the lack of support for weaks in the compiler by
providing the definition of the __cygwin_cxx_malloc struct in assembler
source, and probably the same for the wrapper function names, but I'm not
inclined to do so unless there's serious demand for it.

    cheers,
      DaveK
-- 
(*) - actually, I'll send patches for those anyway.
