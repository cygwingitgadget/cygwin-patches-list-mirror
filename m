Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id CBA2539484B0
 for <cygwin-patches@cygwin.com>; Thu, 13 Jan 2022 12:29:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org CBA2539484B0
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ae233132.dynamic.ppp.asahi-net.or.jp
 [14.3.233.132]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 20DCSLDA010973;
 Thu, 13 Jan 2022 21:29:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 20DCSLDA010973
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1642076947;
 bh=6lgU7COsWBncTM2ReDRv8VRwn5fFlyQ5CFkcbiBzN6A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=UXrzUUpvPGcMi2r+tCE9nGKccvxNIn1418Wwbw3GwYmRyBfIUxXatXcfwN7CenaYY
 Cm0v62Xz7jbUahx9JGE1bzrm5Vwvhxswpo74cO7nhvpB9YKHRZyR2Y7MC7UmKCB4ao
 QuAvE++v9rHKJ/OPeVMrj0sdb+SfsAoDm0QKgZcyhNxtVyVjzDZex8MzewnMGOs+Y3
 3eBgiKoJFLjxfsYzxVnQqiNHLV+qrw8Mt5IDCxkSalAfh9W8TZ5AeFTTHIPHPRrtFX
 5JMWoOZD6YhOzKPk7sYGosGmKK094KUvM1RMWFpk3NMK84EoGm6lTBhBpcAKWf/bxu
 7MGclWJscIMTA==
X-Nifty-SrcIP: [14.3.233.132]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/4] Cygwin: console: Fix potential deadlock regarding
 acuqiring mutex.
Date: Thu, 13 Jan 2022 21:28:11 +0900
Message-Id: <20220113122811.241-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
References: <20220113122811.241-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 13 Jan 2022 12:29:35 -0000

- Acquiring input_mutex and attach_mutex in console code has potential
  risk of deadlock. This patch fixes the issue.
---
 winsup/cygwin/fhandler.h | 2 ++
 winsup/cygwin/select.cc  | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler.h b/winsup/cygwin/fhandler.h
index 0cea1b7f3..fb4747608 100644
--- a/winsup/cygwin/fhandler.h
+++ b/winsup/cygwin/fhandler.h
@@ -2208,9 +2208,11 @@ private:
   void acquire_input_mutex_if_necessary (DWORD ms)
   {
     acquire_input_mutex (ms);
+    acquire_attach_mutex (ms);
   }
   void release_input_mutex_if_necessary (void)
   {
+    release_attach_mutex ();
     release_input_mutex ();
   }
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 5b8fc0f81..d01a319ef 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1122,29 +1122,30 @@ peek_console (select_record *me, bool)
   HANDLE h;
   set_handle_or_return_if_not_open (h, me);
 
+  fh->acquire_input_mutex (mutex_timeout);
   acquire_attach_mutex (mutex_timeout);
   while (!fh->input_ready && !fh->get_cons_readahead_valid ())
     {
       if (fh->bg_check (SIGTTIN, true) <= bg_eof)
 	{
 	  release_attach_mutex ();
+	  fh->release_input_mutex ();
 	  return me->read_ready = true;
 	}
       else if (!PeekConsoleInputW (h, &irec, 1, &events_read) || !events_read)
 	break;
-      fh->acquire_input_mutex (mutex_timeout);
       if (fhandler_console::input_winch == fh->process_input_message ()
 	  && global_sigs[SIGWINCH].sa_handler != SIG_IGN
 	  && global_sigs[SIGWINCH].sa_handler != SIG_DFL)
 	{
 	  set_sig_errno (EINTR);
-	  fh->release_input_mutex ();
 	  release_attach_mutex ();
+	  fh->release_input_mutex ();
 	  return -1;
 	}
-      fh->release_input_mutex ();
     }
   release_attach_mutex ();
+  fh->release_input_mutex ();
   if (fh->input_ready || fh->get_cons_readahead_valid ())
     return me->read_ready = true;
 
-- 
2.34.1

