Return-Path: <SRS0=Yn/K=BV=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 602AE4BB58AB
	for <cygwin-patches@cygwin.com>; Sat, 21 Mar 2026 11:36:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 602AE4BB58AB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 602AE4BB58AB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774092993; cv=none;
	b=xIiOVbVGCKM0j2HSHizIkV1qFIn/cCmHddL1LX68iFBiKlk+BCnyo+dTneTsVO1DSvq3ASQgVi5ZMg0VFDGuDw3vrXVeb1yiacWUsuOAym3KNy0hxrL0QY9tWZpT16uCMpqV3ecn0g/PpzRgtHSWStNdwVngkvRIyk4TRgecxOM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774092993; c=relaxed/simple;
	bh=6kSwj7idYuY8zkkXQhugR7awsTsTmpwXNRxD7RG9YE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=VMHwQ0PZKBuWJnohc0PyQK9H9iDjfzvBpUne2Q00DD9fKBdsh81lEQa3Bh/RuJitwelm51ZcVKT7W1KGM2pwlYlF7yfUNiESrRX1hJDWrAsbNp+rFZEWnuIAZI5sxEPXNbSjiKRuWRK01w83zwerSCkjcm1lo5x3OXhSrjgvhzQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 602AE4BB58AB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=fQfzEX+n
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260321113629528.VNRV.36235.HP-Z230@nifty.com>;
          Sat, 21 Mar 2026 20:36:29 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 1/6] Cygwin: console: Fix master thread
Date: Sat, 21 Mar 2026 20:35:26 +0900
Message-ID: <20260321113613.9443-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
References: <20260320160143.1548-1-takashi.yano@nifty.ne.jp>
 <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774092989;
 bh=SVe8rISNSTOq25X3TpEApz9G9be51KsshaFhAWvTPJU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=fQfzEX+nlxoV4S4m8/K8or0WcoH9o6DC4ALuEHqjpOSwhUiz8OnUiqclK7wXwo2miQaEK91c
 1Vsg3XEl0uDMxxA+sSvIOZA6E93QXQ6PyPizz1qyFiAmLrKtpp3wlckZPJX2LvAV1ZQNFUZzSm
 69+AdAc9J1TGnq10mWPM3+avhmAjmKLSfLVTBHcUOWdGuc9iIKvf6q4PlrWsOfNtFUKcCR4180
 y6CgditN/bwfTRkkUIMNfWxDfBpRKrRFvVKNz8UP3ocA+oC4A9QV7o046vkSZyD9DI56EIcfpP
 YifUUMSwik7iHGf0NzDrFBNuIM81yT2aHaAPpbhc2/exCGEQ==
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In Windows 11, key event with wRepeatCount == 0 is fixed-up to
wRepeatCount == 1 in conhost.exe. Due to this behaviour, inreq_eq()
returns false even though the two event records are the same. This
patch adds workaround for this behaviour in inrec_eq().

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

