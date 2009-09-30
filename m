Return-Path: <cygwin-patches-return-6662-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3224 invoked by alias); 30 Sep 2009 12:07:59 -0000
Received: (qmail 3205 invoked by uid 22791); 30 Sep 2009 12:07:57 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0 	tests=AWL,BAYES_00,SPF_SOFTFAIL
X-Spam-Check-By: sourceware.org
Received: from qmta05.emeryville.ca.mail.comcast.net (HELO QMTA05.emeryville.ca.mail.comcast.net) (76.96.30.48)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 30 Sep 2009 12:07:51 +0000
Received: from OMTA18.emeryville.ca.mail.comcast.net ([76.96.30.74]) 	by QMTA05.emeryville.ca.mail.comcast.net with comcast 	id n03g1c0021bwxycA507qBM; Wed, 30 Sep 2009 12:07:50 +0000
Received: from [192.168.0.101] ([24.10.247.15]) 	by OMTA18.emeryville.ca.mail.comcast.net with comcast 	id n0DR1c0080Lg2Gw8e0DS4z; Wed, 30 Sep 2009 12:13:26 +0000
Message-ID: <4AC34A01.4070509@byu.net>
Date: Wed, 30 Sep 2009 12:07:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.23) Gecko/20090812 Thunderbird/2.0.0.23 Mnenhy/0.7.6.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: detect . in a/.//
Content-Type: multipart/mixed;  boundary="------------010406010402040907090802"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q3/txt/msg00116.txt.bz2

This is a multi-part message in MIME format.
--------------010406010402040907090802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1095

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

My testing on rename found another corner case: we rejected
rename("dir","a/./") but accepted rename("dir","a/.//").  OK to commit?

For reference, the test I am writing for hammering rename() and renameat()
corner cases is currently visible here; it will be part of the next
coreutils release, among other places.  It currently stands at 400+ lines,
and exposes bugs in NetBSD, Solaris 10, mingw, and cygwin 1.5, but passes
on cygwin 1.7 (after this patch) and on Linux:
http://repo.or.cz/w/gnulib/ericb.git?a=blob;f=tests/test-rename.h

2009-09-30  Eric Blake  <ebb9@byu.net>

	* path.cc (has_dot_last_component): Detect "a/.//".

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAkrDSgEACgkQ84KuGfSFAYDIHACgqgrcRJ0E9NuYHTsZpgopyDY7
+YMAnj0pA/eQ1DbHPNPn4dpg4ddoem4p
=3WS7
-----END PGP SIGNATURE-----

--------------010406010402040907090802
Content-Type: text/plain;
 name="cygwin.patch28"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch28"
Content-length: 734

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index e543dd4..9f24f4f 100644
--- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -207,11 +207,16 @@ has_dot_last_component (const char *dir, bool test_dot_dot)
   if (!last_comp)
     last_comp = dir;
   else {
-    /* Check for trailing slash.  If so, hop back to the previous slash. */
+    /* Check for trailing slashes.  If so, hop back to the previous slash. */
     if (!last_comp[1])
-      while (last_comp > dir)
-	if (*--last_comp == '/')
-	  break;
+      {
+	while (last_comp > dir)
+	  if (*--last_comp != '/')
+	    break;
+	while (last_comp > dir)
+	  if (*--last_comp == '/')
+	    break;
+      }
     if (*last_comp == '/')
       ++last_comp;
   }

--------------010406010402040907090802--
