Return-Path: <SRS0=PQXH=IU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id 4A2FC4BAE7DC
	for <cygwin-patches@cygwin.com>; Fri, 30 Oct 2026 23:16:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A2FC4BAE7DC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A2FC4BAE7DC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793402186; cv=none;
	b=tKiSs+odYDDphC0W0kuS6cZf4kQhhzfGFuFswGV0BNfP7VLYZ6NC2NmPBjh7hSgMTIw4kiVX5vcYg+DxJ+8GhmmiUZplfBrjPzTMSF9QnKnnAK67VIfuBazrtgQQOR8H4zlEXtgh0qM1JcnLKf+TsJscQxlwj4qGODebZk5NLF8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793402186; c=relaxed/simple;
	bh=vRT3B3hIf1hmA5hpLTRFWFe3HzFx2j21kkukvjKeU4o=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=DJX4m1LhbtIfjQup1989jc1itkGhrVeUlgRZTJNLfDvacoLtiEJiGPPyz4VSUSDHAf5kTqSxOwekF3rFkR3EJOaW6/qKeUoDYHSltey1HTCvYL2cpwc09o/RwWho2+QAO6COFpC0BPsP1e41CkvZlN0u7P8XEzjmzaRAm9kmchE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=osQZEvzr
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A2FC4BAE7DC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=osQZEvzr
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20261030231622803.LCOG.44671.HP-Z230@nifty.com>;
          Sat, 31 Oct 2026 08:16:22 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 2/2] Cygwin: pty: Handle win32 input mode rather than omitting it
Date: Sat, 31 Oct 2026 08:16:07 +0900
Message-ID: <20261030231615.9970-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793402182;
 bh=ZL+qqMTBYmVBJIYOIIBOutWKNs2+xdm3kCpKWuMCZ4c=;
 h=From:To:Cc:Subject:Date;
 b=osQZEvzrttod2AEX1TMCkxDAgwHm3Bko0HuE/ZW00UROoMCFZqSV6HlzikXjU1teq55HevOB
 YnF5Kvl3aykFXRnlHJZNkIme0m+EwxTHHHP2zMuhxKhfCEg386pPFXoZJAD+hY9CVSK/Ly8KpL
 l8X0VeahkZRwG0TEM1xa1AMCsZ3hpTTlUn+Nr5LbbEdyLSLZ0brKPzSceC0SFLKc2cdcoFaaiQ
 v3pRdj5p8bLUnppXQBsAduLOlvmpiQu4zyYm7CpZvLRFF/LTQVAaU4+DoOljF2Mm8v0C2gfo36
 Tx9ltSP0XvgrRWXGJUXjMnoDlPjGQWfB229cRi52F3VfWXCA==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, win32 input mode request from pseudo console is omitted
to avoid incorrect Ctrl-C handling. This patch makes pty handle win32
input mode properly instead of removing that sequence (SCI?9001h/l)
from the output of the pseudo console.

Fixes: b7541ef1242a ("Cygwin: pty: Omit win32-input-mode sequence from pseudo console")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
v2: Remove SCI?9001h/l if the foreground process is cygwin process.

 winsup/cygwin/fhandler/pty.cc      | 48 ++++++++++++++++++++++++++++--
 winsup/cygwin/local_includes/tty.h |  1 +
 2 files changed, 47 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 39525bd08..e200d5b7c 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2734,6 +2734,38 @@ fhandler_pty_master::write (const void *ptr, size_t len)
       len = nlen;
       for (size_t i = 0, j = 0; i < len; i++)
 	{
+	  const int max_w32i_len = 64;
+	  static char w32i_buf[max_w32i_len];
+	  static int w32i_idx;
+	  if (get_ttyp ()->win32input_mode_maybe
+	      && (buf[i] == '\033' || w32i_idx))
+	    {
+	      int a1, a2, a3, a4, a5, a6;
+	      DWORD n;
+	      if (buf[i] == '\033')
+		{
+		  if (w32i_idx)
+		    WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+		  w32i_idx = 0;
+		}
+	      if (w32i_idx < max_w32i_len - 1)
+		{
+		  w32i_buf[w32i_idx++] = buf[i];
+		  w32i_buf[w32i_idx] = '\0';
+		}
+	      nlen--;
+	      if (buf[i] == '_'
+		  && sscanf(w32i_buf, "\033[%d;%d;%d;%d;%d;%d_",
+			    &a1, &a2, &a3, &a4, &a5, &a6) == 6
+		  && a1 == 0x43 && a4 == 1 && a5 == 8) /* Ctrl-C */
+		process_sigs ('\003', get_ttyp (), this);
+	      if (buf[i] == '_')
+		{
+		  WriteFile (to_slave_nat, w32i_buf, w32i_idx, &n, NULL);
+		  w32i_idx = 0;
+		}
+	      continue;
+	    }
 	  process_sig_state r = process_sigs (buf[i], get_ttyp (), this);
 	  if (r != done_with_debugger &&
 	      (r != signalled || (ti.c_lflag & NOFLSH) || buf[i] == '\003'))
@@ -3238,8 +3270,7 @@ fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
 	      }
 	    state = 0;
 	  }
-	else if (saw_question_mark
-		 && (arg == 9001 || arg == 1004)
+	else if (saw_question_mark && arg == 1004
 		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
 	  {
 	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
@@ -3247,6 +3278,19 @@ fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
 	    i = start_at - 1;
 	    state = 0;
 	  }
+	else if (saw_question_mark && arg == 9001
+		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
+	  {
+	    if (ttyp->pty_input_state == tty::to_cyg)
+	      {
+		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		rlen = start_at + rlen - i - 1;
+		i = start_at - 1;
+	      }
+	    else
+	      ttyp->win32input_mode_maybe = (outbuf[i] == 'h');
+	    state = 0;
+	  }
 	else if (outbuf[i] == '\033')
 	  {
 	    start_at = i;
diff --git a/winsup/cygwin/local_includes/tty.h b/winsup/cygwin/local_includes/tty.h
index c5102eb81..eb9457181 100644
--- a/winsup/cygwin/local_includes/tty.h
+++ b/winsup/cygwin/local_includes/tty.h
@@ -146,6 +146,7 @@ private:
   bool discard_input;
   bool stop_fwd_thread;
   bool req_fixup_pcon_cur_pos;
+  bool win32input_mode_maybe;
 
 public:
   HANDLE from_master_nat () const { return _from_master_nat; }
-- 
2.51.0

