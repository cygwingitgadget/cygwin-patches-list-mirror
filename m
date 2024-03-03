Return-Path: <SRS0=DLLh=KJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from dmta0010.nifty.com (mta-snd00009.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 1DD013858C55
	for <cygwin-patches@cygwin.com>; Sun,  3 Mar 2024 05:09:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1DD013858C55
Authentication-Results: sourceware.org; dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1DD013858C55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1709442581; cv=none;
	b=buD4WN5NDWe4UXyNXvkqX9buZVi6eNiPcrVlCOq/pl2K45IGC/o/GS575ZrFDKHeUpL4/0kz9sODMQu26axRZLKuNg5l86xuAAOdVLcJObZ8MJD53iuJl3oU2zaqwROiYC7/z5CLEjahlgZYssTR0G/1/qvQko4te411eYW5760=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1709442581; c=relaxed/simple;
	bh=QwtFvA71xJUdSMgYSQ8oU7ZGmlwv8RroRsb4dYQt0Q4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Dof8sc3NF8D2KgzedfBziWCPfMh5pOxdE1wD7iVaaVNcf30+B6J311SdS1w1FMgg2fzJGdmcXMvUsoTqKkSbUNiU+QIwqZSgdL5OrlBZZjyYZKRbkW8iuH3XlW9KV3vO7Jo46leOkxLdWXSQV3A9jfFAhBdoEcma8vRSf0v09l0=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by dmta0010.nifty.com with ESMTP
          id <20240303050934888.CIWC.108497.localhost.localdomain@nifty.com>;
          Sun, 3 Mar 2024 14:09:34 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Alisa,
	Sireneva,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin apps.
Date: Sun,  3 Mar 2024 14:09:07 +0900
Message-ID: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Non-cygwin app may call ReadFile() which makes NtQueryObject() for
ObjectNameInformation block in fhandler_pipe::get_query_hdl_per_process.
Therefore, stop to try to get query_hdl for non-cygwin apps.

Addresses: https://github.com/msys2/msys2-runtime/issues/202

Fixes: b531d6b06eeb ("Cygwin: pipe: Introduce temporary query_hdl.")
Reported-by: Alisa Sireneva, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pipe.cc | 10 ++++++++++
 winsup/cygwin/release/3.5.2    |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
index 1a97108b5..95c2f843a 100644
--- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -1241,6 +1241,16 @@ fhandler_pipe::get_query_hdl_per_process (WCHAR *name,
 
   for (LONG i = (LONG) n_process - 1; i >= 0; i--)
     {
+      /* Non-cygwin app may call ReadFile() which makes NtQueryObject()
+	for ObjectNameInformation block. Therefore, stop to try to get
+	query_hdl for non-cygwin apps. */
+      pid_t cygpid;
+      if (!(cygpid = cygwin_pid (proc_pids[i])))
+	continue;
+      pinfo p (cygpid);
+      if (p && ISSTATE (p, PID_NOTCYGWIN))
+	continue;
+
       HANDLE proc = OpenProcess (PROCESS_DUP_HANDLE
 				 | PROCESS_QUERY_INFORMATION,
 				 0, proc_pids[i]);
diff --git a/winsup/cygwin/release/3.5.2 b/winsup/cygwin/release/3.5.2
index 7d8df9489..efd30b64a 100644
--- a/winsup/cygwin/release/3.5.2
+++ b/winsup/cygwin/release/3.5.2
@@ -5,3 +5,7 @@ Fixes:
   is already unmapped due to race condition. To avoid this issue,
   shared console memory will be kept mapped if it belongs to CTTY.
   Addresses:  https://cygwin.com/pipermail/cygwin/2024-February/255561.html
+
+- Fix a problem that select() call for write-side of a pipe possibly
+  hangs with non-cygwin reader.
+  Addresses: https://github.com/msys2/msys2-runtime/issues/202
-- 
2.43.0

