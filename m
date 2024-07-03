Return-Path: <SRS0=FO7W=OD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [106.153.227.178])
	by sourceware.org (Postfix) with ESMTPS id 844EB386101B
	for <cygwin-patches@cygwin.com>; Wed,  3 Jul 2024 14:22:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 844EB386101B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 844EB386101B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1720016532; cv=none;
	b=XMvVrP/jsJaojt18NYAbfrwwNf+1lsqIBOfd54+yk6GRSySZAAzZeTjBKAejkQQeK3Bn4eHXuBWB4AR6cBDi4PaB6F+/+boIph4EeALaeAt/ZHMzJjtzn3QqPrFv/HgzR7KUi9Eo4lVIbdHhdvDwceBhwrfgWJs6Iog93yHENxI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1720016532; c=relaxed/simple;
	bh=MhIAvHiEfLZ/WpSUNyQQbwV2jh1vQFJ9gaVnQFU3o/I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=E14l/DC+BC8au68gED0r4iUbMX1Z1xnQc3TxS1b+5m0KNJvMg66fa7gav0iVD476WMMTM/hDtuLLaf7eFV+jQxl3NDfrjWdcq4BjYcbpq4rlDhAaGCZRJhRO3iCcMAaZbhU/pB4Iyt4joWRSYSpuhtBZ9Xs4aZ8+Yy6+kKpzNso=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from localhost.localdomain by mta-snd-e02.mail.nifty.com
          with ESMTP
          id <20240703142207696.WZEK.83552.localhost.localdomain@nifty.com>;
          Wed, 3 Jul 2024 23:22:07 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Khoshnazar-Thoma <johannes@johannesthoma.com>
Subject: [PATCH] Cygwin: console: Fix conflict on shared names between sessions.
Date: Wed,  3 Jul 2024 23:21:43 +0900
Message-ID: <20240703142151.27229-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1720016527;
 bh=U2M4vGXDsNON9UvbAh9fBrgWBN25MzBcIQ+KOh6mIVM=;
 h=From:To:Cc:Subject:Date;
 b=qQT0R/7AdTlNL57PllWkVJnbotr4nNQuEBJqrIzKmRHBFMPBsA0vEiHYk7X057aYvEz6Yztj
 xA+BrjIlplDa1qd2FbXDA5215FIiQat6Av6wdDRMoaUG0slYgY5m0R6VdJFzfu1QjU0K5b2knh
 HwbyB5ZTUy3a4c7xaPzSFvyEpDfdWayGfTTVeFPOhAeBvxJZqta8JV9t/u9v97mmNqpxXTx5QP
 S6m9ZYVTFIHU7RzyuarfNMj1znjBXBQKWeFnGl/XBvaQp8YH8JY2ZYGY25rFqPOW529QrlZc/j
 3sXqQn7GN4Im84ct/YBBg9PyKLXEUO2CGT8Z1q5fUaw48jKQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, shared names in the console were created using get_minor().
However, get_minor() was not unique to the console across sessions.
This is because EnumWindows(), which is used to look for console windows,
cannot enumerate windows across sessions. This causes conflict on the
shared names between sessions (e.g. sessions of different users,
different services, a service and a user session, etc.).

With this patch, GetConsoleWindow() is used instead of get_minor().
GetConsoleWindow() has been used for the name of shared memory, which
should be unique to each console.

Addresses: https://cygwin.com/pipermail/cygwin/2024-April/255893.html
Fixes: ff4440fcf768 ("Cygwin: console: Introduce new thread which handles input signal.");
Reported-by: Johannes Khoshnazar-Thoma <johannes@johannesthoma.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/console.cc | 15 +++++++++++----
 winsup/cygwin/release/3.5.4       |  3 +++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index dbf6ce8a6..7945a32eb 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -66,6 +66,13 @@ static struct fhandler_base::rabuf_t con_ra;
    in xterm compatible mode */
 static wchar_t last_char;
 
+static char *
+cons_shared_name (char *ret_buf, const char *str, HWND hw)
+{
+  __small_sprintf (ret_buf, "%s.%p", str, hw);
+  return ret_buf;
+}
+
 DWORD
 fhandler_console::attach_console (pid_t owner, bool *err)
 {
@@ -922,7 +929,7 @@ fhandler_console::setup_io_mutex (void)
   res = WAIT_FAILED;
   if (!input_mutex || WAIT_FAILED == (res = acquire_input_mutex (0)))
     {
-      shared_name (buf, "cygcons.input.mutex", get_minor ());
+      cons_shared_name (buf, "cygcons.input.mutex", GetConsoleWindow ());
       input_mutex = OpenMutex (MAXIMUM_ALLOWED, TRUE, buf);
       if (!input_mutex)
 	input_mutex = CreateMutex (&sec_none, FALSE, buf);
@@ -938,7 +945,7 @@ fhandler_console::setup_io_mutex (void)
   res = WAIT_FAILED;
   if (!output_mutex || WAIT_FAILED == (res = acquire_output_mutex (0)))
     {
-      shared_name (buf, "cygcons.output.mutex", get_minor ());
+      cons_shared_name (buf, "cygcons.output.mutex", GetConsoleWindow ());
       output_mutex = OpenMutex (MAXIMUM_ALLOWED, TRUE, buf);
       if (!output_mutex)
 	output_mutex = CreateMutex (&sec_none, FALSE, buf);
@@ -1853,7 +1860,7 @@ fhandler_console::open (int flags, mode_t)
       if (GetModuleHandle ("ConEmuHk64.dll"))
 	hook_conemu_cygwin_connector ();
       char name[MAX_PATH];
-      shared_name (name, CONS_THREAD_SYNC, get_minor ());
+      cons_shared_name (name, CONS_THREAD_SYNC, GetConsoleWindow ());
       thread_sync_event = CreateEvent(NULL, FALSE, FALSE, name);
       if (thread_sync_event)
 	{
@@ -1922,7 +1929,7 @@ fhandler_console::close ()
       if (master_thread_started)
 	{
 	  char name[MAX_PATH];
-	  shared_name (name, CONS_THREAD_SYNC, get_minor ());
+	  cons_shared_name (name, CONS_THREAD_SYNC, GetConsoleWindow ());
 	  thread_sync_event = OpenEvent (MAXIMUM_ALLOWED, FALSE, name);
 	  if (thread_sync_event)
 	    {
diff --git a/winsup/cygwin/release/3.5.4 b/winsup/cygwin/release/3.5.4
index 17db61146..c95ef4635 100644
--- a/winsup/cygwin/release/3.5.4
+++ b/winsup/cygwin/release/3.5.4
@@ -19,3 +19,6 @@ Fixes:
 - Fix a problem that pty slave hangs on writing when pty master stops
   to read.
   Addresses: https://cygwin.com/pipermail/cygwin/2024-June/256178.html
+
+- Fix conflict on shared name in console between sessions.
+  Addresses: https://cygwin.com/pipermail/cygwin/2024-April/255893.html
-- 
2.45.1

