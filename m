Return-Path: <cygwin-patches-return-7768-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32748 invoked by alias); 5 Nov 2012 02:41:55 -0000
Received: (qmail 32636 invoked by uid 22791); 5 Nov 2012 02:41:53 -0000
X-SWARE-Spam-Status: No, hits=-4.7 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,KHOP_RCVD_TRUST,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ie0-f171.google.com (HELO mail-ie0-f171.google.com) (209.85.223.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Nov 2012 02:41:47 +0000
Received: by mail-ie0-f171.google.com with SMTP id s9so7800069iec.2        for <cygwin-patches@cygwin.com>; Sun, 04 Nov 2012 18:41:47 -0800 (PST)
Received: by 10.50.46.199 with SMTP id x7mr8252650igm.19.1352083306964;        Sun, 04 Nov 2012 18:41:46 -0800 (PST)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net. [24.79.200.150])        by mx.google.com with ESMTPS id gs6sm5220171igc.11.2012.11.04.18.41.45        (version=TLSv1/SSLv3 cipher=OTHER);        Sun, 04 Nov 2012 18:41:46 -0800 (PST)
Message-ID: <1352083306.8040.10.camel@YAAKOV04>
Subject: [PATCH] additional sys/termios.h defines
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Mon, 05 Nov 2012 02:41:00 -0000
Content-Type: multipart/mixed; boundary="=-75rIbK+WlwhUiFb/ZEcp"
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
X-SW-Source: 2012-q4/txt/msg00045.txt.bz2


--=-75rIbK+WlwhUiFb/ZEcp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 110

The attached patch adds a few defines to <sys/termios.h> to make it
compatible with Linux and *BSD.


Yaakov


--=-75rIbK+WlwhUiFb/ZEcp
Content-Disposition: attachment; filename="ttydefaults.patch"
Content-Type: text/x-patch; name="ttydefaults.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1500

2012-11-04  Yaakov Selkowitz  <yselkowitz@...>

	* include/sys/termios.h (CBRK): Define as alias of CEOL.
	(CREPRINT): Define as alias of CRPRNT.
	(CDISCARD): Define as alias of CFLUSH.
	(TTYDEF_*): Define.

Index: include/sys/termios.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/termios.h,v
retrieving revision 1.22
diff -u -p -r1.22 termios.h
--- include/sys/termios.h	28 Feb 2012 14:03:03 -0000	1.22
+++ include/sys/termios.h	5 Nov 2012 02:35:34 -0000
@@ -85,6 +85,7 @@ POSIX commands */
 #define CEOT	CTRL('D')
 #define CEOL	0
 #define CEOL2	0
+#define CBRK	CEOL
 #define CEOF	CTRL('D')
 #define CSTART	CTRL('Q')
 #define CSTOP	CTRL('S')
@@ -93,7 +94,9 @@ POSIX commands */
 #define CSUSP	CTRL('Z')
 #define CDSUSP	CTRL('Y')
 #define CRPRNT	CTRL('R')
+#define CREPRINT	CRPRNT
 #define CFLUSH	CTRL('O')
+#define CDISCARD	CFLUSH
 #define CWERASE	CTRL('W')
 #define CLNEXT	CTRL('V')
 
@@ -241,6 +244,12 @@ POSIX commands */
    `struct termios'.  If VAL is _POSIX_VDISABLE, no character can match it.  */
 #define CCEQ(val, c)	((c) == (val) && (val) != _POSIX_VDISABLE)
 
+#define TTYDEF_IFLAG	(BRKINT	| ICRNL	| IMAXBEL | IXON | IXANY)
+#define TTYDEF_OFLAG	(OPOST | ONLCR)
+#define TTYDEF_LFLAG	(ICANON | ISIG | IEXTEN | ECHO | ECHOE | ECHOKE | ECHOCTL)
+#define TTYDEF_CFLAG	(CREAD | CS8 | HUPCL)
+#define TTYDEF_SPEED	(B9600)
+
 typedef unsigned char cc_t;
 typedef unsigned int  tcflag_t;
 typedef unsigned int  speed_t;

--=-75rIbK+WlwhUiFb/ZEcp--
