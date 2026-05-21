Return-Path: <SRS0=2AmO=DS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id 7D5A04C91762
	for <cygwin-patches@cygwin.com>; Thu, 21 May 2026 21:26:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D5A04C91762
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D5A04C91762
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779398791; cv=none;
	b=a4l7hfc+xHC5f1ky/gba61sAhrX1SyhTqJJYPZYMOrZfBMebC7U2yOGdXaJVbTowUlP89xSXIJeI9De9WQgTnCnOwLpV/QONooZDdoZZ05Low3ny/49yidIuKO0B2aYmAaxSD0YaaiSZWdPy6PcMX4Aj2qq3EsPI89pfbujMZik=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779398791; c=relaxed/simple;
	bh=rOzTLOklke+3Pd8SKQ2WH+gxS9VPkmtJ5/XbzRgKX6g=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=J/bDKyua090GjXM+1Qwe+Q8O47ZL7QrGphduuHJl9Hw817Mkx8LzdpYcIeT2hWyZ4BDKmq1yBgAZJ+75VDgvd2dVE9ugKUqOpQk8RN+7PVGPHpkGCGGEwpRQ9NJK+UyVByNEWsk+k3+sl88yG6S/W/Y45oUORJXZCUsV58/wkY4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Y+zpEjZM
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7D5A04C91762
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Y+zpEjZM
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260521212627963.UFPU.3198.HP-Z230@nifty.com>;
          Fri, 22 May 2026 06:26:27 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix deadlock in console teardown that arises from pcon
Date: Fri, 22 May 2026 06:26:10 +0900
Message-ID: <20260521212621.130760-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1779398788;
 bh=cm+3Bj9CBhHA2iq7Q4H8vIOR5ygvxYiJZ4pIMJOstyI=;
 h=From:To:Cc:Subject:Date;
 b=Y+zpEjZMZqGNbSCS9bCSpAYKvJyzWZLLU4v1FVy6qLn0zzSL5C+V+750Ixwx6EYVpxEsRnpq
 mtNFWJZdKsGAqRPDBoRZT2wsOzXt45w93Hlz9xr9XrKu5bWxlxkrUTC5+WX5nwFGE/zU0Y1mYs
 5aiviTTlW7s5TDf3guiOWKElHqvGuBhrmkTwO7MoEzEdSIvKFdgLgDBtyP9/dpLndO+0i8bdyn
 +E5NwlokYCwtMzH2maEReozJf0YnjjWzwLMt9G4IQlcLAgXFZhp9wWQgMqXCRjc5BjpDj8y3sV
 FT/qHuH4GPU5oy1YnePr4zJ/+Tiv22l9u6CaapFl9YgT6hjA==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When a console process originating from a pseudo console exits, the
current sequence is as follows:

  1) atexit handlers (pcon_handover_proc) called. This also closes
     parent_pty_input_mutex which is introduced by the commit
     c4fb720afcf1.
  2) close_all_files() is called via _exit(). This terminates
     cons_master_thread.

parent_pty_input_mutex is referenced in cons_master_thread, so
cons_master_thread may still use the mutex after it has been closed.
This can lead to undesired behaviour, including a deadlock. Instead
of registering pcon_hand_over_proc() as an atexit handler, this
patch calls pcon_handover_proc() at a point in fhandler_console::close
where cons_master_thread has already terminated, ensuring that no
other thread accesses the mutex.

Addresses: https://github.com/msys2/msys2-runtime/issues/338
Fixes: c4fb720afcf1 ("Cygwin: console: Use input_mutex in the parent PTY in master thread")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index c76347f6f..6fd4cd965 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -2018,7 +2018,6 @@ fhandler_console::setup_pcon_hand_over ()
 	if (get_console_process_id (owner, true, false, false, false))
 	  {
 	    inside_pcon = true;
-	    atexit (fhandler_console::pcon_hand_over_proc);
 	    parent_pty = i;
 	    parent_pty_input_mutex =
 	      cygwin_shared->tty[i]->open_input_mutex (MAXIMUM_ALLOWED);
@@ -2157,6 +2156,8 @@ fhandler_console::close (int flag)
   CloseHandle (output_mutex);
   output_mutex = NULL;
 
+  pcon_hand_over_proc ();
+
   WaitForSingleObject (shared_info_mutex, INFINITE);
   if (--shared_info_state[unit] == 0 && shared_console_info[unit])
     {
-- 
2.51.0

