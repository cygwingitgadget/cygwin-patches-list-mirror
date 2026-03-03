Return-Path: <SRS0=xgHh=BD=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:26])
	by sourceware.org (Postfix) with ESMTPS id 4ACD74BA23E6
	for <cygwin-patches@cygwin.com>; Tue,  3 Mar 2026 13:41:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4ACD74BA23E6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4ACD74BA23E6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:26
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772545284; cv=none;
	b=gvP2wq2HRwlvciz0hYugY/Ppp0TlL8BehI9dK5sOqCBO0AHAjkY37fSirFJ+94tHY55zg2nPdKOQUs8wmmowCcfblXh889GDQhhq4PF5U20tIYy5y75TolsuuJnx68XItEBhGvU2bw9Chl5FsLt54MQocqjiEZdu87jbKxIsw7E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772545284; c=relaxed/simple;
	bh=c4fHFa5a1voNqeRfNP+1kaWfxlaoGGFEziRju1IdwOc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Ezp6pV7HfBHevwqi5ixBbS7JOa8H4hL3l0uWUzSNTUgOCuCyk9A8YsHKL25hLy3i0UVyBBZp3NS0k2bldBNie8bxUYe3XRyQCWaRI9Gbj26lMahVeTbwB+6tuTCoj9myTTj5gNjZCb1SAYgvsh9AkbipAzwFKN7PgzJnLOzJ1II=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4ACD74BA23E6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=lakF0mjP
Received: from HP-Z230 by mta-snd-w06.mail.nifty.com with ESMTP
          id <20260303134117419.IPDB.116286.HP-Z230@nifty.com>;
          Tue, 3 Mar 2026 22:41:17 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Fix input transferring from nat pipe to cyg pipe
Date: Tue,  3 Mar 2026 22:40:47 +0900
Message-ID: <20260303134058.3517-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260303134058.3517-1-takashi.yano@nifty.ne.jp>
References: <20260303134058.3517-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772545277;
 bh=PYQkFft/ks+3t/xqVQgwVEitnWU7/amDZ70jNok0n3c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lakF0mjPlOvvieKOCop5YD4RNWpdat4pHGB5CNRaNJkmMXrhXNGPprofJvJNHF7/VUpopLor
 S/xWRhm1Y28uY8ZuEnQRkPGEIJ7CieofuDGUbAZbxLNpxEVKQsZ9uP8zWwgyXhT4NjyPWPKibV
 cz4KCHtjRyP7VQB5dGvYsw/FDEd8DmccgKViH/At1YoPc6K3zmG62RIs2lJgRa+qv0SbNLHXXz
 mhY2/TymHUY1B8ApLPSx7F1VsOOCI9EZ3FHiOa1By+HQ8vDajj/1EBTAh3fqBu6ndHzooehBYg
 vTrBxEzDVmfL9YIuTOH0E0jFDchSLiByMY2tMLHcbQDM0Ukg==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In disable_pcon mode, input transferring from nat pipe to cyg pipe
does not work after the commit 04f386e9af99. This is because nat
pipe hand over is wrongly handled in get_winpid_to_hand_over().
This function should return the PID that should acquire ownership
of the nat pipe. However, when pseudo console is disabled, it
returns PID of cygwin process (such as cygwin shell) when no
other native (non-cygwin) app is not found.

The case that even cygwin app should take over the ownership
of nat pipe, is happen only in pcon_activated case. This patch
adds pcon_activated check to the condition where even a cygwin
app is allowable as a target to hand over.

Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from parent pty")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 3e8c7ff9f..03f31d1fe 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -3596,7 +3596,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *ttyp,
       if (!switch_to)
 	switch_to = get_console_process_id (current_pid,
 					    false, true, false, true);
-      if (!switch_to)
+      if (!switch_to && ttyp->pcon_activated)
 	switch_to = get_console_process_id (current_pid,
 					    false, false, false, false);
     }
-- 
2.51.0

