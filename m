Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 23289386EC42
 for <cygwin-patches@cygwin.com>; Sun, 31 May 2020 05:54:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 23289386EC42
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 04V5rSi7024218;
 Sun, 31 May 2020 14:53:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 04V5rSi7024218
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 4/4] Cygwin: pty: Revise the code which prevents undesired
 window title.
Date: Sun, 31 May 2020 14:53:20 +0900
Message-Id: <20200531055320.1419-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
References: <20200531055320.1419-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0,
 RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sun, 31 May 2020 05:54:20 -0000

- In current pty, the window title can not be set from non-cygwin
  program due to the code which prevents overwriting the window
  title to "cygwin-console-helper.exe" in fhandler_pty_master::pty_
  master_fwd_thread(). This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index c3d49968d..e434b7878 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3313,9 +3313,14 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      }
 	    else if (state == 4 && outbuf[i] == '\a')
 	      {
-		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
+		if (memmem (&outbuf[start_at], i + 1 - start_at,
+			    helper_str, strlen (helper_str)))
+		  {
+		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		    rlen = wlen = start_at + rlen - i - 1;
+		  }
 		state = 0;
-		rlen = wlen = start_at + rlen - i - 1;
 		continue;
 	      }
 	    else if (outbuf[i] == '\a')
-- 
2.26.2

