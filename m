Return-Path: <cygwin-patches-return-7373-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2275 invoked by alias); 18 May 2011 00:21:08 -0000
Received: (qmail 2254 invoked by uid 22791); 18 May 2011 00:21:06 -0000
X-SWARE-Spam-Status: No, hits=-2.3 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,TW_CP,TW_NV,TW_RR,TW_VF,TW_VP
X-Spam-Check-By: sourceware.org
Received: from mail-yi0-f43.google.com (HELO mail-yi0-f43.google.com) (209.85.218.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 May 2011 00:20:48 +0000
Received: by yie16 with SMTP id 16so484409yie.2        for <cygwin-patches@cygwin.com>; Tue, 17 May 2011 17:20:47 -0700 (PDT)
Received: by 10.236.145.230 with SMTP id p66mr1326147yhj.343.1305678047439;        Tue, 17 May 2011 17:20:47 -0700 (PDT)
Received: from [127.0.0.1] (S0106000cf16f58b1.wp.shawcable.net [174.5.115.130])        by mx.google.com with ESMTPS id p9sm471193yhm.7.2011.05.17.17.20.45        (version=SSLv3 cipher=OTHER);        Tue, 17 May 2011 17:20:46 -0700 (PDT)
Subject: [PATCH] error.h
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches <cygwin-patches@cygwin.com>
Date: Wed, 18 May 2011 00:21:00 -0000
Content-Type: multipart/mixed; boundary="=-Jw5sbfHIGuMDye6gdqBQ"
Message-ID: <1305678052.6192.5.camel@YAAKOV04>
Mime-Version: 1.0
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00139.txt.bz2


--=-Jw5sbfHIGuMDye6gdqBQ
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 435

This patch series adds error.h and the error(3) functions, a GNU
extension:

http://www.kernel.org/doc/man-pages/online/pages/man3/error.3.html

I implemented this within Cygwin itself instead of newlib, because it is
a GNU extension which depends on program_invocation_name, another GNU
extension available only in Cygwin.

Patches for winsup/cygwin and winsup/doc, the new error.h header, and a
test application, attached.


Yaakov


--=-Jw5sbfHIGuMDye6gdqBQ
Content-Disposition: attachment; filename="error.patch"
Content-Type: text/x-patch; name="error.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 4871

http://www.kernel.org/doc/man-pages/online/pages/man3/error.3.html

2011-05-17  Yaakov Selkowitz  <yselkowitz@...>

	* cygwin.din (error): Export.
	(error_at_line): Export.
	(error_message_count): Export.
	(error_one_per_line): Export.
	(error_print_progname): Export.
	* errno.cc (error_message_count): Define.
	(error_one_per_line): Define.
	(error_print_progname): Define.
	(_verror): New static function.
	(error): New function.
	(error_at_line): New function.
	* posix.sgml (std-gnu): Add error, error_at_line.
	* include/error.h: New header.
	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Index: cygwin.din
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/cygwin.din,v
retrieving revision 1.241
diff -u -r1.241 cygwin.din
--- cygwin.din	15 May 2011 18:49:39 -0000	1.241
+++ cygwin.din	16 May 2011 05:50:06 -0000
@@ -10,6 +10,9 @@
 __cygwin_environ DATA
 __cygwin_user_data DATA
 _daylight DATA
+error_message_count DATA
+error_one_per_line DATA
+error_print_progname DATA
 h_errno DATA
 _impure_ptr DATA
 in6addr_any DATA
@@ -389,6 +392,8 @@
 _erff = erff NOSIGFE
 err SIGFE
 __errno NOSIGFE
+error SIGFE
+error_at_line SIGFE
 errx SIGFE
 euidaccess SIGFE
 execl SIGFE
Index: errno.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/errno.cc,v
retrieving revision 1.81
diff -u -r1.81 errno.cc
--- errno.cc	29 Apr 2011 18:54:23 -0000	1.81
+++ errno.cc	16 May 2011 05:50:06 -0000
@@ -13,6 +13,13 @@
 #define sys_nerr FOOsys_nerr
 #define _sys_errlist FOO_sys_errlist
 #define strerror_r FOO_strerror_r
+#define __INSIDE_CYGWIN__
+#include <errno.h>
+#include <error.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include "winsup.h"
 #include "cygtls.h"
 #include "ntdll.h"
@@ -417,3 +424,67 @@
   strcpy (buf, error);
   return result;
 }
+
+unsigned int error_message_count = 0;
+int error_one_per_line = 0;
+void (*error_print_progname) (void) = NULL;
+
+static void
+_verror (int status, int errnum, const char *filename, unsigned int lineno, const char *fmt, va_list ap)
+{
+  error_message_count++;
+
+  fflush (stdout);
+
+  if (error_print_progname)
+    (*error_print_progname) ();
+  else
+    fprintf (stderr, "%s:%s", program_invocation_name, filename ? "" : " ");
+
+  if (filename)
+    fprintf (stderr, "%s:%d: ", filename, lineno);
+
+  vfprintf (stderr, fmt, ap);
+
+  if (errnum != 0)
+    fprintf (stderr, ": %s", strerror (errnum));
+
+  fprintf (stderr, "\n");
+
+  if (status != 0)
+    exit (status);
+}
+
+extern "C" void
+error (int status, int errnum, const char *fmt, ...)
+{
+  va_list ap;
+  va_start (ap, fmt);
+  _verror (status, errnum, NULL, 0, fmt, ap);
+  va_end (ap);
+}
+
+extern "C" void
+error_at_line (int status, int errnum, const char *filename, unsigned int lineno, const char *fmt, ...)
+{
+  va_list ap;
+
+  if (error_one_per_line != 0)
+    {
+      static const char *last_filename;
+      static unsigned int last_lineno;
+
+      /* strcmp(3) will SEGV if filename or last_filename are NULL */
+      if (lineno == last_lineno
+          && ((!filename && !last_filename)
+              || (filename && last_filename && strcmp (filename, last_filename) == 0)))
+        return;
+
+      last_filename = filename;
+      last_lineno = lineno;
+    }
+
+  va_start (ap, fmt);
+  _verror (status, errnum, filename, lineno, fmt, ap);
+  va_end (ap);
+}
Index: posix.sgml
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/posix.sgml,v
retrieving revision 1.63
diff -u -r1.63 posix.sgml
--- posix.sgml	15 May 2011 18:49:39 -0000	1.63
+++ posix.sgml	16 May 2011 05:50:06 -0000
@@ -1089,6 +1089,8 @@
     envz_merge
     envz_remove
     envz_strip
+    error
+    error_at_line
     euidaccess
     execvpe
     exp10
Index: include/cygwin/version.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
retrieving revision 1.346
diff -u -r1.346 version.h
--- include/cygwin/version.h	15 May 2011 18:49:40 -0000	1.346
+++ include/cygwin/version.h	16 May 2011 05:50:07 -0000
@@ -414,12 +414,14 @@
 	   pthread_attr_setstack, pthread_attr_setstackaddr.
       246: Add CLOCK_PROCESS_CPUTIME_ID, CLOCK_THREAD_CPUTIME_ID.
 	   Export clock_getcpuclockid, pthread_getcpuclockid.
+      247: Export error, error_at_line, error_message_count, error_one_per_line,
+	   error_print_progname.
      */
 
      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
 
 #define CYGWIN_VERSION_API_MAJOR 0
-#define CYGWIN_VERSION_API_MINOR 246
+#define CYGWIN_VERSION_API_MINOR 247
 
      /* There is also a compatibity version number associated with the
 	shared memory regions.  It is incremented when incompatible

--=-Jw5sbfHIGuMDye6gdqBQ
Content-Disposition: attachment; filename="doc-error.patch"
Content-Type: text/x-patch; name="doc-error.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 800

2011-05-17  Yaakov Selkowitz  <yselkowitz@...>

	* new-features.sgml (ov-new1.7.10): Document error.h functions.

Index: new-features.sgml
===================================================================
RCS file: /cvs/src/src/winsup/doc/new-features.sgml,v
retrieving revision 1.82
diff -u -r1.82 new-features.sgml
--- new-features.sgml	17 May 2011 17:09:32 -0000	1.82
+++ new-features.sgml	17 May 2011 17:14:52 -0000
@@ -31,6 +31,11 @@
 </para></listitem>
 
 <listitem><para>
+GNU/glibc error.h error reporting functions.  New APIs: error, error_at_line.
+New exports: error_message_count, error_one_per_line, error_print_progname.
+</para></listitem>
+
+<listitem><para>
 /proc/loadavg now shows the number of currently running processes and the
 total number of processes.
 </para></listitem>

--=-Jw5sbfHIGuMDye6gdqBQ
Content-Disposition: attachment; filename="error.h"
Content-Type: text/x-chdr; name="error.h"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 613

/* error.h: GNU error reporting functions

   Copyright 2011 Red Hat, Inc.

This file is part of Cygwin.

This software is a copyrighted work licensed under the terms of the
Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
details. */

#ifndef _ERROR_H
#define _ERROR_H

#ifdef __cplusplus
extern "C"
{
#endif

void error (int, int, const char *, ...);
void error_at_line (int, int, const char *, unsigned int, const char *, ...);

extern unsigned int error_message_count;
extern int error_one_per_line;
extern void (*error_print_progname) (void);

#ifdef __cplusplus
}
#endif

#endif /* _ERROR_H */

--=-Jw5sbfHIGuMDye6gdqBQ
Content-Disposition: attachment; filename="error-test.c"
Content-Type: text/x-csrc; name="error-test.c"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-length: 1983

#define _GNU_SOURCE
#include <errno.h>	/* for program_invocation_name */
#include <error.h>
#include <stdio.h>

void
mymsg (void)
{
	fprintf (stderr, "custom message:");
}

int
main (int argc, char **argv)
{
	error (0, 0, NULL);		/* error 1 */
	error (0, 0, "error 2");

	/* has effect */
	program_invocation_name = "foobar";

	error (0, 0, NULL);		/* error 3 */
	error (0, 0, "error 4");

	error (0, 1, NULL);		/* error 5 */
	error (0, 2, "%s", "error 6");

	/* same as error() if filename is NULL */
	error_at_line (0, 0, NULL, 32, "error 7");

	error_at_line (0, 0, __FILE__, 34, "%s", "error 8");

	error_one_per_line = -1;
	/* error_one_per_line only counts once set */
	error_at_line (0, 0, __FILE__, 34, "%s", "error 9");
	/* error_one_per_line causes this to be ignored */
	error_at_line (error_message_count, 0, __FILE__, 34, "%s", "OOPS! error 10");
	/* error_one_per_line tracks only the last lineno, none previous */
	error_at_line (0, 0, __FILE__, 32, "%s", "error 11");
	/* error_one_per_line requires both matching filename and lineno */
	error_at_line (0, 0, "myfilename", 32, "%s", "error 12");

	/* overrides the printing of program_invocation_name: */
	error_print_progname = &mymsg;

	error (0, 0, NULL); 	/* error 13 */
	error (0, 0, "error 14");
	error (0, 3, NULL); 	/* error 15 */
	error (0, 4, "%s", "error 16");

	error_at_line (0, 5, __FILE__, 53, "%s", "error 17");
#if !defined(__GLIBC__) || __GLIBC_MINOR__ >= 14
	/* SEGVs on glibc due to strcmp (NULL, __FILE__)
           http://sourceware.org/bugzilla/show_bug.cgi?id=12766
           Fixed upstream for upcoming 2.14:
           http://sourceware.org/git/?p=glibc.git;a=commitdiff;h=15cc7dd */
	error_at_line (0, 6, NULL, 53, "%s", "error 18");
#endif
	/* non-zero status calls exit() */
	/* note that skipped error 8 does not increment count */
	error_at_line (error_message_count, 7, __FILE__, __LINE__, "%s", "error 19");

	/* not reached */
	fprintf (stderr, "Exiting normally\n");
	return 0;
}

--=-Jw5sbfHIGuMDye6gdqBQ--
