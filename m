Return-Path: <cygwin-patches-return-7661-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2154 invoked by alias); 9 May 2012 08:18:50 -0000
Received: (qmail 2110 invoked by uid 22791); 9 May 2012 08:18:43 -0000
X-SWARE-Spam-Status: No, hits=-4.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_CP
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 09 May 2012 08:18:29 +0000
Received: by yenq11 with SMTP id q11so2965yen.2        for <cygwin-patches@cygwin.com>; Wed, 09 May 2012 01:18:29 -0700 (PDT)
Received: by 10.50.77.136 with SMTP id s8mr12657323igw.56.1336551508603;        Wed, 09 May 2012 01:18:28 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id em4sm10437757igc.16.2012.05.09.01.18.27        (version=SSLv3 cipher=OTHER);        Wed, 09 May 2012 01:18:28 -0700 (PDT)
Message-ID: <1336551515.8880.4.camel@YAAKOV04>
Subject: [PATCH] Export memrchr
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Wed, 09 May 2012 08:18:00 -0000
Content-Type: multipart/mixed; boundary="=-5cwZUxMEO38DiYR5Hd9i"
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
X-SW-Source: 2012-q2/txt/msg00030.txt.bz2


--=-5cwZUxMEO38DiYR5Hd9i
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 94

Here are the patches for exporting memrchr, once my patches to newlib
are accepted.


Yaakov


--=-5cwZUxMEO38DiYR5Hd9i
Content-Disposition: attachment; filename="cygwin-memrchr.patch"
Content-Type: text/x-patch; name="cygwin-memrchr.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1926

2012-05-09  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (memrchr): Export.
	* posix.sgml (std-gnu): Add memrchr.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.254
diff -u -p -r1.254 cygwin.din
--- cygwin.din	22 Feb 2012 01:58:24 -0000	1.254
+++ cygwin.din	9 May 2012 08:11:16 -0000
@@ -1062,6 +1062,7 @@ memmove NOSIGFE
 _memmove = memmove NOSIGFE
 mempcpy NOSIGFE
 __mempcpy = mempcpy NOSIGFE
+memrchr NOSIGFE
 memset NOSIGFE
 _memset = memset NOSIGFE
 mkdir SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.77
diff -u -p -r1.77 posix.sgml
--- posix.sgml	30 Mar 2012 11:29:56 -0000	1.77
+++ posix.sgml	9 May 2012 08:11:16 -0000
@@ -1126,6 +1126,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     lsetxattr
     memmem
     mempcpy
+    memrchr
     mkostemp
     mkostemps
     pipe2
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.368
diff -u -p -r1.368 version.h
--- include/cygwin/version.h	24 Apr 2012 16:05:20 -0000	1.368
+++ include/cygwin/version.h	9 May 2012 08:11:17 -0000
@@ -429,12 +429,13 @@ details. */
       258: Export get_current_dir_name.
       259: Export pthread_sigqueue.
       260: Export scandirat.
+      261: Export memrchr.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 260
+#define CYGWIN_VERSION_API_MINOR 261
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-5cwZUxMEO38DiYR5Hd9i
Content-Disposition: attachment; filename="doc-memrchr.patch"
Content-Type: text/x-patch; name="doc-memrchr.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 639

2012-05-09  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.15): Document memrchr.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.116
diff -u -p -r1.116 new-features.sgml
--- new-features.sgml	9 May 2012 07:32:48 -0000	1.116
+++ new-features.sgml	9 May 2012 08:15:17 -0000
@@ -7,6 +7,10 @@
 CYGWIN=pipe_byte option now forces the opening of pipes in byte mode rather than message mode.
 </para></listitem>
 
+<listitem><para>
+New API: memrchr.
+</para></listitem>
+
 </itemizedlist>
 
 </sect2>

--=-5cwZUxMEO38DiYR5Hd9i--
