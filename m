Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id D730C4BA2E1C
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 07:48:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D730C4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D730C4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766130521; cv=none;
	b=GxgnKehpaOU1kOwpUqEhINJi39hpWNiBwLIUWkBRoNF+RBIw+Sc7z6AvoEF0JEMD4oFVO+LNNQwQBhC5FG3VbAvJOLWvGfEj7GwAfbk/Toq+kXPmZmRaJLpMOWwEkMd/Nsjhox5myg2G6LkTm+k4EBgOh3Vz3EL2eCrsGzgEPls=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766130521; c=relaxed/simple;
	bh=+wQpdP7fZBrMqSdrSxLw1g4LMgwFnrKMLrS22yBgDSU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=fb06DJ/58b7MMLAkbCrXUhxdGxCLTIrZEEYicKq+ZLu2f/chIvQEZJCvJgvuZl9obT//K/pUL9nZIVgn6TiHuZOzAk468WwA5cKsgf1soqEqyaz8hzGgVU26mg2/csP8i1WCVdC25H57q6e4Mv+ydIMBIBxpzHPHrH5glyEfmiA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D730C4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=h9yPVzgC
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20251219074838897.IHER.52630.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 16:48:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Cygwin: pty: Refactor workaround code for pseudo console output
Date: Fri, 19 Dec 2025 16:48:21 +0900
Message-ID: <20251219074831.953-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766130518;
 bh=KdrnWuHhgA9tHOma7NQAi2qcNUuVm+GecYhsghV7EqU=;
 h=From:To:Cc:Subject:Date;
 b=h9yPVzgCl9rtLf5CoYoCk1m4oWY6RGpGHjaBxAdUNqK+gSndDFuaRkpjhWVP8POZ6dUHfDpd
 kqjbRb55OmGphJYK7VRb+vTjgNIBc9AtFykR4RRUmZn0r2tNpCDKBt9u3hNUd3RoMw4c5RNhmz
 U4KUKS/36cp5PDVgYfmosI2OGDo0OFAMm6QU0ddh9kaoBQrZiO1MZxHjWTsp/VbDvyAyKJNFRG
 keIJ6NIVUbsVFIcqlLmmQqysf8KLoEQQVFbN8nIRs6jkCdII1XAi7iQwD13nEDJioy3/8Vd40O
 1q/LGLG/fgnBOWzNbXNoEZBJuO+ixzBRc7C17IH8Zq05TLxQ==
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_BL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, there are four separate workarounds for pseudo console
output in pty_master_fwd_thread. Each workaround has its own 'for'
loop that iterates over the entire output buffer, which is not
efficient. This patch consolidates these loops and introduces a
single state machine to handle all worarounds at once. In addition,
the workarouds are moved into a dedicated function,
'workarounds_for_pseudo_console_output()' to improve readability.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 283 ++++++++++++++++------------------
 1 file changed, 129 insertions(+), 154 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 32e50540e..7fa747e0a 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2642,6 +2642,134 @@ pty_master_thread (VOID *arg)
   return fhandler_pty_master::pty_master_thread (&p);
 }
 
+static DWORD
+workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
+{
+  int state = 0;
+  int start_at = 0;
+  bool is_csi = false;
+  bool is_osc = false;
+  int arg = 0;
+  bool saw_greater_than_sign = false;
+  for (DWORD i=0; i<rlen; i++)
+    if (state == 0 && outbuf[i] == '\033')
+      {
+	start_at = i;
+	state = 1;
+	is_csi = false;
+	is_osc = false;
+	arg = 0;
+	continue;
+      }
+    else if (state == 1)
+      {
+	switch (outbuf[i])
+	  {
+	  case '[':
+	    is_csi = true;
+	    state = 2;
+	    break;
+	  case ']':
+	    is_osc = true;
+	    state = 2;
+	    break;
+	  case '\033':
+	    start_at = i;
+	    state = 1;
+	    break;
+	  default:
+	    state = 0;
+	  }
+	continue;
+      }
+    else if (is_csi)
+      {
+	if (state == 2 && outbuf[i] == '>')
+	  saw_greater_than_sign = true;
+	else if (state == 2 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
+	  continue;
+	else if (state == 2)
+	  {
+	    if (saw_greater_than_sign && outbuf[i] == 'm')
+	      {
+		/* Remove CSI > Pm m */
+		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		rlen = start_at + rlen - i - 1;
+		i = start_at - 1;
+		state = 0;
+	      }
+	    else if (wincap.has_pcon_omit_nl_before_cursor_move ()
+		     && !saw_greater_than_sign && outbuf[i] == 'H')
+	      /* Workaround for rlwrap in Win11. rlwrap treats text between
+		 NLs as a line, however, pseudo console in Win11 somtimes
+		 omits NL before "CSIm;nH". This does not happen in Win10. */
+	      {
+		/* Add omitted CR NL before "CSIm;nH". However, when the
+		   cusor is on the bottom-most line, adding NL might cause
+		   unexpected scrolling. To avoid this, add "CSI H" before
+		   CR NL. */
+		const char *ins = "\033[H\r\n";
+		const int ins_len = strlen (ins);
+		if (rlen + ins_len <= NT_MAX_PATH)
+		  {
+		    memmove (&outbuf[start_at + ins_len], &outbuf[start_at],
+			     rlen - start_at);
+		    memcpy (&outbuf[start_at], ins, ins_len);
+		    rlen += ins_len;
+		    i += ins_len;
+		  }
+	      }
+	    state = 0;
+	  }
+	else if (outbuf[i] == '\033')
+	  {
+	    start_at = i;
+	    is_csi = false;
+	    state = 1;
+	  }
+	else
+	  state = 0;
+      }
+    else if (is_osc)
+      {
+	if (state == 2 && isdigit (outbuf[i]))
+	  arg = arg * 10 + (outbuf[i] - '0');
+	else if (state == 2 && outbuf[i] == ';')
+	  state = 3;
+	else if (state == 3 && outbuf[i] == '\033')
+	  state = 4;
+	else if ((state == 3 && outbuf[i] == '\a')
+		 || (state == 4 && outbuf[i] == '\\'))
+	  {
+	    const char *helper_str = "\\bin\\cygwin-console-helper.exe";
+	    if (outbuf[start_at + 4] == '?' /* OSC Ps; ? BEL/ST */
+		/* Stray set title at the start up of pcon */
+		|| (arg == 0 && memmem (&outbuf[start_at], i + 1 - start_at,
+					helper_str, strlen (helper_str))))
+	      {
+		/* Remove this ESC sequence */
+		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		rlen = start_at + rlen - i - 1;
+		i = start_at - 1;
+	      }
+	    state = 0;
+	  }
+	else if (state == 3)
+	  continue;
+	else if (outbuf[i] == '\033')
+	  {
+	    start_at = i;
+	    is_osc = false;
+	    state = 1;
+	  }
+	else
+	  state = 0;
+      }
+    else
+      state = 0; /* Do not reach */
+  return rlen;
+}
+
 /* The function pty_master_fwd_thread() should be static because the
    instance is deleted if the master is dup()'ed and the original is
    closed. In this case, dup()'ed instance still exists, therefore,
@@ -2676,160 +2804,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
       char *ptr = outbuf;
       if (p->ttyp->pcon_activated)
 	{
-	  /* Avoid setting window title to "cygwin-console-helper.exe" */
-	  int state = 0;
-	  int start_at = 0;
-	  for (DWORD i=0; i<rlen; i++)
-	    if (state == 0 && outbuf[i] == '\033')
-	      {
-		start_at = i;
-		state = 1;
-		continue;
-	      }
-	    else if ((state == 1 && outbuf[i] == ']') ||
-		     (state == 2 && outbuf[i] == '0') ||
-		     (state == 3 && outbuf[i] == ';') ||
-		     (state == 4 && outbuf[i] == '\033'))
-	      {
-		state ++;
-		continue;
-	      }
-	    else if ((state == 4 && outbuf[i] == '\a')
-		     || (state == 5 && outbuf[i] == '\\'))
-	      {
-		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
-		if (memmem (&outbuf[start_at], i + 1 - start_at,
-			    helper_str, strlen (helper_str)))
-		  {
-		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
-		    rlen = wlen = start_at + rlen - i - 1;
-		    i = start_at - 1;
-		  }
-		state = 0;
-		continue;
-	      }
-	    else if (state == 4)
-	      continue;
-	    else if (outbuf[i] == '\033')
-	      {
-		start_at = i;
-		state = 1;
-		continue;
-	      }
-	    else
-	      {
-		state = 0;
-		continue;
-	      }
-
-	  /* Remove CSI > Pm m */
-	  state = 0;
-	  for (DWORD i = 0; i < rlen; i++)
-	    if (outbuf[i] == '\033')
-	      {
-		start_at = i;
-		state = 1;
-		continue;
-	      }
-	    else if ((state == 1 && outbuf[i] == '[')
-		     || (state == 2 && outbuf[i] == '>'))
-	      {
-		state ++;
-		continue;
-	      }
-	    else if (state == 3 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
-	      continue;
-	    else if (state == 3 && outbuf[i] == 'm')
-	      {
-		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
-		rlen = wlen = start_at + rlen - i - 1;
-		state = 0;
-		i = start_at - 1;
-		continue;
-	      }
-	    else
-	      state = 0;
-
-	  /* Remove OSC Ps ; ? BEL/ST */
-	  state = 0;
-	  for (DWORD i = 0; i < rlen; i++)
-	    if (state == 0 && outbuf[i] == '\033')
-	      {
-		start_at = i;
-		state = 1;
-		continue;
-	      }
-	    else if ((state == 1 && outbuf[i] == ']')
-		     || (state == 2 && outbuf[i] == ';')
-		     || (state == 3 && outbuf[i] == '?')
-		     || (state == 4 && outbuf[i] == '\033'))
-	      {
-		state ++;
-		continue;
-	      }
-	    else if (state == 2 && isdigit (outbuf[i]))
-	      continue;
-	    else if ((state == 4 && outbuf[i] == '\a')
-		     || (state == 5 && outbuf[i] == '\\'))
-	      {
-		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
-		rlen = wlen = start_at + rlen - i - 1;
-		state = 0;
-		i = start_at - 1;
-		continue;
-	      }
-	    else if (outbuf[i] == '\033')
-	      {
-		start_at = i;
-		state = 1;
-		continue;
-	      }
-	    else
-	      state = 0;
-
-	  /* Workaround for rlwrap in Win11. rlwrap treats text between
-	     NLs as a line, however, pseudo console in Win11 somtimes
-	     omits NL before "CSIm;nH". This does not happen in Win10. */
-	  if (wincap.has_pcon_omit_nl_before_cursor_move ())
-	    {
-	      state = 0;
-	      for (DWORD i = 0; i < rlen; i++)
-		if (state == 0 && outbuf[i] == '\033')
-		  {
-		    start_at = i;
-		    state++;
-		    continue;
-		  }
-		else if (state == 1 && outbuf[i] == '[')
-		  {
-		    state++;
-		    continue;
-		  }
-		else if (state == 2
-			 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
-		  continue;
-		else if (state == 2 && outbuf[i] == 'H')
-		  {
-		    /* Add omitted CR NL before "CSIm;nH". However, when the
-		       cusor is on the bottom-most line, adding NL might cause
-		       unexpected scrolling. To avoid this, add "CSI H" before
-		       CR NL. */
-		    const char *ins = "\033[H\r\n";
-		    const int ins_len = strlen (ins);
-		    if (rlen + ins_len <= NT_MAX_PATH)
-		      {
-			memmove (&outbuf[start_at + ins_len],
-				 &outbuf[start_at], rlen - start_at);
-			memcpy (&outbuf[start_at], ins, ins_len);
-			rlen += ins_len;
-			i += ins_len;
-		      }
-		    state = 0;
-		    continue;
-		  }
-		else
-		  state = 0;
-	    }
+	  wlen = rlen = workarounds_for_pseudo_console_output (outbuf, rlen);
 
 	  if (p->ttyp->term_code_page != CP_UTF8)
 	    {
-- 
2.51.0

