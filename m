Return-Path: <SRS0=9YkS=6Y=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e10.mail.nifty.com (mta-snd-e10.mail.nifty.com [106.153.226.42])
	by sourceware.org (Postfix) with ESMTPS id CD8D24BA2E26
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 07:27:42 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CD8D24BA2E26
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CD8D24BA2E26
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766042863; cv=none;
	b=NEeeHF1r3j6kmFFuvtNoXY68jY9XWIt9yNzYRODYLf6JwzB6h8I5pKeJwHG2Yp3xjviYQy2xQ4THyiVHmENpvmWFIl+lL9tg92Za8z+KwxMMtqyTgHl+jdO0Ok/SpUdlJigxVRPwXRNrVza6wxABUhxAUfWBJ21ZMKuchnol23E=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766042863; c=relaxed/simple;
	bh=Yq/RgaIhfwZju2uyZUI1hM8JLW88vV3ov8RxcDt/NKY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=fYsAIaHwLknJ3oW/Hi7u4x79qa6GBM2v4iyCdtE0zvS8dlZwT9I1st/x0u+i3ckUNfNR8so9sH0g9Ju+Up7iQE8jXgnTIEMz2CS1rjZ08l1yBa4MEs7G+IzOzbDx6NF/7Fe+7xWOiv17f64gqHF/yyt3OSFyXNAIakuNPYglfs4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CD8D24BA2E26
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XfSgXWC5
Received: from HP-Z230 by mta-snd-e10.mail.nifty.com with ESMTP
          id <20251218072741094.HHFI.4197.HP-Z230@nifty.com>;
          Thu, 18 Dec 2025 16:27:41 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Corinna Vinschen <corinna@vinschen.de>
Subject: [PATCH v2 1/2] Cygwin: pty: Fix ESC sequence parsing in pty_master_fwd_thread
Date: Thu, 18 Dec 2025 16:27:02 +0900
Message-ID: <20251218072722.1634-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251218072722.1634-1-takashi.yano@nifty.ne.jp>
References: <20251218072722.1634-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1766042861;
 bh=PyWqqoj5UEMEGq36W1H7Qfy633iwzSRWOXTb5yHo0Cw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XfSgXWC5qOjSXrB4acte7I6+xzgz0ELv6y/HZh2+ccBMR6qtgJ5R4wVTrMuk4yZqfvZCNsI6
 X4ZpS5nkzG8jNzyYT7aD8fdrgKxdGKh+l8gvDja0VIK8da+RiEMi61hMEdgPb3WqumDyzWr+QJ
 I8TSMvWcjIsiOrldZYL9bwYNBhFWl+mQoGDRUCKFrEuuTPmwILjRwvSyH33h61qx80b2JzVEdL
 s7fuSRUk/jYu7qPlGbr8Z7gU6EOk1b+cx2ETBmsHJVf00IPLBsOLu5KRg8i1lxr/Opf+2nlaAI
 YKm3b6OhzMYpUwHJA8JoBPlrrhsR/dod0Hx04Ov8Tfzdr++w==
X-Spam-Status: No, score=-10.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch fixes the bug in ESC sequence parser used when pseudo
console is enabled in pty_master_fwd_thread(). Previously, if
multiple ESC sequences exist in a fowarding chunk, the later one
might not be processed appropriately. In addition, the termination
ST (ESC \) was not supported, that is, only BEL was supported.

Fixes: 10d083c745dd ("Cygwin: pty: Inherit typeahead data between two input pipes.")
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
---
 winsup/cygwin/fhandler/pty.cc | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 679068ea2..3b0b4f073 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2680,7 +2680,7 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	  int state = 0;
 	  int start_at = 0;
 	  for (DWORD i=0; i<rlen; i++)
-	    if (outbuf[i] == '\033')
+	    if (state == 0 && outbuf[i] == '\033')
 	      {
 		start_at = i;
 		state = 1;
@@ -2688,12 +2688,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 	      }
 	    else if ((state == 1 && outbuf[i] == ']') ||
 		     (state == 2 && outbuf[i] == '0') ||
-		     (state == 3 && outbuf[i] == ';'))
+		     (state == 3 && outbuf[i] == ';') ||
+		     (state == 4 && outbuf[i] == '\033'))
 	      {
 		state ++;
 		continue;
 	      }
-	    else if (state == 4 && outbuf[i] == '\a')
+	    else if ((state == 4 && outbuf[i] == '\a')
+		     || (state == 5 && outbuf[i] == '\\'))
 	      {
 		const char *helper_str = "\\bin\\cygwin-console-helper.exe";
 		if (memmem (&outbuf[start_at], i + 1 - start_at,
@@ -2701,11 +2703,14 @@ fhandler_pty_master::pty_master_fwd_thread (const master_fwd_thread_param_t *p)
 		  {
 		    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
 		    rlen = wlen = start_at + rlen - i - 1;
+		    i = start_at - 1;
 		  }
 		state = 0;
 		continue;
 	      }
-	    else if (outbuf[i] == '\a')
+	    else if (state == 4)
+	      continue;
+	    else
 	      {
 		state = 0;
 		continue;
-- 
2.51.0

