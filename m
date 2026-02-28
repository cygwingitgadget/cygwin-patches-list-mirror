Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 317904BA23D6
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:03:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 317904BA23D6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 317904BA23D6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269420; cv=none;
	b=o0qCqCiQEJldgfNGi/TKSfMgt926nFAcU+kQi0cnx5ndUbxPr9SR3zBVoWHRLLcMKrq/wpcJQ/xzAblMn+NOWXsyVsyyakM/kJXIltENx/dy0qP3EahOpBGcbCbHX8lwnNPty3E3YZfBFLo7NE3Z61haKlKduhoBjF873BXb+Ec=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269420; c=relaxed/simple;
	bh=dq7eIMHlHTLqjZ90pl0/baL8pcK4HtCDhGmRetI//FI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=j7wAFTc4zKx5VHihecalIxiABrpXdhld9Y7EmO90DTp37guy9WzPHRnwmJd7P2duOppH0TUWhlOh/5XKx8SJidYPJsPcU4GwDbFRuEzLfs90Y84/ueSR7E5cTWZhkTHvA3wrwoQKiQAbAPJ0jghyuvDYabP5Ci0Shbq4k218Hs0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 317904BA23D6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Q49OZmGc
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260228090338222.YDZB.127398.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:03:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 4/4] Cygwin: pty: Fix the terminal state after leaving pcon
Date: Sat, 28 Feb 2026 18:02:53 +0900
Message-ID: <20260228090304.2562-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
References: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269418;
 bh=4zJGk9ssYzIuOBwfODAxlEOZQpUQi2OSAkp5viVnb58=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Q49OZmGc1v0VkfkjSniOdoA3BS80pJmk56EmRJTxNyyY7ftrNNKji1X5aSwja2plmS56CvNG
 bOn18apIUo1P0YSOYGWcyXXTvn3HmPj8te+Ji+09/sP+T1xicosZr3A9xDj88xE8SZkMjL+FSw
 2pbX0lsC6orrNeDB9lKSOEc4OUoQ8WcQmxTldR+X/x6SlMf41sPb0Dlnc++QFiWWc2iehzes/k
 1tsSXHqH/HWiYxl+SNq3YCA85kM5x7F38ESWsi7Ljl8LGRjxUDOvjPvkvw7s8PPnmxBN4Ht789
 4NRfTNSmqgOXVA3/O9BsIAu92Q6VX9aKaYRlqTQFENZGghcQ==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

OpenConsole.exe ocaasionally leaves the terminal state in the
"CSI?1004h" after exiting. This is a workaround for that issue.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 9a175e722..6c9572007 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3990,6 +3990,23 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
 	  ttyp->nat_pipe_owner_pid = 0;
 	  ttyp->pcon_start = false;
 	  ttyp->pcon_start_pid = 0;
+	  /* OpenConsole.exe ocaasionally leaves the terminal state in
+	     the "CSI?1004h" after exiting. The following code block is
+	     a workaround for that. */
+	  do
+	    {
+	      pinfo p (ttyp->master_pid);
+	      HANDLE pty_master = OpenProcess (PROCESS_DUP_HANDLE, FALSE,
+					       p->dwProcessId);
+	      HANDLE to_master_nat;
+	      DuplicateHandle (pty_master, ttyp->to_master_nat (),
+			       GetCurrentProcess (), &to_master_nat,
+			       0, FALSE, DUPLICATE_SAME_ACCESS);
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

