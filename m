Return-Path: <cygwin-patches-return-7299-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28344 invoked by alias); 4 May 2011 15:13:58 -0000
Received: (qmail 28329 invoked by uid 22791); 4 May 2011 15:13:57 -0000
X-SWARE-Spam-Status: No, hits=-1.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm28-vm0.bullet.mail.sp2.yahoo.com (HELO nm28-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.234)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Wed, 04 May 2011 15:13:43 +0000
Received: from [98.139.91.63] by nm28.bullet.mail.sp2.yahoo.com with NNFMP; 04 May 2011 15:13:43 -0000
Received: from [98.136.185.29] by tm3.bullet.mail.sp2.yahoo.com with NNFMP; 04 May 2011 15:13:43 -0000
Received: from [127.0.0.1] by smtp110.mail.gq1.yahoo.com with NNFMP; 04 May 2011 15:13:43 -0000
Received: from cgf.cx (cgf@108.49.31.43 with login)        by smtp110.mail.gq1.yahoo.com with SMTP; 04 May 2011 08:13:42 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id A41464A800A	for <cygwin-patches@cygwin.com>; Wed,  4 May 2011 11:13:41 -0400 (EDT)
Date: Wed, 04 May 2011 15:13:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] psignal, psiginfo, sys_siglist
Message-ID: <20110504151341.GD19601@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1304506369.820.15.camel@YAAKOV04> <20110504111826.GA32087@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20110504111826.GA32087@calimero.vinschen.de>
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
X-SW-Source: 2011-q2/txt/msg00065.txt.bz2

On Wed, May 04, 2011 at 01:18:26PM +0200, Corinna Vinschen wrote:
>On May  4 05:52, Yaakov (Cygwin/X) wrote:
>> This patch exports psignal() from newlib (once my corresponding patch is
>> accepted) and implements psiginfo() and sys_siglist[].  The first two
>> are POSIX.1-2008, the latter is in BSD and glibc.
>> 
>> Patches for winsup/cygwin and winsup/doc, and a test application,
>> attached.
>> 
>> 
>> Yaakov
>> 
>
>> 2011-05-04  Yaakov Selkowitz  <yselkowitz@...>
>> 
>> 	* cygwin.din (psiginfo): Export.
>> 	(psignal): Export.
>> 	(sys_siglist): Export.
>> 	* posix.sgml (std-notimpl): Move psiginfo and psignal from here...
>> 	(std-susv4): ... to here.
>> 	(std-deprec): Add sys_siglist.
>> 	* strsig.cc (sys_siglist): New array.
>> 	(psiginfo): New function.
>> 	* include/cygwin/signal.h (sys_siglist): Declare.
>> 	(psiginfo): Declare.
>> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.
>
>Looks fine to me.  Chris, what do you think?

The indentation on if and switch is wrong but, other than that minor
point, it looks fine.

cgf
