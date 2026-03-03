Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 397764BAE7CE
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 11:39:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 397764BAE7CE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 397764BAE7CE
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772537968; cv=none;
	b=FjQzoNvRGA6SUlvZfY1FAKoCO9uztGhnarh05kTeXPjxILH+YGbDF3VrQaysHx6QoaJcb95d33f/oFhCsPjF4k4iGyhdkueEgb97FKSxqQeT4LRcg7pd0zy45+SeLdFBW2VA7Bwykm+YR+93YE+bcsY6mQwKNCOCRACRH7b01Uk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772537968; c=relaxed/simple;
	bh=hTF/PxuAv9Beu6mxMfVTEi1O3rrvNWYjICR1aJOJjfk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=e3zdIdxuHf8BGpMqpPw3OSLMkuDN6nJm7de6nvNVAdihUebI71bbXm5XcTc2pwMUz11BmL0EwUFJLNOSetbpzL1jcWws9FMq2DOgmXloHjd2boVRf6C9iak0uqXdKK1BrXJXTRPFzpoElQjahEm0NE1IHS1Vy8rPtZy1uNllc3g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 397764BAE7CE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=CHMSiB80
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260303113926450.WEQJ.19957.HP-Z230@nifty.com>;
          Tue, 3 Mar 2026 20:39:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v3] Cygwin: pty: Fix handling of data after CSI6n response
Date: Tue,  3 Mar 2026 20:39:08 +0900
Message-ID: <20260303113918.25905-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772537966;
 bh=C1kxot1CbnbF/4ASMxzIe5cnPtyzdaM0oCvS2mFx/GI=;
 h=From:To:Cc:Subject:Date;
 b=CHMSiB803tEDKxJysoI7ESMe0CKa6rLc1ix+LKibdpYC3h3tccZUrQO1zyk7iTaRGLugF6Mz
 XdW/z0xoihR6iH/BSixBpJo0mo91sloSOYL3Ukw7+EsLBVugm7KYn8T+eDNBz+bbx7r+i0p65o
 niJxMzFulZUr2NXykVyxNsfuBuaBQQGOClC4M1mOn29i+tyDMFK/FTM2/JpA+jQAM1V2NHdsH1
 cWzwbGWlta3INc20e2OLG6yTbUhUGe+gQbu+ER1xtcacK2xY7CXucZ6pjcjewxi9cdcx+ZteZo
 Sp2tlEtZtNt9R//adLWrx4ILprd8TdYA3A+g20imHMhHw3Xw==
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/pty.cc | 40 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index b59f54096..2c4b5bdbe 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
 ssize_t
 fhandler_pty_master::write (const void *ptr, size_t len)
 {
+  size_t orig_len = len;
+
   ssize_t ret;
   char *p = (char *) ptr;
   termios &ti = tc ()->ti;
@@ -2160,6 +2162,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
       DWORD n;
       WaitForSingleObject (input_mutex, mutex_timeout);
+      len = 0;
       for (size_t i = 0; i < len; i++)
 	{
 	  if (p[i] == '\033')
@@ -2185,18 +2188,21 @@ fhandler_pty_master::write (const void *ptr, size_t len)
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
+	      len = orig_len - i - 1;
+	      ptr = p + i + 1;
+	      ixput = 0;
+	      state = 0;
+	      get_ttyp ()->req_xfer_input = false;
+	      get_ttyp ()->pcon_start = false;
+	      break;
+	    }
 	}
       ReleaseMutex (input_mutex);
 
@@ -2220,8 +2226,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
-
-      return len;
+      if (len == 0)
+	return orig_len;
     }
 
   /* Write terminal input to to_slave_nat pipe instead of output_handle
@@ -2261,7 +2267,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
       ReleaseMutex (input_mutex);
 
-      return len;
+      return orig_len;
     }
 
   /* The code path reaches here when pseudo console is not activated
@@ -2283,8 +2289,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   ReleaseMutex (input_mutex);
 
   if (status > line_edit_signalled && status != line_edit_pipe_full)
-    ret = -1;
-  return ret;
+    return -1;
+  return orig_len - len + ret;
 }
 
 void
-- 
2.51.0

