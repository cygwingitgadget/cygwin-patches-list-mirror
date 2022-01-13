Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id CB7DF39484A0
 for <cygwin-patches@cygwin.com>; Thu, 13 Jan 2022 12:29:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CB7DF39484A0
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 20DCSLD8010973;
 Thu, 13 Jan 2022 21:28:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 20DCSLD8010973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1642076938;
 bh=5BGbbrM7yfaLN+9Ojs+aWbbbyixMflq3mAh27bxXEyI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=iS2s6R+Wvunif/sxYMIe5OEW2WsuCPQ2JG4+pCObJV0PAb0UqcklqeHcPEMRXYTeo
 PgUmkqpodcVOFtd4EpL59+B4uXC83CifBg03YMOp2bvMw+jrPPkWIs0DpN3sodaBgq
 +M0VbW7OthHwpArmpa+ICe+pwwiHragoKaIM2YkKC8rhhvscwQh2VHcKIaCpVYKxlX
 FphQL+qAVp+8/X/J2qLqT5ryPrS6y/tkJVb0Ms31dy3MPg2p1DBTau3lBqdOSB6Bq2
 3SV4lt7bed65Re5XIj6NgHsL3M7uNcYMfyjF6iBdvbvB4hBCiAYWNvR5JlLYERmkcB
 Gsg98ZuYARoxQ==
X-Nifty-SrcIP: [14.3.233.132]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 3/4] Cygwin: pty: Stop closing and recreating attach_mutex.
Date: Thu, 13 Jan 2022 21:28:10 +0900
Message-Id: <20220113122811.241-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
References: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 13 Jan 2022 12:29:36 -0000

- Closing attach_mutex and recreating it causes the race issue
  between pty and console codes. With this patch, attach_mutex
  is created only once in a process which opens pty, and never
  closed in order to avoid this issue.

Addresses:
  https://cygwin.com/pipermail/cygwin-developers/2021-December/012548.html
---
 winsup/cygwin/fhandler.h          |  3 +++
 winsup/cygwin/fhandler_console.cc | 17 -----------------
 winsup/cygwin/fhandler_tty.cc     | 30 ++++++++++++++++++++----------
 winsup/cygwin/select.cc           | 16 ----------------
 4 files changed, 23 insertions(+), 43 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 4f70c4c0b..0cea1b7f3 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -1881,6 +1881,9 @@ class fhandler_serial: public fhandler_base
 #define release_output_mutex() \
   __release_output_mutex (__PRETTY_FUNCTION__, __LINE__)
 
+DWORD acquire_attach_mutex (DWORD t);
+void release_attach_mutex (void);
+
 class tty;
 class tty_min;
 class fhandler_termios: public fhandler_base
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 024be522b..0e4b41559 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -56,25 +56,8 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
 
 bool NO_COPY fhandler_console::invisible_console;
 
-/* Mutex for AttachConsole()/FreeConsole() in fhandler_tty.cc */
-HANDLE attach_mutex;
-
 extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
 
-static inline void
-acquire_attach_mutex (DWORD t)
-{
-  if (attach_mutex)
-    WaitForSingleObject (attach_mutex, t);
-}
-
-static inline void
-release_attach_mutex ()
-{
-  if (attach_mutex)
-    ReleaseMutex (attach_mutex);
-}
-
 /* con_ra is shared in the same process.
    Only one console can exist in a process, therefore, static is suitable. */
 static struct fhandler_base::rabuf_t con_ra;
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f68e80df9..1ae4edd63 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -58,8 +58,21 @@ struct pipe_reply {
   DWORD error;
 };
 
-extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
-static LONG master_cnt = 0;
+HANDLE attach_mutex;
+
+DWORD acquire_attach_mutex (DWORD t)
+{
+  if (!attach_mutex)
+    return WAIT_OBJECT_0;
+  return WaitForSingleObject (attach_mutex, t);
+}
+
+void release_attach_mutex (void)
+{
+  if (!attach_mutex)
+    return;
+  ReleaseMutex (attach_mutex);
+}
 
 inline static bool pcon_pid_alive (DWORD pid);
 
@@ -523,13 +536,13 @@ fhandler_pty_master::accept_input ()
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  WaitForSingleObject (attach_mutex, mutex_timeout);
+	  acquire_attach_mutex (mutex_timeout);
 	  FreeConsole ();
 	  AttachConsole (target_pid);
 	  cp_to = GetConsoleCP ();
 	  FreeConsole ();
 	  AttachConsole (resume_pid);
-	  ReleaseMutex (attach_mutex);
+	  release_attach_mutex ();
 	}
       else
 	cp_to = GetConsoleCP ();
@@ -2111,8 +2124,6 @@ fhandler_pty_master::close ()
 	  master_fwd_thread->detach ();
 	}
     }
-  if (InterlockedDecrement (&master_cnt) == 0)
-    CloseHandle (attach_mutex);
 
   /* Check if the last master handle has been closed.  If so, set
      input_available_event to wake up potentially waiting slaves. */
@@ -2838,13 +2849,13 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	{
 	  /* Slave attaches to a different console than master.
 	     Therefore reattach here. */
-	  WaitForSingleObject (attach_mutex, mutex_timeout);
+	  acquire_attach_mutex (mutex_timeout);
 	  FreeConsole ();
 	  AttachConsole (target_pid);
 	  cp_from = GetConsoleOutputCP ();
 	  FreeConsole ();
 	  AttachConsole (resume_pid);
-	  ReleaseMutex (attach_mutex);
+	  release_attach_mutex ();
 	}
       else
 	cp_from = GetConsoleOutputCP ();
@@ -2993,7 +3004,7 @@ fhandler_pty_master::setup ()
   if (!(pcon_mutex = CreateMutex (&sa, FALSE, buf)))
     goto err;
 
-  if (InterlockedIncrement (&master_cnt) == 1)
+  if (!attach_mutex)
     attach_mutex = CreateMutex (&sa, FALSE, NULL);
 
   /* Create master control pipe which allows the master to duplicate
@@ -3057,7 +3068,6 @@ err:
   close_maybe (input_available_event);
   close_maybe (output_mutex);
   close_maybe (input_mutex);
-  close_maybe (attach_mutex);
   close_maybe (from_master_nat);
   close_maybe (from_master);
   close_maybe (to_master_nat);
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 0cd62d932..5b8fc0f81 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1095,22 +1095,6 @@ fhandler_fifo::select_except (select_stuff *ss)
   return s;
 }
 
-extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
-
-static inline void
-acquire_attach_mutex (DWORD t)
-{
-  if (attach_mutex)
-    WaitForSingleObject (attach_mutex, t);
-}
-
-static inline void
-release_attach_mutex ()
-{
-  if (attach_mutex)
-    ReleaseMutex (attach_mutex);
-}
-
 extern DWORD mutex_timeout; /* defined in fhandler_termios.cc */
 
 static int
-- 
2.34.1

