Return-Path: <SRS0=vXQ3=A3=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id D7B8F4B9DB55
	for <cygwin-patches@cygwin.com>; Mon, 23 Feb 2026 08:02:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D7B8F4B9DB55
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D7B8F4B9DB55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771833760; cv=none;
	b=EaQ8sfVDdTfgGcf2LoAWhrWPF0I4f2X83FhqGpD3OvDrI5PDJHp/bmds4Hkt8F0rTTucwplpI48K71mzSpiYnQDxVIosJ2dBDCM6GR/SWqzijPEyRhib1/vnapatCJm6ZsQr41FrEdwjLKBGo3hpOGU2QFrtReIwwZJ8S0dwk6M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771833760; c=relaxed/simple;
	bh=DQ0MsS5dmzHBSLshDM7EuTa78wTOirLEnaeCiz8Vbvg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=eIMiNE2/8PhU6tGlqAmqWAKJAIous9NethGPNbqdTk3hOKkNnBuCWR1tNgX1eR6fGTYa96cvgmtfU5cFdQjvINIPBnl2Ct5Dp0/xL6xRvJyIa/CK3U+m5lkjp76qw+h6usX7FJN2j57P1RIBI8eVRpU6ijsHofO808HyO+4ehkU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D7B8F4B9DB55
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mKq1065x
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20260223080231221.UFUL.48098.HP-Z230@nifty.com>;
          Mon, 23 Feb 2026 17:02:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 4/4] Cygwin: pty: Fix the terminal state after leaving pcon
Date: Mon, 23 Feb 2026 17:01:30 +0900
Message-ID: <20260223080141.340-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260223080141.340-1-takashi.yano@nifty.ne.jp>
References: <20260223080141.340-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771833751;
 bh=qUb02Tg5hAC4PVqk0gHluLhb7l9Kms1xmB5gDh8E6BU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mKq1065x/S2m50nMq4ncav8xqz5wr48NlgpNGV6tGcda9oXdmLEilZuHDwdpH4ntS/Pppp1P
 SeixIwUr7QxwuOr9D4ZVc6xOWD7I8vL1MT4gIcL52BYJ40hooa/h66ye8L31d9OJyYkjbQSK0k
 Y6G6rynWau68FLcEiy2c8RttpPS99DyLxHy7irD0Y1H7B/yx5Lt72dg/M7c9l0abu1mYjOcDWq
 nT+Q+0ERZFPoMLleeaEe9nuWEa4PpYNx/kdyVnMGUa9XjLHW40HPqwjAlTTWift9mb9jSZVykf
 4AokNEpPlcCzLMB/lgfD3eYGmZpNhwIMr6NI3ya6JLSB+2GQ==
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

OpenConsole.exe ocaasionally leaves the terminal state in the
"CSI?9001h" (win32-input-mode) and "CSI?1004h" after exiting.
This is a workaround for that issue.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 6b114c795..b30cb0128 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3952,6 +3952,24 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  ttyp->nat_pipe_owner_pid = 0;
 	  ttyp->pcon_start = false;
 	  ttyp->pcon_start_pid = 0;
+	  /* OpenConsole.exe ocaasionally leaves the terminal state in
+	     the "CSI?9001h" (win32-input-mode) and "CSI?1004h" after
+	     exiting. The following code block is a workaround for that. */
+	  do
+	    {
+	      pinfo p (ttyp->master_pid);
+	      HANDLE pty_master = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					       p->dwProcessId);
+	      HANDLE to_master_nat;
+	      DuplicateHandle (pty_master, ttyp->to_master_nat (),
+			       GetCurrentProcess (), &to_master_nat,
+			       0, FALSE, DUPLICATE_SAME_ACCESS);
+	      WriteFile (to_master_nat, "\033[?9001l", 8, NULL, NULL);
+	      WriteFile (to_master_nat, "\033[?1004l", 8, NULL, NULL);
+	      CloseHandle (to_master_nat);
+	      CloseHandle (pty_master);
+	    }
+	  while (false);
 	}
     }
   else
-- 
2.51.0

