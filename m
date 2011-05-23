Return-Path: <cygwin-patches-return-7392-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8142 invoked by alias); 23 May 2011 20:52:50 -0000
Received: (qmail 8132 invoked by uid 22791); 23 May 2011 20:52:49 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm9.bullet.mail.sp2.yahoo.com (HELO nm9.bullet.mail.sp2.yahoo.com) (98.139.91.79)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 23 May 2011 20:52:35 +0000
Received: from [98.139.91.63] by nm9.bullet.mail.sp2.yahoo.com with NNFMP; 23 May 2011 20:52:34 -0000
Received: from [98.136.185.41] by tm3.bullet.mail.sp2.yahoo.com with NNFMP; 23 May 2011 20:52:34 -0000
Received: from [127.0.0.1] by smtp102.mail.gq1.yahoo.com with NNFMP; 23 May 2011 20:52:34 -0000
Received: from cgf.cx (cgf@173.48.46.160 with login)        by smtp102.mail.gq1.yahoo.com with SMTP; 23 May 2011 13:52:33 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 79C8D42804D	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 16:52:32 -0400 (EDT)
Date: Mon, 23 May 2011 20:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: __xpg_strerror_r should not clobber strerror buffer
Message-ID: <20110523205232.GA7573@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4DD8664D.2000407@redhat.com> <20110522013514.GA16516@ednor.casa.cgf.cx> <4DDAC777.5030205@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DDAC777.5030205@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00158.txt.bz2

On Mon, May 23, 2011 at 02:45:43PM -0600, Eric Blake wrote:
>Just for the record, I'm having a problem self-building cygwin right
>now, from what looks like mingw issues:
>
>/home/eblake/src/winsup/utils/mingw gcc-4 -B./ -shared
>-Wl,--image-base,0x6FBC0000 -Wl,--entry,_DllMainCRTStartup@12 mthr.o
>mthr_init.o mingwthrd.def -Lmingwex -o mingwm10.dll
>mingwex/libmingwex.a(strtodnrp.o): In function `strtod':
>/home/eblake/src/build/i686-pc-cygwin/winsup/mingw/mingwex/../../../../../winsup/mingw/include/stdlib.h:315:
>multiple definition of `_strtod'
>...
>/usr/lib/gcc/i686-pc-cygwin/4.3.4/../../../../i686-pc-cygwin/bin/ld:
>warning: cannot find entry symbol _DllMainCRTStartup@12; defaulting to
>6fbc1000
>ertr000001.o:(.rdata+0x0): undefined reference to
>`__pei386_runtime_relocator'
>collect2: ld returned 1 exit status
>make[3]: *** [mingwm10.dll] Error 1
>make[3]: Leaving directory
>`/home/eblake/src/build/i686-pc-cygwin/winsup/mingw'
>
>How do we go about getting that resolved?

I sent email to ironh34d regarding the strtod error after you mentioned
this on irc.  I added an "extern" in front of the strtod definition in
stdlib.h and that allowed mingw to build but I don't know if it is the
right fix or not.

cgf
