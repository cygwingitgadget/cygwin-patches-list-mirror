Return-Path: <cygwin-patches-return-6461-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18267 invoked by alias); 3 Apr 2009 07:05:54 -0000
Received: (qmail 17979 invoked by uid 22791); 3 Apr 2009 07:05:52 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f176.google.com (HELO mail-fx0-f176.google.com) (209.85.220.176)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 03 Apr 2009 07:05:46 +0000
Received: by fxm24 with SMTP id 24so915288fxm.2         for <cygwin-patches@cygwin.com>; Fri, 03 Apr 2009 00:05:43 -0700 (PDT)
Received: by 10.86.65.9 with SMTP id n9mr705407fga.61.1238742343148;         Fri, 03 Apr 2009 00:05:43 -0700 (PDT)
Received: from ?82.6.108.62? (cpc2-cmbg8-0-0-cust61.cmbg.cable.ntl.com [82.6.108.62])         by mx.google.com with ESMTPS id d4sm3537176fga.3.2009.04.03.00.05.42         (version=SSLv3 cipher=RC4-MD5);         Fri, 03 Apr 2009 00:05:42 -0700 (PDT)
Message-ID: <49D5B44F.7030509@gmail.com>
Date: Fri, 03 Apr 2009 07:05:00 -0000
From: Dave Korn <dave.korn.cygwin@googlemail.com>
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] <asm/byteorder.h> missing prototypes warning
References: <49D57E45.4000409@users.sourceforge.net>
In-Reply-To: <49D57E45.4000409@users.sourceforge.net>
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
X-SW-Source: 2009-q2/txt/msg00003.txt.bz2

Yaakov (Cygwin/X) wrote:

> This is similar in concept to the <stdio.h> patch I just posted to
> newlib@.  It looks like I mistakenly removed the prototypes when I was
> trying to fix the C99 inline issue in <asm/byteorder.h>.
> 
> Since this makes four lines which need the C99 inline workaround, I
> decided to make a macro similar to that in <stdio.h>.  I didn't use the
> same macro name, since I didn't want to deal with a possible collision
> with, or dependency on, <stdio.h>.  Perhaps there is a better way of
> dealing with this; I'm certainly open to ideas.

  I'll suggest upstream that since this macro trick is going to spread
increasingly to more and more header files, maybe we should actually provide a
predefined preprocessor macro for it.  If it's acceptable, I'll backport
support to the cygwin distro version.

  Maybe we can call it __extern__ (so it looks like a c99-compatible extension
keyword and doesn't cause problems for non-GCC compilers) and define it as
"'extern' if !__GNUC_STDC_INLINE__".  That might work well.

    cheers,
      DaveK

