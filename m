Return-Path: <SRS0=vXQ3=A3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 2E1BC4BA2E17
	for <cygwin-patches@cygwin.com>; Mon, 23 Feb 2026 08:01:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2E1BC4BA2E17
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2E1BC4BA2E17
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771833675; cv=none;
	b=gGd5qFPiydeZ8bNerL8KLvr4BNOqWJYaL2gA0ErYt8vX8m+2+GQPSAh7jzn9tiIUqHluinyEzwCK+d2PQ51Pse3wi2DEBMD45/GkZKaK4wmPvgzoZOTHw2PmmOhYjUOPalz/uC/Q4XktBaWx6Z+VZ1M1njux16guLB2B7DDt8NM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771833675; c=relaxed/simple;
	bh=EtFpnsXHp0Q2ujOV3/Cqz9Azki6uPymqVU15n+IZMi4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=eV+bEt3LNHapPqCJxwmSWEElP6GD+Vb79MFHcriyScy+u9B+ZA8e2oMUNbNbWaI9QMxx+D4JjSIrc+6Zb3NnePatx1QsvJRIqhdmF8Gd9uQ/Fqn+8jDjEwa9cEZKkDXKsfVUCPcSJY7ze/7FSS3KLI0FoHJNiuCxufPHHByajv8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2E1BC4BA2E17
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=OXpo11LQ
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260223080113435.NJUE.50988.HP-Z230@nifty.com>;
          Mon, 23 Feb 2026 17:01:13 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Improve CSI6n handling in pcon_start state
Date: Mon, 23 Feb 2026 17:00:56 +0900
Message-ID: <20260223080106.330-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771833673;
 bh=4uJqr4BCrMM5hxga1q5G34m7kjSCE4f1G514MTbtsbw=;
 h=From:To:Cc:Subject:Date;
 b=OXpo11LQSnG2Nw/dqBQDmRNfay/lIiu565Ik2VSSB6wlRi9XtbW6ZfeSOU029vxR7ku9/LpP
 xI8cOngQXb4rCpbiTzTRE4O8YvyfomuRrG8gLoNv1/U1egA9SgXp/xGk6n1+tFlPGHuAl0G9hP
 siMRuuB1bR/i3I3fibKQvbhJanZOK8BL4U1+TNt+8gWm1ZkqggwopwnTb44rY8XwgRTICWFmGB
 lkqB+bjtsEGg4o6mDVckOiHXPbNlRhI+NSPERW7jigV5Ak5GbmRmDDWKICX0fxow3v0XY8sMt4
 tw0F0CNKzc9/amQgHPU/ErJkBpRP+cwhJ6t1hFFrnc1KoSfw==
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previsouly, CSI6n was not handled correctly if the some sequences
are appended after the responce for CSI6n. Especially, if the
appended sequence is a ESC sequence, which is longer than the
expected maximum length of the CSI6n responce, the sequence will
not be written atomically. With this patch, pcon_start state
is cleared at the end of CSI6n responce, and appended sequence
will be written outside of the CSI&n handling block.

Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 838be4a2b..c1e03db41 100644
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
@@ -2171,6 +2173,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  if (state == 1)
 	    {
+	      towrite--;
+	      ptr = p + i + 1;
 	      if (ixput < wpbuf_len)
 		wpbuf[ixput++] = p[i];
 	      else
@@ -2184,7 +2188,10 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	  else
 	    line_edit (p + i, 1, ti, &ret);
 	  if (state == 1 && p[i] == 'R')
-	    state = 2;
+	    {
+	      state = 2;
+	      break;
+	    }
 	}
       if (state == 2)
 	{
@@ -2220,8 +2227,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 	    }
 	  get_ttyp ()->pcon_start_pid = 0;
 	}
-
-      return len;
+      if (towrite == 0)
+	return len;
     }
 
   /* Write terminal input to to_slave_nat pipe instead of output_handle
@@ -2233,15 +2240,14 @@ fhandler_pty_master::write (const void *ptr, size_t len)
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

