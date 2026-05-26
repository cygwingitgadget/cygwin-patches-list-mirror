Return-Path: <SRS0=6Hi8=DX=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 30C914BA2E35
	for <cygwin-patches@cygwin.com>; Tue, 26 May 2026 09:52:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 30C914BA2E35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 30C914BA2E35
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779789156; cv=none;
	b=WJxDzmX9iOO2xUvBp913mg/CFVjE9RpkiQCAja+5J7WKiPk36w3W3Rqnps1TO8Pm1fBA3LIRtXolx7Fn3Br5NuxkuVhF+EdpAwFRqjeC0HAatYHlqdQuMREViq3prmOhqf0GapEJdnD+6fqtv4DlDB2p2xU0+hXq4IMNHIZp//o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779789156; c=relaxed/simple;
	bh=Cz9EDiRoCBwfoCl8gXCMfHiTLpqx3Tw6aimOH6I31kg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=SRTCfXATfKHOv7LGXbw7BqkiZ4tmaPTHEGBaZPXGjiUdq4lpIegpw1Ph+voXje1jMq7ykoMyyT64JZhfHiX4UyaGKBtpD887FSHjqjth7d91ZQInGAeKUaWSeL8JQqdbK3dl5m4trtUs8kMnntuH+o2KANrkoh+EuMUH/iw7hYE=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dlIB0iX+
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 30C914BA2E35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dlIB0iX+
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260526095231126.AVV.117312.HP-Z230@nifty.com>;
          Tue, 26 May 2026 18:52:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: console: Fix handling of surrogate pairs
Date: Tue, 26 May 2026 18:52:15 +0900
Message-ID: <20260526095224.1958-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1779789151;
 bh=CTrLFWLr/lmRnLzGWEZcPsz+xpBZ1D7RPFSXYzRKx0Y=;
 h=From:To:Cc:Subject:Date;
 b=dlIB0iX+dWN8nWYnqehI4ZIFhfeMd7yMnJ+qTvfrbUENCe8FB9o3gICSYChNzrllIBf4G3ed
 bqOA/KLzIs9HO381F0GihkE9TNAk4m3c3xq+qC7YwbAD2mA5JPZM69fgM41vL38UIT27WmewGa
 XpiPjehR1coDm6znzpZxH361mjTPRg8rLoPNuvsPLrXoBNVi1O4Tvv3pey7mMpLUdYQzZNTQSV
 LH/c3fRH8PQqhQ88+vDRzqNWjf7hJrDat/C6KUcBI/sk3ve/4H0zEODmP68rMeLgVt6a0s4X6l
 0kh62RtuFr+fD19ePlkzqwtugtdDVVg8lE3JpyHafqOxfVOw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The commit 782aac590af7 introduced surrogate-pair handling. However,
it does not work as expected in the legacy console. This is because
a KeyDown event for ALT key with UnicodeChar == 0 is inserted the
between surrogate pair. The current code reads the next key event
unconditionally for the second UnicodeChar, but it is not correct.
This patch searches the next appropriate key event with a valid
UnicodeChar, ensuring that the second code unit is valid.

Fixes: 782aac590af7 ("Cygwin: console: Handle Unicode surrogate pairs.")
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index 6fd4cd965..45eff6efe 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -1452,9 +1452,21 @@ fhandler_console::process_input_message (void)
 	    }
 	  else
 	    {
-	      WCHAR second = unicode_char >= 0xd800 && unicode_char <= 0xdbff
-		  && i + 1 < total_read ?
-		  input_rec[i + 1].Event.KeyEvent.uChar.UnicodeChar : 0;
+	      WCHAR second = 0;
+	      DWORD second_pos = i;
+	      if (unicode_char >= 0xd800 && unicode_char <= 0xdbff)
+		for (DWORD j = i + 1; j < total_read; j++)
+		  {
+		    /* Do not check bKeyDown. bKeyDown is 0 for surrogate
+		       pair in legacy console */
+		    if (input_rec[j].EventType == KEY_EVENT &&
+			input_rec[j].Event.KeyEvent.uChar.UnicodeChar)
+		      {
+			second = input_rec[j].Event.KeyEvent.uChar.UnicodeChar;
+			second_pos = j;
+			break;
+		      }
+		  }
 
 	      if (second < 0xdc00 || second > 0xdfff)
 		{
@@ -1465,7 +1477,7 @@ fhandler_console::process_input_message (void)
 		  /* handle surrogate pairs */
 		  WCHAR pair[2] = { unicode_char, second };
 		  nread = sys_wcstombs (tmp + 1, 59, pair, 2);
-		  i++;
+		  i = second_pos;
 		}
 
 	      /* Determine if the keystroke is modified by META.  The tricky
-- 
2.51.0

