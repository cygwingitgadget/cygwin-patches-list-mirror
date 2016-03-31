Return-Path: <cygwin-patches-return-8523-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 1527 invoked by alias); 31 Mar 2016 18:04:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 1423 invoked by uid 89); 31 Mar 2016 18:04:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,SPF_PASS autolearn=ham version=3.3.2 spammy=887
X-HELO: mail-qg0-f50.google.com
Received: from mail-qg0-f50.google.com (HELO mail-qg0-f50.google.com) (209.85.192.50) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES128-GCM-SHA256 encrypted) ESMTPS; Thu, 31 Mar 2016 18:04:26 +0000
Received: by mail-qg0-f50.google.com with SMTP id n34so64146860qge.1        for <cygwin-patches@cygwin.com>; Thu, 31 Mar 2016 11:04:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to         :references;        bh=FVjoaO86a/NmmMEjTFeSguCwVRhovWha2e4zTM9G0cw=;        b=k7MgFLU6+H4PS3r/fD9nTYy7Vyxavfz/R8vh9MXP79Q4nxLLtTG5vdZK9/lKsjjJ3k         U2ycX/b3/a5yqnNtzLIWre83AAO9IICAeWj16Ftx05ISW8pybfPykmkb9v+E4sN19p7i         pJbpHB/+rXKsEZ9CN9l4PYnoIT1InJvZoGpvqd26EjgJub3/T0lYRzNSkFJlA/sOZXqa         NIRvnnGyeGVPovXXnk6d2XgCUX4e6MPWiKQA/8kfO7sYOnjxZyEU4lkHfdz1PLQIplWd         F+g4nN9QsVh0ThdRbm5MTb+aMPIpe8l3L5be7wDFg9kT1Cce9NitcQFnsf9MGKQrNJk/         /eaQ==
X-Gm-Message-State: AD7BkJLXxhZohJFi55QiYH1zkvfHZOlx4q106hWN7inp3BOzZUhTGG4n5oDZuUcbhwIWCg==
X-Received: by 10.140.83.212 with SMTP id j78mr18577660qgd.83.1459447464261;        Thu, 31 Mar 2016 11:04:24 -0700 (PDT)
Received: from bronx.local.pefoley.com (foleype-1-pt.tunnel.tserv13.ash1.ipv6.he.net. [2001:470:7:ee7::2])        by smtp.gmail.com with ESMTPSA id 94sm4421831qgj.10.2016.03.31.11.04.23        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);        Thu, 31 Mar 2016 11:04:23 -0700 (PDT)
From: Peter Foley <pefoley2@pefoley.com>
To: cygwin-patches@cygwin.com
Cc: Peter Foley <pefoley2@pefoley.com>
Subject: [PATCH 3/4] Remove remnants of never-defined MALLOC_DEBUG and NEWVFORK
Date: Thu, 31 Mar 2016 18:04:00 -0000
Message-Id: <1459447458-6547-3-git-send-email-pefoley2@pefoley.com>
In-Reply-To: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com>
References: <1459447458-6547-1-git-send-email-pefoley2@pefoley.com>
X-IsSubscribed: yes
X-SW-Source: 2016-q1/txt/msg00229.txt.bz2

MALLOC_DEBUG and NEWVFORK haven't been defined since 2008 (46162537516c5e5fbb).
Remove all references to tem.

winsup/cygwin/ChangeLog:
acconfig.h: delete
dcrt0.cc (dll_crt0_1): remove NEWVFORK code.
dcrt0.cc (do_exit): ditto.
debug.h: ditto.
dtable.h: ditto.
winsup.h: ditto.
globals.cc: ditto.
malloc_wrapper.cc: ditto.
malloc_wrapper.cc (malloc_init): ditto.
spawn.cc (spawnve): ditto.
syscalls.cc (setsid): ditto.

Signed-off-by: Peter Foley <pefoley2@pefoley.com>
---
 winsup/cygwin/acconfig.h        |  5 -----
 winsup/cygwin/config.h.in       |  5 -----
 winsup/cygwin/dcrt0.cc          | 14 --------------
 winsup/cygwin/debug.h           |  9 ---------
 winsup/cygwin/dtable.h          |  6 ------
 winsup/cygwin/globals.cc        |  3 ---
 winsup/cygwin/malloc_wrapper.cc |  4 ----
 winsup/cygwin/spawn.cc          | 18 ------------------
 winsup/cygwin/syscalls.cc       | 15 ---------------
 winsup/cygwin/winsup.h          |  2 --
 10 files changed, 81 deletions(-)
 delete mode 100644 winsup/cygwin/acconfig.h

diff --git a/winsup/cygwin/acconfig.h b/winsup/cygwin/acconfig.h
deleted file mode 100644
index ffe9f81..0000000
--- a/winsup/cygwin/acconfig.h
+++ /dev/null
@@ -1,5 +0,0 @@
-/* Define if MALLOC_DEBUGGING support is requested.  */
-#undef MALLOC_DEBUG
-
-/* Define if using new vfork functionality. */
-#undef NEWVFORK
diff --git a/winsup/cygwin/config.h.in b/winsup/cygwin/config.h.in
index 32f191a..5ddff24 100644
--- a/winsup/cygwin/config.h.in
+++ b/winsup/cygwin/config.h.in
@@ -1,9 +1,4 @@
 /* config.h.in.  Generated from configure.ac by autoheader.  */
-/* Define if MALLOC_DEBUGGING support is requested.  */
-#undef MALLOC_DEBUG
-
-/* Define if using new vfork functionality. */
-#undef NEWVFORK
 
 /* Define if DEBUGGING support is requested. */
 #undef DEBUGGING
diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
index 94f7bf8..aaa8c44 100644
--- a/winsup/cygwin/dcrt0.cc
+++ b/winsup/cygwin/dcrt0.cc
@@ -902,11 +902,6 @@ dll_crt0_1 (void *)
      Need to do this before any helper threads start. */
   debug_init ();
 
-#ifdef NEWVFORK
-  cygheap->fdtab.vfork_child_fixup ();
-  main_vfork = vfork_storage.create ();
-#endif
-
   cygbench ("pre-forkee");
   if (in_forkee)
     {
@@ -1197,15 +1192,6 @@ do_exit (int status)
 {
   syscall_printf ("do_exit (%d), exit_state %d", status, exit_state);
 
-#ifdef NEWVFORK
-  vfork_save *vf = vfork_storage.val ();
-  if (vf != NULL && vf->pid < 0)
-    {
-      exit_state = ES_NOT_EXITING;
-      vf->restore_exit (status);
-    }
-#endif
-
   lock_process until_exit (true);
 
   if (exit_state < ES_EVENTS_TERMINATE)
diff --git a/winsup/cygwin/debug.h b/winsup/cygwin/debug.h
index 627c77e..602ab93 100644
--- a/winsup/cygwin/debug.h
+++ b/winsup/cygwin/debug.h
@@ -7,16 +7,7 @@ This software is a copyrighted work licensed under the terms of the
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
-#ifndef MALLOC_DEBUG
 #define MALLOC_CHECK do {} while (0)
-#else
-#include <stdlib.h>
-#include <malloc.h>
-#define MALLOC_CHECK ({\
-  debug_printf ("checking malloc pool");\
-  mallinfo ();\
-})
-#endif
 
 #if !defined(_DEBUG_H_)
 #define _DEBUG_H_
diff --git a/winsup/cygwin/dtable.h b/winsup/cygwin/dtable.h
index 34e975b..fb44c95 100644
--- a/winsup/cygwin/dtable.h
+++ b/winsup/cygwin/dtable.h
@@ -25,9 +25,6 @@ class suffix_info;
 class dtable
 {
   fhandler_base **fds;
-#ifdef NEWVFORK
-  fhandler_base **fds_on_hold;
-#endif
   fhandler_base **archetypes;
   unsigned narchetypes;
   unsigned farchetype;
@@ -77,9 +74,6 @@ public:
   void stdio_init ();
   void get_debugger_info ();
   void set_file_pointers_for_exec ();
-#ifdef NEWVFORK
-  bool in_vfork_cleanup () {return fds_on_hold == fds;}
-#endif
   fhandler_base *find_archetype (device& dev);
   fhandler_base **add_archetype ();
   void delete_archetype (fhandler_base *);
diff --git a/winsup/cygwin/globals.cc b/winsup/cygwin/globals.cc
index 990158e..7dfe74d 100644
--- a/winsup/cygwin/globals.cc
+++ b/winsup/cygwin/globals.cc
@@ -88,9 +88,6 @@ int NO_COPY __isthreaded = 0;
 int __argc_safe;
 int __argc;
 char **__argv;
-#ifdef NEWVFORK
-vfork_save NO_COPY *main_vfork;
-#endif
 
 _cygtls NO_COPY *_main_tls /* !globals.h */;
 
diff --git a/winsup/cygwin/malloc_wrapper.cc b/winsup/cygwin/malloc_wrapper.cc
index 0db5de8..8098952 100644
--- a/winsup/cygwin/malloc_wrapper.cc
+++ b/winsup/cygwin/malloc_wrapper.cc
@@ -18,9 +18,7 @@ details. */
 #include "perprocess.h"
 #include "miscfuncs.h"
 #include "cygmalloc.h"
-#ifndef MALLOC_DEBUG
 #include <malloc.h>
-#endif
 extern "C" struct mallinfo dlmallinfo ();
 
 /* we provide these stubs to call into a user's
@@ -281,7 +279,6 @@ malloc_init ()
 {
   mallock.init ("mallock");
 
-#ifndef MALLOC_DEBUG
   /* Check if malloc is provided by application. If so, redirect all
      calls to malloc/free/realloc to application provided. This may
      happen if some other dll calls cygwin's malloc, but main code provides
@@ -296,7 +293,6 @@ malloc_init ()
       malloc_printf ("using %s malloc", use_internal ? "internal" : "external");
       internal_malloc_determined = true;
     }
-#endif
 }
 
 extern "C" void
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index a2111c2..9871bb5 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -882,14 +882,6 @@ spawnve (int mode, const char *path, const char *const *argv,
   static char *const empty_env[] = { NULL };
 
   int ret;
-#ifdef NEWVFORK
-  vfork_save *vf = vfork_storage.val ();
-
-  if (vf != NULL && (vf->pid < 0) && mode == _P_OVERLAY)
-    mode = _P_NOWAIT;
-  else
-    vf = NULL;
-#endif
 
   syscall_printf ("spawnve (%s, %s, %p)", path, argv[0], envp);
 
@@ -910,16 +902,6 @@ spawnve (int mode, const char *path, const char *const *argv,
     case _P_DETACH:
     case _P_SYSTEM:
       ret = ch_spawn.worker (path, argv, envp, mode);
-#ifdef NEWVFORK
-      if (vf)
-	{
-	  if (ret > 0)
-	    {
-	      debug_printf ("longjmping due to vfork");
-	      vf->restore_pid (ret);
-	    }
-	}
-#endif
       break;
     default:
       set_errno (EINVAL);
diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 15fb8ce..5d881f5 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1129,21 +1129,6 @@ getppid ()
 extern "C" pid_t
 setsid (void)
 {
-#ifdef NEWVFORK
-  vfork_save *vf = vfork_storage.val ();
-  /* This is a horrible, horrible kludge */
-  if (vf && vf->pid < 0)
-    {
-      pid_t pid = fork ();
-      if (pid > 0)
-	{
-	  syscall_printf ("longjmping due to vfork");
-	  vf->restore_pid (pid);
-	}
-      /* assuming that fork was successful */
-    }
-#endif
-
   if (myself->pgid == myself->pid)
     syscall_printf ("hmm.  pgid %d pid %d", myself->pgid, myself->pid);
   else
diff --git a/winsup/cygwin/winsup.h b/winsup/cygwin/winsup.h
index d7f7350..9b12267 100644
--- a/winsup/cygwin/winsup.h
+++ b/winsup/cygwin/winsup.h
@@ -88,9 +88,7 @@ extern const unsigned char case_folded_lower[];
 extern const unsigned char case_folded_upper[];
 #define cyg_toupper(c) ((char) case_folded_upper[(unsigned char)(c)])
 
-#ifndef MALLOC_DEBUG
 #define cfree newlib_cfree_dont_use
-#endif
 
 /* Used as type by sys_wcstombs_alloc and sys_mbstowcs_alloc.  For a
    description see there. */
-- 
2.8.0
