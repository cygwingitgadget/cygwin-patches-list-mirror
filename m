Return-Path: <cygwin-patches-return-7455-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24618 invoked by alias); 30 Jul 2011 20:57:45 -0000
Received: (qmail 24606 invoked by uid 22791); 30 Jul 2011 20:57:44 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm20.bullet.mail.sp2.yahoo.com (HELO nm20.bullet.mail.sp2.yahoo.com) (98.139.91.90)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sat, 30 Jul 2011 20:57:29 +0000
Received: from [98.139.91.66] by nm20.bullet.mail.sp2.yahoo.com with NNFMP; 30 Jul 2011 20:57:29 -0000
Received: from [208.71.42.193] by tm6.bullet.mail.sp2.yahoo.com with NNFMP; 30 Jul 2011 20:57:29 -0000
Received: from [127.0.0.1] by smtp204.mail.gq1.yahoo.com with NNFMP; 30 Jul 2011 20:57:29 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@173.76.51.125 with login)        by smtp204.mail.gq1.yahoo.com with SMTP; 30 Jul 2011 13:57:15 -0700 PDT
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 27F5913C003	for <cygwin-patches@cygwin.com>; Sat, 30 Jul 2011 16:56:57 -0400 (EDT)
Date: Sat, 30 Jul 2011 20:57:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] workaround for sigproc_init
Message-ID: <20110730205644.GA31551@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4E329C56.8090605@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4E329C56.8090605@gmail.com>
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
X-SW-Source: 2011-q3/txt/msg00031.txt.bz2

On Fri, Jul 29, 2011 at 08:41:10PM +0900, jojelino wrote:
>As sigproc_init is called during dll initialization, wait_sig thread is 
>not created as soon as possible.(this is known in msdn createthread 
>reference. http://msdn.microsoft.com/en-us/library/ms682453(v=vs.85).aspx)
>And then wait_sig starts to wake up as sig_dispatch_pending enters 
>waitforsingleobject. then main thread stops for few ms. and it shows 
>poor performance.
>as a workaround, issue user apc call, let the os decide when to call them.
>And the result was quite good. patch,changelog modified are attached.
>Please review it.

The result is good but the patch isn't the way I chose to implement
this.  I appreciate the idea, though.  The performance improvement
is amazing.

Thanks for the patch/idea.

cgf

P.S.  I really do appreciate the effort that you put into this but, had
it been accepted, it would have required some reformatting since you
used a different indentation style from the rest of the code.  I hope
that you'll consider keeping your changes formatted like the surrounded
code.  It will make patch adoption easier.
