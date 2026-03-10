Return-Path: <SRS0=Vhwg=BK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id 66E364BA23C9
	for <cygwin-patches@cygwin.com>; Tue, 10 Mar 2026 08:51:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 66E364BA23C9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 66E364BA23C9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773132675; cv=none;
	b=QtN4GPm6dw0MObtDbzD2PhQLSDcgqJ9ZIWBL9SbKxnopYvIM4tTC4dYgmIUkYHs1vs9+/XzK7WJuqfBP/355RMBKmEehsxuVJB8c6Vj5RTsS5nkqNOhLQ/0d2fMhbvNTAqjk5qYXw0voksWl8fxtTsFbVnejvz6+hfAULjrGgu8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773132675; c=relaxed/simple;
	bh=E/ZUFxaMrxc674x7Pc8W61PRt9xSDjb4ugrL8uhdBig=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=WQqK55aXs2U9buZKIQHPIHkliT05AmjW4Fo4v3HvZxx7TGyQTae7kZmPLdXAJwARvG2JHlUdf20Mim3RH7SR/gWQqAXs0PZoUXaSy/B4eJ5bnpmXA83eKaGEWMfrfpiTgGSXJ9nL1ldCCNXcjZnznYAhmlv+NYJ5S6QQCbubgpA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 66E364BA23C9
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=WkePyuc3
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260310085112441.MMDX.116672.HP-Z230@nifty.com>;
          Tue, 10 Mar 2026 17:51:12 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 3/3] Cygwin: signal: Implement fake stop/cont for non-cygwin process
Date: Tue, 10 Mar 2026 17:50:09 +0900
Message-ID: <20260310085041.102-4-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
References: <20260310085041.102-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773132672;
 bh=CC+cjb9s2Pl0B9vEDfYIhggBI5+t16hSn0DNymdxpO4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WkePyuc32wc397GgSILYs9TNNZ4yITNRo2Yel3kQaQLmNZFtwLSj6B52DPKloRG7ftzAafGf
 5YE94ps7xNSenjmIb2jNXMhBIsQ+Iw5C3N8CERCA4djyA3C/U7esRiDNFnzA+xAvrgpVWEAzqv
 qzu80v7GLWt3ikfzBz95aHi+tsaX2WONbeNFA5CjEe4JgE+D13Io2LQgcpVF9GgW3AkBgc6l5U
 NIaGtgvat0XmLEVNvsshkdxp3WIuRraEmii+RWz/PNo4IjdB5CKZcwjSglOfMnTSY5jItx/2bd
 cr6BtwXDlEaY2WMeOcbiSpb0YIwWh+DJI+XeZuPwzNIKwgkQ==
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the following command in bash cannot make `cat | cmd`
foreground correctly, and also cannot be terminated by Ctrl-C.

  $ cat |cmd &
  $ fg
  $ (Ctrl-C)

This is because, bash does not recognize the process `cmd` as stopped
by SIGTTIN, and does not send SIGCONT not only to `cmd` but also to
`cat`.

To solve this problem, this patch implements fake stop/cont for non-
cygwin process such as `cmd`. Even with this patch, the process `cmd`
does not enter into stopped state because non-cygwin process itself
does not handle cygwin signal, the but stub process for `cmd` enters
into stopped state instead by SIGTTIN.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/exceptions.cc | 19 ++++++++++++++++++-
 winsup/cygwin/spawn.cc      |  2 +-
 2 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
index 830846431..158d8675b 100644
--- a/winsup/cygwin/exceptions.cc
+++ b/winsup/cygwin/exceptions.cc
@@ -1508,6 +1508,23 @@ _cygtls::handle_SIGCONT ()
   InterlockedAnd ((LONG *) &myself->process_state, ~PID_STOPPED);
 }
 
+inline static bool
+is_stop_or_cont (int sig)
+{
+  switch (sig)
+    {
+    case SIGSTOP:
+    case SIGTSTP:
+    case SIGTTIN:
+    case SIGTTOU:
+    case SIGCONT:
+      return true;
+    default:
+      break;
+    }
+  return false;
+}
+
 int
 sigpacket::process ()
 {
@@ -1661,7 +1678,7 @@ exit_sig:
   thissig.sa_flags &= ~SA_ONSTACK;
 
 dosig:
-  if (have_execed)
+  if (have_execed && (ch_spawn.iscygwin () || !is_stop_or_cont (si.si_signo)))
     {
       sigproc_printf ("terminating captive process");
       if (::cygheap->ctty)
diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index 04e4a4028..81b99e763 100644
--- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -877,7 +877,7 @@ child_info_spawn::worker (const char *prog_arg, const char *const *argv,
 	  if (term_spawn_worker.need_cleanup ())
 	    {
 	      LONG prev_sigExeced = sigExeced;
-	      while (WaitForSingleObject (pi.hProcess, 100) == WAIT_TIMEOUT)
+	      while (cygwait (pi.hProcess, 100) != WAIT_OBJECT_0)
 		/* If child process does not exit in predetermined time
 		   period, the process does not seem to be terminated by
 		   the signal sigExeced. Therefore, clear sigExeced here. */
-- 
2.51.0

