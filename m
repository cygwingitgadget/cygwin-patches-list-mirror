Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 89FCC3854838
 for <cygwin-patches@cygwin.com>; Fri, 29 Jan 2021 03:46:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 89FCC3854838
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 10T3kPpd025539;
 Fri, 29 Jan 2021 12:46:30 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 10T3kPpd025539
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: exceptions.cc: Suspend all threads in
 sig_handle_tty_stop().
Date: Fri, 29 Jan 2021 12:46:26 +0900
Message-Id: <20210129034626.157-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 29 Jan 2021 03:46:53 -0000

- Currently, thread created by pthread_create() is not suspended by
  the signal SIGTSTP. For example, even if a process with a thread
  is suspended by Ctrl-Z, the thread continues running. This patch
  fixes the issue.
---
 winsup/cygwin/exceptions.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index c98b92d30..3a6823325 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -902,7 +902,9 @@ sig_handle_tty_stop (int sig, siginfo_t *, void *)
 	 thread. */
       /* Use special cygwait parameter to handle SIGCONT.  _main_tls.sig will
 	 be cleared under lock when SIGCONT is detected.  */
+      pthread::suspend_all_except_self ();
       DWORD res = cygwait (NULL, cw_infinite, cw_sig_cont);
+      pthread::resume_all ();
       switch (res)
 	{
 	case WAIT_SIGNALED:
-- 
2.30.0

