Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 726C1384607A
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 09:46:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 726C1384607A
Received: from localhost.localdomain (v038192.dynamic.ppp.asahi-net.or.jp
 [124.155.38.192]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 07R9kO13015453;
 Thu, 27 Aug 2020 18:46:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 07R9kO13015453
X-Nifty-SrcIP: [124.155.38.192]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: select: Fix a bug on closing pi->bye event.
Date: Thu, 27 Aug 2020 18:46:20 +0900
Message-Id: <20200827094620.591-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 27 Aug 2020 09:47:01 -0000

- Close event handle pi->bye only if it was created.
  Addresses:
  https://cygwin.com/pipermail/cygwin-developers/2020-August/011948.html
---
 winsup/cygwin/select.cc | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 9f1a8a57a..501714fa7 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -783,8 +783,8 @@ pipe_cleanup (select_record *, select_stuff *stuff)
       pi->stop_thread = true;
       SetEvent (pi->bye);
       pi->thread->detach ();
+      CloseHandle (pi->bye);
     }
-  CloseHandle (pi->bye);
   delete pi;
   stuff->device_specific_pipe = NULL;
 }
@@ -978,8 +978,8 @@ fifo_cleanup (select_record *, select_stuff *stuff)
       pi->stop_thread = true;
       SetEvent (pi->bye);
       pi->thread->detach ();
+      CloseHandle (pi->bye);
     }
-  CloseHandle (pi->bye);
   delete pi;
   stuff->device_specific_fifo = NULL;
 }
@@ -1344,8 +1344,8 @@ pty_slave_cleanup (select_record *me, select_stuff *stuff)
       pi->stop_thread = true;
       SetEvent (pi->bye);
       pi->thread->detach ();
+      CloseHandle (pi->bye);
     }
-  CloseHandle (pi->bye);
   delete pi;
   stuff->device_specific_ptys = NULL;
 }
-- 
2.28.0

