Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 95B9D385841F
 for <cygwin-patches@cygwin.com>; Thu, 24 Feb 2022 14:25:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 95B9D385841F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak036016.dynamic.ppp.asahi-net.or.jp
 [119.150.36.16]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 21OEOb6K022170;
 Thu, 24 Feb 2022 23:24:41 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 21OEOb6K022170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1645712681;
 bh=vkgnjJu059od3ch5RQvjAQFpWcT8ruNgZw+BTHDjg/c=;
 h=From:To:Cc:Subject:Date:From;
 b=GYYARf6qvM4IXEQN2s4VY6vWUTWp5rOqwbsR7bFWlx359miipigHBOJa+reVsLIh0
 Rp0Idw6F7ssXlr8xFYJNnzLDkwlxVIpQJGNxcbIFqBIai++Teo/NyBrBJIfAaT4ylH
 iatJeMhkPARze+xWas4MZywnWYj00SiKvPJ5Zs4+2LtLUv0tADhfdz46uCl021CcO9
 nEbQh7FcFWuOO7pphgxTz1QykhJZaTokOgQkDIIfVhXpmjeJCVMgzTiTbw4FMyxe4b
 71pSFUn7PWzxxsSL256Ymt7Hn7SAOaIFhJ52UWYTaSA4/H1qAYraE5Qoo8x7MQXza5
 DqJals/3Bt72Q==
X-Nifty-SrcIP: [119.150.36.16]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH v2] Cygwin: pinfo: Fix exit code when non-cygwin app exits by
 Ctrl-C.
Date: Thu, 24 Feb 2022 23:24:29 +0900
Message-Id: <20220224142429.888-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.35.1
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
X-List-Received-Date: Thu, 24 Feb 2022 14:25:05 -0000

- Previously, if non-cygwin app exits by Ctrl-C, exit code was
  0x00007f00. With this patch, the exit code will be 0x00000002,
  which means process exited by SIGINT.
---
 winsup/cygwin/exceptions.cc | 6 +++++-
 winsup/cygwin/pinfo.cc      | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 73bf68939..f6a755b3c 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1139,7 +1139,11 @@ ctrl_c_handler (DWORD type)
     }
 
   if (ch_spawn.set_saw_ctrl_c ())
-    return TRUE;
+    {
+      if (myself->process_state & PID_NOTCYGWIN)
+	sigExeced = SIGINT;
+      return TRUE;
+    }
 
   /* We're only the process group leader when we have a valid pinfo structure.
      If we don't have one, then the parent "stub" will handle the signal. */
diff --git a/winsup/cygwin/pinfo.cc b/winsup/cygwin/pinfo.cc
index bce743bfc..bb7c16547 100644
--- a/winsup/cygwin/pinfo.cc
+++ b/winsup/cygwin/pinfo.cc
@@ -156,6 +156,9 @@ pinfo::status_exit (DWORD x)
 	 a lengthy small_printf instead. */
       x = SIGBUS;
       break;
+    case STATUS_CONTROL_C_EXIT:
+      x = SIGINT;
+      break;
     default:
       debug_printf ("*** STATUS_%y\n", x);
       x = 127 << 8;
-- 
2.35.1

