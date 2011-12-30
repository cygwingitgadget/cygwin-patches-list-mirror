Return-Path: <cygwin-patches-return-7573-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3244 invoked by alias); 30 Dec 2011 06:25:41 -0000
Received: (qmail 3229 invoked by uid 22791); 30 Dec 2011 06:25:38 -0000
X-SWARE-Spam-Status: No, hits=-2.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_RW
X-Spam-Check-By: sourceware.org
Received: from mail-iy0-f171.google.com (HELO mail-iy0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 30 Dec 2011 06:25:25 +0000
Received: by iagw33 with SMTP id w33so26408264iag.2        for <cygwin-patches@cygwin.com>; Thu, 29 Dec 2011 22:25:24 -0800 (PST)
Received: by 10.50.160.201 with SMTP id xm9mr44465779igb.16.1325226324361;        Thu, 29 Dec 2011 22:25:24 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id py4sm83832255igc.2.2011.12.29.22.25.23        (version=SSLv3 cipher=OTHER);        Thu, 29 Dec 2011 22:25:23 -0800 (PST)
Message-ID: <1325226325.5512.7.camel@YAAKOV04>
Subject: [PATCH] Fix cancellation points list
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 30 Dec 2011 06:25:00 -0000
Content-Type: multipart/mixed; boundary="=-ChpNwEfqQcEv5lJ18hCp"
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
X-SW-Source: 2011-q4/txt/msg00063.txt.bz2


--=-ChpNwEfqQcEv5lJ18hCp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 109

pthread_rwlock_timedrdlock and pthread_rwlock_timedwrlock aren't
implemented yet.  Patch attached.


Yaakov


--=-ChpNwEfqQcEv5lJ18hCp
Content-Disposition: attachment; filename="cygwin-cancellation-points.patch"
Content-Type: text/x-patch; name="cygwin-cancellation-points.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 791

2011-12-30  Yaakov Selkowitz  <yselkowitz@...>

	* thread.cc: Mark pthread_rwlock_timedrdlock and
	pthread_rwlock_timedwrlock as not yet implemented in the list of
	cancellation points.

Index: thread.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/thread.cc,v
retrieving revision 1.250
diff -u -p -r1.250 thread.cc
--- thread.cc	22 Dec 2011 11:02:36 -0000	1.250
+++ thread.cc	30 Dec 2011 06:22:45 -0000
@@ -810,8 +810,8 @@ pthread::cancel ()
       psiginfo ()
       psignal ()
       pthread_rwlock_rdlock ()
-      pthread_rwlock_timedrdlock ()
-      pthread_rwlock_timedwrlock ()
+    o pthread_rwlock_timedrdlock ()
+    o pthread_rwlock_timedwrlock ()
       pthread_rwlock_wrlock ()
       putc ()
       putc_unlocked ()

--=-ChpNwEfqQcEv5lJ18hCp--
