Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id E534A385840A
 for <cygwin-patches@cygwin.com>; Sun, 13 Feb 2022 14:40:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org E534A385840A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 21DEdOvR000575;
 Sun, 13 Feb 2022 23:40:01 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 21DEdOvR000575
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1644763202;
 bh=2ZKsHv8BkDdHy38KiRTk1sdQpy9fkc7yQUDANB1M7hs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=0iKHk+nZGWp3aFN2NvSNiWajjZYE6EuFDP1YbjmgZHdLC9F0mJsngqxapcF8JCkDQ
 VVPpMmLw08FJ/6YlCw68LKzAGgnKa/b7nuNCmjvhy5gmxdDi6dBqIXRciGYSQTIe7v
 aMikksCBXM56yd3WoYBn3k4HORhosjYdXgWPyyXOmns9t5cFyWO5IWoBGEFqK4gitj
 lHg+gu56hr7mJrS/8g/EWGUCEWK1nxXgnawhlqbx9FQPXsaFGU5qjT0zrT7Me9VAHT
 mJ7MHKu4lZJkimyX7/TrKrVG4P7JNZQ0K8tz+ZFCGqY5WKScqekqjCyx6UdGiu6EV+
 /OwSNtIM+3J4g==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 7/8] Cygwin: console: Fix console mode for non-cygwin inferior
 of GDB.
Date: Sun, 13 Feb 2022 23:39:09 +0900
Message-Id: <20220213143910.1947-8-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
References: <20220213143910.1947-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 13 Feb 2022 14:40:16 -0000

- Currently, there is no chance to change console mode for non-cygwin
  inferior of GDB. With this patch, the console mode is changed to
  tty::native in CreateProcess() and ContinueDebugEvent() hooked in
  fhandler_console.
---
 winsup/cygwin/fhandler.h          |   2 +
 winsup/cygwin/fhandler_console.cc |  39 +++++++++
 winsup/cygwin/fhandler_tty.cc     | 128 +++++++++++++++---------------
 3 files changed, 107 insertions(+), 62 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index fb4747608..4e86ab58a 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1941,6 +1941,8 @@ class fhandler_termios: public fhandler_base
     fh->copy_from (this);
     return fh;
   }
+  static bool path_iscygexec_a (LPCSTR n, LPSTR c);
+  static bool path_iscygexec_w (LPCWSTR n, LPWSTR c);
 };
 
 enum ansi_intensity
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index da65c465e..50f350c49 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -32,6 +32,7 @@ details. */
 #include "sync.h"
 #include "child_info.h"
 #include "cygwait.h"
+#include "winf.h"
 
 /* Don't make this bigger than NT_MAX_PATH as long as the temporary buffer
    is allocated using tmp_pathbuf!!! */
@@ -3595,10 +3596,32 @@ set_console_title (char *title)
   debug_printf ("title '%W'", buf);
 }
 
+static bool NO_COPY gdb_inferior_noncygwin = false;
+static void
+set_console_mode_to_native ()
+{
+  cygheap_fdenum cfd (false);
+  while (cfd.next () >= 0)
+    if (cfd->get_major () == DEV_CONS_MAJOR)
+      {
+	fhandler_console *cons = (fhandler_console *) (fhandler_base *) cfd;
+	if (cons->get_device () == cons->tc ()->getntty ())
+	  {
+	    termios *cons_ti = &((tty *) cons->tc ())->ti;
+	    fhandler_console::set_input_mode (tty::native, cons_ti,
+					      cons->get_handle_set ());
+	    fhandler_console::set_output_mode (tty::native, cons_ti,
+					       cons->get_handle_set ());
+	    break;
+	  }
+      }
+}
+
 #define DEF_HOOK(name) static __typeof__ (name) *name##_Orig
 /* CreateProcess() is hooked for GDB etc. */
 DEF_HOOK (CreateProcessA);
 DEF_HOOK (CreateProcessW);
+DEF_HOOK (ContinueDebugEvent);
 
 static BOOL WINAPI
 CreateProcessA_Hooked
@@ -3608,6 +3631,9 @@ CreateProcessA_Hooked
 {
   if (f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS))
     mutex_timeout = 0; /* to avoid deadlock in GDB */
+  gdb_inferior_noncygwin = !fhandler_termios::path_iscygexec_a (n, c);
+  if (gdb_inferior_noncygwin)
+    set_console_mode_to_native ();
   return CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
@@ -3619,9 +3645,21 @@ CreateProcessW_Hooked
 {
   if (f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS))
     mutex_timeout = 0; /* to avoid deadlock in GDB */
+  gdb_inferior_noncygwin = !fhandler_termios::path_iscygexec_w (n, c);
+  if (gdb_inferior_noncygwin)
+    set_console_mode_to_native ();
   return CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, si, pi);
 }
 
+static BOOL WINAPI
+ContinueDebugEvent_Hooked
+     (DWORD p, DWORD t, DWORD s)
+{
+  if (gdb_inferior_noncygwin)
+    set_console_mode_to_native ();
+  return ContinueDebugEvent_Orig (p, t, s);
+}
+
 void
 fhandler_console::fixup_after_fork_exec (bool execing)
 {
@@ -3641,6 +3679,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
   /* CreateProcess() is hooked for GDB etc. */
   DO_HOOK (NULL, CreateProcessA);
   DO_HOOK (NULL, CreateProcessW);
+  DO_HOOK (NULL, ContinueDebugEvent);
 }
 
 /* Ugly workaround to create invisible console required since Windows 7.
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 8c9a10c23..5ba50cc73 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -157,6 +157,66 @@ set_switch_to_pcon (HANDLE *in, HANDLE *out, HANDLE *err, bool iscygwin)
     *err = replace_err->get_output_handle_nat ();
 }
 
+static bool
+path_iscygexec_a_w (LPCSTR na, LPSTR ca, LPCWSTR nw, LPWSTR cw)
+{
+  path_conv path;
+  tmp_pathbuf tp;
+  char *prog =tp.c_get ();
+  if (na)
+    {
+      __small_sprintf (prog, "%s", na);
+      find_exec (prog, path);
+    }
+  else if (nw)
+    {
+      __small_sprintf (prog, "%W", nw);
+      find_exec (prog, path);
+    }
+  else
+    {
+      if (ca)
+	__small_sprintf (prog, "%s", ca);
+      else if (cw)
+	__small_sprintf (prog, "%W", cw);
+      else
+	return true;
+      char *p = prog;
+      char *p1;
+      do
+	if ((p1 = strchr (p, ' ')) || (p1 = p + strlen (p)))
+	  {
+	    p = p1;
+	    if (*p == ' ')
+	      {
+		*p = '\0';
+		find_exec (prog, path);
+		*p = ' ';
+		p ++;
+	      }
+	    else if (*p == '\0')
+	      find_exec (prog, path);
+	  }
+      while (!path.exists() && *p);
+    }
+  const char *argv[] = {"", NULL}; /* Dummy */
+  av av1;
+  av1.setup ("", path, "", 1, argv, false);
+  return path.iscygexec ();
+}
+
+bool
+fhandler_termios::path_iscygexec_a (LPCSTR n, LPSTR c)
+{
+  return path_iscygexec_a_w (n, c, NULL, NULL);
+}
+
+bool
+fhandler_termios::path_iscygexec_w (LPCWSTR n, LPWSTR c)
+{
+  return path_iscygexec_a_w (NULL, NULL, n, c);
+}
+
 static bool atexit_func_registered = false;
 static bool debug_process = false;
 
@@ -220,37 +280,9 @@ CreateProcessA_Hooked
       siov->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
       siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
-  path_conv path;
-  tmp_pathbuf tp;
-  char *prog =tp.c_get ();
-  if (n)
-    __small_sprintf (prog, "%s", n);
-  else
-    {
-      __small_sprintf (prog, "%s", c);
-      char *p = prog;
-      char *p1;
-      do
-	if ((p1 = strchr (p, ' ')) || (p1 = p + strlen (p)))
-	  {
-	    p = p1;
-	    if (*p == ' ')
-	      {
-		*p = '\0';
-		find_exec (prog, path);
-		*p = ' ';
-		p ++;
-	      }
-	    else if (*p == '\0')
-	      find_exec (prog, path);
-	  }
-      while (!path.exists() && *p);
-    }
-  const char *argv[] = {"", NULL}; /* Dummy */
-  av av1;
-  av1.setup ("", path, "", 1, argv, false);
+  bool path_iscygexec = fhandler_termios::path_iscygexec_a (n, c);
   set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError,
-		      path.iscygexec ());
+		      path_iscygexec);
   BOOL ret = CreateProcessA_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
   h_gdb_process = pi->hProcess;
   DuplicateHandle (GetCurrentProcess (), h_gdb_process,
@@ -259,7 +291,7 @@ CreateProcessA_Hooked
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
     mutex_timeout = 0; /* to avoid deadlock in GDB */
-  if (!atexit_func_registered && !path.iscygexec ())
+  if (!atexit_func_registered && !path_iscygexec)
     {
       atexit (atexit_func);
       atexit_func_registered = true;
@@ -286,37 +318,9 @@ CreateProcessW_Hooked
       siov->hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
       siov->hStdError = GetStdHandle (STD_ERROR_HANDLE);
     }
-  path_conv path;
-  tmp_pathbuf tp;
-  char *prog =tp.c_get ();
-  if (n)
-    __small_sprintf (prog, "%W", n);
-  else
-    {
-      __small_sprintf (prog, "%W", c);
-      char *p = prog;
-      char *p1;
-      do
-	if ((p1 = strchr (p, ' ')) || (p1 = p + strlen (p)))
-	  {
-	    p = p1;
-	    if (*p == ' ')
-	      {
-		*p = '\0';
-		find_exec (prog, path);
-		*p = ' ';
-		p ++;
-	      }
-	    else if (*p == '\0')
-	      find_exec (prog, path);
-	  }
-      while (!path.exists() && *p);
-    }
-  const char *argv[] = {"", NULL}; /* Dummy */
-  av av1;
-  av1.setup ("", path, "", 1, argv, false);
+  bool path_iscygexec = fhandler_termios::path_iscygexec_w (n, c);
   set_switch_to_pcon (&siov->hStdInput, &siov->hStdOutput, &siov->hStdError,
-		      path.iscygexec ());
+		      path_iscygexec);
   BOOL ret = CreateProcessW_Orig (n, c, pa, ta, inh, f, e, d, siov, pi);
   h_gdb_process = pi->hProcess;
   DuplicateHandle (GetCurrentProcess (), h_gdb_process,
@@ -325,7 +329,7 @@ CreateProcessW_Hooked
   debug_process = !!(f & (DEBUG_PROCESS | DEBUG_ONLY_THIS_PROCESS));
   if (debug_process)
     mutex_timeout = 0; /* to avoid deadlock in GDB */
-  if (!atexit_func_registered && !path.iscygexec ())
+  if (!atexit_func_registered && !path_iscygexec)
     {
       atexit (atexit_func);
       atexit_func_registered = true;
-- 
2.35.1

