Return-Path: <cygwin-patches-return-2273-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 14762 invoked by alias); 31 May 2002 00:47:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 14748 invoked from network); 31 May 2002 00:47:55 -0000
Message-ID: <20020531004755.25499.qmail@web14505.mail.yahoo.com>
Date: Thu, 30 May 2002 17:47:00 -0000
From: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
Subject: [Re]move  w32api/include/excpt.h
To: cygwin-patches <cygwin-patches@cygwin.com>,
  mingw-dvlpr <mingw-dvlpr@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SW-Source: 2002-q2/txt/msg00256.txt.bz2

The w32api and mingw-runtime each conatin a file called excpt.h
The one in the w32api just defines  __try, __except, __finally as
no-ops and lets some code "at least" compile.  I would like to get rid of that
file, so mingw has only one excpt.h and we don't have the perennial problem
of one overwriting the other, depending on order of installation.

This patch puts the no-op defines in windef.h, so that they are still
available to cygwin users of w32api and to mingw.  Alternative option
is to put them in the mingw-runtime version of excpt.h and thus remove
them from cygwin.

I think they should go in the rubbish, but others may like to have code
that compiles and links fine and then crashes at runtime.  

No, I don't mean to stir up a long debate over this, I just want to get rid of
the file somehow.  


2002-05-31    Danny Smith  <dannysmith@users.sourceforge.net>

	* include/windef.h: Add no-op __try, __except, __finally
	defines from ...
	* include/excpt.h: Remove file.
	* include/windows.h: Don't include excpt.h.

Index: include/windef.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/windef.h,v
retrieving revision 1.10
diff -u -p -r1.10 windef.h
--- include/windef.h	6 May 2002 23:37:52 -0000	1.10
+++ include/windef.h	30 May 2002 23:17:50 -0000
@@ -184,6 +184,19 @@ extern "C" {
 #endif
 #endif
 
+/* FIXME: This will make some code compile. The programs will most
+   likely crash when an exception is raised, but at least they will
+   compile. */
+#if defined ( __GNUC__ )  /* && defined (__SEH_NOOP) */ 
+#define __try
+#define __except(x) if (0) /* don't execute handler */
+#define __finally
+
+#define _try __try
+#define _except __except
+#define _finally __finally
+#endif
+
 typedef unsigned long DWORD;
 typedef int WINBOOL,*PWINBOOL,*LPWINBOOL;
 /* FIXME: Is there a good solution to this? */
Index: include/windows.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/windows.h,v
retrieving revision 1.10
diff -u -p -r1.10 windows.h
--- include/windows.h	6 May 2002 23:37:52 -0000	1.10
+++ include/windows.h	30 May 2002 23:17:50 -0000
@@ -48,7 +48,6 @@
 #include <windef.h>
 #include <wincon.h>
 #include <basetyps.h>
-#include <excpt.h>
 #include <winbase.h>
 #ifndef _WINGDI_H
 #include <wingdi.h>

http://www.sold.com.au - The Sold.com.au Big Brand Sale
- New PCs, notebooks, digital cameras, phones and more ... Sale ends June 12
