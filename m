Return-Path: <cygwin-patches-return-5667-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30139 invoked by alias); 24 Oct 2005 01:08:30 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30083 invoked by uid 22791); 24 Oct 2005 01:08:24 -0000
Received: from zipcon.net (HELO zipcon.net) (209.221.136.5)
    by sourceware.org (qpsmtpd/0.30-dev) with SMTP; Mon, 24 Oct 2005 01:08:24 +0000
Received: (qmail 28398 invoked from network); 23 Oct 2005 18:12:48 -0700
Received: from unknown (HELO efn.org) (209.221.136.31)
  by mail.zipcon.net with SMTP; 23 Oct 2005 18:12:48 -0700
Received: by efn.org (sSMTP sendmail emulation); Sun, 23 Oct 2005 18:08:23 -0700
Date: Mon, 24 Oct 2005 01:08:00 -0000
From: Yitzchak Scott-Thoennes <sthoenna@efn.org>
To: cygwin-patches@cygwin.com
Subject: expose creating windows-style envblock from current environment
Message-ID: <20051024010823.GA648@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-SW-Source: 2005-q4/txt/msg00009.txt.bz2

I need to translate the current environment in a cygwin C program to
an envblock suitable for calling CreateProcess directly, and couldn't
think of a better way than the following patch.

But I think there's something I'm not understanding; with the free()
calls in place, it coredumps, though checking the code in environ.cc
seems to show that all the freed chunks should have been properly
allocated.  As an aside, does the build_env call in spawn.cc leak?

2005-10-23  Yitzchak Scott-Thoennes  <sthoenna@efn.org>

	* include/sys/cygwin.h (enum cygwin_getinfo_types): Add
        CW_GET_WIN_ENVBLOCK.
	* external.cc (cygwin_internal): Implement CW_GET_WIN_ENVBLOCK.

--- winsup/cygwin/include/sys/cygwin.h.orig	2005-05-16 18:21:06.000000000 -0700
+++ winsup/cygwin/include/sys/cygwin.h	2005-10-23 12:44:23.760520000 -0700
@@ -83,7 +83,8 @@
     CW_HOOK,
     CW_ARGV,
     CW_ENVP,
-    CW_DEBUG_SELF
+    CW_DEBUG_SELF,
+    CW_GET_WIN_ENVBLOCK
   } cygwin_getinfo_types;
 
 #define CW_NEXTPID	0x80000000	/* or with pid to get next one */
--- winsup/cygwin/external.cc.orig	2005-09-25 02:07:40.197334000 -0700
+++ winsup/cygwin/external.cc	2005-10-23 16:11:32.662403200 -0700
@@ -10,6 +10,7 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
+#include <stdlib.h>
 #include "winsup.h"
 #include "security.h"
 #include "sigproc.h"
@@ -28,6 +29,7 @@ details. */
 #include "pwdgrp.h"
 #include "cygtls.h"
 #include "child_info.h"
+#include "environ.h"
 
 child_info *get_cygwin_startup_info ();
 
@@ -310,6 +312,22 @@ cygwin_internal (cygwin_getinfo_types t,
 	error_start_init (va_arg (arg, const char *));
 	try_to_debug ();
 	break;
+      case CW_GET_WIN_ENVBLOCK:
+	{
+	  char *envblock;
+	  int envc;
+	  char **envp = build_env (cur_environ (), envblock, envc, 0);
+
+          /* we don't actually want the C-style environment */
+#if 0
+	  if (envp) {
+	    for (char **e = envp; *e; ++e) free (*e);
+	    free (envp);
+	  }
+#endif
+
+	  return (unsigned long) (envp ? envblock : NULL);
+	}
       default:
 	break;
     }
