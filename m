Return-Path: <cygwin-patches-return-6038-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24682 invoked by alias); 13 Mar 2007 12:28:24 -0000
Received: (qmail 24671 invoked by uid 22791); 13 Mar 2007 12:28:23 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc11.comcast.net (HELO rwcrmhc11.comcast.net) (216.148.227.151)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Tue, 13 Mar 2007 12:28:12 +0000
Received: from [192.168.0.103] (c-67-186-254-72.hsd1.co.comcast.net[67.186.254.72])           by comcast.net (rwcrmhc11) with ESMTP           id <20070313122811m11009m2tpe>; Tue, 13 Mar 2007 12:28:11 +0000
Message-ID: <45F69971.4000604@byu.net>
Date: Tue, 13 Mar 2007 12:28:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.10) Gecko/20070221 Thunderbird/1.5.0.10 Mnenhy/0.7.4.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: compile warning in cygwin/stat.h
Content-Type: multipart/mixed;  boundary="------------050501060909080309070503"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q1/txt/msg00019.txt.bz2

This is a multi-part message in MIME format.
--------------050501060909080309070503
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 793

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch: http://cygwin.com/ml/cygwin-cvs/2007-q1/msg00123.html
breaks compilation of coreutils against the latest snapshot when using
- -Wall -Werror, due to an unused expression on the left of a comma.

2007-03-13  Eric Blake  <ebb9@byu.net>

	* include/cygwin/stat.h (S_TYPEISSHM, S_TYPEISSEM, S_TYPEISSHM):
	Avoid compiler warnings.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF9plw84KuGfSFAYARAotJAJ9BAhe/pj0BKfM4hnnv9Nz0h+ebiwCcCkZ+
eo+aekowcQMQsmIZMyAIrU0=
=BSsC
-----END PGP SIGNATURE-----

--------------050501060909080309070503
Content-Type: text/plain;
 name="cygwin.patch5"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch5"
Content-length: 853

Index: include/cygwin/stat.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/stat.h,v
retrieving revision 1.10
diff -u -p -r1.10 stat.h
--- include/cygwin/stat.h	6 Mar 2007 14:56:44 -0000	1.10
+++ include/cygwin/stat.h	13 Mar 2007 12:26:19 -0000
@@ -91,9 +91,9 @@ struct stat
 /* POSIX IPC objects are not implemented as distinct file types, so the
    below macros have to return 0.  The expression is supposed to catch
    illegal usage with non-stat parameters. */
-#define S_TYPEISMQ(buf)  ((buf)->st_mode,0)
-#define S_TYPEISSEM(buf) ((buf)->st_mode,0)
-#define S_TYPEISSHM(buf) ((buf)->st_mode,0)
+#define S_TYPEISMQ(buf)  ((void)(buf)->st_mode,0)
+#define S_TYPEISSEM(buf) ((void)(buf)->st_mode,0)
+#define S_TYPEISSHM(buf) ((void)(buf)->st_mode,0)
 
 #ifdef __cplusplus
 }

--------------050501060909080309070503--
