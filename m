Return-Path: <cygwin-patches-return-9663-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 81093 invoked by alias); 8 Sep 2019 13:23:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 81084 invoked by uid 89); 8 Sep 2019 13:23:44 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-19.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=screen, HContent-Transfer-Encoding:8bit
X-HELO: conuserg-03.nifty.com
Received: from conuserg-03.nifty.com (HELO conuserg-03.nifty.com) (210.131.2.70) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Sun, 08 Sep 2019 13:23:42 +0000
Received: from localhost.localdomain (ntsitm268057.sitm.nt.ngn.ppp.infoweb.ne.jp [125.1.110.57]) (authenticated)	by conuserg-03.nifty.com with ESMTP id x88DNRXX011391;	Sun, 8 Sep 2019 22:23:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-03.nifty.com x88DNRXX011391
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1567949014;	bh=0btqkCwh/Wr1mtMNXBowef1CNnbJ6Jb1Nl14GfBqg3U=;	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;	b=TZ5vYIuu7DcXkLeBhUn92VTL/mJLk+alWBNXJkNQ9Wh2gZiXskuLfIWmBxRvc+o9k	 ClxSzR67ikapg4xK1H7a71M9Wqyc8rk+awvpoFHd647Ic99Vjmdyqv51SSmz3sqiMb	 wMubi2DW56NXmAf6JUgOJanOW2DaVDScQStIQ1v44/UCwOa13MfcXrHEzITxlOqd7L	 4kOqWmypo2qhJJrVka+y5IR3IU29oNouOftANZoVl6+EAqxPoRLg1T/pDgYT+IcpJo	 Sde4NuXiKTlGuZnfBBP9kW5+RC3MrGDjTGu3bA6XjP8mxb7FIz/aU2VACAvrC2Sj/k	 ndsYNnbyJWBJg==
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 1/1] Cygwin: pty: Fix screen alternation while pseudo console switching.
Date: Sun, 08 Sep 2019 13:23:00 -0000
Message-Id: <20190908132323.860-2-takashi.yano@nifty.ne.jp>
In-Reply-To: <20190908132323.860-1-takashi.yano@nifty.ne.jp>
References: <20190908132323.860-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IsSubscribed: yes
X-SW-Source: 2019-q3/txt/msg00183.txt.bz2

- If screen alternated while pseudo console switching, it sometimes
  failed. This might happen when the output of the non-cygwin program
  is piped to less. This patch fixes this issue.
---
 winsup/cygwin/fhandler_tty.cc | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a8821c72c..b4591c17a 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -73,6 +73,7 @@ struct pipe_reply {
 
 static int pcon_attached_to = -1;
 static bool isHybrid;
+static bool do_not_reset_switch_to_pcon;
 
 #if USE_API_HOOK
 static void
@@ -1046,6 +1047,8 @@ fhandler_pty_slave::reset_switch_to_pcon (void)
       init_console_handler (true);
       return;
     }
+  if (do_not_reset_switch_to_pcon)
+    return;
   if (get_ttyp ()->switch_to_pcon)
     {
       DWORD mode;
@@ -1108,6 +1111,8 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
 	    {
 	      //p0 += 8;
 	      get_ttyp ()->screen_alternated = true;
+	      if (get_ttyp ()->switch_to_pcon)
+		do_not_reset_switch_to_pcon = true;
 	    }
 	}
       if (get_ttyp ()->screen_alternated)
@@ -1118,6 +1123,7 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
 	    {
 	      p1 += 8;
 	      get_ttyp ()->screen_alternated = false;
+	      do_not_reset_switch_to_pcon = false;
 	      memmove (p0, p1, buf+nlen - p1);
 	      nlen -= p1 - p0;
 	    }
@@ -1177,7 +1183,8 @@ fhandler_pty_slave::push_to_pcon_screenbuffer (const char *ptr, size_t len)
       p += wLen;
     }
   /* Detach from pseudo console and resume. */
-  SetConsoleMode (get_output_handle (), dwMode);
+  flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
+  SetConsoleMode (get_output_handle (), dwMode | flags);
 cleanup:
   SetConsoleOutputCP (origCP);
   HeapFree (GetProcessHeap (), 0, buf);
@@ -1267,7 +1274,7 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
   HeapFree (GetProcessHeap (), 0, buf);
   flags = ENABLE_VIRTUAL_TERMINAL_PROCESSING;
   if (get_ttyp ()->switch_to_pcon && !fallback)
-    SetConsoleMode (get_output_handle (), dwMode);
+    SetConsoleMode (get_output_handle (), dwMode | flags);
 
   restore_reattach_pcon ();
 
@@ -2899,12 +2906,11 @@ fhandler_pty_slave::fixup_after_attach (bool native_maybe)
     {
       FlushConsoleInputBuffer (get_handle ());
       DWORD mode;
-      GetConsoleMode (get_handle (), &mode);
-      SetConsoleMode (get_handle (),
-		      (mode & ~ENABLE_VIRTUAL_TERMINAL_INPUT) |
-		      ENABLE_ECHO_INPUT |
-		      ENABLE_LINE_INPUT |
-		      ENABLE_PROCESSED_INPUT);
+      mode = ENABLE_PROCESSED_OUTPUT | ENABLE_WRAP_AT_EOL_OUTPUT;
+      SetConsoleMode (get_output_handle (), mode);
+      FlushConsoleInputBuffer (get_handle ());
+      mode = ENABLE_PROCESSED_INPUT | ENABLE_LINE_INPUT | ENABLE_ECHO_INPUT;
+      SetConsoleMode (get_handle (), mode);
       Sleep (20);
       if (get_ttyp ()->pcon_pid == 0 ||
 	  kill (get_ttyp ()->pcon_pid, 0) != 0)
-- 
2.21.0
