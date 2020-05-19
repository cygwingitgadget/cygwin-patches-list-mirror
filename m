Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id 8B389384A87E
 for <cygwin-patches@cygwin.com>; Tue, 19 May 2020 11:36:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 8B389384A87E
Received: from localhost.localdomain (v040007.dynamic.ppp.asahi-net.or.jp
 [124.155.40.7]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 04JBa8lb005756;
 Tue, 19 May 2020 20:36:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 04JBa8lb005756
X-Nifty-SrcIP: [124.155.40.7]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Make system_printf() work after closing pty
 slave.
Date: Tue, 19 May 2020 20:35:59 +0900
Message-Id: <20200519113600.467-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 19 May 2020 11:36:35 -0000

- Current pty cannot show system_printf() output after closing pty
  slave. This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 5a1bcd3ce..02b78cd2c 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -948,6 +948,10 @@ fhandler_pty_slave::open (int flags, mode_t)
       init_console_handler (true);
     }
 
+  get_ttyp ()->pcon_pid = 0;
+  get_ttyp ()->switch_to_pcon_in = false;
+  get_ttyp ()->switch_to_pcon_out = false;
+
   set_open_status ();
   return 1;
 
@@ -1008,6 +1012,7 @@ fhandler_pty_slave::close ()
     termios_printf ("CloseHandle (output_mutex<%p>), %E", output_mutex);
   if (pcon_attached_to == get_minor ())
     get_ttyp ()->num_pcon_attached_slaves --;
+  set_switch_to_pcon (2); /* Make system_printf() work after close. */
   return 0;
 }
 
-- 
2.21.0

