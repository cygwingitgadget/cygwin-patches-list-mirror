Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id B125C3840C19
 for <cygwin-patches@cygwin.com>; Fri, 15 Jan 2021 09:27:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B125C3840C19
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 10F9Qgl0004790;
 Fri, 15 Jan 2021 18:26:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 10F9Qgl0004790
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Set input_available_event only for cygwin pipe.
Date: Fri, 15 Jan 2021 18:26:31 +0900
Message-Id: <20210115092631.748-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Fri, 15 Jan 2021 09:27:09 -0000

- cat exits immediately in the following senario.
    1) Execute env CYGWIN=disable_pcon script
    2) Execute cmd.exe
    3) Execute cat in cmd.exe.
  This is caused by setting input_available_event for the pipe for
  non-cygwin app. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e4993bf31..0b9901974 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -394,7 +394,8 @@ fhandler_pty_master::accept_input ()
 	}
     }
 
-  SetEvent (input_available_event);
+  if (write_to == get_output_handle ())
+    SetEvent (input_available_event);
   ReleaseMutex (input_mutex);
   return ret;
 }
-- 
2.30.0

