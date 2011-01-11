Return-Path: <cygwin-patches-return-7149-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4420 invoked by alias); 11 Jan 2011 09:36:36 -0000
Received: (qmail 4113 invoked by uid 22791); 11 Jan 2011 09:36:31 -0000
X-SWARE-Spam-Status: No, hits=-2.1 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,TW_CF
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 11 Jan 2011 09:36:26 +0000
Received: by yxi11 with SMTP id 11so10257207yxi.2        for <cygwin-patches@cygwin.com>; Tue, 11 Jan 2011 01:36:24 -0800 (PST)
Received: by 10.236.105.226 with SMTP id k62mr916192yhg.53.1294738584007;        Tue, 11 Jan 2011 01:36:24 -0800 (PST)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id q8sm17833482yhg.1.2011.01.11.01.36.20        (version=SSLv3 cipher=RC4-MD5);        Tue, 11 Jan 2011 01:36:23 -0800 (PST)
Subject: Fixes for cfget[io]speed
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-H5N685Ex8UFJmYKBG2m/"
Date: Tue, 11 Jan 2011 09:36:00 -0000
Message-ID: <1294738575.5256.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q1/txt/msg00004.txt.bz2


--=-H5N685Ex8UFJmYKBG2m/
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 404

I discovered some compliance issues with cfget[io]speed:

* POSIX requires these to be declared (at least) as functions[1];
* POSIX requires their argument to be const[1];
* the macros are not safe for C++ code.

The following patch fixes these issues, providing that constifying the
arguments doesn't change the ABI.


Yaakov

[1]
http://pubs.opengroup.org/onlinepubs/9699919799/basedefs/termios.h.html

--=-H5N685Ex8UFJmYKBG2m/
Content-Disposition: attachment; filename="posix-cfgetospeed.patch"
Content-Type: text/x-patch; name="posix-cfgetospeed.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1945

2011-01-11  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* termios.cc (cfgetospeed, cfgetispeed): Constify argument per POSIX.
	* include/sys/termios.h (cfgetospeed, cfgetispeed): Declare functions.
	Move macros after declarations and make conditional on !__cplusplus.

Index: termios.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/termios.cc,v
retrieving revision 1.35
diff -u -r1.35 termios.cc
--- termios.cc	2 Aug 2009 21:38:40 -0000	1.35
+++ termios.cc	11 Jan 2011 09:07:38 -0000
@@ -232,14 +232,14 @@
 
 /* cfgetospeed: POSIX96 7.1.3.1 */
 extern "C" speed_t
-cfgetospeed (struct termios *tp)
+cfgetospeed (const struct termios *tp)
 {
   return __tonew_termios (tp)->c_ospeed;
 }
 
 /* cfgetispeed: POSIX96 7.1.3.1 */
 extern "C" speed_t
-cfgetispeed (struct termios *tp)
+cfgetispeed (const struct termios *tp)
 {
   return __tonew_termios (tp)->c_ispeed;
 }
Index: include/sys/termios.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/termios.h,v
retrieving revision 1.18
diff -u -r1.18 termios.h
--- include/sys/termios.h	23 Oct 2010 18:07:08 -0000	1.18
+++ include/sys/termios.h	11 Jan 2011 09:07:39 -0000
@@ -317,9 +317,6 @@
 
 #define termio termios
 
-#define cfgetospeed(tp)		((tp)->c_ospeed)
-#define cfgetispeed(tp)		((tp)->c_ispeed)
-
 #ifdef __cplusplus
 extern "C" {
 #endif
@@ -331,6 +328,8 @@
 int tcflush (int, int);
 int tcflow (int, int);
 void cfmakeraw (struct termios *);
+speed_t cfgetispeed(const struct termios *);
+speed_t cfgetospeed(const struct termios *);
 int cfsetispeed (struct termios *, speed_t);
 int cfsetospeed (struct termios *, speed_t);
 
@@ -338,6 +337,11 @@
 }
 #endif
 
+#ifndef __cplusplus
+#define cfgetispeed(tp)		((tp)->c_ispeed)
+#define cfgetospeed(tp)		((tp)->c_ospeed)
+#endif
+
 /* Extra stuff to make porting stuff easier.  */
 struct winsize
 {

--=-H5N685Ex8UFJmYKBG2m/--
