Return-Path: <cygwin-patches-return-7131-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 16912 invoked by alias); 2 Nov 2010 17:06:24 -0000
Received: (qmail 16901 invoked by uid 22791); 2 Nov 2010 17:06:22 -0000
X-SWARE-Spam-Status: No, hits=-50.8 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mail-px0-f171.google.com (HELO mail-px0-f171.google.com) (209.85.212.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 02 Nov 2010 17:06:18 +0000
Received: by pxi4 with SMTP id 4so1205220pxi.2        for <cygwin-patches@cygwin.com>; Tue, 02 Nov 2010 10:06:16 -0700 (PDT)
Received: by 10.229.86.149 with SMTP id s21mr1327499qcl.234.1288717575930;        Tue, 02 Nov 2010 10:06:15 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [24.76.240.202])        by mx.google.com with ESMTPS id s34sm6146324qcp.32.2010.11.02.10.06.14        (version=SSLv3 cipher=RC4-MD5);        Tue, 02 Nov 2010 10:06:15 -0700 (PDT)
Subject: [PATCH] define _PATH_VARTMP
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Content-Type: multipart/mixed; boundary="=-d1G4l3kt18hZcTUWfAgF"
Date: Tue, 02 Nov 2010 17:07:00 -0000
Message-ID: <1288717582.7256.43.camel@YAAKOV04>
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
X-SW-Source: 2010-q4/txt/msg00010.txt.bz2


--=-d1G4l3kt18hZcTUWfAgF
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-length: 63

Another glibc-ish <paths.h> define.  Patch attached.


Yaakov


--=-d1G4l3kt18hZcTUWfAgF
Content-Disposition: attachment; filename="paths-vartmp.patch"
Content-Type: text/x-patch; name="paths-vartmp.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 623

2010-11-02  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/paths.h (_PATH_VARTMP): Define.

Index: include/paths.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/paths.h,v
retrieving revision 1.5
diff -u -r1.5 paths.h
--- include/paths.h	2 Feb 2010 11:17:54 -0000	1.5
+++ include/paths.h	2 Nov 2010 16:16:55 -0000
@@ -26,6 +26,7 @@
 #define _PATH_TTY	"/dev/tty"
 #define _PATH_UTMP	"/var/run/utmp"
 #define _PATH_VARRUN	"/var/run/"
+#define _PATH_VARTMP	"/var/tmp/"
 #define _PATH_VI        "/bin/vi"
 #define _PATH_WTMP	"/var/log/wtmp"
 

--=-d1G4l3kt18hZcTUWfAgF--
