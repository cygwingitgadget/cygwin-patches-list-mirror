Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
	by sourceware.org (Postfix) with ESMTPS id 2EA263858C62
	for <cygwin-patches@cygwin.com>; Sat, 22 Oct 2022 05:35:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 2EA263858C62
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (aj136180.dynamic.ppp.asahi-net.or.jp [220.150.136.180]) (authenticated)
	by conuserg-11.nifty.com with ESMTP id 29M5YUqL003731;
	Sat, 22 Oct 2022 14:34:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 29M5YUqL003731
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
	s=dec2015msa; t=1666416875;
	bh=LRZ0T9rOiKfoEf2ncXs2N1WjccANeygoMTR07H1Yia8=;
	h=From:To:Cc:Subject:Date:From;
	b=QXyg72pmUeGunfR4mEfldZ4tmIistHlRQemCoM9zWgNf4nr2JUODk6wn4xez0uNo+
	 9sL2pNY5haOItSaoWbdDpdeRtNo3oLgFvTTuQuAiaIr5l1XhmAvrLSedJCcpFOem41
	 nPMLnMT/ts2PA+O2TernldJaIImNIb3dbemfkmIwTk5caITpgwr3z4tMkCQ8KGKMrR
	 gpstQpU5LY1cPP/yHplZDYL6UQNcaS1gLsPnuGixR5fyE5SeQDUjkGsBT6ZaQM9n/E
	 PCVApSb5eD9lsLQFrj0beVee3vU75y4FKLdjcYegxGxxnFUp0NaVgCkjhLeB7fA2Gj
	 kVBVIlCzTdm2A==
X-Nifty-SrcIP: [220.150.136.180]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix 'Bad address' error when running 'cmd.exe /c dir'
Date: Sat, 22 Oct 2022 14:34:20 +0900
Message-Id: <20221022053420.1842-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

- If the command executed is 'cmd.exe /c [...]', runpath in spawn.cc
  will be NULL. In this case, is_console_app(runpath) check causes
  access violation. This case also the command executed is obviously
  console app., therefore, treat it as console app to fix this issue.

  Addresses: https://github.com/msys2/msys2-runtime/issues/108
---
 winsup/cygwin/spawn.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 5aa52ab1e..4fc842a2b 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -215,6 +215,8 @@ handle (int fd, bool writing)
 static bool
 is_console_app (WCHAR *filename)
 {
+  if (filename == NULL)
+    return true; /* The command executed is command.com or cmd.exe. */
   HANDLE h;
   const int id_offset = 92;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
-- 
2.37.2

