Return-Path: <cygwin-patches-return-7488-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5350 invoked by alias); 19 Aug 2011 20:13:17 -0000
Received: (qmail 5337 invoked by uid 22791); 19 Aug 2011 20:13:15 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW
X-Spam-Check-By: sourceware.org
Received: from mail-yx0-f171.google.com (HELO mail-yx0-f171.google.com) (209.85.213.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Fri, 19 Aug 2011 20:13:01 +0000
Received: by yxs7 with SMTP id 7so849822yxs.2        for <cygwin-patches@cygwin.com>; Fri, 19 Aug 2011 13:13:00 -0700 (PDT)
Received: by 10.150.225.4 with SMTP id x4mr200033ybg.106.1313784780573;        Fri, 19 Aug 2011 13:13:00 -0700 (PDT)
Received: from [192.168.0.100] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id 9sm1580711ybb.1.2011.08.19.13.12.58        (version=SSLv3 cipher=OTHER);        Fri, 19 Aug 2011 13:12:59 -0700 (PDT)
Subject: [PATCH] <paths.h> additions
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Fri, 19 Aug 2011 20:13:00 -0000
Content-Type: multipart/mixed; boundary="=-5W/Mw0rhUZb7cKgWnPZy"
Message-ID: <1313784780.2220.14.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00064.txt.bz2


--=-5W/Mw0rhUZb7cKgWnPZy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 139

This patch adds _PATH_MAILDIR and _PATH_SHELLS to <paths.h>, as found on
Linux and *BSD.  This will save me a patch to kdeadmin.


Yaakov


--=-5W/Mw0rhUZb7cKgWnPZy
Content-Disposition: attachment; filename="paths_h.patch"
Content-Type: text/x-patch; name="paths_h.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 863

2011-08-19  Yaakov Selkowitz  <yselkowitz@...>

	* include/paths.h (_PATH_MAILDIR): Define.
	(_PATH_SHELLS): Define.

Index: include/paths.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/paths.h,v
retrieving revision 1.6
diff -u -p -r1.6 paths.h
--- include/paths.h	2 Nov 2010 17:38:36 -0000	1.6
+++ include/paths.h	19 Aug 2011 20:08:11 -0000
@@ -17,10 +17,12 @@ details. */
 #define _PATH_DEV	"/dev/"
 #define _PATH_DEVNULL	"/dev/null"
 #define _PATH_LASTLOG	"/var/log/lastlog"
+#define _PATH_MAILDIR	"/var/spool/mail/"
 #define _PATH_MAN	"/usr/share/man"
 #define _PATH_MEM	"/dev/mem"
 #define _PATH_MNTTAB	"/etc/fstab"
 #define _PATH_MOUNTED	"/etc/mtab"
+#define _PATH_SHELLS	"/etc/shells"
 #define _PATH_STDPATH	"/bin:/usr/sbin:/sbin"
 #define _PATH_TMP	"/tmp/"
 #define _PATH_TTY	"/dev/tty"

--=-5W/Mw0rhUZb7cKgWnPZy--
