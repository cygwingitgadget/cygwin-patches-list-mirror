Return-Path: <SRS0=RYfm=3K=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w08.mail.nifty.com (mta-snd-w08.mail.nifty.com [106.153.227.40])
	by sourceware.org (Postfix) with ESMTPS id 795983858CD1
	for <cygwin-patches@cygwin.com>; Sat, 30 Aug 2025 03:04:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 795983858CD1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 795983858CD1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1756523043; cv=none;
	b=UfXLb9J7JLjEjOcNhM0z9AETvzsaO9D+pC4liTT+21Tr4paxkJccRFST0hBe7l7k0rq9bEf/ct60eQuDlZ4Xf+VkIz1Cr175RFbyEYp5CCpx9YnAPuFOml+3Flmx86HfcES5SkOQ36QtCBuci5pPce6po6IOqGN7RR4w9EyZc9c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756523043; c=relaxed/simple;
	bh=rnk8M0SSOP7wTT0CqMNmbzAfrePlGW5Bx8Dt625glek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ILxgoT90+HeoC0X357ZbbQhtNUSZvykleDxYSzm2WMiL58XjqANzw+7n8AEqMyccUZDJZklGGc1/mSTBEoTd0lrMkIYf1ryzAeUZFBqEkh5kzmHGkY7iIYu56sUSSl2gFB68jYvkmDyG80P6UeMymzzQILehwFPudMgXEQnvC8E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 795983858CD1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ka3spUG4
Received: from localhost.localdomain by mta-snd-w08.mail.nifty.com
          with ESMTP
          id <20250830030400249.WZOJ.78984.localhost.localdomain@nifty.com>;
          Sat, 30 Aug 2025 12:04:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	"Reported-by : Thomas Wolff" <towo@towo.net>
Subject: [PATCH] Cygwin: pty: Fix FLUSHO handling
Date: Sat, 30 Aug 2025 12:03:34 +0900
Message-ID: <20250830030342.918-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1756523040;
 bh=MlYNLWq205/ZiLlKoUveosIUHxp7zX8nUlwt7ordImI=;
 h=From:To:Cc:Subject:Date;
 b=ka3spUG4lU19Q4lhgBKXOZAMzzUWTiHvR2U6KivWkgGStNWgvkE5a1aTrrOjD+IkDw9PA+Nn
 JLH3jpHswG3f8hzEZVQUzm+JMUMAfViPwRO32H9Xvn0s/rweymidIx5YEEUVxnrq3z9cDdpFpC
 r0Z6JKgbn+Kfrik9RxRiY26hahd3OacdSBjqP1vfmsAAVAifXC7mpMYfhQ7kLbXu+6DQfKGlkZ
 Kf9MTWygzFVqQ4/ouLIEPYvBRO72FTRDb8cixZ3GOjWfc8gP5Rr0JUNawzBvK516jzSCPIs4OX
 lMKWpUrboi4aLuQ3RG/tm3mD3uTD1zVzHj/9qLz7LRPPmqXw==
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previsouly, FLUSHO did not work correctly.
 1) Even when FLUSHO is set, read() returns with undesired data in
    the pipe if select() is called in advance.
 2) FLUSHO is toggled even in the case pseudo console enabled.
Due to these problems, read data in the pty master was partially
lost when Ctrl-O is pressed.

With this patch, the mask_flusho flag, that was introduced by the
commit 9677efcf005a and caused the issue 1), has been dropped and
select() and read() for pty master discards the pipe data instead
if FLUSHO flag is set.  In addition, FLUSHO handling in the case
pseudo console activated is disabled.

Addresses: https://cygwin.com/pipermail/cygwin/2025-August/258717.html
Fixes: 2cab4d0bb4af ("Cygwin: pty, console: Refactor the code processing special keys.")
Fixes: 9677efcf005a ("Cygwin: pty: Make FLUSHO and Ctrl-O work.")
Reported-by: Reported-by: Thomas Wolff <towo@towo.net>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc           |  6 +-----
 winsup/cygwin/local_includes/fhandler.h |  1 -
 winsup/cygwin/local_includes/tty.h      |  1 -
 winsup/cygwin/select.cc                 | 16 +++++++++++-----
 winsup/cygwin/tty.cc                    |  1 -
 5 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 77a363eb0..679068ea2 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -693,8 +693,7 @@ fhandler_pty_master::process_slave_output (char *buf, size_t len, int pktmode_on
 
       termios_printf ("bytes read %u", n);
 
-      if (!buf || ((get_ttyp ()->ti.c_lflag & FLUSHO)
-		   && !get_ttyp ()->mask_flusho))
+      if (!buf || (get_ttyp ()->ti.c_lflag & FLUSHO))
 	continue; /* Discard read data */
 
       memcpy (optr, outbuf, n);
@@ -714,8 +713,6 @@ fhandler_pty_master::process_slave_output (char *buf, size_t len, int pktmode_on
     }
 
 out:
-  if (buf)
-    set_mask_flusho (false);
   termios_printf ("returning %d", rc);
   return rc;
 }
@@ -2256,7 +2253,6 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	      nlen--;
 	      i--;
 	    }
-	  process_stop_start (buf[i], get_ttyp ());
 	}
 
       DWORD n;
diff --git a/winsup/cygwin/local_includes/fhandler.h b/winsup/cygwin/local_includes/fhandler.h
index 4db2964fe..bdd87ebb7 100644
--- a/winsup/cygwin/local_includes/fhandler.h
+++ b/winsup/cygwin/local_includes/fhandler.h
@@ -2625,7 +2625,6 @@ public:
   }
   void get_master_thread_param (master_thread_param_t *p);
   void get_master_fwd_thread_param (master_fwd_thread_param_t *p);
-  void set_mask_flusho (bool m) { get_ttyp ()->mask_flusho = m; }
   bool need_send_ctrl_c_event ();
 };
 
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index a418ab1f9..9485e24c5 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -139,7 +139,6 @@ private:
   bool master_is_running_as_service;
   bool req_xfer_input;
   xfer_dir pty_input_state;
-  bool mask_flusho;
   bool discard_input;
   bool stop_fwd_thread;
 
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index a7e82a024..8a94ac076 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -689,6 +689,8 @@ pipe_data_available (int fd, fhandler_base *fh, HANDLE h, int mode)
   return 0;
 }
 
+SRWLOCK ptym_peek_lock = SRWLOCK_INIT;
+
 static int
 peek_pipe (select_record *s, bool from_select)
 {
@@ -730,10 +732,19 @@ peek_pipe (select_record *s, bool from_select)
 	  gotone = s->read_ready = true;
 	  goto out;
 	}
+      if (fh->get_major () == DEV_PTYM_MAJOR)
+	AcquireSRWLockExclusive (&ptym_peek_lock);
       ssize_t n = pipe_data_available (s->fd, fh, h, PDA_READ);
       /* On PTY masters, check if input from the echo pipe is available. */
       if (n == 0 && fh->get_echo_handle ())
 	n = pipe_data_available (s->fd, fh, fh->get_echo_handle (), PDA_READ);
+      if (fh->get_major () == DEV_PTYM_MAJOR)
+	{
+	  fhandler_pty_master *fhm = (fhandler_pty_master *) fh;
+	  while (n > 0 && (fhm->tc ()->ti.c_lflag & FLUSHO))
+	    n = fhm->process_slave_output (NULL, n, 0); /* Discard pipe data */
+	  ReleaseSRWLockExclusive (&ptym_peek_lock);
+	}
 
       if (n == PDA_ERROR)
 	{
@@ -759,11 +770,6 @@ peek_pipe (select_record *s, bool from_select)
     }
 
 out:
-  if (fh->get_major () == DEV_PTYM_MAJOR)
-    {
-      fhandler_pty_master *fhm = (fhandler_pty_master *) fh;
-      fhm->set_mask_flusho (s->read_ready);
-    }
   h = fh->get_output_handle ();
   if (s->write_selected && dev != FH_PIPER)
     {
diff --git a/winsup/cygwin/tty.cc b/winsup/cygwin/tty.cc
index a4b716721..0c49dc2bd 100644
--- a/winsup/cygwin/tty.cc
+++ b/winsup/cygwin/tty.cc
@@ -253,7 +253,6 @@ tty::init ()
   req_xfer_input = false;
   pty_input_state = to_cyg;
   last_sig = 0;
-  mask_flusho = false;
   discard_input = false;
   stop_fwd_thread = false;
 }
-- 
2.45.1

