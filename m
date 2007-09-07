Return-Path: <cygwin-patches-return-6145-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27371 invoked by alias); 7 Sep 2007 23:19:22 -0000
Received: (qmail 27361 invoked by uid 22791); 7 Sep 2007 23:19:21 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Sep 2007 23:19:14 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1ITn6X-0001gN-7v 	for cygwin-patches@cygwin.com; Fri, 07 Sep 2007 23:19:13 +0000
Message-ID: <46E1DC70.57961D04@dessent.net>
Date: Fri, 07 Sep 2007 23:19:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [patch] inline __getreent in newlib
References: <46E08F5C.D534F44E@dessent.net> <20070907001523.GA27234@ednor.casa.cgf.cx> <46E0A004.2BA35626@dessent.net>
Content-Type: multipart/mixed;  boundary="------------7209BDEA539BDA765EDBE11A"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00020.txt.bz2

This is a multi-part message in MIME format.
--------------7209BDEA539BDA765EDBE11A
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1592

Brian Dessent wrote:

> Done.  I added the following comment to config.h to hopefully clarify
> the situation:
> 
> /* The following provides an inline version of __getreent() for newlib,
>    which will be used throughout the library whereever there is a _r
>    version of a function that takes _REENT.  This saves the overhead
>    of a function call for what amounts to a simple computation.
> 
>    The definition below is essentially equivalent to the one in cygtls.h
>    (&_my_tls.local_clib) however it uses a fixed precomputed
>    offset rather than dereferencing a field of a structure.
> 
>    Including tlsoffets.h here in order to get this constant offset
>    tls_local_clib is a bit of a hack, but the alternative would require
>    dragging the entire definition of struct _cygtls (a large and complex
>    Cygwin internal data structure) into newlib.  The machinery to
>    compute these offsets already exists for the sake of gendef so
>    we might as well just use it here.  */

Turns out that <sys/config.h> includes <cygwin/config.h>, which leads to
this breakage when the winsup headers are installed in the system
location:

$ echo "#include <math.h>" | gcc -x c -
In file included from /usr/include/sys/config.h:180,
                 from /usr/include/_ansi.h:16,
                 from /usr/include/sys/reent.h:13,
                 from /usr/include/math.h:5,
                 from <stdin>:1:
/usr/include/cygwin/config.h:22:27: ../tlsoffsets.h: No such file or
directory

Attached patch fixes the situation by only exposing this when
_COMPILING_NEWLIB.  Ok?

Brian
--------------7209BDEA539BDA765EDBE11A
Content-Type: text/plain; charset=us-ascii;
 name="newlib-getreent-guard.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newlib-getreent-guard.patch"
Content-length: 900

2007-09-07  Brian Dessent  <brian@dessent.net>

	* include/cygwin/config.h: Conditionalize inline __getreent()
	definition on _COMPILING_NEWLIB.

Index: include/cygwin/config.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/config.h,v
retrieving revision 1.6
diff -u -p -r1.6 config.h
--- include/cygwin/config.h	7 Sep 2007 00:44:27 -0000	1.6
+++ include/cygwin/config.h	7 Sep 2007 23:15:23 -0000
@@ -37,9 +37,11 @@ extern "C" {
    compute these offsets already exists for the sake of gendef so
    we might as well just use it here.  */
 
+#ifdef _COMPILING_NEWLIB
 #include "../tlsoffsets.h"
 extern char *_tlsbase __asm__ ("%fs:4");
 #define __getreent() (struct _reent *)(_tlsbase + tls_local_clib)
+#endif  /* _COMPILING_NEWLIB */
 
 #define __FILENAME_MAX__ (260 - 1 /* NUL */)
 #define _READ_WRITE_RETURN_TYPE _ssize_t

--------------7209BDEA539BDA765EDBE11A--
