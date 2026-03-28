Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id A610D4BA23F6
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:57:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A610D4BA23F6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A610D4BA23F6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695453; cv=none;
	b=Ve+FxtvtJhWebroxujWHJLEH6qf7NY8LQ/Kg92yGph4dZOrMgLANcJ4hEaZK0oFnY5ojGYUD66lLBctbSnWLuz9IWKwZeBC/YeAnDAgGO9e/4D9L/VDMvj0/ZJNjFdnI//PUjFb1+KgQ1FF8nJu1GAGuLo92U9tNqJXw5exw/6k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695453; c=relaxed/simple;
	bh=XwoSSvrLXR2t6mz5m1u1QUI4ZNkOC88EIQSrTeb7FuU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=ZvplBxMjNYPR9EMfG5/FwfVwmPMUeaqFvVpcQjjBJZYzx91Voz2yxSpw4acU6bFUBebrpMwtQWon2QA/rFKSu1bMqsYjnQRsr3tCaAIlJU5djRX6dEDpeV/JYUI2Rjj3ULAtxCg1xK1ViHapySbT2nXSBOQBR88kXMZsanfjfYE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A610D4BA23F6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=RtIZ/tVi
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260328105730871.LDFE.58584.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 19:57:30 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 7/7] Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()
Date: Sat, 28 Mar 2026 19:55:51 +0900
Message-ID: <20260328105632.1916-8-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
 <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695450;
 bh=pFsP1vNEt3Ltwyk4TDWZPPnlmioJD9VewayGhKuBSTw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RtIZ/tViKpBNzBBuaYchPj6cMZhd4TNqemK6uCWvs4GoIept8hkp6Vy2F19hy0FfZWgl4Nun
 hsFXciHXyLyKEvn4Y385jkalJoqH7dIFn24JjlLAxTPWQ6LIqkRrLFWobcoNaXzmrxXhlAOpYv
 2BcGZw+SeFD9eb2/jhojsM4TIBz1HK0+U7j1kxOINUvZdPTLtHNUcH6popDgu45NfkmLuWDzsB
 rAHx1izIlk+D9wFprnZe+u4VIxgE/oNznE++aWG14vrqTHir3RHfvHLrx0dhxqvejYB8Tpawap
 pCYSEy1MyDG66jwLhly2TOy88oWKK+YG85t388WP7hAqc6gg==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

While a non-cygwin app has exited but the stub process has not yet
terminated, `nat_fg()` returns false because no non-cygwin app is
running. In this window, pty input goes to the cyg pipe. Due to
this, the keystroke order is swapped unexpectedly:

1) start non-cygwin app
2) press 'a' ('a' goes to nat pipe)
3) non-cygwin app exits
4) press 'b' ('b' goes to cyg pipe)
5) the stub process for non-cygwin app transfers input in nat pipe
   to cyg pipe ('a' goes to cyg pipe)
6) the result in the cyg pipe is "ba"

Fix this by dropping the `nat_fg()` check from
`to_be_read_from_nat_pipe()`. The function now returns true when
`!pcon_start && switch_to_nat_pipe && !masked`. Each component has
a specific purpose:

- `!pcon_start`: keystrokes go through the CSI6n response handler
  during pseudo console initialization rather than the fast path.
- `switch_to_nat_pipe`: this session-level flag stays true from
  `setup_for_non_cygwin_app()` through `cleanup_for_non_cygwin_app()`,
  spanning the entire native process lifetime including the post-exit
  cleanup window.
- `!masked` (`TTY_SLAVE_READING` event does not exist): keystrokes
  go to the Cygwin pipe when a Cygwin process is actively reading
  from the slave, since that process expects POSIX-processed input.

Removing `nat_fg()` is safe because conhost's input buffer
accumulates keystrokes as INPUT_RECORDs during the post-exit
window, and `transfer_input(to_cyg)` in `cleanup_for_non_cygwin_app()`
reads them back via `ReadConsoleInputA()` and writes them to the
cyg pipe. Those transferred bytes then go through `line_edit()` in
the master's forward thread (via `input_transferred_to_cyg` from an
earlier patch in this series), ensuring proper POSIX line discipline
processing.

Additionally, add a `nat_fg()` check to the disable_pcon transfer
path in `master::write()`. That transfer moves cyg pipe data to
the nat pipe when a Cygwin child exits and a native process
regains the foreground with pcon disabled. Without pcon, there is
no conhost buffer to accumulate keystrokes (the nat pipe is a raw
pipe), so keystrokes must only go there when a native process is
genuinely in the foreground and ready to read them. The `nat_fg()`
guard prevents the transfer from stealing readline's data during
the post-exit window.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/pty.cc | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 6a36075f1..6f886d957 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -1309,14 +1309,8 @@ fhandler_pty_common::to_be_read_from_nat_pipe (void)
       goto out;
   }
 
-  if (!pinfo (get_ttyp ()->getpgid ()))
-    /* GDB may set invalid process group for non-cygwin process. */
-    {
-      ret = true;
-      goto out;
-    }
+  ret = true; /* !pcon_start && switch_to_nat_pipe && !masked */
 
-  ret = get_ttyp ()->nat_fg (get_ttyp ()->getpgid ());
 out:
   ReleaseMutex (pipe_sw_mutex);
   return ret;
@@ -2379,6 +2373,7 @@ fhandler_pty_master::write (const void *ptr, size_t len)
   /* This input transfer is needed when cygwin-app which is started from
      non-cygwin app is terminated if pseudo console is disabled. */
   if (to_be_read_from_nat_pipe () && !get_ttyp ()->pcon_activated
+      && get_ttyp ()->nat_fg (get_ttyp ()->getpgid ())
       && get_ttyp ()->pty_input_state == tty::to_cyg)
     {
       acquire_attach_mutex (mutex_timeout);
-- 
2.51.0

