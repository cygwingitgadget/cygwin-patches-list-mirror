Return-Path: <SRS0=SG5m=GM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 94F2C4BA2E1A
	for <cygwin-patches@cygwin.com>; Wed, 19 Aug 2026 05:16:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 94F2C4BA2E1A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 94F2C4BA2E1A
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1787116583; cv=none;
	b=EXaqzC3OBBglsGF6RDd6oOPBSHlZhTOiysoCKCsYHbGGPmoCVD7vJGA+lqkhwsqxSH6LTPuurPkRPVO9BYzeRoAGdx73pkd4SXx8K378kENmjpvkPIGoyNp46esNB4fEUn7D0V1sDd8oOwSc0OYg2j54MSoOFMTxWFvBx4+CR2o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1787116583; c=relaxed/simple;
	bh=wlTGx8mtO/XLpEzIyql+sf+6710a9VV/z/uXD3KX2g0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=li6bZkmDGnYF52O+0H7cHJfv2I3UPXjdkCG4MTuf5PYZD6FfRKeOPQNZ/3djAJQYdZwZu/RlUe8e57Jjo2q9L3745Qh7bK8UHLBQ9q90UZbTWszP3ePLN0q6sPBqRVxhexwWNDw3hPlq+k1xm5K+VeglzoYIfkXoC+Vq5Gm7iJI=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=c6ZtTb61
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 94F2C4BA2E1A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=c6ZtTb61
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260819051619362.BNXX.18412.HP-Z230@nifty.com>;
          Wed, 19 Aug 2026 14:16:19 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2] Cygwin: console: Clear readahead buffer on tcflush()
Date: Wed, 19 Aug 2026 14:16:02 +0900
Message-ID: <20260819051609.128310-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1787116579;
 bh=VHfyVIs6a6wxM/p9p7jH33jSzypmbT6SfHqFMiZrLlE=;
 h=From:To:Cc:Subject:Date;
 b=c6ZtTb61zwRZPZ/0+tWAG1cLJZ5wVU50OmltQVP0DcQrfGt/zGjvLHg58JVgLat2b5WkJXb+
 n4n0IeCqTNeN9LRLDfawTX4yrvtytZ31hdOkQRoGI0O6GhseLto7kkDVhbnHyZcZQBJ1+ktzJV
 VTPxeufuyrEhQpZlHFM3gZUpy0GqfWcQhTlj1Axnbu74CXHm1P6+57fvXokNU2QJRMhHG+bbju
 JgBfhe2UNYfSSMDJxyd3o1kD/Ok7KpCqDNXbDTH7TeDrzv3KjOZVzJU/otAZaZT9OzB3rEqL+l
 FcPP81L7c9ZGPaBUZA4JMAODmeh003TPgUbGYQg4RTd9WRVQ==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, tcflush(TCIFLUSH) only discarded the input events and
did not clear the readahead buffer. Because of this bug, when user
program called select() -> tcflush() -> read(), the last read()
returned the contents of the readahead buffer instead of blocking
as it should.

Correctly, tcflush() must discard all pending input, so read()
should block until new input arrives. With this patch, the read-
ahead buffer and `rapoi` are also cleared as well as input events.

Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
v2: Add input_mutex guard. Clear rapoi as well.

 winsup/cygwin/fhandler/console.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index ba35ca44c..a5887ca8d 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -2351,6 +2351,9 @@ fhandler_console::tcflush (int queue)
   if (queue == TCIFLUSH
       || queue == TCIOFLUSH)
     {
+      /* tcflush() may be called inside the input_mutex,
+	 however, mutex of Win32 can be acquired recursively. */
+      WaitForSingleObject (input_mutex, mutex_timeout);
       acquire_attach_mutex (mutex_timeout);
       DWORD resume_pid = attach_console (con.owner);
       BOOL r = FlushConsoleInputBuffer (get_handle ());
@@ -2362,6 +2365,10 @@ fhandler_console::tcflush (int queue)
 	  res = -1;
 	}
       con.num_processed = 0;
+      eat_readahead (-1);
+      input_ready = false;
+      con.cons_rapoi = NULL;
+      ReleaseMutex(input_mutex);
     }
   return res;
 }
-- 
2.51.0

