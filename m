Return-Path: <SRS0=y1f5=EJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 54B3A4BA79AC
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 02:54:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 54B3A4BA79AC
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 54B3A4BA79AC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781319263; cv=none;
	b=FFcffwNUJGQtrT7iNy4wAkx7JiQ60uxU322eQuHpP6/0s0dPa5z/+BudHCSqtCrvz56xoD9u1VxoyCoMqYStBfQB6kyjcvwkkij+s7uy/HJoqxoQXYTr/2yrrNEJ/YXHXcxhN3tCZl0MdqWIgVc3OWeA+z/raEwEfrm34n6z2Hk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781319263; c=relaxed/simple;
	bh=R4sLZEdSMp6lmRq32FrTlS+5qiP2Ac3d8Sax78k+ZDw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=xA4C8QeFBbps0+4vsu4BHmJJDT/c/i3YCfobw3gQuk98EqBnCvUXEEyYba6E1ffXIH8hRtwZJ4i6i3AKh5vfVevGv4xaYQwjEcyat6Ayx37qE43R4hxSj9bLwKrIAYl7gQemqMg4oG6XLindK4PZ7HmLsp7bS9Z5wLny6BDsepc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kHGvETsW
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 54B3A4BA79AC
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=kHGvETsW
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260613025420340.IDDT.117312.HP-Z230@nifty.com>;
          Sat, 13 Jun 2026 11:54:20 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Mark Geisert <mark@maxrnd.com>
Subject: [PATCH v3] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN
Date: Sat, 13 Jun 2026 11:54:01 +0900
Message-ID: <20260613025412.642-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1781319260;
 bh=FLVLxfqlrw0DEk7809RQLhrlAMMmdZ3T69i0MqdPQrk=;
 h=From:To:Cc:Subject:Date;
 b=kHGvETsWcmx8grZd1NBcEpjHY2QYhsVoDwS4zhY/Z5v1eXU3/Qrb+I8eJEY+akgAP0fd8hnf
 NyhqbqGreUVQJ0+fG0FrbivMY2ul46v9/iJMb7fueTXCcWQbVyjs10eDnwLnasFkJbeTohpKL/
 oKxwNY/0UjtMkTUzFz29sfdnjbE22dkYr86WemOVpirwOKRmvrqgVAq/I/IdLwfmvl47uhg4Sx
 6rDdj46zRxO02BjsTZvyUe+ZkARWBfWALD5V7hyHtjvxhPnCww9GSPDM79Z+IpdNuU+Z9kuqJd
 prPEkbrLuMJ5pT5f+lD8te8cweaLqpnsUxwqhf/5E2VAXe4g==
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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
v3: Change the timing of CloseClipboard().

 winsup/cygwin/fhandler/clipboard.cc | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
index 12691c7c1..1273863f4 100644
--- a/winsup/cygwin/fhandler/clipboard.cc
+++ b/winsup/cygwin/fhandler/clipboard.cc
@@ -25,11 +25,26 @@ details. */
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
+	  if (GetClipboardData (CF_UNICODETEXT))
+	    return true;
+	  DWORD err = GetLastError ();
+	  if (err == ERROR_NOT_FOUND)
+	    return true;
+	  CloseClipboard ();
+	  if (err != ERROR_CLIPBOARD_NOT_OPEN)
+	    return false;
+	}
       Sleep (1);
     }
   return false;
-- 
2.51.0

