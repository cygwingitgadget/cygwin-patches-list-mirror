Return-Path: <cygwin-patches-return-7785-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11773 invoked by alias); 21 Nov 2012 10:54:07 -0000
Received: (qmail 11762 invoked by uid 22791); 21 Nov 2012 10:54:05 -0000
X-SWARE-Spam-Status: No, hits=-4.6 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE,TW_CF,TW_VP
X-Spam-Check-By: sourceware.org
Received: from mail-ia0-f171.google.com (HELO mail-ia0-f171.google.com) (209.85.210.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 21 Nov 2012 10:53:56 +0000
Received: by mail-ia0-f171.google.com with SMTP id b35so2557666iac.2        for <cygwin-patches@cygwin.com>; Wed, 21 Nov 2012 02:53:56 -0800 (PST)
Received: by 10.50.189.193 with SMTP id gk1mr13388434igc.22.1353495235907;        Wed, 21 Nov 2012 02:53:55 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id hg2sm11663244igc.3.2012.11.21.02.53.54        (version=TLSv1/SSLv3 cipher=OTHER);        Wed, 21 Nov 2012 02:53:55 -0800 (PST)
Message-ID: <1353495243.5592.25.camel@YAAKOV04>
Subject: [PATCH] add cfsetspeed
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 21 Nov 2012 10:54:00 -0000
Content-Type: multipart/mixed; boundary="=-LIRCoaC205Lgjdl0NaOi"
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
X-SW-Source: 2012-q4/txt/msg00062.txt.bz2


--=-LIRCoaC205Lgjdl0NaOi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 286

This patchset adds cfsetspeed(3), a BSD extension also available in
glibc:

http://man7.org/linux/man-pages/man3/termios.3.html

Per the description, cfsetspeed() is the equivalent of cfsetospeed() and
cfsetispeed() with the same baud rate.  Patch for winsup/cygwin
attached.


Yaakov


--=-LIRCoaC205Lgjdl0NaOi
Content-Disposition: attachment; filename="cygwin-cfsetspeed.patch"
Content-Type: text/x-patch; name="cygwin-cfsetspeed.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 3424

2012-11-21  Yaakov Selkowitz  <yselkowitz@...>

	* termios.cc (cfsetspeed): New function.
	* cygwin.din (cfsetspeed): Export.
	* posix.sgml (std-bsd): Add cfsetspeed.
	* include/sys/termios.h (cfsetspeed): Declare.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.256
diff -u -p -r1.256 cygwin.din
--- cygwin.din	18 Jul 2012 11:17:24 -0000	1.256
+++ cygwin.din	21 Nov 2012 10:19:11 -0000
@@ -208,6 +208,7 @@ cfgetospeed NOSIGFE
 cfmakeraw NOSIGFE
 cfsetispeed SIGFE
 cfsetospeed SIGFE
+cfsetspeed SIGFE
 chdir SIGFE
 _chdir = chdir SIGFE
 chmod SIGFE
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.79
diff -u -p -r1.79 posix.sgml
--- posix.sgml	18 Jul 2012 11:17:25 -0000	1.79
+++ posix.sgml	21 Nov 2012 10:19:11 -0000
@@ -957,6 +957,7 @@ also IEEE Std 1003.1-2008 (POSIX.1-2008)
     bindresvport
     bindresvport_sa
     cfmakeraw
+    cfsetspeed
     daemon
     dn_comp
     dn_expand
Index: termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/termios.cc,v
retrieving revision 1.41
diff -u -p -r1.41 termios.cc
--- termios.cc	28 Feb 2012 14:03:02 -0000	1.41
+++ termios.cc	21 Nov 2012 10:19:10 -0000
@@ -328,6 +328,20 @@ cfsetispeed (struct termios *in_tp, spee
   return res;
 }
 
+/* cfsetspeed: 4.4BSD */
+extern "C" int
+cfsetspeed (struct termios *in_tp, speed_t speed)
+{
+  struct termios *tp = __tonew_termios (in_tp);
+  int res;
+  /* errors come only from unsupported baud rates, so setspeed() would return
+     identical results in both calls */
+  if ((res = setspeed (tp->c_ospeed, speed)) == 0)
+    setspeed (tp->c_ispeed, speed);
+  __toapp_termios (in_tp, tp);
+  return res;
+}
+
 extern "C" void
 cfmakeraw(struct termios *tp)
 {
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.373
diff -u -p -r1.373 version.h
--- include/cygwin/version.h	21 Oct 2012 10:20:53 -0000	1.373
+++ include/cygwin/version.h	21 Nov 2012 10:19:11 -0000
@@ -431,12 +431,13 @@ details. */
       260: Export scandirat.
       261: Export memrchr.
       262: Export getmntent_r.
+      263: Export cfsetspeed.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 262
+#define CYGWIN_VERSION_API_MINOR 263
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible
Index: include/sys/termios.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/termios.h,v
retrieving revision 1.23
diff -u -p -r1.23 termios.h
--- include/sys/termios.h	5 Nov 2012 03:19:28 -0000	1.23
+++ include/sys/termios.h	21 Nov 2012 10:19:12 -0000
@@ -345,6 +345,7 @@ speed_t cfgetispeed(const struct termios
 speed_t cfgetospeed(const struct termios *);
 int cfsetispeed (struct termios *, speed_t);
 int cfsetospeed (struct termios *, speed_t);
+int cfsetspeed (struct termios *, speed_t);
 
 #ifdef __cplusplus
 }

--=-LIRCoaC205Lgjdl0NaOi--
