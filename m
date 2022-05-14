Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 2FB893858D28
 for <cygwin-patches@cygwin.com>; Sat, 14 May 2022 22:28:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2FB893858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 24EMSV1f031118;
 Sun, 15 May 2022 07:28:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 24EMSV1f031118
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652567316;
 bh=lKWOyQE75FV4I5x3xVFAFtMBfyjUMluf6ro7IQpeuaM=;
 h=From:To:Cc:Subject:Date:From;
 b=bziK5jB/G3QL171QgwXfJPtBsSfS1fHLiO7Rvr78dd1MEs1rHbax2cK/MCLGhpFnj
 Tc40hjAzSMXknw04KhKFdGXwB2l59h8pAlpUcHT12irWgMJZ5byZgzbCb08aF7JitC
 5VS5cdgSVQiFicm9GgJ1EDRupwovVSfInqc75QoHZkqFieOhYXb3+f1LTM+6OdZwbk
 AjcRKEy9C7GWVGsQ/tGeHk1TjHmBrqx67GxrqjAIxrsIYNBkBgWJZhjtC3ey7NJFnZ
 DbSnlEbwFqor/WxGp6HE/KKvrJejmwWdxoJSSGJ+bxbBGr9e9ea2lKjeJKpO5VsCf+
 HzwNK07TDY2kQ==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix script command crash on console in Win7.
Date: Sun, 15 May 2022 07:28:23 +0900
Message-Id: <20220514222823.36326-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Sat, 14 May 2022 22:29:01 -0000

- Previously, the command "cmd /c script -c cmd" in console of Win7
  crashes. This seems to be due to a bug (?) of AttachConsole().
  This patch adds workaround for this issue.

  Currently, pty reattaches to the console of the process which is
  predetermined by ConsoleProcessList() after temporarily attaching
  to another console. After that, the console output handle opened
  with the name "CONOUT$" may not be accessible in Win7.
  This seems to happen when the attached process does not have the
  same handle even if the console attached is the same. With this
  patch, cygwin-console-helper which is started when pty master is
  opened in console, is utilized to be a target process to which
  pty reattaches if the OS is Win7.
---
 winsup/cygwin/fhandler.h                    |  8 ++-
 winsup/cygwin/fhandler_termios.cc           |  3 +-
 winsup/cygwin/fhandler_tty.cc               | 77 +++++++++++++++++++--
 winsup/cygwin/wincap.cc                     | 12 ++++
 winsup/cygwin/wincap.h                      |  2 +
 winsup/utils/mingw/cygwin-console-helper.cc |  2 +-
 6 files changed, 96 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 80dd94508..36f64818d 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1984,6 +1984,7 @@ class fhandler_termios: public fhandler_base
   virtual void setpgid_aux (pid_t pid) {}
   virtual bool need_console_handler () { return false; }
   virtual bool need_send_ctrl_c_event () { return true; }
+  virtual DWORD get_helper_pid () { return 0; }
 };
 
 enum ansi_intensity
@@ -2343,7 +2344,7 @@ class fhandler_pty_common: public fhandler_termios
 				       bool cygwin = false,
 				       bool stub_only = false);
   bool to_be_read_from_nat_pipe (void);
-  static DWORD attach_console_temporarily (DWORD target_pid);
+  static DWORD attach_console_temporarily (DWORD target_pid, DWORD helper_pid);
   static void resume_from_temporarily_attach (DWORD resume_pid);
 
  protected:
@@ -2472,6 +2473,7 @@ public:
     HANDLE from_slave_nat;
     HANDLE output_mutex;
     tty *ttyp;
+    DWORD helper_pid;
   };
 private:
   int pktmode;			// non-zero if pty in a packet mode.
@@ -2483,6 +2485,9 @@ private:
   HANDLE to_master, from_master;
   cygthread *master_fwd_thread;	// Master forwarding thread
   HANDLE thread_param_copied_event;
+  HANDLE helper_goodbye;
+  HANDLE helper_h_process;
+  DWORD helper_pid;
 
 public:
   HANDLE get_echo_handle () const { return echo_r; }
@@ -2537,6 +2542,7 @@ public:
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
   void set_mask_flusho (bool m) { get_ttyp ()->mask_flusho = m; }
   bool need_send_ctrl_c_event ();
+  DWORD get_helper_pid () { return helper_pid; }
 };
 
 class fhandler_dev_null: public fhandler_base
diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index 735423bf2..328c73fcd 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -359,7 +359,8 @@ fhandler_termios::process_sigs (char c, tty* ttyp, fhandler_termios *fh)
 	  DWORD resume_pid = 0;
 	  if (fh && !fh->is_console ())
 	    resume_pid =
-	      fhandler_pty_common::attach_console_temporarily (p->dwProcessId);
+	      fhandler_pty_common::attach_console_temporarily
+				    (p->dwProcessId, fh->get_helper_pid ());
 	  if (fh && p == myself && being_debugged ())
 	    { /* Avoid deadlock in gdb on console. */
 	      fh->tcflush(TCIFLUSH);
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 9dfc3c495..825d80666 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -547,7 +547,8 @@ fhandler_pty_master::accept_input ()
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  DWORD resume_pid = attach_console_temporarily (target_pid);
+	  DWORD resume_pid =
+	    attach_console_temporarily (target_pid, helper_pid);
 	  cp_to = GetConsoleCP ();
 	  resume_from_temporarily_attach (resume_pid);
 	}
@@ -2104,6 +2105,16 @@ fhandler_pty_master::close ()
 	  get_ttyp ()->stop_fwd_thread = true;
 	  WriteFile (to_master_nat, "", 0, &len, NULL);
 	  master_fwd_thread->detach ();
+	  if (helper_goodbye)
+	    {
+	      SetEvent (helper_goodbye);
+	      WaitForSingleObject (helper_h_process, INFINITE);
+	      CloseHandle (helper_h_process);
+	      CloseHandle (helper_goodbye);
+	      helper_pid = 0;
+	      helper_h_process = 0;
+	      helper_goodbye = NULL;
+	    }
 	}
     }
 
@@ -2826,7 +2837,8 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  DWORD resume_pid = attach_console_temporarily (target_pid);
+	  DWORD resume_pid =
+	    attach_console_temporarily (target_pid, p->helper_pid);
 	  cp_from = GetConsoleOutputCP ();
 	  resume_from_temporarily_attach (resume_pid);
 	}
@@ -3009,6 +3021,57 @@ fhandler_pty_master::setup ()
       goto err;
     }
   WaitForSingleObject (thread_param_copied_event, INFINITE);
+
+  if (wincap.has_broken_attach_console ()
+      && _major (myself->ctty) == DEV_CONS_MAJOR
+      && !(!pinfo (myself->ppid) && getenv ("ConEmuPID")))
+    {
+      HANDLE hello = CreateEvent (&sec_none, true, false, NULL);
+      HANDLE goodbye = CreateEvent (&sec_none, true, false, NULL);
+      WCHAR cmd[MAX_PATH];
+      path_conv helper ("/bin/cygwin-console-helper.exe");
+      size_t len = helper.get_wide_win32_path_len ();
+      helper.get_wide_win32_path (cmd);
+      __small_swprintf (cmd + len, L" %p %p", hello, goodbye);
+
+      STARTUPINFOEXW si;
+      PROCESS_INFORMATION pi;
+      ZeroMemory (&si, sizeof (si));
+      si.StartupInfo.cb = sizeof (STARTUPINFOEXW);
+
+      SIZE_T bytesRequired;
+      InitializeProcThreadAttributeList (NULL, 1, 0, &bytesRequired);
+      si.lpAttributeList = (PPROC_THREAD_ATTRIBUTE_LIST)
+	HeapAlloc (GetProcessHeap (), 0, bytesRequired);
+      InitializeProcThreadAttributeList (si.lpAttributeList,
+					 1, 0, &bytesRequired);
+      HANDLE handles_to_inherit[] = {hello, goodbye};
+      UpdateProcThreadAttribute (si.lpAttributeList,
+				 0,
+				 PROC_THREAD_ATTRIBUTE_HANDLE_LIST,
+				 handles_to_inherit,
+				 sizeof (handles_to_inherit),
+				 NULL, NULL);
+      if (CreateProcessW (NULL, cmd, &sec_none, &sec_none,
+			  TRUE, EXTENDED_STARTUPINFO_PRESENT,
+			  NULL, NULL, &si.StartupInfo, &pi))
+	{
+	  WaitForSingleObject (hello, INFINITE);
+	  CloseHandle (hello);
+	  CloseHandle (pi.hThread);
+	  helper_goodbye = goodbye;
+	  helper_pid = pi.dwProcessId;
+	  helper_h_process = pi.hProcess;
+	}
+      else
+	{
+	  CloseHandle (hello);
+	  CloseHandle (goodbye);
+	}
+      DeleteProcThreadAttributeList (si.lpAttributeList);
+      HeapFree (GetProcessHeap (), 0, si.lpAttributeList);
+    }
+
   master_fwd_thread = new cygthread (::pty_master_fwd_thread, this, "ptymf");
   if (!master_fwd_thread)
     {
@@ -3814,6 +3877,7 @@ fhandler_pty_master::get_master_fwd_thread_param (master_fwd_thread_param_t *p)
   p->from_slave_nat = from_slave_nat;
   p->output_mutex = output_mutex;
   p->ttyp = get_ttyp ();
+  p->helper_pid = helper_pid;
   SetEvent (thread_param_copied_event);
 }
 
@@ -4124,7 +4188,7 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 			   0, TRUE, DUPLICATE_SAME_ACCESS);
 	  CloseHandle (pcon_owner);
 	  DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
-	  resume_pid = attach_console_temporarily (target_pid);
+	  resume_pid = attach_console_temporarily (target_pid, 0);
 	  attach_restore = true;
 	}
       else
@@ -4170,12 +4234,15 @@ fhandler_pty_slave::release_ownership_of_nat_pipe (tty *ttyp,
 }
 
 DWORD
-fhandler_pty_common::attach_console_temporarily (DWORD target_pid)
+fhandler_pty_common::attach_console_temporarily (DWORD target_pid,
+						 DWORD helper_pid)
 {
   DWORD resume_pid = 0;
   acquire_attach_mutex (mutex_timeout);
   pinfo pinfo_resume (myself->ppid);
-  if (pinfo_resume)
+  if (helper_pid)
+    resume_pid = helper_pid;
+  else if (pinfo_resume)
     resume_pid = pinfo_resume->dwProcessId;
   if (!resume_pid)
     resume_pid = get_console_process_id (myself->dwProcessId, false);
diff --git a/winsup/cygwin/wincap.cc b/winsup/cygwin/wincap.cc
index 835497cfe..0f0b77de8 100644
--- a/winsup/cygwin/wincap.cc
+++ b/winsup/cygwin/wincap.cc
@@ -44,6 +44,7 @@ wincaps wincap_7 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_tcp_maxrtms:false,
     has_query_process_handle_info:false,
     has_con_broken_tabs:false,
+    has_broken_attach_console:true,
   },
 };
 
@@ -73,6 +74,7 @@ wincaps wincap_8 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_tcp_maxrtms:false,
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
+    has_broken_attach_console:false,
   },
 };
 
@@ -102,6 +104,7 @@ wincaps wincap_8_1 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_tcp_maxrtms:false,
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
+    has_broken_attach_console:false,
   },
 };
 
@@ -131,6 +134,7 @@ wincaps  wincap_10_1507 __attribute__((section (".cygwin_dll_common"), shared))
     has_tcp_maxrtms:false,
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
+    has_broken_attach_console:false,
   },
 };
 
@@ -160,6 +164,7 @@ wincaps  wincap_10_1607 __attribute__((section (".cygwin_dll_common"), shared))
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
+    has_broken_attach_console:false,
   },
 };
 
@@ -189,6 +194,7 @@ wincaps wincap_10_1703 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
+    has_broken_attach_console:false,
   },
 };
 
@@ -218,6 +224,7 @@ wincaps wincap_10_1709 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
+    has_broken_attach_console:false,
   },
 };
 
@@ -247,6 +254,7 @@ wincaps wincap_10_1803 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
+    has_broken_attach_console:false,
   },
 };
 
@@ -276,6 +284,7 @@ wincaps wincap_10_1809 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
+    has_broken_attach_console:false,
   },
 };
 
@@ -305,6 +314,7 @@ wincaps wincap_10_1903 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
+    has_broken_attach_console:false,
   },
 };
 
@@ -334,6 +344,7 @@ wincaps wincap_10_2004 __attribute__((section (".cygwin_dll_common"), shared)) =
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:true,
+    has_broken_attach_console:false,
   },
 };
 
@@ -363,6 +374,7 @@ wincaps wincap_11 __attribute__((section (".cygwin_dll_common"), shared)) = {
     has_tcp_maxrtms:true,
     has_query_process_handle_info:true,
     has_con_broken_tabs:false,
+    has_broken_attach_console:false,
   },
 };
 
diff --git a/winsup/cygwin/wincap.h b/winsup/cygwin/wincap.h
index 8184e7151..818359f94 100644
--- a/winsup/cygwin/wincap.h
+++ b/winsup/cygwin/wincap.h
@@ -38,6 +38,7 @@ struct wincaps
     unsigned has_tcp_maxrtms					: 1;
     unsigned has_query_process_handle_info			: 1;
     unsigned has_con_broken_tabs				: 1;
+    unsigned has_broken_attach_console				: 1;
   };
 };
 
@@ -97,6 +98,7 @@ public:
   bool	IMPLEMENT (has_tcp_maxrtms)
   bool	IMPLEMENT (has_query_process_handle_info)
   bool	IMPLEMENT (has_con_broken_tabs)
+  bool	IMPLEMENT (has_broken_attach_console)
 
   void disable_case_sensitive_dirs ()
   {
diff --git a/winsup/utils/mingw/cygwin-console-helper.cc b/winsup/utils/mingw/cygwin-console-helper.cc
index 66004bd15..80d15e3f3 100644
--- a/winsup/utils/mingw/cygwin-console-helper.cc
+++ b/winsup/utils/mingw/cygwin-console-helper.cc
@@ -6,11 +6,11 @@ main (int argc, char **argv)
   char *end;
   if (argc < 3)
     exit (1);
+  SetConsoleCtrlHandler (NULL, TRUE);
   HANDLE h = (HANDLE) strtoull (argv[1], &end, 0);
   SetEvent (h);
   if (argc == 4) /* Pseudo console helper mode for PTY */
     {
-      SetConsoleCtrlHandler (NULL, TRUE);
       HANDLE hPipe = (HANDLE) strtoull (argv[3], &end, 0);
       char buf[64];
       sprintf (buf, "StdHandles=%p,%p\n",
-- 
2.36.0

