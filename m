Return-Path: <SRS0=xrNc=BU=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id 1499F4BB58CA
	for <cygwin-patches@cygwin.com>; Fri, 20 Mar 2026 16:01:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1499F4BB58CA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1499F4BB58CA
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774022519; cv=none;
	b=R9HD80qp3oG3Jsko4MQ9H9P7aH0VpfPi1+3vqX+c/Ysg2L6sImaH5aQbSosreurYvbq8F4BVIb3UfIFWDaUhSUVHFt6jEKcay3AbHmBJKcx3O8S7h2RL92yi+ZNivMgWGI/OvVuldZNAbpg7UZVnKmexdm4MCUBIGBMTun8drZ8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774022519; c=relaxed/simple;
	bh=UoTJibqZwAOn+4kCEa9DGXxk1CjejCs2yDVoKDK0tBg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=st9vYDq3iLhHglDSImmu/5FZ629+aTSe4o3GmwpvJh8y3SnBF+prSQLZnyXSjNcRtOksJTnCDWv3ebidnx6WIRaqjt1Nxtxtq80vyVbQYYFTKBcvfkCG0ySpN7nyGNt0/VceeIqJgOSeY2Im49kC01nMCdOof3MRGMgOmUeo3Xc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1499F4BB58CA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=L+wJ3hHC
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260320160157248.HLQV.14880.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 01:01:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 1/6] Cygwin: console: Fix master thread
Date: Sat, 21 Mar 2026 01:01:05 +0900
Message-ID: <20260320160143.1548-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
References: <20260320142925.8779-1-takashi.yano@nifty.ne.jp>
 <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774022517;
 bh=GPMdX3zl7MciBFGkpLVDOj3oaWWOLT+zyAtW36unR0w=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=L+wJ3hHCoVDpCaQgXEtDxojjC80D0xaqlhES0cHkNBeWPKgrgaTxPvWc0o5pyJVXhLw03ADV
 i40Gx+RnxgCwFTVsdJRMCS7ncqGYR9Mtz4kZNsrubPtIsvmWs8XcZrDQd98sN94oEDByQFVJPB
 87ZDHMiYUuy0IMa5wN8VYb0vcRfKG5Z/JU/R8OnKz4onQqOyXDnxrpT7ge40464HojK29ZNXXg
 tST8XtMH0q463d/hopiS/eyQODG32143RbfYrKfAcZrxxgCHyZs87IOOOhMTAu2sZA+6hl0bHW
 g7HKstWFsgIPOjRr62iPESeDy0dnKkUgcfmSRX1cgd4nyqrw==
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, key event with wRepeatCount == 0 is fixed-up to
wRepeatCount == 1 in conhost.exe. Due to this behaviour, inreq_eq()
returns false even though the two event records are the same. This
patch add workaround for this behaviour in inrec_eq().

Addresses: https://github.com/git-for-windows/git/issues/5632
Fixes: ff4440fcf768 ("Cygwin: console: Introduce new thread which handles input signal.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 9fd3ff506..2f59f8f24 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -318,9 +318,16 @@ inrec_eq (const INPUT_RECORD *a, const INPUT_RECORD *b, DWORD n)
 	     written event. Therefore they are ignored. */
 	  const KEY_EVENT_RECORD *ak = &a[i].Event.KeyEvent;
 	  const KEY_EVENT_RECORD *bk = &b[i].Event.KeyEvent;
+	  /* Fixup repeat count */
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

