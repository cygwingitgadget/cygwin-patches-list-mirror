Return-Path: <cygwin-patches-return-7275-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6052 invoked by alias); 7 Apr 2011 00:53:12 -0000
Received: (qmail 6041 invoked by uid 22791); 7 Apr 2011 00:53:10 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yw0-f43.google.com (HELO mail-yw0-f43.google.com) (209.85.213.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 07 Apr 2011 00:53:04 +0000
Received: by ywa6 with SMTP id 6so979140ywa.2        for <cygwin-patches@cygwin.com>; Wed, 06 Apr 2011 17:53:04 -0700 (PDT)
Received: by 10.236.67.74 with SMTP id i50mr376942yhd.58.1302137583916;        Wed, 06 Apr 2011 17:53:03 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id x61sm487936yhn.48.2011.04.06.17.52.58        (version=SSLv3 cipher=OTHER);        Wed, 06 Apr 2011 17:52:59 -0700 (PDT)
Subject: Re: [PATCH] fix make after clean
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
In-Reply-To: <20110404145207.GB1140@ednor.casa.cgf.cx>
References: <1301870258.3104.11.camel@YAAKOV04>	 <20110403230350.GA16226@ednor.casa.cgf.cx>	 <1301876562.3104.45.camel@YAAKOV04>	 <20110404050727.GA23230@ednor.casa.cgf.cx>	 <1301896591.3104.49.camel@YAAKOV04> <1301901216.3104.73.camel@YAAKOV04>	 <20110404145207.GB1140@ednor.casa.cgf.cx>
Content-Type: multipart/mixed; boundary="=-hg0tcsnBwP7b2jSYM/cy"
Date: Thu, 07 Apr 2011 00:53:00 -0000
Message-ID: <1302137582.3328.2.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00041.txt.bz2


--=-hg0tcsnBwP7b2jSYM/cy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 883

On Mon, 2011-04-04 at 10:52 -0400, Christopher Faylor wrote:
> The last time I reported that I was using relative paths in the
> gcc/binutils/winsup directory I was told "Don't do that.  It isn't
> supported."  However, I'll move the call to Makefile.common earlier
> in Makefile.in.
> 
> Thanks for the analysis.

You overcompensated just a bit too much.  With a clean builddir:

In file included from /usr/src/cygwin/winsup/cygwin/gmon.c:42:0:
/usr/src/cygwin/winsup/cygwin/gmon.h:46:21: fatal error: profile.h: No
such file or directory
compilation terminated.
make[3]: *** [gmon.o] Error 1
make[3]: *** Waiting for unfinished jobs....
In file included from /usr/src/cygwin/winsup/cygwin/mcount.c:39:0:
/usr/src/cygwin/winsup/cygwin/gmon.h:46:21: fatal error: profile.h: No
such file or directory
compilation terminated.
make[3]: *** [mcount.o] Error 1

Patch attached.


Yaakov


--=-hg0tcsnBwP7b2jSYM/cy
Content-Disposition: attachment; filename="winsup-cygwin-Makefile.patch"
Content-Type: text/x-patch; name="winsup-cygwin-Makefile.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 719

2011-04-06  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* Makefile.in: Move srcdir definition before others which uses it.

Index: Makefile.in
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
retrieving revision 1.245
diff -u -r1.245 Makefile.in
--- Makefile.in	4 Apr 2011 15:01:43 -0000	1.245
+++ Makefile.in	7 Apr 2011 00:46:09 -0000
@@ -13,10 +13,10 @@
 # Include common definitions for winsup directory
 # The following assignments are "inputs" to Makefile.common
 #
+srcdir:=@srcdir@
 CC:=@CC@
 CC_FOR_TARGET:=$(CC)
 CONFIG_DIR:=$(srcdir)/config/@CONFIG_DIR@
-srcdir:=@srcdir@
 include ${srcdir}/../Makefile.common
 
 SHELL:=@SHELL@

--=-hg0tcsnBwP7b2jSYM/cy--
