Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id AB7663858404
 for <cygwin-patches@cygwin.com>; Sun, 10 Oct 2021 00:50:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AB7663858404
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 19A0nsKp003000;
 Sun, 10 Oct 2021 09:50:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 19A0nsKp003000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1633827010;
 bh=nRVfuFUBbrUtmfm5nGYYC1wpwimqBbSLubeeRvc0SWw=;
 h=From:To:Cc:Subject:Date:From;
 b=tr283hIHA4NoQ9etujBUDKFr/CaNmxTkxKjwoWH/wSG1y9ax1RU57PRLUZai71PDw
 yFrm5ffwsVSbJ+aXWqtX+U87mn+7wo/3KRuakpt2D28epl9kDkNJpFjoZn59OAnDps
 /g3ylFJcILl2zYq1aA5Q5yLnFO63oqp+woxOcb/BY1efd1TGad3jkJBSemRj5aQ+y+
 A4pbOnSL7MZaQ/oAUjDmwTvtw/e0kDkhnzuCx2vjEg+n+tIqF75pFl70BXyVbK9G0W
 RqKZDr5AsCleIQWXRzkM+67tPeMueOa0zseyYBhpLGhd9m25rnzQVYmQlLiaSZ3+u2
 tjTx59zjQ02ew==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix handle leak regarding attach_mutex.
Date: Sun, 10 Oct 2021 09:49:53 +0900
Message-Id: <20211010004953.801-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
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
X-List-Received-Date: Sun, 10 Oct 2021 00:50:48 -0000

- If the process having master pty opened is forked, attach_mutex
  fails to be closed when master is closed. This patch fixes the
  issue.
---
 winsup/cygwin/fhandler_console.cc | 2 +-
 winsup/cygwin/fhandler_tty.cc     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index ee862b17d..aee5e8284 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -57,7 +57,7 @@ fhandler_console::console_state NO_COPY *fhandler_console::shared_console_info;
 bool NO_COPY fhandler_console::invisible_console;
 
 /* Mutex for AttachConsole()/FreeConsole() in fhandler_tty.cc */
-HANDLE NO_COPY attach_mutex;
+HANDLE attach_mutex;
 
 static inline void
 acquire_attach_mutex (DWORD t)
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 823dabf73..f523dafed 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -57,7 +57,7 @@ struct pipe_reply {
 };
 
 extern HANDLE attach_mutex; /* Defined in fhandler_console.cc */
-static LONG NO_COPY master_cnt = 0;
+static LONG master_cnt = 0;
 
 inline static bool pcon_pid_alive (DWORD pid);
 
@@ -2042,10 +2042,10 @@ fhandler_pty_master::close ()
 	    }
 	  release_output_mutex ();
 	  master_fwd_thread->terminate_thread ();
-	  if (InterlockedDecrement (&master_cnt) == 0)
-	    CloseHandle (attach_mutex);
 	}
     }
+  if (InterlockedDecrement (&master_cnt) == 0)
+    CloseHandle (attach_mutex);
 
   /* Check if the last master handle has been closed.  If so, set
      input_available_event to wake up potentially waiting slaves. */
-- 
2.33.0

