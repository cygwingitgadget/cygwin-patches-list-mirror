Return-Path: <SRS0=jFRs=S5=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 56B0B3858D26
	for <cygwin-patches@cygwin.com>; Wed,  4 Dec 2024 11:53:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 56B0B3858D26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 56B0B3858D26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733313235; cv=none;
	b=Wyacc2Fq6i92FIriQbn/9ABTNJz8zggCnIJb2kLE5S9QZgyQ6kbUuIwaevQsBftLB6wInr3eb/OU6hOTV92PqrrSYLBs7Kpf0vZdvTtwMieCt+DYwM79cIkc+UaqWxSePcLRhB1fNnJ7GW/9ucwTxQzNN3RhRJz+8jQm2QORuac=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733313235; c=relaxed/simple;
	bh=8Rc6AkqUL4dHHJNyAjCwjeA9+MlhIpnO0Litaf3aNOY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=M7PPUPAlyhuRtpWHoCw2NH3jk0REcaMlCcnE6oO8W1NCcRrUZ3bkKDJWmyCSW8zfAjcjjXjWBrZJXlfLl3O2OXjCaBIUlEoGy60NpAaTtYgsKUTRhpj7D6GDELYtQSrzpBsXLffBeMG7uATScZrXLC3CDBHevkWJD+GWvnwUB8I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 56B0B3858D26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EoB0ylvf
Received: from localhost.localdomain by mta-snd-w05.mail.nifty.com
          with ESMTP
          id <20241204115353619.MNRG.116458.localhost.localdomain@nifty.com>;
          Wed, 4 Dec 2024 20:53:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Steven Buehler <buehlersj@outlook.com>
Subject: [PATCH] Cygwin: termios: Trim buffer size for GetConsoleProcessList()
Date: Wed,  4 Dec 2024 20:53:27 +0900
Message-ID: <20241204115337.1211-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733313233;
 bh=BD5qIXL1k7ENo59gEGlWdkTkKarnTo5FGy1f1imaq/s=;
 h=From:To:Cc:Subject:Date;
 b=EoB0ylvfflFe/vicKA7gg+M+hRYhA7v+GRoA62vKwLH+0MnjNDE7JHs+bZAypFih7rkdXa0t
 UPtEaZ2OJ7/AMJaHcRIhAQ4sNpIH2O+XX+ODsbeQPCv7CbgEpWRnTsAYc0FUMMsVRlITgvc9dg
 /u6+Pt66svPOwS2FRjs3J+pVzPGmtjc2OkDySIdJD9BrE9vkgshAudpGsaZfkRnrQfjGcAjajf
 GSAU0GKxo9w6l4eHQCevNhsVA/noXcIoLyO2FUyXGkd1O7Au2ypmLz3IGjughJXS8RL6XI/CF+
 DlLu9pp25q4O8NQ1+wY6Pz0N1adGORpwhv1fKfqjvYz4mn9g==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the buffer of 128KB is passed to GetConsoleProcessList().
This causes page fault in the select() loop for console due to:
https://github.com/microsoft/terminal/issues/18264
because the previous code calls GetConsoleProcessList() with large
buffer and PeekConsoleInput() with small buffer alternately.
With this patch, the minimum buffer size is used that is determined
by GetConsoleProcessList() with small buffer passed.

Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256841.html
Fixes: 72770148ad0a ("Cygwin: pty: Prevent pty from changing code page of parent console.")
Reported-by: Steven Buehler <buehlersj@outlook.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/termios.cc | 14 ++++++++++++--
 winsup/cygwin/release/3.5.5       |  3 +++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 585e6ac4a..3cbdf7fca 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -870,8 +870,18 @@ fhandler_termios::get_console_process_id (DWORD pid, bool match,
   DWORD *list = (DWORD *) tp.c_get ();
   const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
 
-  DWORD num = GetConsoleProcessList (list, buf_size);
-  if (num == 0 || num > buf_size)
+  DWORD buf_size1 = 1;
+  DWORD num;
+  /* The buffer of too large size does not seem to be expected by new condrv.
+     https://github.com/microsoft/terminal/issues/18264#issuecomment-2515448548
+     Use the minimum buffer size in the loop. */
+  while ((num = GetConsoleProcessList (list, buf_size1)) > buf_size1)
+    {
+      if (num > buf_size)
+	return 0;
+      buf_size1 = num;
+    }
+  if (num == 0)
     return 0;
 
   DWORD res_pri = 0, res = 0;
diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
index d41d168c6..7ccf28abf 100644
--- a/winsup/cygwin/release/3.5.5
+++ b/winsup/cygwin/release/3.5.5
@@ -48,3 +48,6 @@ Fixes:
 
 - sched_setscheduler(2) allows to change the priority if the policy is
   equal to the value returned by sched_getscheduler(2).
+
+- Fix frequent page fault caused in Windows Terminal.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-December/256841.html
-- 
2.45.1

