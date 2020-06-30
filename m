Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 3EF633857026
 for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2020 11:12:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3EF633857026
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 05UBCJ9a007775;
 Tue, 30 Jun 2020 20:12:26 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 05UBCJ9a007775
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Discard CSI > Pm m sequence from native windows
 apps.
Date: Tue, 30 Jun 2020 20:12:13 +0900
Message-Id: <20200630111213.2678-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Tue, 30 Jun 2020 11:12:56 -0000

- If vim is started from WSL (Ubuntu) which is executed in pseudo
  console in mintty, shift key and ctrl key do not work. Though
  this issue is similar to the issue resolved by commit
  4527541ec66af8d82bb9dba5d25afdf489d71271, that commit is not
  effective for this issue. This patch fixes the issue by discarding
  "CSI > Pm m" in fhandler_pty_master::pty_master_fwd_thread().
---
 winsup/cygwin/fhandler_tty.cc | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 126249d9f..0f95cec2e 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3316,6 +3316,34 @@ fhandler_pty_master::pty_master_fwd_thread ()
 		continue;
 	      }
 
+	  /* Remove CSI > Pm m */
+	  state = 0;
+	  start_at = 0;
+	  for (DWORD i=0; i<rlen; i++)
+	    if (outbuf[i] == '\033')
+	      {
+		start_at = i;
+		state = 1;
+		continue;
+	      }
+	    else if ((state == 1 && outbuf[i] == '[') ||
+		     (state == 2 && outbuf[i] == '>'))
+	      {
+		state ++;
+		continue;
+	      }
+	    else if (state == 3 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
+	      continue;
+	    else if (state == 3 && outbuf[i] == 'm')
+	      {
+		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		rlen = wlen = start_at + rlen - i - 1;
+		state = 0;
+		continue;
+	      }
+	    else
+	      state = 0;
+
 	  size_t nlen;
 	  char *buf = convert_mb_str
 	    (get_ttyp ()->term_code_page, &nlen, CP_UTF8, ptr, wlen);
-- 
2.27.0

