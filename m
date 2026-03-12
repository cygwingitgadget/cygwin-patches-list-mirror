Return-Path: <SRS0=ji6e=BM=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 55B024BAE7F8
	for <cygwin-patches@cygwin.com>; Thu, 12 Mar 2026 11:39:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 55B024BAE7F8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 55B024BAE7F8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773315574; cv=none;
	b=cVNlCPZtHUiwBofyhn2Zgpbq3Ncr/La0tBnECOaElfq8hCn7kSkIXGx6hRvQOWJrRfCS2zCP7LIHUT8Yopvahb7kgi4X7QFK5onc3u7477qkR+Gmu/dMX5leUU0lkWK/tWNQz/b9l7duAAwHV12X6EK/u3vfqPbkWUCNzRhIgqI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773315574; c=relaxed/simple;
	bh=ILwG8Yvet3w6BGv9uJzOeNmSmIV0/BhkvQLRZFTPK7Q=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=wYZLIMvaFGfwBOHwdM4odxKUO0Q3dnRKaGG+eogek6fyZkgzactxkvx31wjVn16hjnYORiAU/At96U/8lRTCo/anwZU1q41kCuVBgvZjAT5ngbSZN5XAS0Q4H1x2y6feoESzKPuohhg1Vw9FSdWiP4Jnj1+kFpJbJwAexOJPssg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 55B024BAE7F8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JLaSLZzW
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260312113931358.XLWN.127398.HP-Z230@nifty.com>;
          Thu, 12 Mar 2026 20:39:31 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 0/3] Add support for OpenConsole.exe
Date: Thu, 12 Mar 2026 20:38:54 +0900
Message-ID: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773315571;
 bh=LGLQRxD6wyFKDcqQMq2/Xsadiyb9oqGlgHxXEBNfy3Y=;
 h=From:To:Cc:Subject:Date;
 b=JLaSLZzWnCW3KZGtM5+P6xndPBkqBB7296I79NvRnPWCxG89X+DdW2VpHvR40X0si2sXvhwN
 HRIQnt5TVEe6yTMizeJIJoly71UDyCwJSqGWwNkQCoeELPJRA20nKbYN0pborXPuD+x6NaSeEW
 +PFrf7zggkx2wxN9e11lf47df1Zjepry2eM2k4d4yKlhIsaLjG4ip9l2D8JhooPZrGTsdbX8VH
 1RR7A8fPrWJwXlCWxu/2Tgkk2rqEznh/PAb7CxFAAI0po+ue0f1jyc3ljYAIlbm3p4/088n8NE
 459pIi5EiO49yoosoUL/09iUe1CGakZP/nqN5WxsoQwmZ0/A==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v5: Revise "Cygwin: pty: Update workaround for rlwrap for pseudo console"
    Drop workaround for "CSI?1004h"

Takashi Yano (3):
  Cygwin: pty: Use OpenConsole.exe if available
  Cygwin: pty: Update workaround for rlwrap for pseudo console
  Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled

 winsup/cygwin/fhandler/pty.cc           | 410 ++++++++++++++++++++++--
 winsup/cygwin/local_includes/fhandler.h |   1 +
 winsup/cygwin/local_includes/tty.h      |   1 +
 winsup/cygwin/tty.cc                    |   1 +
 4 files changed, 383 insertions(+), 30 deletions(-)

-- 
2.51.0

