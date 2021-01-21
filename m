Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id D3E7F386EC7E
 for <cygwin-patches@cygwin.com>; Thu, 21 Jan 2021 13:10:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D3E7F386EC7E
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 10LD9eEZ019369;
 Thu, 21 Jan 2021 22:10:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 10LD9eEZ019369
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/4] Cygwin: pty: Keep code page between non-cygwin apps.
Date: Thu, 21 Jan 2021 22:09:09 +0900
Message-Id: <20210121130911.855-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210121130911.855-1-takashi.yano@nifty.ne.jp>
References: <20210121130911.855-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Thu, 21 Jan 2021 13:10:52 -0000

- After commit bb428520, there has been the disadvantage:
  4) Code page cannot be changed by chcp.com. Acctually, chcp works
     itself and changes code page of its own pseudo console.  However,
     since pseudo console is recreated for another process, it cannot
     inherit the code page.
  This patch clears this disadvantage.
---
 winsup/cygwin/fhandler_tty.cc | 7 +++++++
 winsup/cygwin/tty.cc          | 2 ++
 winsup/cygwin/tty.h           | 2 ++
 3 files changed, 11 insertions(+)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 7ba9f26b8..a815e5312 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2803,6 +2803,11 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
       HPCON_INTERNAL *hp = (HPCON_INTERNAL *) get_ttyp ()->h_pseudo_console;
       get_ttyp ()->h_pcon_write_pipe = hp->hWritePipe;
     }
+
+  if (get_ttyp ()->previous_code_page)
+    SetConsoleCP (get_ttyp ()->previous_code_page);
+  if (get_ttyp ()->previous_output_code_page)
+    SetConsoleOutputCP (get_ttyp ()->previous_output_code_page);
   return true;
 
 cleanup_pcon_in:
@@ -2842,6 +2847,8 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp)
   if (ttyp->h_pseudo_console)
     {
       ttyp->wait_pcon_fwd ();
+      ttyp->previous_code_page = GetConsoleCP ();
+      ttyp->previous_output_code_page = GetConsoleOutputCP ();
       FreeConsole ();
       AttachConsole (ATTACH_PARENT_PROCESS);
       HPCON_INTERNAL *hp = (HPCON_INTERNAL *) ttyp->h_pseudo_console;
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index 436f5c6c3..908166a37 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -246,6 +246,8 @@ tty::init ()
   has_csi6n = false;
   need_invisible_console = false;
   invisible_console_pid = 0;
+  previous_code_page = 0;
+  previous_output_code_page = 0;
 }
 
 HANDLE
diff --git a/winsup/cygwin/tty.h b/winsup/cygwin/tty.h
index eb604588c..061357437 100644
--- a/winsup/cygwin/tty.h
+++ b/winsup/cygwin/tty.h
@@ -107,6 +107,8 @@ private:
   bool has_csi6n;
   bool need_invisible_console;
   pid_t invisible_console_pid;
+  UINT previous_code_page;
+  UINT previous_output_code_page;
 
 public:
   HANDLE from_master () const { return _from_master; }
-- 
2.30.0

