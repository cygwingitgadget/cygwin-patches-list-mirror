Return-Path: <cygwin-patches-return-4692-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7791 invoked by alias); 20 Apr 2004 17:38:16 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7782 invoked from network); 20 Apr 2004 17:38:15 -0000
Message-ID: <40855FF9.33C9C5DF@phumblet.no-ip.org>
Date: Tue, 20 Apr 2004 17:38:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: Pierre.Humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: [Patch]: 3 or more initial slashes
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q2/txt/msg00044.txt.bz2

POSIX specifies that three ore more slashes at the beginning
of a pathname are equivalent to a single one.
This patch implements that feature. 
Only Posix paths are affected, Windows paths are left alone. 
Also, Posix paths are never handled by normalize_win32_path
anymore.

Pierre

2004-04-20  Pierre Humblet <pierre.humblet@ieee.org>

	* path.cc (normalize_posix_path): Process all Posix paths and
	map three or more initial slashes to a single one. Simplify
	processing following two initial slashes. 
	(normalize_win32_path): Make last argument non-optional and
	do not check for NULL value.

Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.302
diff -u -p -r1.302 path.cc
--- path.cc     16 Apr 2004 21:22:13 -0000      1.302
+++ path.cc     20 Apr 2004 17:14:40 -0000
@@ -75,7 +75,7 @@ details. */
 #include "cygtls.h"
 #include <assert.h>
 
-static int normalize_win32_path (const char *src, char *dst, char ** tail = 0);
+static int normalize_win32_path (const char *src, char *dst, char ** tail);
 static void slashify (const char *src, char *dst, int trailing_slash_p);
 static void backslashify (const char *src, char *dst, int trailing_slash_p);
 
@@ -202,7 +202,7 @@ normalize_posix_path (const char *src, c
   const char *in_src = src;
   char *in_dst = dst;
 
-  if (isdrive (src) || slash_unc_prefix_p (src))
+  if (isdrive (src) || *src == '\\')
     goto win32_path;
 
   if (!isslash (src[0]))
@@ -220,26 +220,12 @@ normalize_posix_path (const char *src, c
        *dst++ = '/';
     }
   /* Two leading /'s?  If so, preserve them.  */
-  else if (isslash (src[1]))
+  else if (isslash (src[1]) && !isslash (src[2]))
     {
       *dst++ = '/';
       *dst++ = '/';
       src += 2;
-      if (isslash (*src))
-       { /* Starts with three or more slashes - reset. */
-         dst = dst_start;
-         *dst++ = '/';
-         src = src_start + 1;
-       }
-      else if (src[0] == '.' && isslash (src[1]))
-       {
-         *dst++ = '.';
-         *dst++ = '/';
-         src += 2;
-       }
     }
-  else
-    *dst = '\0';
 
   while (*src)
     {
@@ -1005,9 +991,8 @@ normalize_win32_path (const char *src, c
       if ((dst - dst_start) >= CYG_MAX_PATH)
        return ENAMETOOLONG;
     }
-  *dst = 0;
-  if (tail)
-    *tail = dst;
+  *dst = '\0';
+  *tail = dst;
   debug_printf ("%s = normalize_win32_path (%s)", dst_start, src_start);
   return 0;
 }
