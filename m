Return-Path: <cygwin-patches-return-7546-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23759 invoked by alias); 11 Nov 2011 05:22:15 -0000
Received: (qmail 23734 invoked by uid 22791); 11 Nov 2011 05:22:08 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm24.access.bullet.mail.mud.yahoo.com (HELO nm24.access.bullet.mail.mud.yahoo.com) (66.94.237.89)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Fri, 11 Nov 2011 05:21:52 +0000
Received: from [66.94.237.201] by nm24.access.bullet.mail.mud.yahoo.com with NNFMP; 11 Nov 2011 05:21:52 -0000
Received: from [66.94.237.112] by tm12.access.bullet.mail.mud.yahoo.com with NNFMP; 11 Nov 2011 05:21:52 -0000
Received: from [127.0.0.1] by omp1017.access.mail.mud.yahoo.com with NNFMP; 11 Nov 2011 05:21:52 -0000
Received: (qmail 99140 invoked from network); 11 Nov 2011 05:21:51 -0000
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from cgf.cx (cgf@98.110.183.46 with login)        by smtp102.vzn.mail.bf1.yahoo.com with SMTP; 10 Nov 2011 21:21:51 -0800 PST
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id E91DE13C0D3	for <cygwin-patches@cygwin.com>; Fri, 11 Nov 2011 00:21:50 -0500 (EST)
Date: Fri, 11 Nov 2011 05:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: ptsname_r
Message-ID: <20111111052150.GA5926@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4EB82DF9.7080408@redhat.com> <20111107193521.GA30056@ednor.casa.cgf.cx> <4EB8437B.5090600@redhat.com> <4EB843B4.4030605@redhat.com> <4EB846BC.9010003@redhat.com> <20111108060418.GA11373@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20111108060418.GA11373@ednor.casa.cgf.cx>
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
X-SW-Source: 2011-q4/txt/msg00036.txt.bz2

On Tue, Nov 08, 2011 at 01:04:18AM -0500, Christopher Faylor wrote:
>On Mon, Nov 07, 2011 at 01:59:40PM -0700, Eric Blake wrote:
>>On 11/07/2011 01:46 PM, Eric Blake wrote:
>>>> Thanks. Also, even with your patches of today, ptsname() is still not
>>>> thread-safe; should we be sticking that in a thread-local buffer rather
>>>> than in static storage, similar to how other functions like strerror()
>>>> are thread-safe?
>>
>>I didn't tackle that,
>>
>>>
>>> Also, should we have an efault handler in syscalls.cc ptsname_r(),
>>> similar to ttyname_r(), so as to gracefully reject invalid buffers
>>> rather than faulting?
>>
>>but I had this additional code in my sandbox right before your commit 
>>hit CVS; should I add a ChangeLog and make it a formal patch submission?
>
>No thanks.  Except for the Copyright change in stdlib.h, there is nothing that
>I think should go in.  On inspection, openpty() needs some work.

Actually, Corinna has added your patch to posix.sgml.  I forgot that gnu
functions were mentioned there too.

cgf
