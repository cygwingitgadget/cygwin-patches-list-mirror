Return-Path: <SRS0=Wlsd=SA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 50D31385840F
	for <cygwin-patches@cygwin.com>; Tue,  5 Nov 2024 11:44:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 50D31385840F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 50D31385840F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1730807052; cv=none;
	b=iQ26i24x3lxuV3aFLfwVeeN9r2FQnlf5ZSSUBZiIam4Fnp4WcLlqFZ2jKCM6vtVt65OIub4CZYQDJygla1pUjQohzbjPqgeJcXDR2+gbLGq6PwkUqguU/GB4wQcwFK+mkxKMWcWAgq5hPn3GHBiJSJ0+MLJ1V6PHM5SgolpY34A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1730807052; c=relaxed/simple;
	bh=zkpjK1DYpPN5oVyDaY/mmuGGWjKPYNSt/qQeKY4xPsw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=boTXwYB3lY8WMOkUNbV6qNJMd9k/ANBBdv7H9aPtl1aIGofcvmjRifZ5tY3A1X9v93h8NshMYz0fNEvd7SLvvC7P3C7b57ALWVs5lk0s7phbR0NVajEMlgwQ0An4i89sS2UNj4U8ssuBcoIAtqTJ5JMf6G/YAg3VOFqHSyCpQQc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e07.mail.nifty.com
          with ESMTP
          id <20241105114405779.MJLS.76216.localhost.localdomain@nifty.com>;
          Tue, 5 Nov 2024 20:44:05 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix open() failure when the console owner calls exec().
Date: Tue,  5 Nov 2024 20:43:29 +0900
Message-ID: <20241105114350.40796-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1730807045;
 bh=VKoPLFfDjIgTIHPSaCDyof6RRxTgwiObX8OshiuSbYo=;
 h=From:To:Cc:Subject:Date;
 b=gyFI0mr+cplDCcFJ5e4MZUTD54AH1VTRqnzHNJkjCgKiwyEOB9H5wU8BC9T1qlxPCJ7ruovg
 eKH5HMLRMAky0ipono7dEdsxe2j1P9zkPF/E122RYsE9l8drhbm2acVbhkFYjq7RmZKjXITg0J
 +xQkqZKbmQgq2ZluH7rczIig9Z3F8Mv1dKyVM1zz0+U6YhYmTDx9nzFEBIi/kxe1N8LYobf6vL
 ia7UgV07/2oj/1bMwERU1ZDTGGqLp3QGXVsNnMPRhMcOfopVEBA0SE3wp45R5GX/PJPna9vAHt
 Ww9AnyLDlUE5KU7LqZM/ipvpRw5vyCwvKodoNHOO9RL0iXsA==
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, open() tries to attach to the console which is owned by
the console owner process. However, when the owner process calls
exec(), AttachConsole() to dwProcessId may sometimes fail due to
unlucky timing. With this patch, open() tries to attach also to
exec_dwProcessId if attaching to dwProcessId fails. That is, open()
tries to attach to both the stub process and target process to
prevent the above situation.

Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible from other terminals.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 9cdc13dd2..ac47c8374 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -84,6 +84,10 @@ fhandler_console::attach_console (pid_t owner, bool *err)
       DWORD attached =
 	fhandler_pty_common::get_console_process_id (p->dwProcessId,
 						     true, false, false);
+      if (!attached)
+	attached =
+	  fhandler_pty_common::get_console_process_id (p->exec_dwProcessId,
+						       true, false, false);
       if (!attached)
 	{
 	  resume_pid =
@@ -91,6 +95,8 @@ fhandler_console::attach_console (pid_t owner, bool *err)
 							 false, false, false);
 	  FreeConsole ();
 	  BOOL r = AttachConsole (p->dwProcessId);
+	  if (!r)
+	    r = AttachConsole (p->exec_dwProcessId);
 	  if (!r)
 	    {
 	      if (resume_pid)
-- 
2.45.1

