Return-Path: <SRS0=QjWS=E2=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id D159D4BA2E17
	for <cygwin-patches@cygwin.com>; Tue, 30 Jun 2026 08:14:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D159D4BA2E17
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D159D4BA2E17
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782807294; cv=none;
	b=VCVUU1B1YGizUN35N2TXgHFCOcW2bgRDi1sn8GgclK+SgX5MwueckuejcBUS5Y2xzdjl0PA6pYjZ6KnXF6b4chY4QZuXb7tqwRS50eABribge7RNMdpUva3X+PkwDN3XqYPSPieELKSeSpOMbc/efgUtPYWslKDSZyLDGeTErBU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782807294; c=relaxed/simple;
	bh=VIHp64I253XtcJZGr54aYtldtl+wLk37h1/5UNUsVek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=PnhHJMD5JAOEOmK41M73UcpN9UE6CtQ6s1GoOyXIBZZhNjtCUUiup1g6PTwWweAw1E6edB4LxJXbVexSc3fPmmWnoT/xMTH9vpSb1sEVoklVasrP0kR679syw6qt6REcmEArO3JYOrxK5nuu7EPVW8liNoobnDYGFnjsHWL2TP4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=c3zso1ox
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D159D4BA2E17
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=c3zso1ox
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260630081444490.SRUE.44671.HP-Z230@nifty.com>;
          Tue, 30 Jun 2026 17:14:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2] Cygwin: pty: Do not transfer input to nat-pipe while masked
Date: Tue, 30 Jun 2026 17:14:29 +0900
Message-ID: <20260630081436.2427-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1782807284;
 bh=Dz5qy4F4PFR3WJus7ZHSvRPLp+i+mJHCIOMZ7635nS0=;
 h=From:To:Cc:Subject:Date;
 b=c3zso1oxDkwJq0dsh+G9x49fATkKNepn3wnoDPVsbm6g8iq0ipZY7EWCGeqz1l3JYafFSMSH
 1E6wlZtxUiRYICzkpdOMWNESFLLFJMo3ZTqNAK7u975ymsT1lSw8zACmAtqPy2t/TMx/Gnovzh
 7jQZs3jnyQp21b8WPff/ttkBiXFaZNvPYn3+X6Tkah88r1MTC17uMQwJWseaSJNFtetACoGYos
 4vBV3+kcRKVGtwzA1kvPPF30GXVfiZhcEqV985mvat2DfeW6LmZjbV7C3P+In8htB5pZQk8ftg
 SG8DE/Lv2Jnu5+SDnzBJcU2kUOQGRmJ6tz+LzjeInnAps+5Q==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by:
---
v2: Release all masks owned by myself on cleanup()

 winsup/cygwin/fhandler/pty.cc           | 33 +++++++++++++++++++++----
 winsup/cygwin/local_includes/fhandler.h |  3 +--
 winsup/cygwin/local_includes/tty.h      |  2 ++
 3 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 35e320507..54cd64a47 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -951,7 +951,7 @@ out:
 
 fhandler_pty_slave::fhandler_pty_slave (int unit, dev_t via)
   : fhandler_pty_common (), inuse (NULL), output_handle_nat (NULL),
-  io_handle_nat (NULL), slave_reading (NULL), num_reader (0)
+  io_handle_nat (NULL), masked_cnt (0)
 {
   dev_referred_via = via;
   if (unit >= 0)
@@ -1230,6 +1230,10 @@ fhandler_pty_slave::open_setup (int flags)
 void
 fhandler_pty_slave::cleanup ()
 {
+  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
+  while (arch->masked_cnt)
+    mask_switch_to_nat_pipe (false, false);
+
   if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () == myself->pgid)
     req_fixup_pcon_state ();
 
@@ -1499,11 +1503,18 @@ fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
   WaitForSingleObject (input_mutex, mutex_timeout);
   if (mask)
     {
-      if (InterlockedIncrement (&num_reader) == 1)
-	slave_reading = CreateEvent (&sec_none_nih, TRUE, FALSE, name);
+      if (InterlockedIncrement (&get_ttyp ()->num_reader) == 1)
+	get_ttyp ()->slave_reading =
+	  CreateEvent (&sec_none_nih, TRUE, FALSE, name);
     }
-  else if (InterlockedDecrement (&num_reader) == 0)
-    CloseHandle (slave_reading);
+  else if (InterlockedDecrement (&get_ttyp ()->num_reader) == 0)
+    CloseHandle (get_ttyp ()->slave_reading);
+
+  fhandler_pty_slave *arch = (fhandler_pty_slave *) archetype ? : this;
+  if (mask)
+    InterlockedIncrement (&arch->masked_cnt);
+  else
+    InterlockedDecrement (&arch->masked_cnt);
 
   if (!!masked != mask && xfer && get_ttyp ()->switch_to_nat_pipe)
     {
@@ -4401,6 +4412,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir dir, HANDLE from, tty *ttyp,
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
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 8e9cbef4b..d8b6f5950 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2442,8 +2442,7 @@ class fhandler_pty_slave: public fhandler_pty_common
 {
   HANDLE inuse;			// used to indicate that a tty is in use
   HANDLE output_handle_nat, io_handle_nat;
-  HANDLE slave_reading;
-  LONG num_reader;
+  LONG masked_cnt;
 
   /* Helper functions for fchmod and fchown. */
   bool fch_open_handles (bool chown);
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index c5102eb81..407565ce9 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -146,6 +146,8 @@ private:
   bool discard_input;
   bool stop_fwd_thread;
   bool req_fixup_pcon_cur_pos;
+  HANDLE slave_reading;
+  LONG num_reader;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
-- 
2.51.0

