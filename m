Return-Path: <SRS0=/go4=AY=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:2a])
	by sourceware.org (Postfix) with ESMTPS id A04164B9DB52
	for <cygwin-patches@cygwin.com>; Fri, 20 Feb 2026 17:03:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A04164B9DB52
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A04164B9DB52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:2a
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771607020; cv=none;
	b=QE7KczLjaLOuaQJiSRmwXLVUkFpOyA+zbvf/MFzTjRWchS5OiX64D6RzIhdxavaJV9mS0tsZQ6K0orNASNEQ5Y4zkxruIkNaUd3wv0qvytdhrdLhV1ijQ0309RlBnvcZswgcvtHvf5Foi7e0N3uHlFPlubNqEpWvSjLDOpMqQO4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771607020; c=relaxed/simple;
	bh=fUENt34Or5gwZIgiUaSSC6MnK4v7n/6LeO1tk16w5j0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=v8ISSR4j8YbKrzdrqrX2CZnbynJjt2QhghdZZBkjzEm4eRbbERsQEQsN3ChQf5/gfhQJsev96QIKAuPxa1LRgkOcaNKeeUPPvzoMoOWlOKNCVTcsIuX/VwuOJgqOo2DA4/1NRljMtSSNaghvsrEJ+8KswQrye1eHZk6g877H8X8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A04164B9DB52
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=bn+z/xk/
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260220170337735.KSWZ.83778.HP-Z230@nifty.com>;
          Sat, 21 Feb 2026 02:03:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 4/4] Cygwin: pty: Fix the terminal state after leaving pcon
Date: Sat, 21 Feb 2026 02:02:43 +0900
Message-ID: <20260220170253.815-5-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220170253.815-1-takashi.yano@nifty.ne.jp>
References: <20260220170253.815-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771607017;
 bh=WuP31w2G4O1yUNnmoYiJOBOjrGgeFSyAp6r1KGOZK5w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=bn+z/xk/TkkoK0bnT1wvXNMnBFXqNaWtxJuuzEyNbtWJ2WwRE+mJ4S60NcH1RLbgKfNjSo+Y
 Lr4RijDtoPi+7clSjy75EIMNjtKH4KI+KAkFbKiMIVHddZigFBJPEFhab5Ku17N5FjXQGIp8p6
 jgA1TuZ9C6nXFVXw8VbFLblTgK6Np34NEYP1Xz+1n1FJ0J0dKMInfEkRVGQnMkexiyd+Wm/dGR
 J2anSnEYYpRmjXpoeverSyLBJgHNSPZTx1/VpR5xGmDwizIZAOWC308fUcN6peDipeSuG0Rgpw
 hB5bzPgIHoi4d31OTCv+gK/MV71ncZ0fZje2GI4Q9Bp2Cyrg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

OpenConsole.exe ocaasionally leaves the terminal state in the
"CSI?1004h" after exiting. The is a workaround for that issue.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 1b818d2ff..8518324f8 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3956,6 +3956,23 @@ fhandler_pty_slave::close_pseudoconsole (tty *ttyp, DWORD force_switch_to)
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

