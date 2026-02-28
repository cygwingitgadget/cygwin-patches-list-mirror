Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id 8D4C24BA23C2
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:01:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8D4C24BA23C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8D4C24BA23C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269277; cv=none;
	b=ICBieDROCa/04VRTeqxac3eCU3gXAMhEllC+gTIwiKaeEIez8ylu+5wh8pZ7DIEsCDjBq1PlqfsgAaKR/GpHS/gqo9DMJmkmfKALyDpAglJyzO2nN+Uhbcb6IYF4qIdOwHOMFqeW5WuSLjbm4eEMYu9G3JPWES+Lcg3ageeFfuQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269277; c=relaxed/simple;
	bh=V1+xICckJuLrUyjjQWg61GjOo9L+py7eXQLw4uPtiJM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=sFXfdnodw4oH/SvBC5p11cQQg2eO/gUGKTp2s0MuwFOfua/kQd6GG+zrbw5VzaIhVxYxiUXndsrxTfxpEcAgHHVB7YDf9ILub+JDFbMVC3UlqHCv0t1yPj9WYjYyZO8XVEmfBLjwdS604ch+ohlMOKdZxsE8nYSxfMdxzWEaRUQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8D4C24BA23C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=p0wnY6LC
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260228090114541.CMKU.84842.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:01:14 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pty: Fix handling of data after CSI6n response
Date: Sat, 28 Feb 2026 18:00:58 +0900
Message-ID: <20260228090107.2529-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269274;
 bh=jK7no9kb4Yj1hZfwRv+9J9i9oA7LJPmrdO/k+5FbSac=;
 h=From:To:Cc:Subject:Date;
 b=p0wnY6LCs4H+wd4994Oh6NDKhDX3qro3Y1YXO68unKjlH0WpeZ06bmsgE2kFUEnWlwqBF9xk
 tyWwyFgdlWs4HnsNpCT21S12VezCXw2P6eTmLpkRQEINZUlw1qwqCgAEfRgde3q/Fi0dnwqAoz
 nzJ0Mb8VQ+uTjBoFkKReZaMEWNRXO4tRG9r9uHpuo/S0JW8G/q87pWXA2Mo7wt9yHhVzpEOBvl
 4d1BqSzhGka5dmJYTtjvjazg5iKIdEthX4QjUexVAqG7mmYWwQs4Tqj8/bysJ+MHM6o1twJLnC
 PrFF7SMZbMaIG59z79dFv+5HgsCix/K4+SWR2c7DCkw55aOg==
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, CSI6n was not handled correctly if the some sequences
are appended after the response for CSI6n. Especially, if the
appended sequence is a ESC sequence, which is longer than the
expected maximum length of the CSI6n response, the sequence will
not be written atomically.

Moreover, when the terminal's CSI 6n response and subsequent data
(e.g. keystrokes) arrive in the same write buffer, master::write()
processes all of it inside the pcon_start loop and returns early.
Bytes after the 'R' terminator go through per-byte line_edit() in
that loop instead of falling through to the `nat` pipe fast path
or the normal bulk `line_edit()` call. Due to this behaviour,
the chance of code conversion to the terminal code page for the
subsequent data in `to_be_read_from_nat_pipe()` case, will be lost.

Fix this by breaking out of the loop when 'R' is found and letting
the remaining data fall through to the normal write paths, which
are now reachable because `pcon_start` has been cleared.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 47 +++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 22 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 838be4a2b..34a87c6dc 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
 ssize_t
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
+  size_t towrite = len;
+
   ssize_t ret;
   char *p = (char *) ptr;
   termios &ti = tc ()->ti;
@@ -2160,6 +2162,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
       DWORD n;
       WaitForSingleObject (input_mutex, mutex_timeout);
+      towrite = 0;
       for (size_t i = 0; i < len; i++)
 	{
 	  if (p[i] == '\033')
@@ -2171,32 +2174,33 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  if (state == 1)
 	    {
-	      if (ixput < wpbuf_len)
-		wpbuf[ixput++] = p[i];
-	      else
+	      if (ixput == wpbuf_len)
 		{
 		  if (!get_ttyp ()->req_xfer_input)
 		    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
 		  ixput = 0;
-		  wpbuf[ixput++] = p[i];
 		}
+	      wpbuf[ixput++] = p[i];
 	    }
 	  else
 	    line_edit (p + i, 1, ti, &ret);
 	  if (state == 1 && p[i] == 'R')
 	    state = 2;
-	}
-      if (state == 2)
-	{
-	  /* req_xfer_input is true if "ESC[6n" was sent just for
-	     triggering transfer_input() in master. In this case,
-	     the responce sequence should not be written. */
-	  if (!get_ttyp ()->req_xfer_input)
-	    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
-	  ixput = 0;
-	  state = 0;
-	  get_ttyp ()->req_xfer_input = false;
-	  get_ttyp ()->pcon_start = false;
+	  if (state == 2)
+	    {
+	      /* req_xfer_input is true if "ESC[6n" was sent just for
+		 triggering transfer_input() in master. In this case,
+		 the response sequence should not be written. */
+	      if (!get_ttyp ()->req_xfer_input)
+		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
+	      towrite = len - i - 1;
+	      ptr = p + i + 1;
+	      ixput = 0;
+	      state = 0;
+	      get_ttyp ()->req_xfer_input = false;
+	      get_ttyp ()->pcon_start = false;
+	      break;
+	    }
 	}
       ReleaseMutex (input_mutex);
 
@@ -2220,8 +2224,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
-
-      return len;
+      if (towrite == 0)
+	return len;
     }
 
   /* Write terminal input to to_slave_nat pipe instead of output_handle
@@ -2233,15 +2237,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	 is activated. */
       tmp_pathbuf tp;
       char *buf = (char *) ptr;
-      size_t nlen = len;
+      size_t nlen = towrite;
       if (get_ttyp ()->term_code_page != CP_UTF8)
 	{
 	  static mbstate_t mbp;
 	  buf = tp.c_get ();
 	  nlen = NT_MAX_PATH;
-	  convert_mb_str (CP_UTF8, buf, &nlen,
-			  get_ttyp ()->term_code_page, (const char *) ptr, len,
-			  &mbp);
+	  convert_mb_str (CP_UTF8, buf, &nlen, get_ttyp ()->term_code_page,
+			  (const char *) ptr, towrite, &mbp);
 	}
 
       for (size_t i = 0; i < nlen; i++)
-- 
2.51.0

