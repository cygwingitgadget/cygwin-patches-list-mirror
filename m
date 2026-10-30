Return-Path: <SRS0=PQXH=IU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 80EC34BA799F
	for <cygwin-patches@cygwin.com>; Fri, 30 Oct 2026 14:12:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 80EC34BA799F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 80EC34BA799F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793369547; cv=none;
	b=idEDAs2ODulSHrNksENYpF0hbVPK/d1N6f8e9b3nZ+rYYFUYYRL6oZS6tpT86ZHlS/+Hfw5WigapJNkNjT5/8cdtextWa+Gf8A083phVo7DppB/oFqeBDaVMN+LzQJMVpFJ+/04wFoaSsdwVZKkbh03VUbQok/TOVe0+cgViH30=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793369547; c=relaxed/simple;
	bh=Nhk1zaGhQECZ/hLXDFKJVr+v1Zwav7Wnhj0kGy1eJT4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=X9/GMDf2C0VgdGJIq62R3W8DzwVWWOi4592NgBoGOk70yJafRnQw0wErVjLRroWWGAXscT63xYVBG2b8mtnSFb8AKkcgODOnUTvm343kLUDPSTcGQ/TuGU0NbfJShmcKuLrSYYl7wJYu2TfyGbXb6yWNRM/W60nqgElE9tRII0A=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lkukZBx9
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 80EC34BA799F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lkukZBx9
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20261030141224781.HYYW.102121.HP-Z230@nifty.com>;
          Fri, 30 Oct 2026 23:12:24 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/2] Cygwin: pty: Handle win32 input mode rather than omitting it
Date: Fri, 30 Oct 2026 23:11:49 +0900
Message-ID: <20261030141207.12021-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261030141207.12021-1-takashi.yano@nifty.ne.jp>
References: <20261030141207.12021-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1793369544;
 bh=SLcwuIzJRnovI2/wD5pafJ6ahZvadoqrh6o3SZTAvsE=;
 h=From:To:Cc:Subject:Date:In-Reply-To;
 b=lkukZBx95kyRXop8cjClUe35amGiAWLhUXvUEpyx4yKQpneG6An4hepVjk9vM3LqidKL45ft
 toRviQ8KIR8fNv02ruCbWOtP70PkyXYSRaoFDuE14brVgCTEa8IAeC8U2q1L2XqwlUjKNyXr69
 Ys/tVhVQZvJGYDKKGra8JE/Ij4bGdSs6YIA0YUnKCFkOVIr4lDJsbzxuwKBkUIlfmg2p6pWcxo
 dWDTOEKsgh583Rv8sZGYlS7FJErWQa/MoB59dquluKtZFmNrD+0kca0UYjxKAJ2MR+bNXE4Xcl
 oD8imE0Is1B+z03XiAucN6Zndipm7aoE6CwvFWNCjCg9A8fA==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
 winsup/cygwin/fhandler/pty.cc      | 41 ++++++++++++++++++++++++++++--
 winsup/cygwin/local_includes/tty.h |  1 +
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 39525bd08..c6a9c4407 100644
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
@@ -3247,6 +3278,12 @@ fhandler_pty_master::workarounds_for_pseudo_console_output (char *outbuf,
 	    i = start_at - 1;
 	    state = 0;
 	  }
+	else if (saw_question_mark && arg == 9001
+		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
+	  {
+	    ttyp->win32input_mode_maybe = (outbuf[i] == 'h');
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

