Return-Path: <cygwin-patches-return-7430-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20333 invoked by alias); 18 Jul 2011 22:27:18 -0000
Received: (qmail 20323 invoked by uid 22791); 18 Jul 2011 22:27:17 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 18 Jul 2011 22:26:45 +0000
Received: by yib12 with SMTP id 12so1818060yib.2        for <cygwin-patches@cygwin.com>; Mon, 18 Jul 2011 15:26:44 -0700 (PDT)
Received: by 10.150.175.17 with SMTP id x17mr959099ybe.11.1311028004412;        Mon, 18 Jul 2011 15:26:44 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id v10sm2030494ybv.9.2011.07.18.15.26.43        (version=SSLv3 cipher=OTHER);        Mon, 18 Jul 2011 15:26:43 -0700 (PDT)
Subject: [PATCH] update sysconf, confstr, limits
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Date: Mon, 18 Jul 2011 22:27:00 -0000
Content-Type: multipart/mixed; boundary="=-+VpjW81pEDO1/FClfg1s"
Message-ID: <1311028013.7348.5.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00006.txt.bz2


--=-+VpjW81pEDO1/FClfg1s
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 276

This patch adds return values for recent additions to sysconf() and
confstr(), and adds a couple of missing <limits.h> defines required by
POSIX.

This patch, plus the one just posted to newlib@, are required for my
next patch, a getconf(1) implementation.


Yaakov
Cygwin/X


--=-+VpjW81pEDO1/FClfg1s
Content-Disposition: attachment; filename="cygwin-sysconf-update.patch"
Content-Type: text/x-patch; name="cygwin-sysconf-update.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 2952

2011-07-18  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* sysconf.cc (sca): Return -1 for _SC_THREAD_ROBUST_PRIO_INHERIT,
	_SC_THREAD_ROBUST_PRIO_PROTECT, and _SC_XOPEN_UUCP.
	(SC_MAX): Redefine accordingly.
	(csa): Return strings for _CS_POSIX_V7_THREADS_CFLAGS,
	_CS_POSIX_V7_THREADS_LDFLAGS, and _CS_V7_ENV.
	(CS_MAX): Redefine accordingly.
	* include/limits.h (LONG_BIT): Define.
	(WORD_BIT): Define.

Index: sysconf.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/sysconf.cc,v
retrieving revision 1.59
diff -u -p -r1.59 sysconf.cc
--- sysconf.cc	6 Jun 2011 05:02:13 -0000	1.59
+++ sysconf.cc	18 Jul 2011 22:17:42 -0000
@@ -219,10 +219,13 @@ static struct
   {cons, {c:_POSIX2_SW_DEV}},		/* 119, _SC_2_SW_DEV */
   {cons, {c:_POSIX2_UPE}},		/* 120, _SC_2_UPE */
   {cons, {c:_POSIX2_VERSION}},		/* 121, _SC_2_VERSION */
+  {cons, {c:-1L}},			/* 122, _SC_THREAD_ROBUST_PRIO_INHERIT */
+  {cons, {c:-1L}},			/* 123, _SC_THREAD_ROBUST_PRIO_PROTECT */
+  {cons, {c:-1L}},			/* 124, _SC_XOPEN_UUCP */
 };
 
 #define SC_MIN _SC_ARG_MAX
-#define SC_MAX _SC_2_VERSION
+#define SC_MAX _SC_XOPEN_UUCP
 
 /* sysconf: POSIX 4.8.1.1 */
 /* Allows a portable app to determine quantities of resources or
@@ -259,7 +262,7 @@ static struct
   {0, NULL},				/* _CS_POSIX_V6_ILP32_OFF32_CFLAGS */
   {0, NULL},				/* _CS_POSIX_V6_ILP32_OFF32_LDFLAGS */
   {0, NULL},				/* _CS_POSIX_V6_ILP32_OFF32_LIBS */
-  {0, NULL},				/* _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS */
+  {0, NULL},				/* _CS_XBS5_ILP32_OFF32_LINTFLAGS */
   {ls ("")},				/* _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS */
   {ls ("")},				/* _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS */
   {ls ("")},				/* _CS_POSIX_V6_ILP32_OFFBIG_LIBS */
@@ -273,10 +276,13 @@ static struct
   {0, NULL},				/* _CS_POSIX_V6_LPBIG_OFFBIG_LIBS */
   {0, NULL},				/* _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS */
   {ls ("POSIX_V6_ILP32_OFFBIG")},	/* _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS */
+  {ls ("")},				/* _CS_POSIX_V7_THREADS_CFLAGS */
+  {ls ("")},				/* _CS_POSIX_V7_THREADS_LDFLAGS */
+  {ls ("POSIXLY_CORRECT=1")},		/* _CS_V7_ENV */
 };
 
 #define CS_MIN _CS_PATH
-#define CS_MAX _CS_POSIX_V6_WIDTH_RESTRICTED_ENVS
+#define CS_MAX _CS_V7_ENV
 
 extern "C" size_t
 confstr (int in, char *buf, size_t len)
Index: include/limits.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/limits.h,v
retrieving revision 1.26
diff -u -p -r1.26 limits.h
--- include/limits.h	11 Aug 2009 07:28:22 -0000	1.26
+++ include/limits.h	18 Jul 2011 22:17:42 -0000
@@ -26,6 +26,14 @@ details. */
 #undef CHAR_BIT
 #define CHAR_BIT 8
 
+/* Number of bits in a `long'.  */
+#undef LONG_BIT
+#define LONG_BIT 32
+
+/* Number of bits in a `int'.  */
+#undef WORD_BIT
+#define WORD_BIT 32
+
 /* Maximum length of a multibyte character.  */
 #ifndef MB_LEN_MAX
 /* TODO: This is newlib's max value.  We should probably rather define our

--=-+VpjW81pEDO1/FClfg1s--
