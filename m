Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id C2F134BA9001
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 02:42:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C2F134BA9001
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C2F134BA9001
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781318577; cv=none;
	b=T0lxJO9Tq7DlPKP+crp+6d8buP3IdKGrsgOTmo9BdXs6Mo3raVT+3CGt11TqBGzK9uDNL0klRYQQkt2gH+cH+XUMk1LCQpWStJR8+e8K9HSrCmXmDvc50ml9+9FkbfyuEkRsA2mi4EcpnEce1OdtzGSU8bR/GRDHuTZecUoUsTI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781318577; c=relaxed/simple;
	bh=eEPFVzwEwqbUZHE1Loo7/Yakjfn31dIt4EbjT8OBpgg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=QnsRjhG05bFrPHzJHVNJ8BVuTdLsq++PtimRT68Qn7kzD4zLYedWlZQfh5Lqa/zLuODM1R92knNAWbx+9kwjEP484p4k6zWTaQpbnED6IiQDfXT6Gxc6L4iS6X7wLTO+KyhP88OLBGxonYchB4SGo4EXygb2fi14od8SyApXP6E=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fRgaVbM/
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C2F134BA9001
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fRgaVbM/
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260613024254655.HZFG.117312.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 11:42:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v2] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN
Date: Sat, 13 Jun 2026 11:42:38 +0900
Message-ID: <20260613024247.1327-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781318574;
 bh=EOupY3DgjVqyWa+8d7cKOOVyfbxvM3xLY0UDMfTTI9g=;
 h=From:To:Cc:Subject:Date;
 b=fRgaVbM/cHKsul43xalXYPPOQ6wlV1PGmvQ8kdHiI+RVeGG3aEoRc90JiSY+lmzv/J8rFvFd
 GQ3S7f12xQ3grbVfxai4K8gXEunZzALvvKN0wcVlSuz3Lh+5i3dH7Sn7ehhAf4Z75OCJ3cuYLM
 71oeFpvdGMNhCgJKTuf9FqP+fjEmtxSwkrNSKkTiUsm8UsMklI7I2F0MEON77zGJSJvugf/YW4
 lN38g3Qr2kiTI3oshKPXMztm3+Nfa7X0E4lbOdsZiR6K/r5swPJpN1PX4Ag3HMxzil15q2t3k2
 9LtiRnCwPMxYpA3j2gG7d2ZPEf5cgzoMDjd0eVQ3ErDEMO2w==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

SetClipboardData() and GetClipboardData() occasionally fail with
ERROR_CLIPBOARD_NOT_OPEN, even though OpenClipboard() succeeded if
NULL HWND is used. Retry until GetClipboardData() does not return
ERROR_CLIPBOARD_NOT_OPEN.

Addresses: https://cygwin.com/pipermail/cygwin/2026-February/259438.html
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Mark Geisert <mark@maxrnd.com>
---
v2: Handle ERROR_NOT_FOUND case. Call CloseClipboard() in the loop.

 winsup/cygwin/fhandler/clipboard.cc | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
index 12691c7c1..a7ca10039 100644
--- a/winsup/cygwin/fhandler/clipboard.cc
+++ b/winsup/cygwin/fhandler/clipboard.cc
@@ -25,11 +25,24 @@ details. */
 static inline bool
 open_clipboard ()
 {
-  const int max_retry = 10;
+  const int max_retry = 20;
   for (int i = 0; i < max_retry; i++)
     {
+      /* No appropriate HWND exists here. */
       if (OpenClipboard (NULL))
-	return true;
+	{
+	  /* SetClipboardData() and GetClipboardData() occasionally
+	     fail with ERROR_CLIPBOARD_NOT_OPEN, even though
+	     OpenClipboard() succeeded if NULL HWND is used.
+	     Retry until GetClipboardData() does not return
+	     ERROR_CLIPBOARD_NOT_OPEN. */
+	  if (GetClipboardData (CF_UNICODETEXT)
+	      || GetLastError () == ERROR_NOT_FOUND)
+	    return true;
+	  if (GetLastError () != ERROR_CLIPBOARD_NOT_OPEN)
+	    return false;
+	  CloseClipboard ();
+	}
       Sleep (1);
     }
   return false;
-- 
2.51.0

