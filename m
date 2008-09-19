Return-Path: <cygwin-patches-return-6354-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28627 invoked by alias); 19 Sep 2008 22:07:55 -0000
Received: (qmail 28505 invoked by uid 22791); 19 Sep 2008 22:07:54 -0000
X-Spam-Check-By: sourceware.org
Received: from qmta06.emeryville.ca.mail.comcast.net (HELO QMTA06.emeryville.ca.mail.comcast.net) (76.96.30.56)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 19 Sep 2008 22:06:53 +0000
Received: from OMTA10.emeryville.ca.mail.comcast.net ([76.96.30.28]) 	by QMTA06.emeryville.ca.mail.comcast.net with comcast 	id GbET1a0050cQ2SLA6m6sdG; Fri, 19 Sep 2008 22:06:52 +0000
Received: from [192.168.0.101] ([67.166.125.73]) 	by OMTA10.emeryville.ca.mail.comcast.net with comcast 	id Gm6o1a0021b8C2B8Wm6oXr; Fri, 19 Sep 2008 22:06:49 +0000
X-Authority-Analysis: v=1.0 c=1 a=xe8BsctaAAAA:8 a=3yv_nbDT3vgKKC779_YA:9  a=3CMuMWeWmzG4TufzTvig2dfpTt8A:4 a=eDFNAWYWrCwA:10 a=rPt6xJ-oxjAA:10  a=jtExPBr8j1Iz-dRy9CUA:9 a=_Doqc5wIh8ZzVP4YzOIA:7  a=XFMRZwnPIVqRCU1L4K9qc5Wfix4A:4 a=5WZzfXpOq_gA:10
Message-ID: <48D4226C.1030406@byu.net>
Date: Fri, 19 Sep 2008 22:07:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080708 Thunderbird/2.0.0.16 Mnenhy/0.7.5.666
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: strerrno and new errno values
Content-Type: multipart/mixed;  boundary="------------070905000707040705040001"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00017.txt.bz2

This is a multi-part message in MIME format.
--------------070905000707040705040001
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 640

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

OK to apply, to match newlib and in preparation for POSIX 200x?

2008-09-19  Eric Blake  <ebb9@byu.net>

	* errno.cc (_sys_errlist): Add ECANCELED, ENOTRECOVERABLE,
	EOWNERDEAD.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkjUImwACgkQ84KuGfSFAYAWvQCfQO21uJM4UCVJSdZMWQrQ2VRX
/xEAoJ0+riWwRf6pQnOtnun4c8008U8z
=iAt5
-----END PGP SIGNATURE-----

--------------070905000707040705040001
Content-Type: text/plain;
 name="cygwin.patch14"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch14"
Content-length: 882

Index: errno.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
retrieving revision 1.67
diff -u -p -b -r1.67 errno.cc
--- errno.cc	11 Sep 2008 06:22:31 -0000	1.67
+++ errno.cc	19 Sep 2008 22:05:33 -0000
@@ -284,7 +284,10 @@ const char *_sys_errlist[] NO_COPY_INIT 
 /* ENOSHARE 136 */  	  "No such host or network path",
 /* ECASECLASH 137 */	  "Filename exists with different case",
 /* EILSEQ 138 */	  "Invalid or incomplete multibyte or wide character",
-/* EOVERFLOW 139 */	  "Value too large for defined data type"
+/* EOVERFLOW 139 */	  "Value too large for defined data type",
+/* ECANCELED 140 */	  "Operation canceled",
+/* ENOTRECOVERABLE 141 */ "State not recoverable",
+/* EOWNERDEAD 142 */	  "Previous owner died"
 };
 
 int NO_COPY_INIT _sys_nerr = sizeof (_sys_errlist) / sizeof (_sys_errlist[0]);

--------------070905000707040705040001--
