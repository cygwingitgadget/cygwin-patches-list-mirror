Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 0CEC64BA23C5
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:03:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0CEC64BA23C5
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0CEC64BA23C5
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269394; cv=none;
	b=otpa8FqhsBNUWJLRXLqxPjhQYNTFcvAvk46LmtydWNIfX+FgnxBhqu+AKNRLTHfkygP8rKj++3vR487XFOAzwlsp+cY+ZippXvtULUmNIqSP1d00n+FymGgc/FLiIsNyBdpwE8y02JgaLOFwekNnpzhR/uRjKtOSYgWE/PBgWw4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269394; c=relaxed/simple;
	bh=wwzP5lw5HmlDIpoVLx95kpHCx2jTy03kZonYSyllO2I=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=gErqs32nhGKPicj9v8t+lwPxFEiDM8YkSvJi9ri0Td067NUgiPg4anJuOPpqo5HDi3tO7l1JTtYAbEzs54knqvQgF8/YB7JA59kfZipY+Pg3/3alh3gVOcsegDewvesNDS2uH5mISljhSo58COwHYJhWHyM8CW5YjyJobHgnAS4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0CEC64BA23C5
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=HsRBwEDt
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260228090310478.YDYA.127398.HP-Z230@nifty.com>;
          Sat, 28 Feb 2026 18:03:10 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v4 0/4] Add support for OpenConsole.exe
Date: Sat, 28 Feb 2026 18:02:49 +0900
Message-ID: <20260228090304.2562-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269390;
 bh=zIFTFc+f97OSGvlczyb4FkZUlZeUASODkpctXl+gnMk=;
 h=From:To:Cc:Subject:Date;
 b=HsRBwEDtstAOfLpJAlLdsB1Fkwj9Z+NqsV7RTSTYNVW0RgVyYCZ6nRS3IWMWER/bSaCmcZpb
 8H4TujTpitZRkbAStP9Dv/4pq8ic93lZVWyVKvAgQN6DLaqstbmKuTGRvtw5AUKSGzBN+nr7HV
 XrAci8HCGS2Q23Su2+4wbmldFEziC8AnksDT4SWRRQ7S6swv5UFwIsQ5FE+OXkYa5WD8mIhym7
 Z0Acmv9bAZn0bIfPYS2dFQ5GyDBQlfLyNSv2eUWUCw+LYI3rpmD8c+R2tjFGjjx+8QTkdm49TY
 2fneLtmFu6AKocZh9NBh99WcGj0Nyp6BNuxnWasBlRX08OgA==
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v4:
  * Do not close pi.hProcess in CreatePseudoConsole_new()
  * Modify handling of CSIc response

Takashi Yano (4):
  Cygwin: pty: Use OpenConsole.exe if available
  Cygwin: pty: Update workaround for rlwrap for pseudo console
  Cygwin: pty: Add workaround for handling of Ctrl-H when pcon enabled
  Cygwin: pty: Fix the terminal state after leaving pcon

 winsup/cygwin/fhandler/pty.cc           | 368 ++++++++++++++++++++++--
 winsup/cygwin/local_includes/fhandler.h |   1 +
 winsup/cygwin/local_includes/tty.h      |   1 +
 winsup/cygwin/tty.cc                    |   1 +
 4 files changed, 341 insertions(+), 30 deletions(-)

-- 
2.51.0

