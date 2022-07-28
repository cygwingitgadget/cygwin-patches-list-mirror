Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
 by sourceware.org (Postfix) with ESMTPS id 3D941385AE40
 for <cygwin-patches@cygwin.com>; Thu, 28 Jul 2022 15:14:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3D941385AE40
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-10.nifty.com with ESMTP id 26SFE5Dj022987;
 Fri, 29 Jul 2022 00:14:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 26SFE5Dj022987
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1659021251;
 bh=6hu/ISPsT3gaL6zYMsXUram29GJB2w/184YrN+vn2fU=;
 h=From:To:Cc:Subject:Date:From;
 b=zdqWayCLXsTyaBF01HVTsrNcyWRVRf4BxvIJgQY6y6kK4dkBIVV7M2yjYtPBlSHwm
 cI8TVbIGDTikRp1S9PEkKmRCTP4SRsWf67YQTbDx1tCqzAhWOUmkt4hSXmLHSo6h4f
 CO8QzQ2A7E6+EsUGQzxeXWjmSl4LuUfZOBCMBTAjoqSm2T2pcldvwFwEGApsU4Rvro
 3dspbLVffzm5rzrIc1VT67oWaXcHdC/953zt+mTKkHJO0tfsHx+C/VK6t/Z3cbaPMp
 PrklNTzGN48OudyzuZUqP9Vd6sLbcVOXZ4jgZcdrWHMN1DiVqlSpUFKnEPAjkJ3X6y
 9giB3WXX3xhEw==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Add workaround for ConEmu cygwin connector.
Date: Fri, 29 Jul 2022 00:13:55 +0900
Message-Id: <20220728151355.1844-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 28 Jul 2022 15:14:41 -0000

- ConEmu cygwin connector conflicts with cons_master_thread since
  it does not use read() to read console input. With this patch,
  cons_master_thread is disabled in ConEmu cygwin connector.
---
 winsup/cygwin/fhandler_console.cc | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index c20239d13..37262f638 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -1604,6 +1604,8 @@ fhandler_console::dup (fhandler_base *child, int flags)
   return 0;
 }
 
+static void hook_conemu_cygwin_connector();
+
 int
 fhandler_console::open (int flags, mode_t)
 {
@@ -1691,6 +1693,8 @@ fhandler_console::open (int flags, mode_t)
 
   if (myself->pid == con.owner)
     {
+      if (GetModuleHandle ("ConEmuHk64.dll"))
+	hook_conemu_cygwin_connector ();
       char name[MAX_PATH];
       shared_name (name, CONS_THREAD_SYNC, get_minor ());
       thread_sync_event = CreateEvent(NULL, FALSE, FALSE, name);
@@ -3982,6 +3986,7 @@ fhandler_console::set_console_mode_to_native ()
 DEF_HOOK (CreateProcessA);
 DEF_HOOK (CreateProcessW);
 DEF_HOOK (ContinueDebugEvent);
+DEF_HOOK (LoadLibraryA); /* Hooked for ConEmu cygwin connector */
 
 static BOOL WINAPI
 CreateProcessA_Hooked
@@ -4023,6 +4028,20 @@ ContinueDebugEvent_Hooked
   return ContinueDebugEvent_Orig (p, t, s);
 }
 
+/* Hooked for ConEmu cygwin connector */
+static HMODULE WINAPI
+LoadLibraryA_Hooked (LPCSTR m)
+{
+  const char *p;
+  if ((p = strrchr(m, '\\')))
+    p++;
+  else
+    p = m;
+  if (strcasecmp(p, "ConEmuHk64.dll") == 0)
+    fhandler_console::set_disable_master_thread (true);
+  return LoadLibraryA_Orig (m);
+}
+
 void
 fhandler_console::fixup_after_fork_exec (bool execing)
 {
@@ -4046,6 +4065,12 @@ fhandler_console::fixup_after_fork_exec (bool execing)
   DO_HOOK (NULL, ContinueDebugEvent);
 }
 
+static void
+hook_conemu_cygwin_connector()
+{
+  DO_HOOK (NULL, LoadLibraryA);
+}
+
 /* Ugly workaround to create invisible console required since Windows 7.
 
    First try to just attach to any console which may have started this
-- 
2.37.1

