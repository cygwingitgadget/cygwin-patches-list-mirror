Return-Path: <cygwin-patches-return-5825-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8569 invoked by alias); 17 Apr 2006 12:18:44 -0000
Received: (qmail 8559 invoked by uid 22791); 17 Apr 2006 12:18:43 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc14.comcast.net (HELO rwcrmhc14.comcast.net) (216.148.227.154)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Mon, 17 Apr 2006 12:18:42 +0000
Received: from [192.168.0.100] (c-24-10-241-225.hsd1.ut.comcast.net[24.10.241.225])           by comcast.net (rwcrmhc14) with ESMTP           id <20060417121840m1400r6jkfe>; Mon, 17 Apr 2006 12:18:40 +0000
Message-ID: <4443879E.1000406@byu.net>
Date: Mon, 17 Apr 2006 12:18:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: mkstemp vs. text mode
Content-Type: multipart/mixed;  boundary="------------040007000701040505090804"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q2/txt/msg00013.txt.bz2

This is a multi-part message in MIME format.
--------------040007000701040505090804
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 1378

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Should we change mkstemp to always open in binary mode, regardless of the
mount mode of the directory of the template name?  Arguments for this is
that mkstemp is often used by programs for binary data, where a text-mode
/tmp mount point would corrupt that data if we defer to the mount point.
Also, a temp file is an intermediate data storage location, similar to
pipes, and we currently treat pipes as binary by default; a program
copying data to a temp file, then from there to a final destination, only
needs text mode on the final destination.  Programs that really want a
text-mode temp file can do setmode after the fact, but this is probably
less common.

This should still be a trivial patch.  Meanwhile, I will start the process
of getting an employee disclaimer for Red Hat (it took me almost a year to
get one signed for FSF).

2006-04-17  Eric Blake  <ebb9@byu.net>

	* mktemp.cc (_gettemp): Open temp files in binary mode.

- --
Life is short - so eat dessert first!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.1 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEQ4ee84KuGfSFAYARAkpIAKCYK1IRVHZ4dMkWUTgyzycxyMkBawCfXgz4
wCvt41FDUXLB67JFnv+vZgg=
=LLV/
-----END PGP SIGNATURE-----

--------------040007000701040505090804
Content-Type: text/plain;
 name="cygwin.patch1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch1"
Content-length: 596

Index: mktemp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/mktemp.cc,v
retrieving revision 1.2
diff -u -p -r1.2 mktemp.cc
--- mktemp.cc	25 May 2005 03:43:58 -0000	1.2
+++ mktemp.cc	17 Apr 2006 12:15:39 -0000
@@ -105,7 +105,8 @@ _gettemp(char *path, int *doopen, int do
     {
       if (doopen)
 	{
-	  if ((*doopen = open (path, O_CREAT | O_EXCL | O_RDWR, 0600)) >= 0)
+	  if ((*doopen = open (path, O_CREAT | O_EXCL | O_RDWR | O_BINARY,
+			       S_IRUSR | S_IWUSR)) >= 0)
 	    return 1;
 	  if (errno != EEXIST)
 	    return 0;

--------------040007000701040505090804--
