Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 9A496385803E
 for <cygwin-patches@cygwin.com>; Mon,  1 Aug 2022 23:04:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 9A496385803E
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 271N46sG027927;
 Tue, 2 Aug 2022 08:04:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 271N46sG027927
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1659395054;
 bh=3FXV4523omJZvlnqjD0IvmfA9Mgb5pKamVkmz62wVpY=;
 h=From:To:Cc:Subject:Date:From;
 b=Az+PK+bBzaZ1Bjfbip9pZXRh3x3SkSifqpL6MSXmU50KLxrTKEjKXObarFXbBWA99
 +4PTK1H4P7LHRLaNQNBKbyOlfG8Tos6muYjrm+rU68TCAiBq90n+A2QoY8UcKSd8QL
 Ou2ZeoFQU68l1PaQlKnSNKlA8f7PoBVxaFMQ4rDZSeq8IgjYxul+qi7ObtQwkB9uF2
 dyx9ZjeEJNZLh08q/ehM3rbDrev+kxvdH247JdFqhYEOeHkNChZv6pmeWYzclNozZ4
 ODn6hfdxN+FvQOXAbOE6FeUQFFDIKc/iunvrfcjR2DREIV6nOh9SWc6YBSTZ7CnjAu
 pYCZ0sUcdTYJQ==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: console: Modify ConEmu cygwin connector hook.
Date: Tue,  2 Aug 2022 08:03:57 +0900
Message-Id: <20220801230357.1799-1-takashi.yano@nifty.ne.jp>
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
X-List-Received-Date: Mon, 01 Aug 2022 23:04:37 -0000

- Previously, LoadLibraryA() is hooked for ConEmu cygwin connector.
  With this patch, GetProcAddress() for "RequestTermConnector" is
  hooked instead which is more essential for ConEmu cygwin connector.
---
 winsup/cygwin/fhandler_console.cc | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/winsup/cygwin/fhandler_console.cc b/winsup/cygwin/fhandler_console.cc
index d17f03acf..e3d87331f 100644
--- a/winsup/cygwin/fhandler_console.cc
+++ b/winsup/cygwin/fhandler_console.cc
@@ -3986,7 +3986,7 @@ fhandler_console::set_console_mode_to_native ()
 DEF_HOOK (CreateProcessA);
 DEF_HOOK (CreateProcessW);
 DEF_HOOK (ContinueDebugEvent);
-DEF_HOOK (LoadLibraryA); /* Hooked for ConEmu cygwin connector */
+DEF_HOOK (GetProcAddress); /* Hooked for ConEmu cygwin connector */
 
 static BOOL WINAPI
 CreateProcessA_Hooked
@@ -4029,17 +4029,12 @@ ContinueDebugEvent_Hooked
 }
 
 /* Hooked for ConEmu cygwin connector */
-static HMODULE WINAPI
-LoadLibraryA_Hooked (LPCSTR m)
+static FARPROC WINAPI
+GetProcAddress_Hooked (HMODULE h, LPCSTR n)
 {
-  const char *p;
-  if ((p = strrchr(m, '\\')))
-    p++;
-  else
-    p = m;
-  if (strcasecmp(p, "ConEmuHk64.dll") == 0)
+  if (strcmp(n, "RequestTermConnector") == 0)
     fhandler_console::set_disable_master_thread (true);
-  return LoadLibraryA_Orig (m);
+  return GetProcAddress_Orig (h, n);
 }
 
 void
@@ -4068,7 +4063,7 @@ fhandler_console::fixup_after_fork_exec (bool execing)
 static void
 hook_conemu_cygwin_connector()
 {
-  DO_HOOK (NULL, LoadLibraryA);
+  DO_HOOK (NULL, GetProcAddress);
 }
 
 /* Ugly workaround to create invisible console required since Windows 7.
-- 
2.37.1

