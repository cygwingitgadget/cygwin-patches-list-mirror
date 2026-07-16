Return-Path: <SRS0=Gzk2=FK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id F00634BA5435
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 06:22:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F00634BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F00634BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784182970; cv=none;
	b=LVft6zD8ZLUVrJv8owpnU8jPQRymCCxFt0av1vUgOXArUw3UUHhTAhLI/kpM+EEzCu+WlZ5xoJEaVGS8ODQGLle97chtZEZ1PXVGgENJp8ftb2YxwY1LNfE9x/ky1Um0sXFAVEuuFiLOgfMtOYaChQMC9atzcIJKDPumyFpce3A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784182970; c=relaxed/simple;
	bh=8kOClzsUjZcPSQYcD6LX9jNtc86OXVL6O6R/+KmW0U4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=VDx4FTUGuyVaIq46LnhS700jRAmkf1gTJ0ENZdHQkWqauCgvATqtk3h3u1DCcW9uEJ+kwn2DOLYaaHTc5Ri0jYLqDLlAHHc5cYoOnCVFrEqXhnz2Ae+tpenZthFFYN/E5IX+gsc1THUzTIuimmUvR78DLWNj6ceF0M8g2q0PvVY=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FjUeNu9E
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F00634BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FjUeNu9E
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260716062245532.OSCP.17441.HP-Z230@nifty.com>;
          Thu, 16 Jul 2026 15:22:45 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: console: Fix undesired mode change at exit of non-cygwin apps
Date: Thu, 16 Jul 2026 15:22:27 +0900
Message-ID: <20260716062236.1916-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1784182965;
 bh=m0N4pnhgS7AB2ZIa+PyYG7oNaLEg/HJu8cpctF5oRSg=;
 h=From:To:Cc:Subject:Date;
 b=FjUeNu9EwCgBuqllAVXOeRXAekM8kscgiv9fskmmsSbPWdAckAOT1xTIvNSbC7ywg4a/wpkg
 /vSmp9cxeE2fdfe4elxOcLlqsZQ029mTU22TfsCdvcY3S6YC+RdTqKbuZSkHLNKWvXBnKLl41d
 xfEnoi9De5dJ4Ezp8xBEyPsZkz9fw7N041VAMEfe8XeJ3s3ixiq6kD8lUKergSj/U7EAD9qSk1
 yTb9RvtxAFeop/D/YWjPE6WO5Rus6ihk/OdxbM8M/dA/OJz1h7gU9m5qwwKZlyBzOEGtA5kmJA
 qGLzMxE4p3wZWPIEYTzzr7G2M1oCWt3+nlftpEjDUe7jmD9g==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, if two non-cygwin apps are started and one of them
exits first, the other one loosed appropriate console mode, since
the first one restored it to tty::cygwin. This patch counts the
active console process whose pgid is pgid of the tty and if the
result is zero (means the last non-cygwin foreground process),
restore console mode. To avoid race issue between non-cygwin apps
exiting simultaneously, this patch also introduce a named mutex
used only in cleanup_for_non_cygwin_app().

Fixes: 48285aa36c2c ("Cygwin: console: Fix handling of Ctrl-S in Win7.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Stop counting up/down the counter by itself.
    Use num_active_non_cygwin_apps() instead.

 winsup/cygwin/fhandler/console.cc | 46 +++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index d4c87f29f..7001024a0 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -983,9 +983,53 @@ fhandler_console::setup_for_non_cygwin_app ()
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
@@ -999,6 +1043,8 @@ fhandler_console::cleanup_for_non_cygwin_app (handle_set_t *p)
     set_output_mode (conmode, ti, p);
   if (con.curr_input_mode != conmode)
     set_input_mode (conmode, ti, p);
+  ReleaseMutex (cons_mode_mutex);
+  CloseHandle (cons_mode_mutex);
 }
 
 /* Return the tty structure associated with a given tty number.  If the
-- 
2.51.0

