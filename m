Return-Path: <SRS0=15Wh=6Z=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 6D1654BA2E26
	for <cygwin-patches@cygwin.com>; Fri, 19 Dec 2025 13:17:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6D1654BA2E26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6D1654BA2E26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766150273; cv=none;
	b=krGkuY/1zVd0+3VDTVu77YTQMiZx9L8TcNl4g3gvkaklIqXPQxhDaIMsezEVDHYPdaLd8nAI51XtFz38/DT8b5eV8VKvONAE8Z52W36JIv9+//pD5zV1fb+idIsXi48+IzmzKPkS9V17tPz9XM1JFAjjWlV+eaUzEDXgYmVOCk0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766150273; c=relaxed/simple;
	bh=/szRd8RBy6ZEbezSdaTRpsnKU+ibtSKCv8bsBYXs8i8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=VplPiIBl2v7dCzHApXILZjsfd55LQ6k7vVW/iC8q9PMcKvO4zp49NSNTAeHIi4PBLUyepqdqAvJclfvsM2SPVji7qYW6l6Ws2lqei8YZ3ZBiEqTy7vw6BMyMcdzdkQ6Ipw67fyt2CNwg5o/950549BsvlxJNwVATA4658bnDW1M=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6D1654BA2E26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=djNM4oW2
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20251219131741544.HOAU.98325.HP-Z230@nifty.com>;
          Fri, 19 Dec 2025 22:17:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pty: Refactor workaround code for pseudo console output
Date: Fri, 19 Dec 2025 22:17:23 +0900
Message-ID: <20251219131732.1433-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766150261;
 bh=mmmzlUZCo256sKLxZUaZ0cPhEjI46SA4LWDrjNwb19c=;
 h=From:To:Cc:Subject:Date;
 b=djNM4oW2nM3WGjyOetfGRU4cnuAFUfhRdi7R6ZgVSX4Bd3cBDApNhNOm9B7w0Pi9Y6CaX0Gh
 6KCt2u8coRWjGctdk8Gv6t62shHBOHJLmSMrJ4oa3mwZ/bfzcwvQRc4t/ObxHWe8Gdk6P+qqHj
 vVvP5dbC5b8kx+N7ZU+/Mo9V4RLx904n1JPWjc/+HRnczU2FcHb94O6QxAYMyIIBpvKT9BAlJW
 SVF/bvFg0aYNOqAvgFPinW30aMY910tUig21SEPbVNlwGDP0ajJFByEGMnqkjwQWmx78T1sA3S
 eM5qgpoqWMWLWckM92gpa3245kO3jPh9+DGSHrfYlToRUetg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, there are four separate workarounds for pseudo console
output in pty_master_fwd_thread. Each workaround has its own 'for'
loop that iterates over the entire output buffer, which is not
efficient. This patch consolidates these loops and introduces a
single state machine to handle all workarounds at once. In addition,
the workarounds are moved into a dedicated function,
'workarounds_for_pseudo_console_output()' to improve readability.

Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>, Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 301 +++++++++++++++++-----------------
 1 file changed, 147 insertions(+), 154 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 32e50540e..dcb0a742f 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -28,6 +28,7 @@ details. */
 #include "registry.h"
 #include "tls_pbuf.h"
 #include "winf.h"
+#include <assert.h>
 
 #ifndef PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE
 #define PROC_THREAD_ATTRIBUTE_PSEUDOCONSOLE 0x00020016
@@ -2642,6 +2643,151 @@ pty_master_thread (VOID *arg)
   return fhandler_pty_master::pty_master_thread (&p);
 }
 
+inline static DWORD
+workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
+{
+  int state = 0;
+  int start_at = 0;
+  bool is_csi = false;
+  bool is_osc = false;
+  int arg = 0;
+  bool saw_greater_than_sign = false;
+  bool saw_question_mark = false;
+  for (DWORD i=0; i<rlen; i++)
+    if (state == 0 && outbuf[i] == '\033')
+      {
+	start_at = i;
+	state = 1;
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
+	assert (state == 2);
+	if (outbuf[i-1] == '[' && outbuf[i] == '>')
+	  saw_greater_than_sign = true;
+	else if (isdigit (outbuf[i]) || outbuf[i] == ';')
+	  continue;
+	else if (saw_greater_than_sign && outbuf[i] == 'm')
+	  {
+	    /* Remove CSI > Pm m */
+	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+	    rlen = start_at + rlen - i - 1;
+	    i = start_at - 1;
+	    state = 0;
+	  }
+	else if (wincap.has_pcon_omit_nl_before_cursor_move ()
+		 && !saw_greater_than_sign && outbuf[i] == 'H')
+	  /* Workaround for rlwrap in Win11. rlwrap treats text between
+	     NLs as a line, however, pseudo console in Win11 somtimes
+	     omits NL before "CSIm;nH". This does not happen in Win10. */
+	  {
+	    /* Add omitted CR NL before "CSIm;nH". However, when the
+	       cusor is on the bottom-most line, adding NL might cause
+	       unexpected scrolling. To avoid this, add "CSI H" before
+	       CR NL. */
+#define CSIH_INSERT "\033[H\r\n"
+#define CSIH_INSLEN (sizeof (CSIH_INSERT) - 1)
+	    if (rlen + CSIH_INSLEN <= NT_MAX_PATH)
+	      {
+		memmove (&outbuf[start_at + CSIH_INSLEN], &outbuf[start_at],
+			 rlen - start_at);
+		memcpy (&outbuf[start_at], CSIH_INSERT, CSIH_INSLEN);
+		rlen += CSIH_INSLEN;
+		i += CSIH_INSLEN;
+	      }
+	    state = 0;
+	  }
+	else if (outbuf[i] == '\033')
+	  {
+	    start_at = i;
+	    state = 1;
+	  }
+	else
+	  state = 0;
+
+	if (state < 2)
+	  {
+	    is_csi = false;
+	    saw_greater_than_sign = false;
+	  }
+      }
+    else if (is_osc)
+      {
+	if (state == 2 && isdigit (outbuf[i]))
+	  arg = arg * 10 + (outbuf[i] - '0');
+	else if (state == 2 && outbuf[i] == ';')
+	  state = 3;
+	else if (state == 3 && outbuf[i-1] == ';' && outbuf[i] == '?')
+	  saw_question_mark = true;
+	else if (state == 3 && outbuf[i] == '\033')
+	  state = 4;
+	else if ((state == 3 && outbuf[i] == '\a')
+		 || (state == 4 && outbuf[i] == '\\'))
+	  {
+#define CONSOLE_HELPER "\\bin\\cygwin-console-helper.exe"
+#define CONSOLE_HELPER_LEN (sizeof (CONSOLE_HELPER) - 1)
+	    if (saw_question_mark /* OSC Ps; ? BEL/ST */
+		/* Suppress stray set title at start up of pcon */
+		|| (arg == 0 && memmem (&outbuf[start_at], i + 1 - start_at,
+					CONSOLE_HELPER, CONSOLE_HELPER_LEN)))
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
+	    state = 1;
+	  }
+	else
+	  state = 0;
+
+	if (state < 2)
+	  {
+	    is_osc = false;
+	    saw_question_mark = false;
+	    arg = 0;
+	  }
+      }
+    else
+      { /* Never reached */
+	is_csi = false;
+	is_osc = false;
+	saw_greater_than_sign = false;
+	saw_question_mark = false;
+	arg = 0;
+	state = 0;
+      }
+  return rlen;
+}
+
 /* The function pty_master_fwd_thread() should be static because the
    instance is deleted if the master is dup()'ed and the original is
    closed. In this case, dup()'ed instance still exists, therefore,
@@ -2676,160 +2822,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
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

