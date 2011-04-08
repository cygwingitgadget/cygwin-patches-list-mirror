Return-Path: <cygwin-patches-return-7276-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13897 invoked by alias); 8 Apr 2011 03:55:06 -0000
Received: (qmail 13886 invoked by uid 22791); 8 Apr 2011 03:55:05 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm3-vm0.bullet.mail.bf1.yahoo.com (HELO nm3-vm0.bullet.mail.bf1.yahoo.com) (98.139.212.154)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 08 Apr 2011 03:55:01 +0000
Received: from [98.139.212.151] by nm3.bullet.mail.bf1.yahoo.com with NNFMP; 08 Apr 2011 03:55:00 -0000
Received: from [98.139.213.3] by tm8.bullet.mail.bf1.yahoo.com with NNFMP; 08 Apr 2011 03:55:00 -0000
Received: from [127.0.0.1] by smtp103.mail.bf1.yahoo.com with NNFMP; 08 Apr 2011 03:55:00 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp103.mail.bf1.yahoo.com with SMTP; 07 Apr 2011 20:55:00 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 3A91C4A801A	for <cygwin-patches@cygwin.com>; Thu,  7 Apr 2011 23:55:00 -0400 (EDT)
Date: Fri, 08 Apr 2011 03:55:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix make after clean
Message-ID: <20110408035500.GA4966@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301870258.3104.11.camel@YAAKOV04> <20110403230350.GA16226@ednor.casa.cgf.cx> <1301876562.3104.45.camel@YAAKOV04> <20110404050727.GA23230@ednor.casa.cgf.cx> <1301896591.3104.49.camel@YAAKOV04> <1301901216.3104.73.camel@YAAKOV04> <20110404145207.GB1140@ednor.casa.cgf.cx> <1302137582.3328.2.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1302137582.3328.2.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00042.txt.bz2

On Wed, Apr 06, 2011 at 07:53:02PM -0500, Yaakov (Cygwin/X) wrote:
>On Mon, 2011-04-04 at 10:52 -0400, Christopher Faylor wrote:
>> The last time I reported that I was using relative paths in the
>> gcc/binutils/winsup directory I was told "Don't do that.  It isn't
>> supported."  However, I'll move the call to Makefile.common earlier
>> in Makefile.in.
>> 
>> Thanks for the analysis.
>
>You overcompensated just a bit too much.  With a clean builddir:
>
>In file included from /usr/src/cygwin/winsup/cygwin/gmon.c:42:0:
>/usr/src/cygwin/winsup/cygwin/gmon.h:46:21: fatal error: profile.h: No
>such file or directory
>compilation terminated.
>make[3]: *** [gmon.o] Error 1
>make[3]: *** Waiting for unfinished jobs....
>In file included from /usr/src/cygwin/winsup/cygwin/mcount.c:39:0:
>/usr/src/cygwin/winsup/cygwin/gmon.h:46:21: fatal error: profile.h: No
>such file or directory
>compilation terminated.
>make[3]: *** [mcount.o] Error 1
>
>Patch attached.

I wonder why I don't see this.  I specifically did a clean install to
check it.

As you probably saw, I checked in a change last night.

Thanks.

cgf
