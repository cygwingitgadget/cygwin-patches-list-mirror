Return-Path: <cygwin-patches-return-7247-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7628 invoked by alias); 3 Apr 2011 23:59:04 -0000
Received: (qmail 7617 invoked by uid 22791); 3 Apr 2011 23:59:03 -0000
X-SWARE-Spam-Status: No, hits=-101.6 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,UNPARSEABLE_RELAY,USER_IN_WHITELIST
X-Spam-Check-By: sourceware.org
Received: from nm4.bullet.mail.bf1.yahoo.com (HELO nm4.bullet.mail.bf1.yahoo.com) (98.139.212.163)    by sourceware.org (qpsmtpd/0.43rc1) with SMTP; Sun, 03 Apr 2011 23:58:59 +0000
Received: from [98.139.212.149] by nm4.bullet.mail.bf1.yahoo.com with NNFMP; 03 Apr 2011 23:58:58 -0000
Received: from [98.139.213.15] by tm6.bullet.mail.bf1.yahoo.com with NNFMP; 03 Apr 2011 23:58:58 -0000
Received: from [127.0.0.1] by smtp115.mail.bf1.yahoo.com with NNFMP; 03 Apr 2011 23:58:58 -0000
Received: from cgf.cx (cgf@96.252.118.15 with login)        by smtp115.mail.bf1.yahoo.com with SMTP; 03 Apr 2011 16:58:58 -0700 PDT
X-Yahoo-SMTP: jenXL62swBAWhMTL3wnej93oaS0ClBQOAKs8jbEbx_o-
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 1EF80428048	for <cygwin-patches@cygwin.com>; Sun,  3 Apr 2011 19:58:58 -0400 (EDT)
Resent-From: Christopher Faylor <me@cgf.cx>
Resent-Date: Sun, 3 Apr 2011 19:58:58 -0400
Resent-Message-ID: <20110403235858.GA21638@ednor.casa.cgf.cx>
Resent-To: cygwin-patches@cygwin.com
Date: Sun, 03 Apr 2011 23:59:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fix make after clean
Message-ID: <20110403230350.GA16226@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1301870258.3104.11.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1301870258.3104.11.camel@YAAKOV04>
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
X-SW-Source: 2011-q2/txt/msg00013.txt.bz2

On Sun, Apr 03, 2011 at 05:37:38PM -0500, Yaakov (Cygwin/X) wrote:
>If you run make clean in winsup/cygwin followed by make -jX, the build
>fails because devices.cc is not found; it was removed by make clean but
>nothing forced it to be regenerated in time.
>
>Patch attached.
>
>
>Yaakov
>

>2011-04-03  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
>
>	* Makefile.in (devices.o): New rule with dependency on devices.cc
>	to assure that the latter exists and is current.
>
>Index: Makefile.in
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
>retrieving revision 1.243
>diff -u -r1.243 Makefile.in
>--- Makefile.in	1 Apr 2011 19:48:19 -0000	1.243
>+++ Makefile.in	3 Apr 2011 21:33:27 -0000
>@@ -443,6 +443,9 @@
> $(srcdir)/devices.cc: gendevices devices.in devices.h
> 	${wordlist 1,2,$^} $@
> 
>+devices.o: $(srcdir)/devices.cc
>+	$(COMPILE_CXX) -o $@ $<
>+

This can't be right.  In all of the times that I've run a "make clean",
I have never needed this.  A .o relying on .cc is a given.  You don't
need an explicit rule.

cgf
