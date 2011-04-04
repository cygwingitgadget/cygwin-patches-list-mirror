Return-Path: <cygwin-patches-return-7258-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7885 invoked by alias); 4 Apr 2011 10:54:53 -0000
Received: (qmail 7863 invoked by uid 22791); 4 Apr 2011 10:54:41 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Mon, 04 Apr 2011 10:54:33 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A63CB2C0313; Mon,  4 Apr 2011 12:54:30 +0200 (CEST)
Date: Mon, 04 Apr 2011 10:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] make <sys/sysmacros.h> compatible with glibc
Message-ID: <20110404105430.GN3669@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301873845.3104.26.camel@YAAKOV04> <20110403235557.GA15529@ednor.casa.cgf.cx> <1301875911.3104.39.camel@YAAKOV04> <20110404051942.GA30475@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20110404051942.GA30475@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q2/txt/msg00024.txt.bz2

On Apr  4 01:19, Christopher Faylor wrote:
> On Sun, Apr 03, 2011 at 07:11:51PM -0500, Yaakov (Cygwin/X) wrote:
> >On Sun, 2011-04-03 at 19:55 -0400, Christopher Faylor wrote:
> >> >+#define __INSIDE_CYGWIN_GNU_DEV__
> >> 
> >> I'd prefer a more descriptive name like "__DONT_DEFINE_INLINE_GNU_DEV" 
> >
> >The __INSIDE_CYGWIN_foo__ naming scheme seems to be what is used
> >elsewhere for similar purposes, hence my choice here.
> 
> There is a __INSIDE_CYGWIN_NET__ which I apparently added ten years ago
> but my ideas about naming have changed.  I also added
> USE_SYS_TYPES_FD_SET which is closer to what I now prefer but it should
> have had some leading underscores.

USE_SYS_TYPES_FD_SET is 10 years old, too  ;)

> >> but, then again, why do these have to be exported?  Why can't they just be
> >> always inlined?
> >
> >I just followed what I observed with glibc:
> >
> >$ cat test.c 
> >#include <sys/types.h>
> >#include <stdio.h>
> >
> >int
> >main(void)
> >{
> >  int maj = 4, min = 64;	/* /dev/ttyS0 */
> >  printf("%d, %d = %d\n", maj, min, makedev(maj, min));
> >  return 0;
> >}
> >
> >$ gcc -O0 test.c
> >
> >$ nm a.out | grep " U "
> >         U __libc_start_main@@GLIBC_2.0
> >         U gnu_dev_makedev@@GLIBC_2.3.3
> >         U printf@@GLIBC_2.0
> >
> >$ gcc -O1 test.c 
> >
> >$ nm a.out | grep " U "
> >         U __libc_start_main@@GLIBC_2.0
> >         U printf@@GLIBC_2.0
> 
> Maybe the functions were added to gcc before it had the ability to force
> inlining.

Apparently they have been added rather late. Per the man page the macros
existed for a long time, but the exported functions have been added only
with glibc 2.3.3.

> I'll leave it to Corinna but I'd prefer not adding YA export if we can
> avoid it.

This is very simple code, so I, too, would prefer to keep it inline.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
