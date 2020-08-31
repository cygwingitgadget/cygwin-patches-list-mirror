Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 303F53861022
 for <cygwin-patches@cygwin.com>; Mon, 31 Aug 2020 12:02:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 303F53861022
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 07VC2GHq013700;
 Mon, 31 Aug 2020 21:02:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 07VC2GHq013700
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix a bug in the code removing set window title
 sequence.
Date: Mon, 31 Aug 2020 21:02:13 +0900
Message-Id: <20200831120213.1706-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 31 Aug 2020 12:02:47 -0000

- Commit 4e08fe42c9f3fdba63a57a8e3a6d705c4e10f50f has a bug which
  may cause infinite loop in pty_master_fwd_thread(). This patch
  fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e4e94f114..8bf39c3e6 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2168,15 +2168,12 @@ fhandler_pty_master::pty_master_fwd_thread ()
 	      /* Remove Set title sequence */
 	      char *p0, *p1;
 	      p0 = outbuf;
-	      while ((p0 = (char *) memmem (p0, rlen, "\033]0;", 4)))
+	      while ((p0 = (char *) memmem (p0, rlen, "\033]0;", 4))
+		     && (p1 = (char *) memchr (p0, '\007', rlen-(p0-outbuf))))
 		{
-		  p1 = (char *) memchr (p0, '\007', rlen - (p0 - outbuf));
-		  if (p1)
-		    {
-		      memmove (p0, p1 + 1, rlen - (p1 + 1 - outbuf));
-		      rlen -= p1 + 1 - p0;
-		      wlen = rlen;
-		    }
+		  memmove (p0, p1 + 1, rlen - (p1 + 1 - outbuf));
+		  rlen -= p1 + 1 - p0;
+		  wlen = rlen;
 		}
 	    }
 	  /* Remove CSI > Pm m */
-- 
2.28.0

