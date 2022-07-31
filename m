Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
 by sourceware.org (Postfix) with ESMTPS id 7467D3858005
 for <cygwin-patches@cygwin.com>; Sun, 31 Jul 2022 08:52:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7467D3858005
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (ak044095.dynamic.ppp.asahi-net.or.jp
 [119.150.44.95]) (authenticated)
 by conuserg-07.nifty.com with ESMTP id 26V8pqG1017914;
 Sun, 31 Jul 2022 17:51:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26V8pqG1017914
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1659257517;
 bh=6emk99Rekw1xoF7TBXDHCWFj5NJUqrdFv5MjqU3ZcPw=;
 h=From:To:Cc:Subject:Date:From;
 b=O/SU+oucTySIivQ6jczCznacqTtdwPX53ZSIMlcXgXZEWBux/SgXLzSbL8ehWE0c6
 JgDcuUk1PLscLn5BIrmjhZbISdsn0vM5IKLft7sM7VH+ENVDA45+8eRRNUMI3BR4K0
 FrTBGAIBECOyHM8hPc+nv3ptTP5rlXF8CwG2aLf1/w9FcxAn5amI0NMNaS9MYEq7K8
 Fc2IX2zIy16VL66H5SS9LakkyXvbeq6oy8dPCs7dt2ZYkPI62lUlp+TuJvbdDP6+wk
 ucXGh/AooPf74iP5Ji44zFk38AdVceSJmtYEuyqRh2mfYP9ieVxPsowKFJ7ryJFc09
 YXST9kXnJvifw==
X-Nifty-SrcIP: [119.150.44.95]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Treat *.bat and *.cmd as a non-cygwin console
 app.
Date: Sun, 31 Jul 2022 17:51:43 +0900
Message-Id: <20220731085143.669-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00, DKIM_SIGNED,
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
X-List-Received-Date: Sun, 31 Jul 2022 08:52:21 -0000

- If *.bat or *.cmd is executed directly from cygwin shell, pty
  failed to switch I/O pipe to that for native apps. This patch
  fixes the issue.
---
 winsup/cygwin/spawn.cc | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 2f745e14a..7de96827c 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -227,7 +227,12 @@ is_console_app (WCHAR *filename)
   if (p && p + id_offset <= buf + n)
     return p[id_offset] == '\003'; /* 02: GUI, 03: console */
   else
-    return false;
+    {
+      wchar_t *e = wcsrchr (filename, L'.');
+      if (e && (wcscasecmp (e, L".bat") == 0 || wcscasecmp (e, L".cmd") == 0))
+	return true;
+    }
+  return false;
 }
 
 int
-- 
2.37.1

