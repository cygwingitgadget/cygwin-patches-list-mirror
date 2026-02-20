Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 6AED24BAD158
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:20:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6AED24BAD158
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6AED24BAD158
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771608023; cv=none;
	b=gIHdXhi1mawHtm3i8y7VX1SQDnQyFnGkaJUlIMWlJl9iVolFJwu+StpThzKfdmHVXM7vmzCWPFFrPxfhaPsYbyKLVFa24PKsLt4Jx2d8JxYkywZ1wYpZqKMVhj9kVjGxd0PXmTuixhqgjyUbf+rl+P6tXI/MAvk0qDAwN/t90OM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771608023; c=relaxed/simple;
	bh=pewCRlcChZscr+5XWobAsyC0zCh7P6qWLyl6sjG4jq4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Y0Myx/IAp5c/+WHGmtyIA3wrq0Q4eYK5J+cIQtl7+HXpDZPEzizdoLUpwpFc+rkOaH90dy0bhDiGF/L+gAzDt1azYSw/bFDZQArJNRRi5Sam1Cqk30bBGdwszp0hR1oEsAih0QmhzFMqjzFSXXq5vwMLk+FsDvhmHnem8J6DCJo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6AED24BAD158
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZIF2+fYU
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260220172020762.HPNS.50988.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:20:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 4/4] Cygwin: pty: Fix the terminal state after leaving pcon
Date: Sat, 21 Feb 2026 02:19:15 +0900
Message-ID: <20260220171937.1969-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
References: <20260220171937.1969-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771608020;
 bh=xqfm6pfNcGzrpIKXC4bLUxjwK7HDvFI1UDm2qXKkHgU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZIF2+fYUiLLAU62sWpCG4K1qggMrVfVSHvYZyHC565AYgU9WPoztgw9crTGEpPQoMIVjl1ZU
 q/0jRJxAZmtzSqrZE846K7wYpZKVi+96RoFSeAcL+w1LrLwOx9KKWIvTJWGYloNY925COnwqsf
 UqRatbtTAbGFjO+01/B1Hq4S/nu+rv55FwF3x70l5rA6UoevNCHZ9q0NP4W8ECpdO0aRRXbcCd
 MBhSMi+svL7+RIP9Kp3e+CZE3C/11513Nn7n1SOIiC1SiyJkatEokgo9xqoirJrbqT0gtxqFTb
 3TFrrjfsww9OIKO8DOlP1vcqD64x4xBAoDyjJY8wwWBe6flw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index 1b818d2ff..4a945a530 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3956,6 +3956,24 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
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

