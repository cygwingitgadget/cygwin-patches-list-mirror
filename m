Return-Path: <SRS0=diAQ=HK=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 0672E4BA9032
	for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 01:32:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0672E4BA9032
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0672E4BA9032
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789695158; cv=none;
	b=UUPm5qGXl397gz2ex8w3dDpUxTOWCr4DwoVnwk19qOXKINXCH9dPNMggkybbNQ0OBSkFszkjzm7MWdFrO6No3d26TIvLV7+zekwliYej/OnqSHqtvywFnfetRUkIbImB6f80EFFKEtVkR5NUXXyMRtjntEdmLmOBBVfyBFvSs5s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789695158; c=relaxed/simple;
	bh=sDze8NxXdiL88+oeYAdPaBhUmq7YjxJ4tV7o0/M5ivs=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=BZrsiAF/hp602FG9Wf0CPg5moOhcwBYlO2jLd1oldzDQtrrH8sOkeqvPxx6HS2f+yUaVy9zFdb/t74bpWGkl28FnmWeirRQYziGvJoX9fQgrxyMRMnUzikIxjMrhx2wIFPhcb/6Fsd3RwmMh4PfpvQxOKkvf5n8E2GuXehe+HqU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gsEzDGat
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0672E4BA9032
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=gsEzDGat
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260918013233183.KBBE.17441.HP-Z230@nifty.com>;
          Fri, 18 Sep 2026 10:32:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Shun <shun1048576@gmail.com>
Subject: [PATCH] Cygwin: clipboard: Handle ERROR_SYS_KEY_NOT_FOUND and NO_ERROR
Date: Fri, 18 Sep 2026 10:32:10 +0900
Message-ID: <20260918013226.1205-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789695153;
 bh=BYq3JL5D7sahiMoht2Bgx1PMY+/atBspDl8RFbVC/D4=;
 h=From:To:Cc:Subject:Date;
 b=gsEzDGatmL6jX4IBofTFghz31WUDdzTin+B9e/8N6UpfCqyz1Hghsx0Yq0/R7/vdnI1jRw+5
 3juksERwsFF5hakDljaiAOYdTk8XJ8o7quPzXMqmZXYBjXgBiKO7PsqG4tyyalAUmZSI1alQSU
 SIa5HHTv2dMyxLg0gp8v9gCDPnz5LrzgdGhgRs1iCETdFkz0YjDs/z+/Ydn08Zye8H1Zuzl8Ce
 59529cT6LcxoRq2lqG9EnJrgl9VGatd7CKaDKERU4ZPhivICUUIvjRvt1gDtSDNWcstaMv9czK
 CbqlbMpB8RQ5G+nADQJsIzkroQO/GDtDQBHIMUdO6RuaG/6w==
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Windows 10 seems to return ERROR_SYS_KEY_NOT_FOUND instead of
ERROR_NOT_FOUND. In addition, it returns NO_ERROR even though
GetClipboardData() returns NULL. This patch handles these cases.

Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260058.html
Fixes: 7fd670a36b9a ("Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN")
Reported-by: Shun <shun1048576@gmail.com>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/clipboard.cc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
index 116feb599..391f21051 100644
--- a/winsup/cygwin/fhandler/clipboard.cc
+++ b/winsup/cygwin/fhandler/clipboard.cc
@@ -41,7 +41,10 @@ open_clipboard ()
 	  DWORD err = GetLastError ();
 	  /* Here, ERROR_NOT_FOUND means the clipboard does not contains
 	     valid CF_UNICODETEXT. OpenClipboard() must have succeeded. */
-	  if (err == ERROR_NOT_FOUND)
+	  /* In Windows 10, ERROR_SYS_KEY_NOT_FOUND or NO_ERROR seem
+	     to be returned instead of ERROR_NOT_FOUND. */
+	  if (err == ERROR_NOT_FOUND || err == ERROR_SXS_KEY_NOT_FOUND
+	      || err == NO_ERROR)
 	    return true;
 	  CloseClipboard ();
 	  if (err != ERROR_CLIPBOARD_NOT_OPEN)
-- 
2.51.0

