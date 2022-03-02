Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 1818D3858D39
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 01:10:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 1818D3858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 2221AfLc023937;
 Wed, 2 Mar 2022 10:10:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2221AfLc023937
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1646183446;
 bh=no0vgIlRUnrYwwR0ngm1dkRvbEMwmvYLRpuuQc06Ia0=;
 h=From:To:Cc:Subject:Date:From;
 b=Lm3RR6nVQzvk/Y+AJPPf10+J/iY8+snPD+vhcWPZUZqGzDQwmEDuR+I6ed1MHqzs8
 ko+eVET2Esw4jP8lMAlG0K79qgMuHyh7gGVi6Up16fQY2esGPU19tvpIoDaPeMfeWh
 gVIxCkVEHQnRG+lRlfkbaE203/Y/jh3vIEKFq5Pn6DujbRyqdQlJcTJWBWZcdRksce
 +LoVt0JpYJkIOvuKPoKpOOJfASQghXsigmj0YxYU0rJ882wpDNRYBj13IvQDUh7Nmd
 sdkN1MWWqhEYa+AF/tM5XbfP0HcyHl2ijBB5TvYP5kTPH+PjiX8mKzuH05F+nKI9i9
 AbZJyanXx0jqA==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Prevent special keys processing from drop.
Date: Wed,  2 Mar 2022 10:10:40 +0900
Message-Id: <20220302011040.1426-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Wed, 02 Mar 2022 01:11:04 -0000

- There was a potential risk to drop special key processing when
  process_input_messsage() is called intermittently. This patch
  fixes the issue.
---
 winsup/cygwin/fhandler.h          |  2 ++
 winsup/cygwin/fhandler_console.cc | 22 +++++++++++++---------
 2 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index dd1ab0422..c5eb62136 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2067,6 +2067,8 @@ class dev_console
   char *cons_rapoi;
   bool cursor_key_app_mode;
   bool disable_master_thread;
+  int num_processed; /* Number of input events in the current input buffer
+			already processed by cons_master_thread(). */
 
   inline UINT get_console_cp ();
   DWORD con_to_str (char *d, int dlen, WCHAR w);
diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index 2a4aa7a70..7e51ea19e 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -200,7 +200,6 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
       }
   };
   termios &ti = ttyp->ti;
-  int processed_up_to = -1;
   while (con.owner == myself->pid)
     {
       DWORD total_read, n, i;
@@ -223,17 +222,17 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	  if (total_read == INREC_SIZE /* Working space full */
 	      && cygwait (p->input_handle, (DWORD) 0) == WAIT_OBJECT_0)
 	    {
-	      const int incr = min (processed_up_to + 1, additional_space);
+	      const int incr = min (con.num_processed, additional_space);
 	      ReadConsoleInputW (p->input_handle,
 				 input_rec + total_read, incr, &n);
 	      /* Discard oldest n events. */
 	      memmove (input_rec, input_rec + n, m::bytes (total_read));
-	      processed_up_to -= n;
+	      con.num_processed -= n;
 	      nowait = true;
 	    }
 	  break;
 	case WAIT_TIMEOUT:
-	  processed_up_to = -1;
+	  con.num_processed = 0;
 	case WAIT_SIGNALED:
 	case WAIT_CANCELED:
 	  break;
@@ -256,7 +255,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 	      ttyp->kill_pgrp (SIGWINCH);
 	    }
 	}
-      for (i = processed_up_to + 1; i < total_read; i++)
+      for (i = con.num_processed; i < total_read; i++)
 	{
 	  wchar_t wc;
 	  char c;
@@ -279,7 +278,7 @@ fhandler_console::cons_master_thread (handle_set_t *p, tty *ttyp)
 		  ttyp->output_stopped = false;
 		  if (ti.c_lflag & NOFLSH)
 		    goto remove_record;
-		  processed_up_to = -1;
+		  con.num_processed = 0;
 		  goto skip_writeback;
 		default: /* not signalled */
 		  break;
@@ -312,7 +311,7 @@ remove_record:
 	      i--;
 	    }
 	}
-      processed_up_to = total_read - 1;
+      con.num_processed = total_read;
       if (total_read)
 	{
 	  do
@@ -449,6 +448,7 @@ fhandler_console::setup ()
       shared_console_info->tty_min_state.is_console = true;
       con.cursor_key_app_mode = false;
       con.disable_master_thread = true;
+      con.num_processed = 0;
     }
 }
 
@@ -1265,14 +1265,17 @@ fhandler_console::process_input_message (void)
     }
 out:
   /* Discard processed recored. */
-  DWORD dummy;
   DWORD discard_len = min (total_read, i + 1);
   /* If input is signalled, do not discard input here because
      tcflush() is already called from line_edit(). */
   if (stat == input_signalled && !(ti->c_lflag & NOFLSH))
     discard_len = 0;
   if (discard_len)
-    ReadConsoleInputW (get_handle (), input_rec, discard_len, &dummy);
+    {
+      DWORD discarded;
+      ReadConsoleInputW (get_handle (), input_rec, discard_len, &discarded);
+      con.num_processed = max (con.num_processed - discarded, 0);
+    }
   return stat;
 }
 
@@ -1671,6 +1674,7 @@ fhandler_console::tcflush (int queue)
 	  __seterrno ();
 	  res = -1;
 	}
+      con.num_processed = 0;
       release_attach_mutex ();
     }
   return res;
-- 
2.35.1

