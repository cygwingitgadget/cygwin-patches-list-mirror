Return-Path: <SRS0=Gzk2=FK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 741574BA2E05
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 06:59:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 741574BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 741574BA2E05
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784185143; cv=none;
	b=lyPMjvYzAa7aYIUAMzjDxTU7whwc9ZH3lPApQp5FH5137IIRHySurpxDRMwJ02DJMCjLsHQeBT3kcrTFRkikz+ZvMag0XIFo++ICEeJbxuJVnvfbxnwatZ+pdGwlX+yJw/WE/y7fC/irAkNZZ3fzeCUMmWVLuoDzC32IuMoC6LY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784185143; c=relaxed/simple;
	bh=ageALEAjHyP7DH0CLgtKWZCbxjrCO78b427ADwRSagI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=C7qVzlwkCcpETBBZdfdPbzQltcDYgS92PuSOe3sCLf5py/I3gvcNhXoOlpyopq4hvo/olAreSrJzVeHtc3b5tllKa4Lo4+Dor3u6vQuSAaQ4U8vbyDKDfhbDgN3UmhpnrwZBNh8RcNt3BKSFkSqUaS4cn7FjkgfaFqC+vZQYZJ0=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EZg8wE8g
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 741574BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=EZg8wE8g
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260716065859812.ELIQ.44671.HP-Z230@nifty.com>;
          Thu, 16 Jul 2026 15:58:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
Date: Thu, 16 Jul 2026 15:58:43 +0900
Message-ID: <20260716065852.11502-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784185139;
 bh=pFUNDZFKybScWuyGnyc2jLfGznrIuLhOI71DCoorQ+s=;
 h=From:To:Cc:Subject:Date;
 b=EZg8wE8gWE75u8D58jn8YMF9h1/kIWs/G2iEIpr+0IwtIf/yUipkaEpM+dEvwjaKZwDWJVDW
 q7jzjutabAeF41ZAp2qpkJVCYLfZSO0mYpHKTfloKHYMVDvlcXthYurYrgDzIbErBpD1ffchgi
 H/IJ1BSlt5ILFztpcm2FDHdkq06/fB8+dRYGMNi8dX2rITgh2oFoKD41e1bNtPanzAWWO6iec4
 CfWxKUVfizUhdnE4bOCnBwHTFeFzdJTnmyXxbVG4EHZrLwV9lBu5D2HYLrd/R3Pqdp206Fr5/t
 Bb62IHBrwOmyPciYHaMSI2FOnH3YDexPsTUtQzsqxOhv9pEw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, if two non-cygwin apps are started and one of them
exits first, the other one loosed appropriate console mode, since
the first one restored it to tty::cygwin. This patch counts the
active console process whose pgid is pgid of the tty and if the
result is zero (means the last non-cygwin foreground process),
restore console mode. To avoid race issue between non-cygwin apps
exiting simultaneously, this patch also introduce a named mutex
used only in (setup|cleanup)_for_non_cygwin_app().

Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Stop counting up/down the counter by itself.
    Use num_active_non_cygwin_apps() instead.
v3: Guard setup_for_non_cygwin_app() by cons_mode_mutex as well.

 winsup/cygwin/fhandler/console.cc | 52 +++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d4c87f29f..62650726d 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -977,15 +977,65 @@ fhandler_console::setup_for_non_cygwin_app ()
      console mode. */
   if (get_ttyp ()->getpgid () == myself->pgid)
     {
+      char buf[MAX_PATH];
+      shared_name (buf, "cygcons.cons_mode.mutex", unit);
+      HANDLE cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
+      WaitForSingleObject (cons_mode_mutex, INFINITE);
       set_disable_master_thread (true, this);
       set_input_mode (tty::native, &tc ()->ti, get_handle_set ());
       set_output_mode (tty::native, &tc ()->ti, get_handle_set ());
+      ReleaseMutex (cons_mode_mutex);
+      CloseHandle (cons_mode_mutex);
     }
 }
 
+static int
+num_active_non_cygwin_apps (pid_t pgid)
+{
+  tmp_pathbuf tp;
+  DWORD *list = (DWORD *) tp.c_get ();
+  const DWORD buf_size = NT_MAX_PATH / sizeof (DWORD);
+
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
+    return 0;
+
+  int cnt = 0;
+  for (DWORD i = 0; i < num; i++)
+    {
+      pinfo p (cygwin_pid (list[i]));
+      if (!!p && p->pgid == pgid && ISSTATE (p, PID_NOTCYGWIN))
+	cnt++;
+    }
+  return cnt;
+}
+
 void
 fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
 {
+  if (cygheap->ctty->tc()->pgid != myself->pgid)
+    return;
+  char buf[MAX_PATH];
+  shared_name (buf, "cygcons.cons_mode.mutex", p->unit);
+  HANDLE cons_mode_mutex = CreateMutex (&sec_none, FALSE, buf);
+  WaitForSingleObject (cons_mode_mutex, INFINITE);
+  if (num_active_non_cygwin_apps (cygheap->ctty->tc()->pgid))
+    {
+      ReleaseMutex (cons_mode_mutex);
+      CloseHandle (cons_mode_mutex);
+      return;
+    }
+
   const _minor_t unit = p->unit;
   termios dummy = {0, };
   termios *ti = shared_console_info[unit] ?
@@ -999,6 +1049,8 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
+  ReleaseMutex (cons_mode_mutex);
+  CloseHandle (cons_mode_mutex);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
-- 
2.51.0

