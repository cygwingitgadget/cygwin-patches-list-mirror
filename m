Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 8BD783858419
 for <cygwin-patches@cygwin.com>; Sun, 12 Dec 2021 13:04:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 8BD783858419
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 1BCD3tqW021654;
 Sun, 12 Dec 2021 22:04:00 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 1BCD3tqW021654
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639314241;
 bh=ACgcLWpmS/Ifdj/sItHCeY3Z6Voda5MRdHcK8xjOCaA=;
 h=From:To:Cc:Subject:Date:From;
 b=igP3cdQO27HR3q3iUdacw+yJIBouGJm2F3zO7DkkFeyApIaEH9dAaz7O89NmJqebp
 62257R0ClQlLCRlQkgAxRd47+MR/N0ce0+3bfKJUpmL5J/aJXXowkitEHiyqqkrGEB
 St66BVeyc24TXz7ssnT8HbaWGFWoX2ZVYGTGBANjkfzvZq99x1qIjyG7nvsgjD6OQN
 M99SVXnNSloOwtGG3R4+1TT6UxRCmqrYcoA9FX5Caah4is5wYKz7ISWxkZFqcUzeKm
 0s3PH5v0sN76cy9m5niza+e/zJW+9WLdw93VQTwcM2OitLk1zkQs9sP5AfhtOWUj0I
 uv8/RTAGTyYOQ==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add missing input transfer when
 switch_to_pcon_in state.
Date: Sun, 12 Dec 2021 22:03:47 +0900
Message-Id: <20211212130347.10080-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Sun, 12 Dec 2021 13:04:22 -0000

- This patch fixes the bug that input is wrongly sent to io_handle_nat
  rather than io_handle when neither read() nor select() is called
  after the cygwin app is started from non-cygwin app. This happens
  only if psuedo console is disabled.

Addresses:
  https://cygwin.com/pipermail/cygwin-patches/2021q4/011587.html
---
 winsup/cygwin/fhandler_tty.cc | 87 ++++++++++++++++++++++++++++-------
 winsup/cygwin/release/3.3.4   |  5 ++
 2 files changed, 75 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f523dafed..dae00efd7 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1077,11 +1077,15 @@ pcon_pid_alive (DWORD pid)
 {
   if (pid == 0)
     return false;
-  HANDLE h = OpenProcess (SYNCHRONIZE, FALSE, pid);
+  HANDLE h = OpenProcess (PROCESS_QUERY_LIMITED_INFORMATION, FALSE, pid);
   if (h == NULL)
     return false;
+  DWORD exit_code;
+  BOOL r = GetExitCodeProcess (h, &exit_code);
   CloseHandle (h);
-  return true;
+  if (r && exit_code == STILL_ACTIVE)
+    return true;
+  return false;
 }
 
 inline static bool
@@ -1172,11 +1176,53 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
     return;
   if (get_ttyp ()->pcon_start)
     return;
+  /* This input transfer is needed if non-cygwin app is terminated
+     by Ctrl-C or killed. */
+  WaitForSingleObject (input_mutex, INFINITE);
+  if (!get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ())
+      && get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+    transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+		    input_available_event);
+  ReleaseMutex (input_mutex);
   WaitForSingleObject (pcon_mutex, INFINITE);
   if (!pcon_pid_self (get_ttyp ()->pcon_pid)
       && pcon_pid_alive (get_ttyp ()->pcon_pid))
     {
       /* There is a process which is grabbing pseudo console. */
+      if (get_ttyp ()->pcon_activated
+	  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
+	{
+	  HANDLE pcon_owner =
+	    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+	  if (pcon_owner)
+	    {
+	      pinfo pinfo_resume = pinfo (myself->ppid);
+	      DWORD resume_pid;
+	      if (pinfo_resume)
+		resume_pid = pinfo_resume->dwProcessId;
+	      else
+		resume_pid =
+		  get_console_process_id (myself->dwProcessId, false);
+	      if (resume_pid)
+		{
+		  HANDLE h_pcon_in;
+		  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+				   GetCurrentProcess (), &h_pcon_in,
+				   0, TRUE, DUPLICATE_SAME_ACCESS);
+		  FreeConsole ();
+		  AttachConsole (get_ttyp ()->pcon_pid);
+		  WaitForSingleObject (input_mutex, INFINITE);
+		  transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
+				  input_available_event);
+		  ReleaseMutex (input_mutex);
+		  FreeConsole ();
+		  AttachConsole (resume_pid);
+		  CloseHandle (h_pcon_in);
+		}
+	      CloseHandle (pcon_owner);
+	    }
+	}
       ReleaseMutex (pcon_mutex);
       return;
     }
@@ -1231,6 +1277,7 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
   HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
   CloseHandle (masked);
 
+  WaitForSingleObject (input_mutex, INFINITE);
   if (mask)
     {
       if (InterlockedIncrement (&num_reader) == 1)
@@ -1239,27 +1286,25 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
   else if (InterlockedDecrement (&num_reader) == 0)
     CloseHandle (slave_reading);
 
+  /* This is needed when cygwin-app is started from non-cygwin app if
+     pseudo console is disabled. */
+  bool need_xfer = get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ()) && mask
+    && get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
+
   /* In GDB, transfer input based on setpgid() does not work because
      GDB may not set terminal process group properly. Therefore,
      transfer input here if isHybrid is set. */
-  if (isHybrid && !!masked != mask && xfer
+  if ((isHybrid || need_xfer) && !!masked != mask && xfer
       && GetStdHandle (STD_INPUT_HANDLE) == get_handle ())
     {
       if (mask && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
-	{
-	  WaitForSingleObject (input_mutex, INFINITE);
-	  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-			  input_available_event);
-	  ReleaseMutex (input_mutex);
-	}
+	transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+			input_available_event);
       else if (!mask && get_ttyp ()->pcon_input_state_eq (tty::to_cyg))
-	{
-	  WaitForSingleObject (input_mutex, INFINITE);
-	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
-			  input_available_event);
-	  ReleaseMutex (input_mutex);
-	}
+	transfer_input (tty::to_nat, get_handle (), get_ttyp (),
+			input_available_event);
     }
+  ReleaseMutex (input_mutex);
 }
 
 bool
@@ -1536,7 +1581,7 @@ out:
   if (ptr0)
     { /* Not tcflush() */
       bool saw_eol = totalread > 0 && strchr ("\r\n", ptr0[totalread -1]);
-      mask_switch_to_pcon_in (false, saw_eol);
+      mask_switch_to_pcon_in (false, saw_eol || len == 0);
     }
 }
 
@@ -2187,6 +2232,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   /* Write terminal input to to_slave_nat pipe instead of output_handle
      if current application is native console application. */
+  WaitForSingleObject (input_mutex, INFINITE);
   if (to_be_read_from_pcon () && get_ttyp ()->pcon_activated
       && get_ttyp ()->pcon_input_state == tty::to_nat)
     {
@@ -2203,7 +2249,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 			  &mbp);
 	}
 
-      WaitForSingleObject (input_mutex, INFINITE);
       if ((ti.c_lflag & ISIG) && !(ti.c_lflag & NOFLSH)
 	  && memchr (buf, '\003', nlen))
 	get_ttyp ()->discard_input = true;
@@ -2214,6 +2259,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       return len;
     }
 
+  /* This input transfer is needed when cygwin-app which is started from
+     non-cygwin app is terminated if pseudo console is disabled. */
+  if (to_be_read_from_pcon () && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->pcon_input_state == tty::to_cyg)
+    fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
+					get_ttyp (), input_available_event);
+  ReleaseMutex (input_mutex);
+
   line_edit_status status = line_edit (p, len, ti, &ret);
   if (status > line_edit_signalled && status != line_edit_pipe_full)
     ret = -1;
diff --git a/winsup/cygwin/release/3.3.4 b/winsup/cygwin/release/3.3.4
index 4cbfba8eb..a15684fdb 100644
--- a/winsup/cygwin/release/3.3.4
+++ b/winsup/cygwin/release/3.3.4
@@ -9,3 +9,8 @@ Bug Fixes
   This solves the following issues:
   Addresses: https://cygwin.com/pipermail/cygwin/2021-November/250087.html
              https://cygwin.com/pipermail/cygwin/2021-December/250103.html
+
+- Fix a bug in pty code that input is wrongly sent to io_handle_nat
+  rather than io_handle while neither read() nor select() is called
+  after the cygwin app is started from non-cygwin app.
+  Addresses: https://cygwin.com/pipermail/cygwin-patches/2021q4/011587.html
-- 
2.34.1

