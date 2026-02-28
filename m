Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 1C7FD4BA2E1C
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 10:01:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1C7FD4BA2E1C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1C7FD4BA2E1C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772272921; cv=none;
	b=nXoQYZcB4SNFO989Xe2DgIbHM4Pgl81Utlz6UZJaCpC7m61g7GEsVL9Ot0+aD33FDaWVGneT0WrTmXyhU2wisG0T1mAt6M05J1QvzS69ODW+FxiyNvaMzFSVYeUfkSPuU0RkloDoBsl9iT9ug4ThbIhpYbOfdnDhbsbuU3vnEp0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772272921; c=relaxed/simple;
	bh=q7pJuMMdP+xTshS6s8WAAGJ2cxvhkNBd7ur6O2pSj74=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=NLCrUxol4myYNM3lFd9UJ1ZCW/QgyK5bXsgUPx1/IDW1zLyLzrPEmV73Gkl93eKs3FK5eBNbKEOPWoTJb7wbIQdpV02zndyt7zfz0ElvbUj7/+FAWCMFntdndBIiQUyrxtWrlxqQx+sKKifKPA6gLDriL02SsA3wTrXISJv7BcY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1C7FD4BA2E1C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=suV4dL7r
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20260228100156345.TWLK.86286.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 19:01:56 +0900
Date: Sat, 28 Feb 2026 19:01:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Omit win32-input-mode sequence from
 pseudo console
Message-Id: <20260228190154.1c5e39af25e7d31a36f56017@nifty.ne.jp>
In-Reply-To: <20260228090138.2540-1-takashi.yano@nifty.ne.jp>
References: <20260228090138.2540-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__28_Feb_2026_19_01_54_+0900_qfWTrCzwmWPNZ4oa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772272916;
 bh=lqprubvpXwqTE0YLPlsA08KaOIpTtwD87WzXL1xPZrE=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=suV4dL7rzkzf/K7hVS6SJ5h3PCc/jO10E+k9Zch4D8WYzlYq7FbjhnsdnVvQlHeuOA8EOM1U
 VBcLAigVSgXmN2n66a4BKbz8WvPnwIBE9prcos+ysjQuu80FBCNEeXBymjnO7evQMANAr9TsjQ
 dz11p8fVAI7rLrUNMG585Jy4l9ZQg2GqCv+5fjeuXS41NAIkQBaVKGYpuUEvL+iMTiCIjiYbOR
 ttFhvpWo8NpWb4Ulh1pzpoHG1E7z9Tj2nNt/9TqwuzB9aConvaZ/T/uT3xQTiFEMwBsgLO9Isk
 m98dP26sRceG2BBkUQPJ8AnkBkyllfB/oJgqiUaII4h6zreg==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.

--Multipart=_Sat__28_Feb_2026_19_01_54_+0900_qfWTrCzwmWPNZ4oa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Feb 2026 18:01:29 +0900
Takashi Yano wrote:
> In Windows 11, pseudo console uses CSI?9001h which lets the terminal
> enter win32-input-mode in console. As a result, two problems happen.
> 
> 1) If non-cygwin app is running in script command on the console,
>    Ctrl-C terminates not only the non-cygwin app, but also script
>    command without cleanup for the pseudo console.
> 
> 2) Some remnants sequences from win32-input-mode occasionally
>    appears on the shell in script command on the console.
> 
> This patch fixes them by omit CSI?9001h to prevent the terminal
> from entering win32-input-mode.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Suggested-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 18 ++++++++++++++++--
>  1 file changed, 16 insertions(+), 2 deletions(-)

Attached is the patch for the same purpose against
cygwin-3_6-branch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Sat__28_Feb_2026_19_01_54_+0900_qfWTrCzwmWPNZ4oa
Content-Type: text/plain;
 name="0001-Cygwin-pty-Omit-win32-input-mode-sequence-from-pseud.patch"
Content-Disposition: attachment;
 filename="0001-Cygwin-pty-Omit-win32-input-mode-sequence-from-pseud.patch"
Content-Transfer-Encoding: 7bit

From 1ea31e5b66a493905eec2670bbaa27bf9ec93a26 Mon Sep 17 00:00:00 2001
From: Takashi Yano <takashi.yano@nifty.ne.jp>
Date: Thu, 19 Feb 2026 18:28:08 +0900
Subject: [PATCH] Cygwin: pty: Omit win32-input-mode sequence from pseudo
 console

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
 winsup/cygwin/fhandler/pty.cc | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 90f58671c..0f0240ea7 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2729,6 +2729,38 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	    else
 	      state = 0;
 
+	  /* Remove CSI ? 9001 h/l (win32-input-mode) */
+	  int arg = 0;
+	  state = 0;
+	  for (DWORD i = 0; i < rlen; i++)
+	    if (outbuf[i] == '\033')
+	      {
+		start_at = i;
+		state = 1;
+		continue;
+	      }
+	    else if ((state == 1 && outbuf[i] == '[')
+		     || (state == 2 && outbuf[i] == '?'))
+	      {
+		state ++;
+		continue;
+	      }
+	    else if (state == 3 && isdigit (outbuf[i]))
+	      arg = arg * 10 + (outbuf[i] - '0');
+	    else if (state == 3 && outbuf[i] == ';')
+	      arg = 0;
+	    else if (state == 3 && arg == 9001
+		     && (outbuf[i] == 'h' || outbuf[i] == 'l'))
+	      {
+		memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
+		rlen = wlen = start_at + rlen - i - 1;
+		state = 0;
+		i = start_at - 1;
+		continue;
+	      }
+	    else
+	      state = 0;
+
 	  /* Remove OSC Ps ; ? BEL/ST */
 	  state = 0;
 	  for (DWORD i = 0; i < rlen; i++)
-- 
2.51.0


--Multipart=_Sat__28_Feb_2026_19_01_54_+0900_qfWTrCzwmWPNZ4oa--
