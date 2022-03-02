Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 5C4193858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 19:50:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5C4193858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 222JoTta018498;
 Thu, 3 Mar 2022 04:50:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 222JoTta018498
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646250634;
 bh=H50p1OQPoU4DJW5ABAyp8jngpLPRKgPqeZ/6IUyix54=;
 h=From:To:Cc:Subject:Date:From;
 b=vkV9Z5eBUMlPCI4NwUx5+aTEXluB2i6lITz8Q5IZliwBScvibrs3TXUoqmu7QiIZc
 ic0kK419X8JkPudWN531QgB9cP0E9lByh1hw98VJPI2PBwkUwZ0gNK1Vrcf8/9CaP9
 o6+WqZV/xy/prqPu3eBCqirq7uNxWXIxs4PVlx0f8iHpyRviTsc/Fk0ZcUVYCZW/9G
 i+3YVXFI41QxTKbLvwqwMOWQTd1qVdZrxzbKI3y9FgRvf2HfY+nf40zpiyPh2VRrht
 grTbUlhPgfAYccLCCNVONYLnwIx5fidXenMv6/WO14o3Yj+hHoZmRK78erCmjvpgTS
 xBNvasRGmnrcw==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Add still missing acquire/release_attach_mutex.
Date: Thu,  3 Mar 2022 04:50:24 +0900
Message-Id: <20220302195024.21673-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Wed, 02 Mar 2022 19:50:54 -0000

- transfer_input() function uses console api, so it should be guarded
  by attach_mutex. However, in most cases, it is missing. This patch
  fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 48 +++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 433861bb4..43668975f 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -1133,8 +1133,10 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		  && get_ttyp ()->pty_input_state_eq (tty::to_nat))
 		{
 		  WaitForSingleObject (input_mutex, mutex_timeout);
+		  acquire_attach_mutex (mutex_timeout);
 		  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 				  input_available_event);
+		  release_attach_mutex ();
 		  ReleaseMutex (input_mutex);
 		}
 	      if (get_ttyp ()->master_is_running_as_service
@@ -1237,8 +1239,10 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
 		   && get_ttyp ()->switch_to_nat_pipe)
 	    {
 	      WaitForSingleObject (input_mutex, mutex_timeout);
+	      acquire_attach_mutex (mutex_timeout);
 	      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
 			      input_available_event);
+	      release_attach_mutex ();
 	      ReleaseMutex (input_mutex);
 	    }
 	}
@@ -1250,8 +1254,12 @@ fhandler_pty_slave::reset_switch_to_nat_pipe (void)
   WaitForSingleObject (input_mutex, mutex_timeout);
   if (get_ttyp ()->switch_to_nat_pipe && !get_ttyp ()->pcon_activated
       && get_ttyp ()->pty_input_state_eq (tty::to_nat))
-    transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-		    input_available_event);
+    {
+      acquire_attach_mutex (mutex_timeout);
+      transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+		      input_available_event);
+      release_attach_mutex ();
+    }
   ReleaseMutex (input_mutex);
   /* Clean up nat pipe state */
   get_ttyp ()->pty_input_state = tty::to_cyg;
@@ -1333,11 +1341,19 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
   if (!!masked != mask && xfer && (need_gdb_xfer || need_xfer))
     {
       if (mask && get_ttyp ()->pty_input_state_eq (tty::to_nat))
-	transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
-			input_available_event);
+	{
+	  acquire_attach_mutex (mutex_timeout);
+	  transfer_input (tty::to_cyg, get_handle_nat (), get_ttyp (),
+			  input_available_event);
+	  release_attach_mutex ();
+	}
       else if (!mask && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
-	transfer_input (tty::to_nat, get_handle (), get_ttyp (),
-			input_available_event);
+	{
+	  acquire_attach_mutex (mutex_timeout);
+	  transfer_input (tty::to_nat, get_handle (), get_ttyp (),
+			  input_available_event);
+	  release_attach_mutex ();
+	}
     }
   ReleaseMutex (input_mutex);
 }
@@ -2261,9 +2277,11 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      if (get_readahead_valid ())
 		accept_input ();
 	      WaitForSingleObject (input_mutex, mutex_timeout);
+	      acquire_attach_mutex (mutex_timeout);
 	      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
 						  get_ttyp (),
 						  input_available_event);
+	      release_attach_mutex ();
 	      ReleaseMutex (input_mutex);
 	    }
 	  get_ttyp ()->pcon_start_pid = 0;
@@ -2315,8 +2333,12 @@ fhandler_pty_master::write (const void *ptr, size_t len)
      non-cygwin app is terminated if pseudo console is disabled. */
   if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
       && get_ttyp ()->pty_input_state == tty::to_cyg)
-    fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
-					get_ttyp (), input_available_event);
+    {
+      acquire_attach_mutex (mutex_timeout);
+      fhandler_pty_slave::transfer_input (tty::to_nat, from_master,
+					  get_ttyp (), input_available_event);
+      release_attach_mutex ();
+    }
   ReleaseMutex (input_mutex);
 
   line_edit_status status = line_edit (p, len, ti, &ret);
@@ -4038,8 +4060,10 @@ fhandler_pty_slave::setup_for_non_cygwin_app (bool nopcon, PWCHAR envblock,
       && stdin_is_ptys && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
       WaitForSingleObject (input_mutex, mutex_timeout);
+      acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 		      input_available_event);
+      release_attach_mutex ();
       ReleaseMutex (input_mutex);
     }
 }
@@ -4054,8 +4078,10 @@ fhandler_pty_slave::cleanup_for_non_cygwin_app (handle_set_t *p, tty *ttyp,
       && ttyp->pty_input_state_eq (tty::to_nat))
     {
       WaitForSingleObject (p->input_mutex, mutex_timeout);
+      acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_cyg, p->from_master_nat, ttyp,
 		      p->input_available_event);
+      release_attach_mutex ();
       ReleaseMutex (p->input_mutex);
     }
   WaitForSingleObject (p->pipe_sw_mutex, INFINITE);
@@ -4080,8 +4106,10 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
       && get_ttyp ()->pty_input_state_eq (tty::to_cyg))
     {
       WaitForSingleObject (input_mutex, mutex_timeout);
+      acquire_attach_mutex (mutex_timeout);
       transfer_input (tty::to_nat, get_handle (), get_ttyp (),
 		      input_available_event);
+      release_attach_mutex ();
       ReleaseMutex (input_mutex);
     }
   else if (was_nat_fg && !nat_fg && get_ttyp ()->switch_to_nat_pipe
@@ -4103,11 +4131,15 @@ fhandler_pty_slave::setpgid_aux (pid_t pid)
 	  resume_pid = attach_console_temporarily (target_pid);
 	  attach_restore = true;
 	}
+      else
+	acquire_attach_mutex (mutex_timeout);
       WaitForSingleObject (input_mutex, mutex_timeout);
       transfer_input (tty::to_cyg, from, get_ttyp (), input_available_event);
       ReleaseMutex (input_mutex);
       if (attach_restore)
 	resume_from_temporarily_attach (resume_pid);
+      else
+	release_attach_mutex ();
     }
   ReleaseMutex (pipe_sw_mutex);
 }
-- 
2.35.1

