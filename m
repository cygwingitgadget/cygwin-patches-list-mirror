Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e09.mail.nifty.com (mta-snd-e09.mail.nifty.com [106.153.226.41])
	by sourceware.org (Postfix) with ESMTPS id E217E4BA23D7
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:56:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E217E4BA23D7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E217E4BA23D7
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774695412; cv=none;
	b=IsZ1rO18hJHUgRwguT11Tgk1Jp8E6m3h1/UwZ33jCE9Wf/FyaccsyzAsHcUy+bd2WUAgVULjGIffN/zwwRwNQ8a4C6QHtlNedW2sIEQ+fJ9WjMjcU6KpVdfdQmC5FdCNI2vbasLFQRgDGag2ei1HTWpDlI2Qm1WmUqSbiCU+GJM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774695412; c=relaxed/simple;
	bh=QJIGywbUgs5eWoogVpY3W2BAm5tfWJ040cFXQZVA8TU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=gw24DPyM6DWIECInRuF2YBx4DTSTBhR5Zz8BGu4Y0RWYF8mZj+RmSZtN3YalcFWzz12tDoffDa+/3VnHY6v2WQf2hSnfe0UGSydP/vwakDYzDkMzOZzinrDBsj7S19I8lIFMWmPNYXCrTCaPSC+RHylDNCyy9vk+hTJwFfB6wKY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E217E4BA23D7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Ttje3KEo
Received: from HP-Z230 by mta-snd-e09.mail.nifty.com with ESMTP
          id <20260328105649212.LDAC.58584.HP-Z230@nifty.com>;
          Sat, 28 Mar 2026 19:56:49 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v8 1/7] Cygwin: console: Fix master thread
Date: Sat, 28 Mar 2026 19:55:45 +0900
Message-ID: <20260328105632.1916-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
References: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
 <20260328105632.1916-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774695409;
 bh=sBM3Bs3CtXwQukHAr7I1fzLiIq4Eex53nj60V9HE88w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ttje3KEoxZD5wyeHy9gX03y4SfFG1ss7+3dSMyyupW7PbMrtpJBwU99n1eYp0EfyPTNZkjjQ
 avbDfWOTRVKyXL37RSNTfBb/Vs6QvDjQzbZUT7aLJRGIQjLsRWpBtpYDyPHIYoFlu8hqerEmVw
 KDGvJy365ejJ+k67E/Pk8FDAhoLYHlS4BxiLwdWvWDlpkMAJVAM6svcP0jGoOzXQjhK2yqyTSp
 U9+IWvDVNd2QO2RMJ0hvQtkkwUtEGL0Q0/e7HVSMiUJ6j0CsoXgLTgNygjidwrOMUC0aS8o6Yf
 ABPbn0ap92jhVXRhbmwkQakUgcq880JWWNqs6QaNbWxylIuA==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, key event with wRepeatCount == 0 is fixed-up to
wRepeatCount == 1 in conhost.exe.
https://github.com/microsoft/terminal/blob/v1.25.622.0/src/host/inputBuffer.cpp#L406

The console master thread (`cons_master_thread`) reads INPUT_RECORDs
from the console input buffer, processes signal-generating events,
and writes the remaining records back. After the writeback, it peeks
the buffer and uses `inrec_eq()` to verify that conhost stored the
records faithfully. On Windows 11, conhost normalizes `wRepeatCount`
from 0 to 1 on readback, causing `inrec_eq()` to report a mismatch
and triggering an unnecessary fixup path. Treat 0 and 1 as equivalent
for comparison purposes.

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: ff4440fcf768 ("Cygwin: console: Introduce new thread which handles input signal.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 winsup/cygwin/fhandler/console.cc | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 8b4491daf..2f46bbc6c 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -318,9 +318,17 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 	     written event. Therefore they are ignored. */
 	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
 	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
+	  /* On Windows 11, conhost normalizes wRepeatCount from 0 to 1
+	     on readback. Treat them as equivalent for comparison. */
+	  WORD r1 = ak->wRepeatCount;
+	  WORD r2 = bk->wRepeatCount;
+	  if (r1 == 0)
+	    r1 = 1;
+	  if (r2 == 0)
+	    r2 = 1;
 	  if (ak->bKeyDown != bk->bKeyDown
 	      || ak->uChar.UnicodeChar != bk->uChar.UnicodeChar
-	      || ak->wRepeatCount != bk->wRepeatCount)
+	      || r1 != r2)
 	    return false;
 	}
       else if (a[i].EventType == MOUSE_EVENT)
-- 
2.51.0

