Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
 by sourceware.org (Postfix) with ESMTPS id 7A5763858415
 for <cygwin-patches@cygwin.com>; Tue,  7 Sep 2021 10:28:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7A5763858415
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from localhost.localdomain (z221123.dynamic.ppp.asahi-net.or.jp
 [110.4.221.123]) (authenticated)
 by conuserg-08.nifty.com with ESMTP id 187ARsf3013879;
 Tue, 7 Sep 2021 19:27:59 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 187ARsf3013879
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1631010479;
 bh=M8pN+6J3eP2mpV5U7PbCxw/iq0TqQIp3c4As2p9NghE=;
 h=From:To:Cc:Subject:Date:From;
 b=BYg4K9/NjkFoSeREeUtB6FXp69VlzTDDDrc5qGTOVOG/UheyWcSBI16tgfdxDiJ1R
 FHILbjdPq+ygu2ZPyufYa9mi626ze701xRvLwgTiaouTuHYTuaqAW7co5BF9OUGlRE
 M19uSIkzosEo6cuZ3B83eK7KeX0Q3oJrm+B7KhqJFHPkZZbhtxSs1IaK5/HMtnfVw3
 SXQoTJhlXcZBRZglYiQrqbQ6YuMGQNHHWS+pC95geHSiKEm/ciMYf2FvF6oySRlckH
 SiFtEF4fUHSckYfcllYGz2Pnyxj9qhyLH6uXWU2yto86PVjm/LdXu7Jk4Zs3DD3tfm
 IJc0n6+LMk16Q==
X-Nifty-SrcIP: [110.4.221.123]
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pty: Fix error handling of master write().
Date: Tue,  7 Sep 2021 19:27:45 +0900
Message-Id: <20210907102745.1149-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Tue, 07 Sep 2021 10:28:27 -0000

- Currently, error handling of write() in pty master side is broken.
  This patch fixes that.
---
 winsup/cygwin/fhandler_termios.cc | 24 +++++++++++-------------
 winsup/cygwin/fhandler_tty.cc     | 11 +++++++----
 2 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler_termios.cc b/winsup/cygwin/fhandler_termios.cc
index b487acab3..012ecb356 100644
--- a/winsup/cygwin/fhandler_termios.cc
+++ b/winsup/cygwin/fhandler_termios.cc
@@ -308,12 +308,12 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
   int input_done = 0;
   bool sawsig = false;
   int iscanon = ti.c_lflag & ICANON;
+  size_t read_cnt = 0;
 
-  if (bytes_read)
-    *bytes_read = nread;
-  while (nread-- > 0)
+  while (read_cnt < nread)
     {
       c = *rptr++;
+      read_cnt++;
 
       paranoid_printf ("char %0o", c);
 
@@ -453,7 +453,6 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
 	  if (status != 1)
 	    {
 	      ret = status ? line_edit_error : line_edit_pipe_full;
-	      nread += ralen ();
 	      break;
 	    }
 	  ret = line_edit_input_done;
@@ -462,22 +461,21 @@ fhandler_termios::line_edit (const char *rptr, size_t nread, termios& ti,
     }
 
   /* If we didn't write all bytes in non-canonical mode, write them now. */
-  if (!iscanon && ralen () > 0
-      && (ret == line_edit_ok || ret == line_edit_input_done))
+  if ((input_done || !iscanon) && ralen () > 0 && ret != line_edit_error)
     {
-      int status = accept_input ();
+      int status;
+      int retry_count = 3;
+      while ((status = accept_input ()) != 1 &&
+	     ralen () > 0 && --retry_count > 0)
+	cygwait ((DWORD) 10);
       if (status != 1)
-	{
-	  ret = status ? line_edit_error : line_edit_pipe_full;
-	  nread += ralen ();
-	}
+	ret = status ? line_edit_error : line_edit_pipe_full;
       else
 	ret = line_edit_input_done;
     }
 
-  /* Adding one compensates for the postdecrement in the above loop. */
   if (bytes_read)
-    *bytes_read -= (nread + 1);
+    *bytes_read = read_cnt;
 
   if (sawsig)
     ret = line_edit_signalled;
diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index f2ac26892..1ea9a47ac 100644
--- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -561,18 +561,21 @@ fhandler_pty_master::accept_input ()
 	{
 	  n = p1 - p0 + 1;
 	  rc = WriteFile (write_to, p0, n, &n, NULL);
-	  written += n;
+	  if (rc)
+	    written += n;
 	  p0 = p1 + 1;
 	}
-      if ((n = bytes_left - (p0 - p)))
+      if (rc && (n = bytes_left - (p0 - p)))
 	{
 	  rc = WriteFile (write_to, p0, n, &n, NULL);
-	  written += n;
+	  if (rc)
+	    written += n;
 	}
-      if (!rc)
+      if (!rc && written == 0)
 	{
 	  debug_printf ("error writing to pipe %p %E", write_to);
 	  get_ttyp ()->read_retval = -1;
+	  puts_readahead (p, bytes_left);
 	  ret = -1;
 	}
       else
-- 
2.33.0

