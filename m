Return-Path: <SRS0=g9mI=BJ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 6FC594BA2E11
	for <cygwin-patches@cygwin.com>; Mon,  9 Mar 2026 09:24:54 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6FC594BA2E11
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6FC594BA2E11
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773048295; cv=none;
	b=w6msNXGceHrm7EGv3licQJXMc9McdFuqh4jsMv0o1g/7JqjaJmOexk2YuWYHq4gEQLIz+IAkSbZJ48s2/rZCal27e6DXsrtY/iZEIm7k+RnAj0XGYeBaoadO2ZF4o9MTJVplJorXL1fQC0WkF9A2NKkFNZf6hXO/0nx/RKyCQc0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773048295; c=relaxed/simple;
	bh=sXULPLSucDoTgBN3UvViRUy5z0JeEm7Z3liJFzd6Imo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=VoTPcUYAWybRAevn8mPm447BB8FFeBgE4ZtcPLFs6x+jrh2o9B8JCuJz1LhLvQBkGgH9bFHbxcZ9r1KCD7+PedztrzBlUs5FgQBc6lV5nArK4nvqAYi4aH40ebqsc1f+KzizMU3XxAccMFVkLUqzEaWdO4qNqIToUdspEHu347o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6FC594BA2E11
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=QjH47erc
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260309092450721.ZLRF.19957.HP-Z230@nifty.com>;
          Mon, 9 Mar 2026 18:24:50 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH] Cygwin: pty: Omit CSI?1004h/l from pseudo console output
Date: Mon,  9 Mar 2026 18:24:29 +0900
Message-ID: <20260309092442.1502-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773048290;
 bh=iL7oZ1SpnLaeqVyj2vzDAWlWsbVl+733Q6DVtP98IPk=;
 h=From:To:Cc:Subject:Date;
 b=QjH47ercDb0Xa114xlZs+8oOLJZnYVADPH4AQ1R8jCmrhZBHRWaDEI6HthdXm/coGjmuudLj
 UpOPoCBGhppagmvu0dQTH0CIXwywtBfVG0ryZbaBl99PK6i1/QfWglblmd/1EgWGgsgSG0Ovu2
 lSZo8f/QqFqjsCAE/Gb60SyNa143sq/2INT4rwnf0lzU34Vk+9PMjHTV+v6S8vYFjp+qayjzHk
 d2QuaiaROVml0g0jmU++6Vrzg7ER6j/WZPNKizpr0OqjF6IdkHSjUn0eJV+Qj6fb5dmIrhTutV
 kLjEU+QtDhjN0uX6xJuvCxME3Oq18niACv8y3M/IHfJF3qhQ==
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

"CSI?1004h" is the sequence that enabes focus event report. This
can be handle correctly by pseudo console, however, if the pty
input is not connected to pseudo console, the focus event responces
such as "CSI I/O" are sent to the foreground process. Due to this,
`cat` receives these responces unexpectedly in the command below.

$ cmd &
$ cat

This seems to happen after Windows 11.

To avoid this, this patch removes "CSI?1004h/l" from pseudo console
output.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by:
---
 winsup/cygwin/fhandler/pty.cc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
index 0717c043b..65b10dd62 100644
--- a/winsup/cygwin/fhandler/pty.cc
+++ b/winsup/cygwin/fhandler/pty.cc
@@ -2760,7 +2760,8 @@ workarounds_for_pseudo_console_output (char *outbuf, DWORD rlen)
 	      }
 	    state = 0;
 	  }
-	else if (saw_question_mark && arg == 9001
+	else if (saw_question_mark
+		 && (arg == 9001 || arg == 1004)
 		 && (outbuf[i] == 'h' || outbuf[i] == 'l'))
 	  {
 	    memmove (&outbuf[start_at], &outbuf[i+1], rlen-i-1);
-- 
2.51.0

