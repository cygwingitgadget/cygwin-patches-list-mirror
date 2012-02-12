Return-Path: <cygwin-patches-return-7594-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28668 invoked by alias); 12 Feb 2012 22:04:19 -0000
Received: (qmail 28654 invoked by uid 22791); 12 Feb 2012 22:04:18 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sun, 12 Feb 2012 22:04:05 +0000
Received: by iaeh11 with SMTP id h11so3783859iae.2        for <cygwin-patches@cygwin.com>; Sun, 12 Feb 2012 14:04:05 -0800 (PST)
Received: by 10.50.104.134 with SMTP id ge6mr16074544igb.1.1329084245027;        Sun, 12 Feb 2012 14:04:05 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id gw1sm10772066igb.0.2012.02.12.14.04.02        (version=SSLv3 cipher=OTHER);        Sun, 12 Feb 2012 14:04:04 -0800 (PST)
Message-ID: <1329084242.7872.10.camel@YAAKOV04>
Subject: [PATCH] pthread.h: include <time.h>
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Sun, 12 Feb 2012 22:04:00 -0000
Content-Type: multipart/mixed; boundary="=-m8ewdJcBwNhHGwFIAVg/"
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
X-SW-Source: 2012-q1/txt/msg00017.txt.bz2


--=-m8ewdJcBwNhHGwFIAVg/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 280

POSIX states:
> Inclusion of the <pthread.h> header shall make symbols defined in the
> headers <sched.h> and <time.h> visible.

The reason being that some pthread functions take a clockid_t argument,
and the CLOCK_* symbolic names are therein defined.

Patch attached.


Yaakov


--=-m8ewdJcBwNhHGwFIAVg/
Content-Disposition: attachment; filename="pthread-include-time.patch"
Content-Type: text/x-patch; name="pthread-include-time.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 558

2012-Feb-??  Yaakov Selkowitz  <yselkowitz@...>

	* include/pthread.h: Include time.h as required by POSIX.

Index: include/pthread.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/pthread.h,v
retrieving revision 1.35
diff -u -p -r1.35 pthread.h
--- include/pthread.h	6 Jan 2012 07:12:18 -0000	1.35
+++ include/pthread.h	12 Feb 2012 21:56:02 -0000
@@ -14,6 +14,7 @@
 #include <sys/types.h>
 #include <signal.h>
 #include <sched.h>
+#include <time.h>
 
 #ifndef _PTHREAD_H
 #define _PTHREAD_H

--=-m8ewdJcBwNhHGwFIAVg/--
