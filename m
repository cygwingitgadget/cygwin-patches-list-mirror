Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id DD9374BA23C5
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:01:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DD9374BA23C5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DD9374BA23C5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269310; cv=none;
	b=q4yD1auMZJ0tGBJnfGLPYGmxOoA99jRZ9APJoMdBblCjDW4DjGjLInwOuJofXrwyYPO+sXLd/51tFXXmluA4upLWBl9uqIcl3W97rhBvMVp0e5NtJkbGWneRfULFb14XGDEcUFS5DT3eArI9PBe6sfiWEvNEqov6hJ1siN1J5cw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269310; c=relaxed/simple;
	bh=0lNfToxBfSJiJkTgb2vK/NtYv/dDFOpdVI1+3ARtri8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=oeRw6b4grkfO6L/8evt1B038f4E2hiN7MthYKKEHGZu03LUqdMtfzswyCpjvgKx6rTmhRymTqx0hojujtDFYiCfeIwQZOATmMQUav1j2w4kFihXZCZwBYhXF1xf2hiETe2fOfYEYgw00zRvjjgZ8p1XAC2tVPujJ3A71WDqWDPM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DD9374BA23C5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FOlCq1pg
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20260228090148156.ZGHV.38814.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:01:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: pty: Omit win32-input-mode sequence from pseudo console
Date: Sat, 28 Feb 2026 18:01:29 +0900
Message-ID: <20260228090138.2540-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269308;
 bh=JO+3Nt+CTUF330kgQqjcrlRLMizhANF6meGcFJtDtoE=;
 h=From:To:Cc:Subject:Date;
 b=FOlCq1pg+ly4ogxGImgjOybTzao+j8xgb5YlvUbzM+6r3VqKnNFyfS3iFroVgKxfSgkHkpsE
 ii/g5kZLklci5wHYHI+KIzxRT4c9KbJDpWXNEVzoGEAwoIfcUH9GO98yDCkgXuLc87H5i8AEbb
 ++tl8taASpbCuqRimwFD49TgNzl7V6ssEGn1thl51gDtGhU24twtZLzY2fmdXXCPJ4bOG/rCNm
 H/11LIfwAzivNkoHKocU+YotMGEpVNlDSG0LJI0hJ+pLr8vc3IjWo7WmBaPBHOidWaYRN3+iLs
 uDVGNRpeEzabsW+J4PGh6UyN9IMPmjN53iDbK1+jlr6KxajA==
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, pseudo console uses CSI?9001h which lets the terminal
enter win32-input-mode in console. As a result, two problems happen.

1) If non-cygwin app is running in script command on the console,
   Ctrl-C terminates not only the non-cygwin app, but also script
   command without cleanup for the pseudo console.

2) Some remnants sequences from win32-input-mode occasionally
   appears on the shell in script command on the console.

This patch fixes them by omit CSI?9001h to prevent the terminal
from entering win32-input-mode.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 34a87c6dc..663b0068a 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2694,8 +2694,12 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
 	assert (state == 2);
 	if (outbuf[i-1] == '[' && outbuf[i] == '>')
 	  saw_greater_than_sign = true;
-	else if (isdigit (outbuf[i]) || outbuf[i] == ';')
-	  continue;
+	else if (outbuf[i-1] == '[' && outbuf[i] == '?')
+	  saw_question_mark = true;
+	else if (isdigit (outbuf[i]))
+	  arg = arg * 10 + (outbuf[i] - '0');
+	else if (outbuf[i] == ';')
+	  arg = 0;
 	else if (saw_greater_than_sign && outbuf[i] == 'm')
 	  {
 	    /* Remove CSI > Pm m */
@@ -2724,6 +2728,14 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
 	      }
 	    state = 0;
 	  }
+	else if (saw_question_mark && arg == 9001
+		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
+	  {
+	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+	    rlen = start_at + rlen - i - 1;
+	    i = start_at - 1;
+	    state = 0;
+	  }
 	else if (outbuf[i] == '\033')
 	  {
 	    start_at = i;
@@ -2736,6 +2748,8 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
 	  {
 	    is_csi = false;
 	    saw_greater_than_sign = false;
+	    saw_question_mark = false;
+	    arg = 0;
 	  }
       }
     else if (is_osc)
-- 
2.51.0

