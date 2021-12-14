Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 99EE33858D28
 for <cygwin-patches@cygwin.com>; Tue, 14 Dec 2021 10:23:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 99EE33858D28
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (v050141.dynamic.ppp.asahi-net.or.jp
 [124.155.50.141]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 1BEANQuW012778;
 Tue, 14 Dec 2021 19:23:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 1BEANQuW012778
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1639477412;
 bh=rEhezPjCyg2h8oOLipfW0Ms/IbHedpt4+rW5AZXHX4g=;
 h=From:To:Cc:Subject:Date:From;
 b=ZH5g94r0UIVyX6oSoMARVCvJ5IDM4N0EdXrcaNI2eJ/D4KdT/rpcUoiqVOiWUcmNX
 WaxO61n4S6iExU5il7tvMZcp/gU1FloXy6WtoySDUaft4n2fQ+1iG+Ot7swutKhira
 M7IScF1bxosgq1LUtV9LoQhkXzh/cav690ah9OUstC6E/DBp23KpXGwnqImvZEenLF
 JHIjcbt5x2M5e5+23q3ZP4ONDBfONpCDR4Yp3wsCGzC7IuFK5YLYCyvqEennCNVIEO
 4PrOM4CwlwOe2epQoVStLKmVLnW1JOJt1Qp4z7LlGH8eOahfg3k9qpacSJCjqyWJP7
 LTVIe4HgSJE+Q==
X-Nifty-SrcIP: [124.155.50.141]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix conditions for input transfer again.
Date: Tue, 14 Dec 2021 19:23:17 +0900
Message-Id: <20211214102317.657-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_VALIDITY_RPBL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Tue, 14 Dec 2021 10:23:59 -0000

---
 winsup/cygwin/fhandler_tty.cc | 67 ++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 28 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5e76b51c5..ee687d9ad 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1181,37 +1181,48 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       && pcon_pid_alive (get_ttyp ()->pcon_pid))
     {
       /* There is a process which is grabbing pseudo console. */
-      if (!to_be_read_from_pcon () && get_ttyp ()->pcon_activated
+      if (!to_be_read_from_pcon ()
 	  && get_ttyp ()->pcon_input_state_eq (tty::to_nat))
 	{
-	  HANDLE pcon_owner =
-	    OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
-	  if (pcon_owner)
+	  if (get_ttyp ()->pcon_activated)
 	    {
-	      pinfo pinfo_resume = pinfo (myself->ppid);
-	      DWORD resume_pid;
-	      if (pinfo_resume)
-		resume_pid = pinfo_resume->dwProcessId;
-	      else
-		resume_pid =
-		  get_console_process_id (myself->dwProcessId, false);
-	      if (resume_pid)
+	      HANDLE pcon_owner =
+		OpenProcess (PROCESS_DUP_HANDLE, FALSE, get_ttyp ()->pcon_pid);
+	      if (pcon_owner)
 		{
-		  HANDLE h_pcon_in;
-		  DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
-				   GetCurrentProcess (), &h_pcon_in,
-				   0, TRUE, DUPLICATE_SAME_ACCESS);
-		  FreeConsole ();
-		  AttachConsole (get_ttyp ()->pcon_pid);
-		  WaitForSingleObject (input_mutex, INFINITE);
-		  transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
-				  input_available_event);
-		  ReleaseMutex (input_mutex);
-		  FreeConsole ();
-		  AttachConsole (resume_pid);
-		  CloseHandle (h_pcon_in);
+		  pinfo pinfo_resume = pinfo (myself->ppid);
+		  DWORD resume_pid;
+		  if (pinfo_resume)
+		    resume_pid = pinfo_resume->dwProcessId;
+		  else
+		    resume_pid =
+		      get_console_process_id (myself->dwProcessId, false);
+		  if (resume_pid)
+		    {
+		      HANDLE h_pcon_in;
+		      DuplicateHandle (pcon_owner, get_ttyp ()->h_pcon_in,
+				       GetCurrentProcess (), &h_pcon_in,
+				       0, TRUE, DUPLICATE_SAME_ACCESS);
+		      FreeConsole ();
+		      AttachConsole (get_ttyp ()->pcon_pid);
+		      WaitForSingleObject (input_mutex, INFINITE);
+		      transfer_input (tty::to_cyg, h_pcon_in, get_ttyp (),
+				      input_available_event);
+		      ReleaseMutex (input_mutex);
+		      FreeConsole ();
+		      AttachConsole (resume_pid);
+		      CloseHandle (h_pcon_in);
+		    }
+		  CloseHandle (pcon_owner);
 		}
-	      CloseHandle (pcon_owner);
+	    }
+	  else if (!get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ())
+		   && get_ttyp ()->switch_to_pcon_in)
+	    {
+	      WaitForSingleObject (input_mutex, INFINITE);
+	      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+			      input_available_event);
+	      ReleaseMutex (input_mutex);
 	    }
 	}
       ReleaseMutex (pcon_mutex);
@@ -1287,8 +1298,8 @@ fhandler_pty_slave::mask_switch_to_pcon_in (bool mask, bool xfer)
 
   /* This is needed when cygwin-app is started from non-cygwin app if
      pseudo console is disabled. */
-  bool need_xfer =
-    get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
+  bool need_xfer = get_ttyp ()->pcon_fg (get_ttyp ()->getpgid ())
+    && get_ttyp ()->switch_to_pcon_in && !get_ttyp ()->pcon_activated;
 
   /* In GDB, transfer input based on setpgid() does not work because
      GDB may not set terminal process group properly. Therefore,
-- 
2.34.1

