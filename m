Return-Path: <cygwin-patches-return-6452-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27130 invoked by alias); 23 Mar 2009 03:38:43 -0000
Received: (qmail 27120 invoked by uid 22791); 23 Mar 2009 03:38:42 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f123.google.com (HELO mail-qy0-f123.google.com) (209.85.221.123)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 23 Mar 2009 03:38:35 +0000
Received: by qyk29 with SMTP id 29so2086395qyk.18         for <cygwin-patches@cygwin.com>; Sun, 22 Mar 2009 20:38:32 -0700 (PDT)
Received: by 10.224.2.200 with SMTP id 8mr8223571qak.341.1237779512337;         Sun, 22 Mar 2009 20:38:32 -0700 (PDT)
Received: from ?192.168.0.100? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id 7sm4689509qwb.51.2009.03.22.20.38.30         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Sun, 22 Mar 2009 20:38:31 -0700 (PDT)
Message-ID: <49C70438.10403@users.sourceforge.net>
Date: Mon, 23 Mar 2009 03:38:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] <sys/un.h> uses strlen from <string.h>
Content-Type: multipart/mixed;  boundary="------------040302060805080603050703"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00050.txt.bz2

This is a multi-part message in MIME format.
--------------040302060805080603050703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 551

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

The SUN_LEN macro in <sys/un.h> calls strlen but doesn't #include
<string.h> for its prototype.  Patch attached.

2009-03-22  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

    * include/sys/un.h: #include <string.h> for strlen.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAknHBDgACgkQpiWmPGlmQSNnXwCg40eYsxbTT5v7O0FbZdt/fQfR
rHgAoINxorPjYZGHzJ0oeXuAyixpaqeO
=dZwV
-----END PGP SIGNATURE-----

--------------040302060805080603050703
Content-Type: text/x-patch;
 name="cygwin-sys_un.h-strlen.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-sys_un.h-strlen.patch"
Content-length: 585

2009-03-22  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>

	* include/sys/un.h: #include <string.h> for strlen.


Index: include/sys/un.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/sys/un.h,v
retrieving revision 1.4
diff -u -r1.4 un.h
--- include/sys/un.h	31 Dec 2005 13:07:43 -0000	1.4
+++ include/sys/un.h	23 Mar 2009 03:33:59 -0000
@@ -11,6 +11,7 @@
 #ifndef _SYS_UN_H
 #define _SYS_UN_H
 
+#include <string.h>		/* for strlen */
 #include <cygwin/socket.h>
 
 /* POSIX requires only at least 100 bytes */

--------------040302060805080603050703--
