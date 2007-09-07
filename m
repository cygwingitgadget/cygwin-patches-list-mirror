Return-Path: <cygwin-patches-return-6144-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 18716 invoked by alias); 7 Sep 2007 00:49:17 -0000
Received: (qmail 18517 invoked by uid 22791); 7 Sep 2007 00:49:16 -0000
X-Spam-Check-By: sourceware.org
Received: from dessent.net (HELO dessent.net) (69.60.119.225)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Sep 2007 00:49:11 +0000
Received: from localhost ([127.0.0.1] helo=dessent.net) 	by dessent.net with esmtp (Exim 4.50) 	id 1ITS21-0006gP-5L; Fri, 07 Sep 2007 00:49:09 +0000
Message-ID: <46E0A004.2BA35626@dessent.net>
Date: Fri, 07 Sep 2007 00:49:00 -0000
From: Brian Dessent <brian@dessent.net>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
CC: newlib@sourceware.org
Subject: Re: [patch] inline __getreent in newlib
References: <46E08F5C.D534F44E@dessent.net> <20070907001523.GA27234@ednor.casa.cgf.cx>
Content-Type: multipart/mixed;  boundary="------------91C76870FDF0305633397A43"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q3/txt/msg00019.txt.bz2

This is a multi-part message in MIME format.
--------------91C76870FDF0305633397A43
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 1355


CC'd to newlib: I've checked in the attached change to
libc/reent/getreent.c as obvious, please let me know if it breaks
anything.

Christopher Faylor wrote:

> So, I guess I'll come down on the side of speed over clarity.  I'm sure
> that Jeff won't mind your checking in the undef in newlib.  So, please
> check in everything but, again, document heavily what you're doing with
> the reent macro.

Done.  I added the following comment to config.h to hopefully clarify
the situation:

/* The following provides an inline version of __getreent() for newlib,
   which will be used throughout the library whereever there is a _r
   version of a function that takes _REENT.  This saves the overhead
   of a function call for what amounts to a simple computation.
   
   The definition below is essentially equivalent to the one in cygtls.h
   (&_my_tls.local_clib) however it uses a fixed precomputed
   offset rather than dereferencing a field of a structure.
   
   Including tlsoffets.h here in order to get this constant offset
   tls_local_clib is a bit of a hack, but the alternative would require
   dragging the entire definition of struct _cygtls (a large and complex
   Cygwin internal data structure) into newlib.  The machinery to
   compute these offsets already exists for the sake of gendef so
   we might as well just use it here.  */

Brian
--------------91C76870FDF0305633397A43
Content-Type: text/plain; charset=us-ascii;
 name="newlib-getreent-inline.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="newlib-getreent-inline.patch"
Content-length: 595

2007-09-06  Brian Dessent  <brian@dessent.net>

	* libc/reent/getreent.c: Allow for case where __getreent is
	defined as a macro.

Index: libc/reent/getreent.c
===================================================================
RCS file: /cvs/src/src/newlib/libc/reent/getreent.c,v
retrieving revision 1.1
diff -u -p -r1.1 getreent.c
--- libc/reent/getreent.c	17 May 2002 23:39:37 -0000	1.1
+++ libc/reent/getreent.c	6 Sep 2007 23:13:10 -0000
@@ -3,6 +3,10 @@
 #include <_ansi.h>
 #include <reent.h>
 
+#ifdef __getreent
+#undef __getreent
+#endif
+
 struct _reent *
 _DEFUN_VOID(__getreent)
 {

--------------91C76870FDF0305633397A43--
