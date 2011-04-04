Return-Path: <cygwin-patches-return-7250-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7906 invoked by alias); 4 Apr 2011 05:07:38 -0000
Received: (qmail 7895 invoked by uid 22791); 4 Apr 2011 05:07:36 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm6.bullet.mail.ne1.yahoo.com (HELO nm6.bullet.mail.ne1.yahoo.com) (98.138.90.69)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Mon, 04 Apr 2011 05:07:30 +0000
Received: from [98.138.90.48] by nm6.bullet.mail.ne1.yahoo.com with NNFMP; 04 Apr 2011 05:07:29 -0000
Received: from [98.138.84.36] by tm1.bullet.mail.ne1.yahoo.com with NNFMP; 04 Apr 2011 05:07:29 -0000
Received: from [127.0.0.1] by smtp104.mail.ne1.yahoo.com with NNFMP; 04 Apr 2011 05:07:29 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp104.mail.ne1.yahoo.com with SMTP; 03 Apr 2011 22:07:28 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id B16C0428013	for <cygwin-patches@cygwin.com>; Mon,  4 Apr 2011 01:07:27 -0400 (EDT)
Date: Mon, 04 Apr 2011 05:07:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix make after clean
Message-ID: <20110404050727.GA23230@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301870258.3104.11.camel@YAAKOV04> <20110403230350.GA16226@ednor.casa.cgf.cx> <1301876562.3104.45.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301876562.3104.45.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00016.txt.bz2

On Sun, Apr 03, 2011 at 07:22:42PM -0500, Yaakov (Cygwin/X) wrote:
>On Sun, 2011-04-03 at 19:03 -0400, Christopher Faylor wrote:
>> This can't be right.  In all of the times that I've run a "make clean",
>> I have never needed this.  A .o relying on .cc is a given.  You don't
>> need an explicit rule.
>
>Without it, after a successfully completed build:
>
>$ make clean -C i686-pc-cygwin/winsup/cygwin
>[...]
>$ make
>[...goes until winsup/cygwin...]
>[...compiles all files until link stage...]
>g++: devices.o: No such file or directory
>make[3]: *** [cygwin0.dll] Error 1
>
>So in this case, apparently it is.

And, without it, I continue to build without problem.  I *am* building
on Linux, though, so maybe that's the difference.

Regardless, I am not going to add a rule that doesn't make sense.

cgf
