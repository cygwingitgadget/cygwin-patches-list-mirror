Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id B58503858C54
 for <cygwin-patches@cygwin.com>; Sun,  8 May 2022 11:03:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B58503858C54
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 248B3OFd002848;
 Sun, 8 May 2022 20:03:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 248B3OFd002848
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652007811;
 bh=uLt4tUvPTWZt17uK93Be3Zo8+eYhLPB3yo0XzDcI424=;
 h=From:To:Cc:Subject:Date:From;
 b=Gaog+/5qKr9PYW7CowBGEASxaMd5zS8dPfJX0XMielcwWaUsPC7x0zpneCS76kWvT
 Mj1NPgzi824IGlxKfcW1zbXSldxDNyJmzsYYOtyKStcR63nUAWSp5eofGkcAcXm77C
 idaVKdGCzmKonORAwM8h1ejGnl2bi7zv1D5rnb8T36Qs21d0xd3hSpf8zAqBFRmZwV
 tr9rJJ964MZNiOvuly8lX326Loi8xFV5/fJqn9P1M8YsD3mDKL96zACammQpWOBZdJ
 Gqj63vYIQR86PNMev/SfuM0Jg27c3fhyt8TY/CqtFib8731I7Tx8Aes64nlzNaE8qG
 /PJYaSPrke7Zg==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix acquiring attach_mutex timing.
Date: Sun,  8 May 2022 20:03:15 +0900
Message-Id: <20220508110315.20953-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Sun, 08 May 2022 11:03:56 -0000

- When temporarily attaching a console, the timing of acquiring
  attach_mutex was not appropriate. This sometimes caused master
  forwarding thread to crash on Ctrl-C in Windows 7. This patch
  fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index 484bf55dc..bdde1dce6 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -4171,13 +4171,13 @@ DWORD
 fhandler_pty_common::attach_console_temporarily (DWORD target_pid)
 {
   DWORD resume_pid = 0;
+  acquire_attach_mutex (mutex_timeout);
   pinfo pinfo_resume (myself->ppid);
   if (pinfo_resume)
     resume_pid = pinfo_resume->dwProcessId;
   if (!resume_pid)
     resume_pid = get_console_process_id (myself->dwProcessId, false);
   bool console_exists = fhandler_console::exists ();
-  acquire_attach_mutex (mutex_timeout);
   if (!console_exists || resume_pid)
     {
       FreeConsole ();
-- 
2.36.0

