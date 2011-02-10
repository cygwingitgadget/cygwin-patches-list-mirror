Return-Path: <cygwin-patches-return-7189-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24329 invoked by alias); 10 Feb 2011 15:33:02 -0000
Received: (qmail 24303 invoked by uid 22791); 10 Feb 2011 15:33:02 -0000
X-SWARE-Spam-Status: No, hits=-1.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY
X-Spam-Check-By: sourceware.org
Received: from nm11-vm0.bullet.mail.sp2.yahoo.com (HELO nm11-vm0.bullet.mail.sp2.yahoo.com) (98.139.91.240)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Thu, 10 Feb 2011 15:32:56 +0000
Received: from [98.139.91.61] by nm11.bullet.mail.sp2.yahoo.com with NNFMP; 10 Feb 2011 15:32:55 -0000
Received: from [98.136.185.41] by tm1.bullet.mail.sp2.yahoo.com with NNFMP; 10 Feb 2011 15:32:55 -0000
Received: from [127.0.0.1] by smtp102.mail.gq1.yahoo.com with NNFMP; 10 Feb 2011 15:32:54 -0000
Received: from cgf.cx (cgf@72.70.43.36 with login)        by smtp102.mail.gq1.yahoo.com with SMTP; 10 Feb 2011 07:32:54 -0800 PST
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 98A5C13C0CA	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 10:32:53 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201)	id 931562B352; Thu, 10 Feb 2011 10:32:53 -0500 (EST)
Date: Thu, 10 Feb 2011 15:33:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] for SIGSEGV, compilation error in gcc 4.6
Message-ID: <20110210153253.GC26842@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <AANLkTinBrYcRrRBztY5eKWzon02GtB4t3S5BcLVoA_+D@mail.gmail.com> <20110210100236.GD2305@calimero.vinschen.de> <4D53DE66.2080805@gmail.com> <20110210141515.GB25992@calimero.vinschen.de> <20110210142933.GA29161@calimero.vinschen.de> <4D53FCB4.30404@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D53FCB4.30404@gmail.com>
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
X-SW-Source: 2011-q1/txt/msg00044.txt.bz2

On Thu, Feb 10, 2011 at 11:56:52PM +0900, jojelino wrote:
>i am sorry for extra line feed. corrected.
>requesting review.

>Index: winsup/cygwin/dcrt0.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/dcrt0.cc,v
>retrieving revision 1.390
>diff -u -r1.390 dcrt0.cc
>--- winsup/cygwin/dcrt0.cc	26 Dec 2010 21:11:37 -0000	1.390
>+++ winsup/cygwin/dcrt0.cc	10 Feb 2011 14:46:04 -0000
>@@ -1034,7 +1034,7 @@
>   sig_dispatch_pending (true);
> }
> 
>-void __stdcall
>+void __stdcall __attribute__ ((regparm (1), noreturn))
> do_exit (int status)
> {
>   syscall_printf ("do_exit (%d), exit_state %d", status, exit_state);
>@@ -1198,7 +1198,7 @@
> }

I really don't understand how this can fix a SIGSEGV.  If do_exit is
not being produced as a stdcall function then it should be producing
a link error since a stdcall function is decorated with the number of
bytes that need to be removed from the stack, e.g., do_exit@4.

Also a function declared with regparm() should either 1) do the right
thing if it's missing a regparm() in the definition or 2) complain at
compile time.

It is not a bad thing to make the declarations and definitions coincide
but I don't understand what is being fixed here.

cgf 
