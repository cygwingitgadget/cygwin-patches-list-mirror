Return-Path: <SRS0=4mOZ=BT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:29])
	by sourceware.org (Postfix) with ESMTPS id 515D14BB593E
	for <cygwin-patches@cygwin.com>; Thu, 19 Mar 2026 17:46:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 515D14BB593E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 515D14BB593E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773942414; cv=none;
	b=izZ2al5b0cIrKYQedS2oh7I03QATUvmy0lD9ZoHeh9CdMvC5GJX5iw2bDAPhdmSkU8sclqd3d4tA0DEEM7KiWZALww3bLN6uDGJoP6kkOLC+usTukKdhlVplhkKP3vu5IV2fuz5DmckD+WRbvt+U9D2jJTuszrnC5LNgLIDIvTU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773942414; c=relaxed/simple;
	bh=ooe5tjDY/R/sGIUOyH7It75PGl7b9WOu3cWbQdh3Nyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=vb70t8AnGdnRNllJIg3nJ+3Czmx0oQdyqAhq87Sey/pYbuo1M1IUkDfIL2uB9q34qHrVmL7/xJXA6AWn7A0jBACAuWA+zBoiioCLB3x5m47peJrZ/5GhrlX2qyMyL24isCk31U3Ln5ffRt08xu4P8Eifx/VDjNJTwQ5gaupa6cI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 515D14BB593E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=a71i9J5T
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260319174651439.IIXN.58584.HP-Z230@nifty.com>;
          Fri, 20 Mar 2026 02:46:51 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Clear discard_input flag on master write()
Date: Fri, 20 Mar 2026 02:46:34 +0900
Message-ID: <20260319174645.3469-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773942411;
 bh=rp6RTNMkUO2xG8C1xnV+N/Vao/8KdL/rn11XGCz/Vmo=;
 h=From:To:Cc:Subject:Date;
 b=a71i9J5T6o7boActrjKCsUyO2v5rd2M67oVZxMkOH14GKlCrYbXUulclXBLeY9yEMzOL+6OU
 z/6vepw3y+8PkvO+JIsaj2Ibxxkm44g8ofDQA7udQEzgpkEk8r5X9NZqjeRxCSPYGkW3DNsrLw
 cv/ICpydV9SNFjHuXcX19jzcbakV/JmLn1YdmVytHbJkAuV7BmEmGWc8g/RBQw8Pp+byQgY7P2
 KX7kyc09zIvvBwn1J7dXksLLCV8075GRt+x1DeZE+bbeNSBxvwuKhPqsR3XrYi5rim5/jYV0Rj
 iLDIVgwM6OhtDGPqPsCLpls40CIkuvT9X5pQ/auc+8kKnVlw==
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Currently, the first transfer_input() after Ctrl-C does not work
because discard_input flag remains asserted. This can cause loosing
typeahead input for non-cygwin app after Ctrl-C. With this patch,
the discard_input flag is cleared on master write() because the
input is new valid input after discarding input.

Fixes: 4e16e575db04 ("Cygwin: pty: Discard input already accepted on interrupt.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 0c50e50f5..c05462d1f 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2224,6 +2224,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
 
   push_process_state process_state (PID_TTYOU);
 
+  get_ttyp ()->discard_input = false;
+
   if (get_ttyp ()->pcon_start)
     { /* Reaches here when pseudo console initialization is on going. */
       /* Pseudo condole support uses "CSI6n" to get cursor position.
-- 
2.51.0

