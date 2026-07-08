Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 8826F4BA5439
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 04:54:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8826F4BA5439
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8826F4BA5439
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783486462; cv=none;
	b=wJpIYRP1qIId6RF1GXUka9CRESwv6iJF6qIgrEAUqX3ewsWKTQZnmqZ4ML1Y91yLOsTfS36p+Sv/3wth90dL+LflaqbaTG5YeF5KjcuBh/vYARRNvtmvMWO3ow8bTrZ2BWIBhUKonjN4jNyXfCczcGb6lteP9nThZA7K8GAf9TY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783486462; c=relaxed/simple;
	bh=7yrx5HHP7uvh5UHP5TjEo8ufFnCSEhbp1hxVoKSFWxs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=qMXbcqxYoyfItkcxWewOtzFjgm/AtIYZhEBYAtyPZzPSveUZGFShuBI8Y8yuM+ALKB3442AtB5s+L69QsGLguebA4OEDJcmj1HGRJEKSbq591A8FJljxq0z0J3eUR9TOr5NNWRU3s0dOus+nsu45z67lv23V3Ywp4QdLQpfNyRQ=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ntSmwyJc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8826F4BA5439
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ntSmwyJc
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260708045418298.ZHKY.117312.HP-Z230@nifty.com>;
          Wed, 8 Jul 2026 13:54:18 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v4] Cygwin: pty: Do not transfer input to nat-pipe while masked
Date: Wed,  8 Jul 2026 13:54:04 +0900
Message-ID: <20260708045412.945-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783486458;
 bh=PbAZQCVBYrsPryKxvQvh1kO3wN/zrbfEO1BwpOEPLME=;
 h=From:To:Cc:Subject:Date;
 b=ntSmwyJcsArW/1OYkIMhMXeTBKIdypH4psY21dmNoYguLiQCMfaqWN7a5Lo+dnP2TrykqVQ2
 PalONH8REAKopR+3jVLP68PaPbZGUvn+Vk0cXSRagJec9lAqGhXyqOUlld0JEnYSBSrbfVQZF1
 7jJuSQqhgbcOc2ncJQUPB7ajV5yzpx0g88q4kqnr0tfQ7I9ri+Jr+ZRvessvk9RjKYcKhRdYgi
 Q+Hcnl28MbIVJCFvFIbpIonskYPAdWNNJL9CZRTzdTaWCvAj//rhhkZaFeQUpNaxSLF/pn/QNK
 SwwRNYA8zt7tAfZiuoul4xD+6Yz1yTN4KKKEP/jcbo87wxaw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On the command "cat | non-cygwin-app", `cat` sometimes fails to read
key input. This happens when `cat` starts to read input before `non-
cygwin-app` configures pseudo console. This is because pipe state is
switched to nat-pipe when pseudo console is configured.

This patch prevent the pipe state from changing to nat-pipe state if
some cygwin process is reading input from the cyg-pipe.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Release all masks owned by myself on cleanup()
v3: Reverts the change that made num_reader and slave_reading shared
v4: Correct what mutex shoud be acquired in mask_switch_to_nat_pipe()

 winsup/cygwin/fhandler/pty.cc | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index ca85ae679..1b453a499 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1282,6 +1282,10 @@ fhandler_pty_slave::open_setup (int flags)
 void
 fhandler_pty_slave::cleanup ()
 {
+  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
+  while (arch->num_reader)
+    mask_switch_to_nat_pipe (false, false);
+
   if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
     req_fixup_pcon_state ();
 
@@ -1543,19 +1547,20 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 void
 fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 {
+  WaitForSingleObject (input_mutex, mutex_timeout);
   char name[MAX_PATH];
   shared_name (name, TTY_SLAVE_READING, get_minor ());
   HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
   CloseHandle (masked);
 
-  WaitForSingleObject (input_mutex, mutex_timeout);
+  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
   if (mask)
     {
-      if (InterlockedIncrement (&num_reader) == 1)
-	slave_reading = CreateEvent (&sec_none_nih, TRUE, FALSE, name);
+      if (InterlockedIncrement (&arch->num_reader) == 1)
+	arch->slave_reading = CreateEvent (&sec_none_nih, TRUE, FALSE, name);
     }
-  else if (InterlockedDecrement (&num_reader) == 0)
-    CloseHandle (slave_reading);
+  else if (InterlockedDecrement (&arch->num_reader) == 0)
+    CloseHandle (arch->slave_reading);
 
   if (!!masked != mask && xfer && get_ttyp ()->switch_to_nat_pipe)
     {
@@ -4460,6 +4465,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
 				    HANDLE input_available_event,
 				    HANDLE input_transferred_to_cyg)
 {
+  if (dir == tty::to_nat)
+    {
+      char name[MAX_PATH];
+      shared_name (name, TTY_SLAVE_READING, ttyp->get_minor ());
+      HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
+      CloseHandle (masked);
+      if (masked)
+	/* Cygwin process is reading cyg-pipe.
+	   Do not transfer input to nat-pipe. */
+	return;
+    }
+
   HANDLE to;
   if (dir == tty::to_nat)
     to = ttyp->to_slave_nat ();
-- 
2.51.0

