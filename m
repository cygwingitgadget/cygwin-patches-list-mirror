Return-Path: <cygwin-patches-return-7251-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10424 invoked by alias); 4 Apr 2011 05:22:13 -0000
Received: (qmail 10413 invoked by uid 22791); 4 Apr 2011 05:22:11 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm22.bullet.mail.sp2.yahoo.com (HELO nm22.bullet.mail.sp2.yahoo.com) (98.139.91.92)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 04 Apr 2011 05:22:07 +0000
Received: from [98.139.91.66] by nm22.bullet.mail.sp2.yahoo.com with NNFMP; 04 Apr 2011 05:22:07 -0000
Received: from [98.139.91.33] by tm6.bullet.mail.sp2.yahoo.com with NNFMP; 04 Apr 2011 05:22:07 -0000
Received: from [127.0.0.1] by omp1033.mail.sp2.yahoo.com with NNFMP; 04 Apr 2011 05:22:07 -0000
Received: (qmail 13107 invoked from network); 4 Apr 2011 05:19:49 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp148.mail.mud.yahoo.com with SMTP; 03 Apr 2011 22:19:47 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 22837428013	for <cygwin-patches@cygwin.com>; Mon,  4 Apr 2011 01:19:43 -0400 (EDT)
Date: Mon, 04 Apr 2011 05:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
Message-ID: <20110404051942.GA30475@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301873845.3104.26.camel@YAAKOV04> <20110403235557.GA15529@ednor.casa.cgf.cx> <1301875911.3104.39.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301875911.3104.39.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00017.txt.bz2

On Sun, Apr 03, 2011 at 07:11:51PM -0500, Yaakov (Cygwin/X) wrote:
>On Sun, 2011-04-03 at 19:55 -0400, Christopher Faylor wrote:
>> >+#define __INSIDE_CYGWIN_GNU_DEV__
>> 
>> I'd prefer a more descriptive name like "__DONT_DEFINE_INLINE_GNU_DEV" 
>
>The __INSIDE_CYGWIN_foo__ naming scheme seems to be what is used
>elsewhere for similar purposes, hence my choice here.

There is a __INSIDE_CYGWIN_NET__ which I apparently added ten years ago
but my ideas about naming have changed.  I also added
USE_SYS_TYPES_FD_SET which is closer to what I now prefer but it should
have had some leading underscores.

>> but, then again, why do these have to be exported?  Why can't they just be
>> always inlined?
>
>I just followed what I observed with glibc:
>
>$ cat test.c 
>#include <sys/types.h>
>#include <stdio.h>
>
>int
>main(void)
>{
>  int maj = 4, min = 64;	/* /dev/ttyS0 */
>  printf("%d, %d = %d\n", maj, min, makedev(maj, min));
>  return 0;
>}
>
>$ gcc -O0 test.c
>
>$ nm a.out | grep " U "
>         U __libc_start_main@@GLIBC_2.0
>         U gnu_dev_makedev@@GLIBC_2.3.3
>         U printf@@GLIBC_2.0
>
>$ gcc -O1 test.c 
>
>$ nm a.out | grep " U "
>         U __libc_start_main@@GLIBC_2.0
>         U printf@@GLIBC_2.0

Maybe the functions were added to gcc before it had the ability to force
inlining.

I'll leave it to Corinna but I'd prefer not adding YA export if we can
avoid it.

cgf
