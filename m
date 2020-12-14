Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
 by sourceware.org (Postfix) with ESMTPS id A28EA3850417
 for <cygwin-patches@cygwin.com>; Mon, 14 Dec 2020 08:25:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A28EA3850417
Received: from localhost.localdomain (x067108.dynamic.ppp.asahi-net.or.jp
 [122.249.67.108]) (authenticated)
 by conuserg-11.nifty.com with ESMTP id 0BE8PTYW001535;
 Mon, 14 Dec 2020 17:25:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 0BE8PTYW001535
X-Nifty-SrcIP: [122.249.67.108]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Skip term_has_pcon_cap() if pseudo console is
 disabled.
Date: Mon, 14 Dec 2020 17:25:33 +0900
Message-Id: <20201214082533.631-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 14 Dec 2020 08:25:52 -0000

- This patch skips unnecessary term_has_pcon_cap() call if pseudo
  console is disabled.
---
 winsup/cygwin/fhandler_tty.cc | 2 --
 winsup/cygwin/spawn.cc        | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index a6dc8e93b..845e51184 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -2459,8 +2459,6 @@ fhandler_pty_slave::setup_pseudoconsole (STARTUPINFOEXW *si, bool nopcon)
   if (get_ttyp ()->pcon_pid && get_ttyp ()->pcon_pid != myself->pid
       && !!pinfo (get_ttyp ()->pcon_pid))
     return false;
-  if (disable_pcon)
-    return false;
   /* If the legacy console mode is enabled, pseudo console seems
      not to work as expected. To determine console mode, registry
      key ForceV2 in HKEY_CURRENT_USER\Console is checked. */
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 83b216f52..5057af932 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -656,7 +656,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
       if (!iscygwin () && ptys_primary && is_console_app (runpath))
 	{
 	  bool nopcon = mode != _P_OVERLAY && mode != _P_WAIT;
-	  if (!ptys_primary->term_has_pcon_cap (envblock))
+	  if (disable_pcon || !ptys_primary->term_has_pcon_cap (envblock))
 	    nopcon = true;
 	  if (ptys_primary->setup_pseudoconsole (&si_pcon, nopcon))
 	    {
-- 
2.29.2

