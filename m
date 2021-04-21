Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
 by sourceware.org (Postfix) with ESMTPS id EFAF53858031
 for <cygwin-patches@cygwin.com>; Wed, 21 Apr 2021 03:07:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EFAF53858031
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=takashi.yano@nifty.ne.jp
Received: from localhost.localdomain (v050190.dynamic.ppp.asahi-net.or.jp
 [124.155.50.190]) (authenticated)
 by conuserg-09.nifty.com with ESMTP id 13L36l3m002502;
 Wed, 21 Apr 2021 12:06:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 13L36l3m002502
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1618974412;
 bh=TLUlKXnoQOWcRYdqzmsQWGGDFj6MIDhG4UHM5utulAM=;
 h=From:To:Cc:Subject:Date:From;
 b=oo/43T5sRKaVcXyQG4JycbV/rVbQ4jNpg9BY1gF/BUdkI8QFKMNIQtiRzgKAsouTh
 pC0/K4NK/J0EBrZuVqQ2kuSEdf6QHZ3Jez2aH/72RMQw/DED/ffTfszI16K65YXNzj
 D7qLx7cYcHBzJ0+I7WCluvl8Qpgx+jxrRovpbjDNUaVkNpIXke3dmn6gUqJqSp9O9H
 zQD9WZeWLH8tQZ7Y4uKfUZwxNa8a+tM8flxuyLnzp0JbsrIylXFUQpFUcGOmrXCwLW
 3LPrSeWIL9d1Ab6IwoKPEZJ64Hf/SWO6NCAXwGnWLqAd7UUpAvnDxhsKApw6cJ54wc
 iJ4uYLI3ANX2Q==
X-Nifty-SrcIP: [124.155.50.190]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix fallback processing in setup_pseudoconsole().
Date: Wed, 21 Apr 2021 12:06:43 +0900
Message-Id: <20210421030643.4790-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Wed, 21 Apr 2021 03:07:33 -0000

- Currently, the fallback processing in setup_pseudoconsole()
  when helper process error occurs does not work properly.
  This patch fixes the issue.
---
 winsup/cygwin/fhandler_tty.cc | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index e4480771b..530321513 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3226,15 +3226,15 @@ fhandler_pty_slave::setup_pseudoconsole (bool nopcon)
 	  if (wait_result == WAIT_OBJECT_0)
 	    break;
 	  if (wait_result != WAIT_TIMEOUT)
-	    goto cleanup_helper_process;
+	    goto cleanup_helper_with_hello;
 	  DWORD exit_code;
 	  if (!GetExitCodeProcess (pi.hProcess, &exit_code))
-	    goto cleanup_helper_process;
+	    goto cleanup_helper_with_hello;
 	  if (exit_code == STILL_ACTIVE)
 	    continue;
 	  if (exit_code != 0 ||
 	      WaitForSingleObject (hello, 500) != WAIT_OBJECT_0)
-	    goto cleanup_helper_process;
+	    goto cleanup_helper_with_hello;
 	  break;
 	}
       CloseHandle (hello);
@@ -3349,6 +3349,10 @@ skip_create:
 
   return true;
 
+cleanup_helper_with_hello:
+  CloseHandle (hello);
+  CloseHandle (pi.hThread);
+  goto cleanup_helper_process;
 cleanup_pcon_in:
   CloseHandle (hpConIn);
 cleanup_helper_process:
@@ -3358,10 +3362,10 @@ cleanup_helper_process:
   goto skip_close_hello;
 cleanup_event_and_pipes:
   CloseHandle (hello);
+skip_close_hello:
   get_ttyp ()->pcon_start = false;
   get_ttyp ()->pcon_start_pid = 0;
   get_ttyp ()->pcon_activated = false;
-skip_close_hello:
   CloseHandle (goodbye);
   CloseHandle (hr);
   CloseHandle (hw);
-- 
2.31.1

