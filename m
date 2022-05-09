Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id 13D2A384859A
 for <cygwin-patches@cygwin.com>; Mon,  9 May 2022 11:22:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 13D2A384859A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 249BM8DM023432;
 Mon, 9 May 2022 20:22:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 249BM8DM023432
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1652095335;
 bh=9HmCKJAKmayUO0fEdF0tqw1VhmPdgxoEyj8wedHbpyg=;
 h=From:To:Cc:Subject:Date:From;
 b=PyZX1gcMuZuOKa6Zjvs3ExXfqh84IaKQo5rpmqsIUZwjh7lUHejw/q2QDBPG1/ZCY
 IImPrj7FLCvEZVTKr3nQLzafYghdeEHonbk6TzRsIWTLrsNh+6SCC65BsDvTKwbkS0
 9ovOQOGEQlxUNa8JPI9KgSEvCQF6rupmKKZCPN5um8QLOvlhlw/a/7S3eQqDUTv4fs
 EEZBtuBrhKhJx96pF5dl25EPBzkjQD+RsHJaNCPVnuhPUdiIjE5jnlKVmbsanBPzVv
 oaPhE8PU2mfieQaPoKBxt7h9QKNQMPkFiDHkCor2BG9zPdSZkiOheJSRsQ4BBuLuDH
 GvKiC13TuWeFQ==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Avoid script command crash in console.
Date: Mon,  9 May 2022 20:21:59 +0900
Message-Id: <20220509112159.37125-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Mon, 09 May 2022 11:22:48 -0000

- Previously, script command sometimes crashes by Ctrl-C if it is
  running in console, and non-cygwin app is foreground. This patch
  fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index bb18d139e..9dfc3c495 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -4184,8 +4184,7 @@ fhandler_pty_common::attach_console_temporarily (DWORD target_pid)
     {
       FreeConsole ();
       AttachConsole (target_pid);
-      init_console_handler (::cygheap->ctty
-			    && ::cygheap->ctty->is_console ());
+      init_console_handler (false);
     }
   return console_exists ? resume_pid : (DWORD) -1;
 }
@@ -4200,8 +4199,7 @@ fhandler_pty_common::resume_from_temporarily_attach (DWORD resume_pid)
       if (console_exists)
 	if (!resume_pid || !AttachConsole (resume_pid))
 	  AttachConsole (ATTACH_PARENT_PROCESS);
-      init_console_handler (::cygheap->ctty
-			    && ::cygheap->ctty->is_console ());
+      init_console_handler (false);
     }
   release_attach_mutex ();
 }
-- 
2.36.0

