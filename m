Return-Path: <SRS0=1nHs=6Q=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 2B2C04BA2E21
	for <cygwin-patches@cygwin.com>; Wed, 10 Dec 2025 01:52:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2B2C04BA2E21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2B2C04BA2E21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765331578; cv=none;
	b=f/H5O5FxDYh/uzmBj9vZsIfXRC59tDWaqJ74A1GYIAY+xYN7clmMJqd7d1XScp5cBgrVtPltC/Rec7k9iQDKgdDzhqsJoJdfsmdmaFDwYBMF/ugGIwSqzX95FVxpWg+WpCYNrx+kDTlf+i+NmV9ZyMNrG3mq1xEtNi9eiMhEXlE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765331578; c=relaxed/simple;
	bh=AfMt3o9V2wPR1WjusUTWF+6Fd/OUSWyMSNUUZOWeqMg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=UTpVVjfis1EVFYMjssLdgcnCULsBoUnikh2Q8icTKdylH11DtiW4n2Ja08d1DjUeOinrmCaxp8I3IDn9f+Db8o/sUnqJLMNPYpSI4FBSm+OypzQCRMlQAcM+c9fAqXkyMRPvyUeot8LnurHD86AtrBxMCLxRsydbniIWGRHAkA8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2B2C04BA2E21
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BCPrI/NC
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20251210015256316.EXMI.127398.HP-Z230@nifty.com>;
          Wed, 10 Dec 2025 10:52:56 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 2/2] Cygwin: pty: Add new workaround for rlwrap in pcon enabled mode
Date: Wed, 10 Dec 2025 10:52:23 +0900
Message-ID: <20251210015233.1368-3-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
References: <20251210015233.1368-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765331576;
 bh=0O58Viq489AgOaVtWHbujX9rYsDC1d53J9lJLC1C8V8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=BCPrI/NCLp5VxlG+AOp6PP74e07c9Kr1d68adfblId8ej6UiO56GPid4ZznHQAWdm752Nzri
 f3itjTAx5cnbflydHoyaNcMyv5K7M/VPtdSWW/NJleB4dGuIPom3i1CK7EaZasxT/xwCcw79yy
 yPLoh89vJYYbybcp89VhLCofCCtYg3Rot7NIz/GBjUZFZRGANYi//s+yv1wZNaRhExiGIIO66V
 sDY+E8EJP4plUdLgbaGQ9UDTdxGWn5W5pWXAJrCSs71rg6AReFR+42ddI00DdBzptjP128Cerx
 CgfysXN0X5PclM+J0v1HVEsGhXw6nTZ8h+0rpmwvJXHwbWow==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, the command "rlwrap cmd" outputs garbaged screen.
This is because rlwrap treats text between NLs as a line, while
pseudo console sometimes ommits NL before "CISm;nH". This issue
does not happen in Windows 10. This patch fixes the issue.

Reviewed-by:
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 3b0b4f073..5c02a4111 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2775,6 +2775,40 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	    else
 	      state = 0;
 
+	  /* Workaround for rlwrap */
+	  /* rlwarp treats text between NLs as a line, however,
+	     pseudo console somtimes ommits NL before "CSIm;nH". */
+	  state = 0;
+	  for (DWORD i = 0; i < rlen; i++)
+	    if (state == 0 && outbuf[i] == '\033')
+	      {
+		start_at = i;
+		state++;
+		continue;
+	      }
+	    else if (state == 1 && outbuf[i] == '[')
+	      {
+		state++;
+		continue;
+	      }
+	    else if (state == 2 && (isdigit (outbuf[i]) || outbuf[i] == ';'))
+	      continue;
+	    else if (state == 2 && outbuf[i] == 'H')
+	      {
+		/* Add "CSI H" before CR NL to avoid unexpected scroll */
+		const char *ins = "\033[H\r\n";
+		const int ins_len = strlen (ins);
+		memmove (&outbuf[start_at + ins_len], &outbuf[start_at],
+			 rlen - start_at);
+		memcpy (&outbuf[start_at], ins, ins_len);
+		rlen += ins_len;
+		i += ins_len;
+		state = 0;
+		continue;
+	      }
+	    else
+	      state = 0;
+
 	  if (p->ttyp->term_code_page != CP_UTF8)
 	    {
 	      size_t nlen = NT_MAX_PATH;
-- 
2.51.0

