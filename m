Return-Path: <cygwin-patches-return-7587-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22922 invoked by alias); 12 Jan 2012 11:29:01 -0000
Received: (qmail 22908 invoked by uid 22791); 12 Jan 2012 11:29:00 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f171.google.com (HELO mail-qy0-f171.google.com) (209.85.216.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 12 Jan 2012 11:28:47 +0000
Received: by qcsc20 with SMTP id c20so1023320qcs.2        for <cygwin-patches@cygwin.com>; Thu, 12 Jan 2012 03:28:46 -0800 (PST)
Received: by 10.229.136.77 with SMTP id q13mr1107940qct.154.1326367726876;        Thu, 12 Jan 2012 03:28:46 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id dh10sm9477615qab.19.2012.01.12.03.28.43        (version=SSLv3 cipher=OTHER);        Thu, 12 Jan 2012 03:28:44 -0800 (PST)
Message-ID: <1326367724.4864.1.camel@YAAKOV04>
Subject: [PATCH] doc: tgmath.h
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Thu, 12 Jan 2012 11:29:00 -0000
Content-Type: multipart/mixed; boundary="=-JdBUW0Gl7Epwsn+hi/Te"
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
X-SW-Source: 2012-q1/txt/msg00010.txt.bz2


--=-JdBUW0Gl7Epwsn+hi/Te
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-length: 64

New header just committed to newlib.  Patch attached.


Yaakov


--=-JdBUW0Gl7Epwsn+hi/Te
Content-Disposition: attachment; filename="doc-tgmath.patch"
Content-Type: text/x-patch; name="doc-tgmath.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 721

2012-01-??  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document tgmath.h.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.97
diff -u -p -r1.97 new-features.sgml
--- new-features.sgml	6 Jan 2012 07:13:11 -0000	1.97
+++ new-features.sgml	12 Jan 2012 11:25:14 -0000
@@ -72,6 +72,10 @@ Also, perror and strerror_r no longer cl
 </para></listitem>
 
 <listitem><para>
+C99 &gt;tgmath.h&lt; type-generic macros.
+</para></listitem>
+
+<listitem><para>
 /proc/loadavg now shows the number of currently running processes and the
 total number of processes.
 </para></listitem>

--=-JdBUW0Gl7Epwsn+hi/Te--
