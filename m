Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
 by sourceware.org (Postfix) with ESMTPS id 3D3973858D3C
 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 23:05:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 3D3973858D3C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (v036249.dynamic.ppp.asahi-net.or.jp
 [124.155.36.249]) (authenticated)
 by conuserg-12.nifty.com with ESMTP id 20HN5Al7029356;
 Tue, 18 Jan 2022 08:05:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 20HN5Al7029356
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1642460715;
 bh=zfHtKh83cPgxgRE1pwkYyfqTCWtFQ0GoC6OuZIvBHC8=;
 h=From:To:Cc:Subject:Date:From;
 b=YZCOB4cXyNwqHiZho3mxPRxcqs0eETI5khyxgpIscab2FytXfEuGduN7/2LB1huKO
 53u9B+EEmGLv0yNkFJMb4dAoNBaZ/QQYNa5CTLRTjBHDoyvV7yZjkr54LZdBE0BFLN
 GasDuZoHVyadk75Sc2BIsYXNc8/KLOF6Am6GUXvZDHIJ/Ei4Whf8xeZ8JlxS1t2R8V
 bepNIsba20ZdtK5SoqaC+iDu6uj2oT91TKVCgVyXHU9P7Q3XV2UyCiQmtwlD1S6ssn
 A7otqcV4CKOZ76N1qRN7atnkoW6V6i3ejoFG2Hu0kH6+vMQWZdGG9KEFTBcn4iKJwG
 ufDmHf3EkDgog==
X-Nifty-SrcIP: [124.155.36.249]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: fhandler_base: Fix double free caused when open()
 fails.
Date: Tue, 18 Jan 2022 08:05:07 +0900
Message-Id: <20220117230507.387-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 17 Jan 2022 23:05:34 -0000

- When open fails, archetype stored in archetypes[] is not cleared.
  This causes double free when next open fail. This patch fixes the
  issue.

Addresses:
  https://cygwin.com/pipermail/cygwin/2022-January/250518.html
---
 winsup/cygwin/fhandler.cc   | 4 ++--
 winsup/cygwin/release/3.3.4 | 3 +++
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
index fc7c0422e..7d427135e 100644
--- a/winsup/cygwin/fhandler.cc
+++ b/winsup/cygwin/fhandler.cc
@@ -440,8 +440,8 @@ fhandler_base::open_with_arch (int flags, mode_t mode)
   if (!(res = (archetype && archetype->io_handle)
 	|| open (flags, mode & 07777)))
     {
-      if (archetype)
-	delete archetype;
+      if (archetype && archetype->usecount == 0)
+	cygheap->fdtab.delete_archetype (archetype);
     }
   else if (archetype)
     {
diff --git a/winsup/cygwin/release/3.3.4 b/winsup/cygwin/release/3.3.4
index 7c37a575c..71f8dc888 100644
--- a/winsup/cygwin/release/3.3.4
+++ b/winsup/cygwin/release/3.3.4
@@ -23,3 +23,6 @@ Bug Fixes
 
 - Fix an "Invalid argument" problem in posix_spawn on i686.
   Addresses: https://cygwin.com/pipermail/cygwin/2022-January/250453.html
+
+- Fix double free for archetype, which is caused when open() fails.
+  Addresses: https://cygwin.com/pipermail/cygwin/2022-January/250518.html
-- 
2.34.1

