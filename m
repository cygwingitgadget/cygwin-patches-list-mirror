Return-Path: <cygwin-patches-return-6122-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27200 invoked by alias); 27 Jun 2007 00:57:34 -0000
Received: (qmail 27172 invoked by uid 22791); 27 Jun 2007 00:57:31 -0000
X-Spam-Check-By: sourceware.org
Received: from rwcrmhc11.comcast.net (HELO rwcrmhc11.comcast.net) (204.127.192.81)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 27 Jun 2007 00:57:28 +0000
Received: from [192.168.0.103] (c-24-10-242-83.hsd1.ut.comcast.net[24.10.242.83])           by comcast.net (rwcrmhc11) with ESMTP           id <20070627005726m110008o0ee>; Wed, 27 Jun 2007 00:57:26 +0000
Message-ID: <4681B668.3010201@byu.net>
Date: Wed, 27 Jun 2007 00:57:00 -0000
From: Eric Blake <ebb9@byu.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.12) Gecko/20070509 Thunderbird/1.5.0.12 Mnenhy/0.7.5.666
MIME-Version: 1.0
To:  cygwin-patches@cygwin.com
Subject: Re: C99 assert
References: <loom.20070626T181404-544@post.gmane.org> <46816D73.8050202@redhat.com> <loom.20070626T220222-433@post.gmane.org>
In-Reply-To: <loom.20070626T220222-433@post.gmane.org>
Content-Type: multipart/mixed;  boundary="------------020809090203070504020505"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00068.txt.bz2

This is a multi-part message in MIME format.
--------------020809090203070504020505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-length: 2166

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

According to Eric Blake on 6/26/2007 2:07 PM:
> Jeff Johnston <jjohnstn <at> redhat.com> writes:
[see thread at http://sourceware.org/ml/newlib/2007/msg00763.html -
cygwin's assert currently doesn't comply with POSIX]
> 
>> Hi Eric,
>>
>>    I'd like to see backward-compatiblity to be the old-style message 
>> format.  I don't see the point of saying: function <blank>.  So, old 
>> compiled calls to __assert would behave as they always have.  Similarly, 
>> for systems without function capability, I would like to use the old 
>> message format.  My take would be to have both __assert and 
>> __assert_func and have assert map to the appropriate call.  I also think 
>> that the function should be quoted or you should use a colon (e.g. 
>> function: getparms) for clarification.
>>
> 
> How about the following, then?
> 
> 2007-06-26  Eric Blake  <ebb9@byu.net>
> 
> 	Support __func__ in assert, as required by C99.
> 	* libc/stdlib/assert.c (__assert_func): New function.
> 	(__assert): Use __assert_func.
> 	* libc/include/assert.h (assert) [!NDEBUG]: Use __assert_func when
> 	possible.

If I check in just the above newlib patch, CVS cygwin will be broken when
trying to use assert (and simply exporting __assert_func won't help, since
cygwin's assert.cc must provide all symbols present in newlib's assert.c).
 Likewise, this patch without newlib would break (because assert.h is
maintained by newlib).  So, is it OK to apply this patch at the same time
as the newlib patch, to avoid breakage?

2007-06-26  Eric Blake  <ebb9@byu.net>

	* assert.cc (__assert_func): New function, to match newlib header
	change.
	* cygwin.din: Export __assert_func.
	* include/cygwin/version.h: Bump API minor number.

- --
Don't work too hard, make some time for fun as well!

Eric Blake             ebb9@byu.net
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Cygwin)
Comment: Public key at home.comcast.net/~ericblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFGgbZm84KuGfSFAYARAlGEAJ0SkMaoL1uk3ubAKlpOAHEpqwyoKgCfWvO1
Ab5YpcbXTEG7FSab/uuxDZo=
=W9ry
-----END PGP SIGNATURE-----

--------------020809090203070504020505
Content-Type: text/plain;
 name="cygwin.patch10"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cygwin.patch10"
Content-length: 3038

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.176
diff -u -p -r1.176 cygwin.din
--- cygwin.din	21 Jun 2007 15:57:54 -0000	1.176
+++ cygwin.din	27 Jun 2007 00:43:20 -0000
@@ -118,6 +118,7 @@ _asprintf = asprintf SIGFE
 asprintf_r = _asprintf_r SIGFE
 _asprintf_r SIGFE
 __assert SIGFE
+__assert_func SIGFE
 __assertfail SIGFE
 atan NOSIGFE
 _atan = atan NOSIGFE
Index: assert.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/assert.cc,v
retrieving revision 1.9
diff -u -p -r1.9 assert.cc
--- assert.cc	19 Sep 2002 15:12:48 -0000	1.9
+++ assert.cc	27 Jun 2007 00:43:20 -0000
@@ -1,6 +1,6 @@
 /* assert.cc: Handle the assert macro for WIN32.
 
-   Copyright 1997, 1998, 2000, 2001 Red Hat, Inc.
+   Copyright 1997, 1998, 2000, 2001, 2007 Red Hat, Inc.
 
 This file is part of Cygwin.
 
@@ -23,6 +23,13 @@ details. */
 extern "C" void
 __assert (const char *file, int line, const char *failedexpr)
 {
+  __assert_func (file, line, NULL, failedexpr);
+}
+
+extern "C" void
+__assert_func (const char *file, int line, const char *func,
+	       const char *failedexpr)
+{
   HANDLE h;
 
   /* If we don't have a console in a Windows program, then bring up a
@@ -35,15 +42,17 @@ __assert (const char *file, int line, co
       char *buf;
 
       buf = (char *) alloca (100 + strlen (failedexpr));
-      __small_sprintf (buf, "Failed assertion\n\t%s\nat line %d of file %s",
-		failedexpr, line, file);
+      __small_sprintf (buf, "Failed assertion\n\t%s\nat line %d of file %s%s%s",
+		       failedexpr, line, file,
+		       func ? "\nin function " : "", func ? func : "");
       MessageBox (NULL, buf, NULL, MB_OK | MB_ICONERROR | MB_TASKMODAL);
     }
   else
     {
       CloseHandle (h);
-      small_printf ("assertion \"%s\" failed: file \"%s\", line %d\n",
-		    failedexpr, file, line);
+      small_printf ("assertion \"%s\" failed: file \"%s\", line %d%s%s\n",
+		    failedexpr, file, line,
+		    func ? ", function: " : "", func ? func : "");
     }
 
 #ifdef DEBUGGING
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.246
diff -u -p -r1.246 version.h
--- include/cygwin/version.h	21 Jun 2007 15:57:54 -0000	1.246
+++ include/cygwin/version.h	27 Jun 2007 00:43:20 -0000
@@ -313,12 +313,13 @@ details. */
       171: Export exp10, exp10f, pow10, pow10f, strcasestr, funopen,
            fopencookie.
       172: Export getifaddrs, freeifaddrs.
+      173: Export __assert_func.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 172
+#define CYGWIN_VERSION_API_MINOR 173
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--------------020809090203070504020505--
