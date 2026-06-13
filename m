Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 579F84BB3BCC
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 14:09:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 579F84BB3BCC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 579F84BB3BCC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781359778; cv=none;
	b=vNW74BY9uJOUboiIoAO0wWWZRqcYC/GKakEVY/ZNziN6Jp+dWVpvo/HyaxJUHQcnQDYsIIb3X1eSk8udqVu5Trk/ro0UzUp/oI0JcFlp2wdz6XS0C7HkfUS5rXqRrC91bo3IVYF9COsKBRW+46VGtUSmM9wv4wDLeZSwmgvxRLQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781359778; c=relaxed/simple;
	bh=ONHjiuJC01olCEu11ZBDnonn+DgY1kVlLpJw+mWiffU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BgxQhTj7wClupX2hLaQKG6fy/+rO4DkCngq3H+imLkmphFX8OUYEung2QdPVY62kbaPdw7eyuAOQ6TvrOPHac9382T1FvMsVrwyls+1bQhNpOH3ucG1J4o+VWNqSl34xsatukukyKYpoBtRXohRm/VdECzqLrcReQrxW4uzK2qE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nTvgg8OE
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 579F84BB3BCC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=nTvgg8OE
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260613140935667.XZAS.102121.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 23:09:35 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when discard_input is called.
Date: Sat, 13 Jun 2026 23:09:01 +0900
Message-ID: <20260613140917.27155-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
References: <20260613140917.27155-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781359775;
 bh=BrdPa7u0Xn9gnfj73Ox5lW/3Xj3Vwx85rkyAcbAV/7k=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nTvgg8OEQ6eJKd77rcjNYTmt0Vuzl+bmwzItsYmsX+EhM0TKOg6JdO/AqgfcHzfpYm5YZMov
 i2P+sfv/UbpMrLDNFYgJJArwmbgA7nZA8X1Bgs/I/+uRpps1G2g5R3+RNq9vAvIDLd1Gt73XEf
 aFoedn0EuX2fR+I4B+rNRbQEQDQj2GKEyncxefSCAaP/H9ZOvnVlBgVoDI0nL+DLdAuMblWCDt
 yPa0iYrHHunFgHZZootVoIAn/4Kb67I76lHNdVHdRAN/+Y9MiqLgaTT74qp597vkat5q/kHEXb
 db1DtW8fqzrwe4h2t7V/5n/+vcuRir6aMHsxFeuoTGGQFIcA==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, the process on pty could not be a child of non-cygwin
process. So, it is not necessary to flush pcon input buffer even
when discard_input() is called. However, now, the child process
of non-cygwin app on pseudo console is running on pty. So,
discard_input() should affect to the pcon input buffer as well.

This prevents the probelm:
  1) Run 'sleep 10' in cmd.exe
  2) Enter 'ps\n' while sleeping
  3) Press Ctrl-C
  4) 'ps' will be executed after terminating 'sleep' by Ctrl-C.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviwed-by:
---
 winsup/cygwin/fhandler/pty.cc | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index d625ff9df..b3a8d57cc 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -583,6 +583,14 @@ fhandler_pty_master::discard_input ()
   if (!get_ttyp ()->pcon_activated)
     while (::bytes_available (bytes_in_pipe, from_master_nat) && bytes_in_pipe)
       ReadFile (from_master_nat, buf, sizeof(buf), &n, NULL);
+  else
+    {
+      DWORD target_pid = get_ttyp ()->nat_pipe_owner_pid;
+      DWORD resume_pid =
+	fhandler_pty_common::attach_console_temporarily (target_pid);
+      FlushConsoleInputBuffer (h_pcon_in_dupped);
+      fhandler_pty_common::resume_from_temporarily_attach (resume_pid);
+    }
   get_ttyp ()->discard_input = true;
   ReleaseMutex (input_mutex);
 }
@@ -2585,7 +2593,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       for (size_t i = 0, j = 0; i < len; i++)
 	{
 	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
-	  if (r != done_with_debugger)
+	  if (r != done_with_debugger &&
+	      (r != signalled || (ti.c_lflag & NOFLSH) || buf[i] == '\003'))
 	    {
 	      char c = buf[i];
 	      /* Workaround for pseudo console in Windows 11 */
-- 
2.51.0

