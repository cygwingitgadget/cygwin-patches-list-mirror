Return-Path: <SRS0=wCit=FC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:2a])
	by sourceware.org (Postfix) with ESMTPS id 18AF24BA2E09
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 03:58:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 18AF24BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 18AF24BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783483085; cv=none;
	b=L+8FLizWHmNZsWE0DgCBx6CfDgRGIS9lOPyzTpBc1yYlLAa2gsw7iTOAcKP9rU4lsqgRR1ZVN2uI5jrmd4h0hsOFQRpRLfcPmXHB9XPcQnPGH4uO6euOh3AN9WWNpoihNyyD53JudFvwIbSiEfrOJP9KDACA+EF0bgR65jZ6PWI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783483085; c=relaxed/simple;
	bh=MyvSXNOprIOC0meK1pAyM+YPHxOuAxAjO5Dw8XIMKuA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=V6//18f1d5SGEBzCzWeBC5JTUR/gSkbpUYb6Hwh56eiLXWEv2n3m1FBL5YHTnGEbbwm0lZagps/wJ28durE4a8M4Rra2uA/DonnRARcAlb9QKEkl94s2GLO5vV6FLNXKoD+T/AV9iPuPunoyq2OJ+ON9Qy8W876ZSIjbTx+BHPc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pz8H/Qii
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 18AF24BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=pz8H/Qii
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20260708035803428.LUXY.3198.HP-Z230@nifty.com>;
          Wed, 8 Jul 2026 12:58:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: pty: Do not transfer input to nat-pipe while masked
Date: Wed,  8 Jul 2026 12:57:48 +0900
Message-ID: <20260708035757.885-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1783483083;
 bh=OXAXCyGseO+6Zhr4tlcaOHhyxoYrA2Oah4lg1HLucsg=;
 h=From:To:Cc:Subject:Date;
 b=pz8H/QiipdhBRYpOrcTBHDXfc0fqOwSmaIHduLbhMPyiAuUPDThwhprFyVrSEaJb1zQYAxDN
 9BsaXTl1Zuq3tytKF617riFBnbmt8DrpTISylZkMGTxzANaIKVz2Sx3OqujIZSmLpfY0+y8OIs
 ltv2xgNLoEZACbU9gm23cA1H1WfJN5y/nMQUF036fCxU7v5Vx7PiI2f1YPw2sgIkjk0ByU7Lfx
 aUytAD2h1rm48rtjw3g3z4aqQEeMVsPgkiXIwM7YfUMeOrveHJkDUrPG4btuTGL8t3fe9/QVZ6
 RntncQ7rRa88VP+a73bYLceyZyfybX7tQWRR6YnckYpWnlMw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

