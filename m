Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id C7E914B920D8
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:05:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7E914B920D8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C7E914B920D8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774443911; cv=none;
	b=ScZ3zwMuak5afZId/L96nXVo8L84ihGTrFrxJ9SwFPZii3qR938M3W5mXpL9V27nXx2pD0HYVaW8uPNJkQqsoxJ0mA3z9OlkHuHi4AYbJqnPCaPOHxYPAFS7UPiZyH3LM3mtPMzEYc9A+/DSp/X1nT5qv6c6c1ypCJXvjcditJ4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774443911; c=relaxed/simple;
	bh=6kSwj7idYuY8zkkXQhugR7awsTsTmpwXNRxD7RG9YE4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=PCPr25cacMzqPMLigKR8T8X2tI9DVPRor/bJ7tj15RXWTeqzaGY0HmP1YDtIMoOyYqPzcnjrrkcfDRl87kq4quvHR9ox8RM5Qenv13uGTIfkOdJQoal6s9wpHXdUfiq9ZyhqiQonIKVUP1FzaoyGJQP2l4f7qaZB6xNx1prjaaY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C7E914B920D8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=B+5EmEIB
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325130509003.TUBX.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:05:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v7 1/7] Cygwin: console: Fix master thread
Date: Wed, 25 Mar 2026 22:04:07 +0900
Message-ID: <20260325130453.62246-2-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
 <20260325130453.62246-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774443909;
 bh=SVe8rISNSTOq25X3TpEApz9G9be51KsshaFhAWvTPJU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=B+5EmEIBiFdkWnifVPLXEKagJq13V5xGYV7w51Iu/ThYNEHZ62tfJ2jPReS6AFshO27/hlj/
 WmwYgVfR0y4JzEkRoG++HgtCDEUOJOe+o7At974Nki7PB4q9esTTCQYx3HeCIu2/UxjOa2pixV
 orvauaeB5w+bQOLzvNlzx2h2FxO0LznPAc/+7+7hcMrYGRZxDbMgF9IC6XnXCW9+bwLB8gOMzA
 IfzGsJTkrsqtJzSrbEvFE/XHr8XWJz21yWutUHMYTqWYgcbJibVVdZrWmxZnh48VHoYtVNuDIm
 Kvvgkfthwi3icTN8AQCRG8oxkM7yG+3lX1Ka/R7tU1wachmg==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

