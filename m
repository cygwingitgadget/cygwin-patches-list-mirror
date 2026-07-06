Return-Path: <SRS0=tl+H=FA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 346F64BA2E0E
	for <cygwin-patches@cygwin.com>; Mon,  6 Jul 2026 03:20:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 346F64BA2E0E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 346F64BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783308048; cv=none;
	b=jpXnmWqPwdGLSrCF2402XUJcrJcBGt913rWxUACR3oojU6gxc5Dr29q6LZekcENkSMVVo5D4Ct57Lygsu3QO2Bg6+83juAeS6PiyaMkRaZiUv/st5tox1GmU035/7ank5RHWkEYBZT81KfE3hZo5qf1F6LDdQjlkgX7w/GK9prI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783308048; c=relaxed/simple;
	bh=MyvSXNOprIOC0meK1pAyM+YPHxOuAxAjO5Dw8XIMKuA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=puJCFXNw4rHySByImJ3GOHotHJqwMZ4u/sYmh3QqhkCnVNirv5Eu+Y/bt1c5eiWRG39NfbUNYxLDpfUHHwz/QGJn9U6Gx7nqrPIbJ3ZEn9PuqZ8utqxzNYgiWFrC0gjibr7TW78nF7kzh3fDvUv7WvJv8SZvZjWyR8Anf2cOveU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=SSZryBvA
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 346F64BA2E0E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=SSZryBvA
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260706032045255.MMAH.18412.HP-Z230@nifty.com>;
          Mon, 6 Jul 2026 12:20:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: pty: Do not transfer input to nat-pipe while masked
Date: Mon,  6 Jul 2026 12:20:24 +0900
Message-ID: <20260706032038.100981-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783308045;
 bh=OXAXCyGseO+6Zhr4tlcaOHhyxoYrA2Oah4lg1HLucsg=;
 h=From:To:Cc:Subject:Date;
 b=SSZryBvAKjUsBeiPfPS9awjiSAr3+Lwmn5jcno2KAJM7nNa9HnyvD2CkNX3t3JkOriIrvngT
 1DWwvLVyemXThcmRiKPB3LunqMhxU1JUmT0QyxtiVimXnODrgmw8I/lfed9EOz4FyFoN5nOy2J
 pIJAouX68MMnOFHGh664JVXZONUYmThzFwLimv05sraD3SjWAJR2iBS/0cN93TD2e0lASJ64ia
 M30/USpJx3lV7sab1KKZjuulJ5U+EUaMYL9jmYdh4COI9QZjHqkZYenOy3kWvSyHkOtx+SGPxY
 ejODl2B33RAG4a/Q1+0ye+j/wE7RlwM/XlPpo4zCc9Gdz3GQ==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

 winsup/cygwin/fhandler/pty.cc | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index ca85ae679..963f95801 100644
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
 
@@ -1543,19 +1547,22 @@ fhandler_pty_slave::write (const void *ptr, size_t len)
 void
 fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
 {
+  acquire_attach_mutex (mutex_timeout);
   char name[MAX_PATH];
   shared_name (name, TTY_SLAVE_READING, get_minor ());
   HANDLE masked = OpenEvent (READ_CONTROL, FALSE, name);
   CloseHandle (masked);
 
+  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
   WaitForSingleObject (input_mutex, mutex_timeout);
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
+  release_attach_mutex ();
 
   if (!!masked != mask && xfer && get_ttyp ()->switch_to_nat_pipe)
     {
@@ -4460,6 +4467,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
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

