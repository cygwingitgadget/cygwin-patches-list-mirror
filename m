Return-Path: <cygwin-patches-return-6454-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 15269 invoked by alias); 24 Mar 2009 06:37:48 -0000
Received: (qmail 15257 invoked by uid 22791); 24 Mar 2009 06:37:47 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0 	tests=AWL,BAYES_00,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-qy0-f123.google.com (HELO mail-qy0-f123.google.com) (209.85.221.123)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 24 Mar 2009 06:37:42 +0000
Received: by qyk29 with SMTP id 29so2812402qyk.18         for <cygwin-patches@cygwin.com>; Mon, 23 Mar 2009 23:37:37 -0700 (PDT)
Received: by 10.224.6.83 with SMTP id 19mr5469555qay.128.1237876657482;         Mon, 23 Mar 2009 23:37:37 -0700 (PDT)
Received: from ?192.168.0.100? (S0106001346f94b85.wp.shawcable.net [24.76.249.6])         by mx.google.com with ESMTPS id 6sm11115457ywi.3.2009.03.23.23.37.35         (version=TLSv1/SSLv3 cipher=RC4-MD5);         Mon, 23 Mar 2009 23:37:37 -0700 (PDT)
Message-ID: <49C87FB0.4010005@users.sourceforge.net>
Date: Tue, 24 Mar 2009 06:37:00 -0000
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [PATCH] mntent.h cleanup
Content-Type: multipart/mixed;  boundary="------------090802080705040803080802"
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q1/txt/msg00052.txt.bz2

This is a multi-part message in MIME format.
--------------090802080705040803080802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 624

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

According to the ChangeLogs, addmntent and hasmntopt were removed in
1996(!).  Also, update and (hopefully) clarify a comment.


2009-03-24  Yaakov Selkowitz  <yselkowitz@cygwin.com>

	* include/mntent.h: Remove declarations of nonexistant addmntent
	and hasmntopt.  Update and clarify the /etc/mtab comment.


Yaakov
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEAREIAAYFAknIf7AACgkQpiWmPGlmQSNwrwCeNcCcYe1vqxvDbjT2OSgLfZdp
91gAmgNzj0TZqlzQ8apv2p09yT7qikBH
=NbWF
-----END PGP SIGNATURE-----

--------------090802080705040803080802
Content-Type: text/x-patch;
 name="cygwin-mntent.h-cleanup.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin-mntent.h-cleanup.patch"
Content-length: 997

Index: include/mntent.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/mntent.h,v
retrieving revision 1.4
diff -u -r1.4 mntent.h
--- include/mntent.h	13 Feb 2006 19:01:32 -0000	1.4
+++ include/mntent.h	24 Mar 2009 06:34:09 -0000
@@ -29,18 +29,17 @@
 #include <stdio.h>
 FILE *setmntent (const char *__filep, const char *__type);
 struct mntent *getmntent (FILE *__filep);
-int addmntent (FILE *__filep, const struct mntent *__mnt);
 int endmntent (FILE *__filep);
-char *hasmntopt (const struct mntent *__mnt, const char *__opt);
 #endif
 
-/* This next file doesn't exist, it is in the registry,
-   however applications need the define to pass to
-   the above calls.
+/* This next file does exist, but the implementation of these
+   functions does not actually use it.
+   However, applications need the define to pass to setmntent().
 */
 #ifndef MOUNTED
 #define MOUNTED "/etc/mtab"
 #endif
+
 #ifdef __cplusplus
 };
 #endif

--------------090802080705040803080802--
