Return-Path: <cygwin-patches-return-3091-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 7123 invoked by alias); 29 Oct 2002 14:06:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7026 invoked from network); 29 Oct 2002 14:06:09 -0000
Date: Tue, 29 Oct 2002 06:06:00 -0000
From: Jason Tishler <jason@tishler.net>
Subject: export fseeko() and ftello() patch
To: Cygwin-Patches <cygwin-patches@cygwin.com>
Mail-followup-to: Cygwin-Patches <cygwin-patches@cygwin.com>
Message-id: <20021029141111.GA1812@tishler.net>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_xTg8gWZC6mHa7YmHwEjTvw)"
User-Agent: Mutt/1.4i
X-SW-Source: 2002-q4/txt/msg00042.txt.bz2


--Boundary_(ID_xTg8gWZC6mHa7YmHwEjTvw)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-length: 502

The attached patch exports newlib's fseeko() and ftello().  Besides
being generally useful, this patch also solves the first build issue in
the following:

    http://archives.postgresql.org/pgsql-cygwin/2002-10/msg00039.php

Note that I would like to include a hunk for winsup/doc/calls.texinfo,
but I don't know where to find the associated item information.  For
example, where does one find the following?

    @item fseek: C 4.9.9.2, P 8.2.3.7
                 ^^^^^^^^^  ^^^^^^^^^

Thanks,
Jason

--Boundary_(ID_xTg8gWZC6mHa7YmHwEjTvw)
Content-type: text/plain; charset=us-ascii; NAME=fseeko.patch
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=fseeko.patch
Content-length: 1408

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.65
diff -u -p -r1.65 cygwin.din
--- cygwin.din	21 Oct 2002 01:00:56 -0000	1.65
+++ cygwin.din	29 Oct 2002 13:45:26 -0000
@@ -310,6 +310,8 @@ _fscanf_r
 fscanf_r = _fscanf_r
 fseek
 _fseek = fseek
+fseeko
+_fseeko = fseeko
 fsetpos
 _fsetpos = fsetpos
 _fstat
@@ -325,6 +327,8 @@ _f_tanf
 __f_tanf = _f_tanf
 ftell
 _ftell = ftell
+ftello
+_ftello = ftello
 ftime
 _ftime = ftime
 ftruncate
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.80
diff -u -p -r1.80 version.h
--- include/cygwin/version.h	23 Oct 2002 02:20:38 -0000	1.80
+++ include/cygwin/version.h	29 Oct 2002 13:45:26 -0000
@@ -160,12 +160,13 @@ details. */
        61: Export getc_unlocked, getchar_unlocked, putc_unlocked,
 	   putchar_unlocked
        62: Erroneously bumped.
+       63: Export fseeko, ftello
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 62
+#define CYGWIN_VERSION_API_MINOR 63
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--Boundary_(ID_xTg8gWZC6mHa7YmHwEjTvw)
Content-type: text/plain; charset=us-ascii; NAME=fseeko.ChangeLog
Content-transfer-encoding: 7BIT
Content-disposition: attachment; filename=fseeko.ChangeLog
Content-length: 145

Tue Oct 29 08:53:57 2002  <jason@tishler.net>

	* cygwin.din: Export fseeko() and ftello().
	* include/cygwin/version.h: Bump API minor version.

--Boundary_(ID_xTg8gWZC6mHa7YmHwEjTvw)--
