Return-Path: <cygwin-patches-return-7248-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 10768 invoked by alias); 4 Apr 2011 00:11:56 -0000
Received: (qmail 10753 invoked by uid 22791); 4 Apr 2011 00:11:54 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-gw0-f43.google.com (HELO mail-gw0-f43.google.com) (74.125.83.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 04 Apr 2011 00:11:50 +0000
Received: by gwj21 with SMTP id 21so2488947gwj.2        for <cygwin-patches@cygwin.com>; Sun, 03 Apr 2011 17:11:49 -0700 (PDT)
Received: by 10.236.95.176 with SMTP id p36mr8947892yhf.112.1301875909648;        Sun, 03 Apr 2011 17:11:49 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id x74sm2064282yhn.54.2011.04.03.17.11.47        (version=SSLv3 cipher=OTHER);        Sun, 03 Apr 2011 17:11:48 -0700 (PDT)
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110403235557.GA15529@ednor.casa.cgf.cx>
References: <1301873845.3104.26.camel@YAAKOV04>	 <20110403235557.GA15529@ednor.casa.cgf.cx>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 04 Apr 2011 00:11:00 -0000
Message-ID: <1301875911.3104.39.camel@YAAKOV04>
Mime-Version: 1.0
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
X-SW-Source: 2011-q2/txt/msg00014.txt.bz2

On Sun, 2011-04-03 at 19:55 -0400, Christopher Faylor wrote:
> >+#define __INSIDE_CYGWIN_GNU_DEV__
> 
> I'd prefer a more descriptive name like "__DONT_DEFINE_INLINE_GNU_DEV" 

The __INSIDE_CYGWIN_foo__ naming scheme seems to be what is used
elsewhere for similar purposes, hence my choice here.

> but, then again, why do these have to be exported?  Why can't they just be
> always inlined?

I just followed what I observed with glibc:

$ cat test.c 
#include <sys/types.h>
#include <stdio.h>

int
main(void)
{
  int maj = 4, min = 64;	/* /dev/ttyS0 */
  printf("%d, %d = %d\n", maj, min, makedev(maj, min));
  return 0;
}

$ gcc -O0 test.c

$ nm a.out | grep " U "
         U __libc_start_main@@GLIBC_2.0
         U gnu_dev_makedev@@GLIBC_2.3.3
         U printf@@GLIBC_2.0

$ gcc -O1 test.c 

$ nm a.out | grep " U "
         U __libc_start_main@@GLIBC_2.0
         U printf@@GLIBC_2.0

Yaakov

