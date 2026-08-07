Return-Path: <SRS0=Gg12=GA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.227.181])
	by sourceware.org (Postfix) with ESMTPS id 2ED974B9DB72
	for <cygwin-patches@cygwin.com>; Fri,  7 Aug 2026 11:12:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2ED974B9DB72
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2ED974B9DB72
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.181
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1786101176; cv=none;
	b=tf0HdwqYK6W7xa+6IvYnYB/AEjPgGkfIbWyC+c1OVKKisR2nzBko2RXrOSYIyyws1oamoz2xcl9JtHig0XrR2QDNZ/zuLr4RGG/jZVWo+hhD8gxaNTkrQIipttRu+7kPOwZvMBjXOxDxQIQ+JJOtAfjsY4dFGwJCs332ajtVyHE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1786101176; c=relaxed/simple;
	bh=m31JMTjDLe1ev4+Ys1zZpefnLIuWNsXjeLRaCZzNZxo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=x7R7hetThnkaRn565R2secRzsaQYVlZU5GGVVkO4kgWV8+t/Rm0QA+C8Jf9K0MMiUSvBQuTGhKSg4rARgc2WFns9P6cN0i25pe96KxdCKkiPCozj1CTvT9gLN2aYw+yJ8rEMon8m0lv+NggAV9sNJOD45uAeZTqJqaW2/O2kZ5A=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ibUuFtle
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2ED974B9DB72
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ibUuFtle
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260807111254264.RVHU.102121.HP-Z230@nifty.com>;
          Fri, 7 Aug 2026 20:12:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] Cygwin: console: Clear readahead buffer on tcflush()
Date: Fri,  7 Aug 2026 20:12:38 +0900
Message-ID: <20260807111245.2139-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1786101174;
 bh=D8HxWsBndAApp8xtc9iMEbjfVkF5sRzlbFTDsZVO4Ac=;
 h=From:To:Cc:Subject:Date;
 b=ibUuFtlerBYa13VgyMusR0jz4GzidUL8n6bxrQ/W+LnHvvzpRoTW8AM3OWnNa9Jgmq9Ib4Ex
 LbMk3fNDu/gQOELnuI/jZaRIhN/ZO7uFllRqmw3tAtUkYyOPEx3JBPoiH6kBg+tz0ZO63LF5qF
 nITPUJljmxZLwjFq4kO6T+MqTsDlMAY24cWgQSQG+sJJwMFQRuc/5Mz/kY+FDNTWmWHjsZ2tF4
 7uIjQN0q88VN2DnGhNv03n+laFvq9t6NnyoG6eqY/HllPJwJzRXfgxuBvWq/U0FOTEK+Bre4VU
 ZThzl43IjZrHixbRDLnCe01blHO7qZ2Qk6t1U64dzCVX2DDw==
X-Spam-Status: No, score=-10.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Previously, tcflush(TCIFLUSH) only discarded the input events and
did not clear the readahead buffer. Because of this bug, when user
program called select() -> tcflush() -> read(), the last read()
returned the contents of the readahead buffer instead of blocking
as it should.

Correctly, tcflush() must discard all pending input, so read()
should block until new input arrives. With this patch, the read-
ahead buffer is also cleared as well as input events.

Fixes: 8382778cdb57 ("Cygwin: console: fix select() behaviour")
Suggested-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/console.cc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
index ba35ca44c..d3fb2fcbd 100644
--- a/winsup/cygwin/fhandler/console.cc
+++ b/winsup/cygwin/fhandler/console.cc
@@ -2362,6 +2362,8 @@ fhandler_console::tcflush (int queue)
 	  res = -1;
 	}
       con.num_processed = 0;
+      eat_readahead (-1);
+      input_ready = false;
     }
   return res;
 }
-- 
2.51.0

