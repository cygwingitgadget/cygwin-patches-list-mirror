Return-Path: <SRS0=haOa=BZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 396194BB5927
	for <cygwin-patches@cygwin.com>; Wed, 25 Mar 2026 13:11:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 396194BB5927
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 396194BB5927
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774444266; cv=none;
	b=bcPj7eIg8tDQDdHsy3o4gp+bIqVXWWckMJy3ehldoQSemn0ILpfsYVaHsQZcYE1Jn3dOrR9IPMiV1YqZAZIDNgXQBi1uQ9zyspSh52rdcr9ftgROTFceZi2WCeDcijtcAy8e2bZmZvWVkVx1ZVM/BX0mH5hTxChD5FhXFPZGjAM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774444266; c=relaxed/simple;
	bh=W78K/K2NTh+rPUSxxAKkB9Fa5qs8DTvabD5+kzpmSuc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=Pdy+No+hc2R7FztCYMbJAx/ioG2LD7bRXtVCFmgkyPKys98HUW8Z6OHhnka6zaJFmdZoLfUPZF9NEx2u1rg7nmMjviIRvOwo4nw70LwWPW0WRHUQJp3o//5Idlwq7RlAODnsmoHJ1ZY2uucOVRdADeKu8Eh9ZFCbGXpyaaCdkjw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 396194BB5927
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Idc6KHba
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260325131104502.TVPM.127398.HP-Z230@nifty.com>;
          Wed, 25 Mar 2026 22:11:04 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 0/3] Add support for OpenConsole.exe
Date: Wed, 25 Mar 2026 22:09:56 +0900
Message-ID: <20260325131056.69116-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
References: <20260312113923.1528-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774444264;
 bh=4D+hZKTfKrIltQx9VdQ/V38Etjv+IbR8kTDc2lxFQNg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Idc6KHbapTu1G584fmxkc1nTCXfesvIwgrbFpVWDp7lkOE7Aq3M/QQcXvLM0ewLUHVgK555B
 HaEGaM7TL12yATNBpV0HFkfpkvrNRW5oGw+WYrF8tVyRBtSQc7dNqZE99GuRDTkZsUcozXBECU
 95ln9lL7cywDds4IA7KJnjbWfJAPNoJyDmEW1oPyih0Xh09RwiG2eIsZrcLgFtXa7Xg7g4dVL5
 JZRUv+EK6RfvBylm7V3FrQDZ7BN4rxl8VHKJM81e42jI/KUrLufmIrEtH1Y0Wun6Zqe8wut2Zi
 KFqBJiYlJsmwMjICqDaIJAcIpLlcAXhaK3Hy44oAs40TUk7A==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v6:
  [PATCH 1/3]: Separate CSIc handling, Fix a few small bugs.
  [PATCH 2/3]: Separated from [PATCH 1/3] with small fix.
  [PATCH 3/3]: Newly added for cygwin app started from non-cygwin shell.

Dropped form this patch series:
  [PATCH v5 2/3] Cygwin: pty: Update workaround for rlwrap for pseudo console
      Did too much than necessary. The [PATCH 2/3] seems enough.
  [PATCH v5 3/3] Cygwin: pty: Add workaround for handling of Ctrl-H
      The issue addressed is not specific to OpenConsole.exe bug also
      happens with conhost.exe in Windows 11. Handle this issue
      by [PATCH v7 2/7] Cygwin: pty: Add workaround for handling of backspace
      when pcon enabled in out-of-order keystroke patch series.

Takashi Yano (3):
  Cygwin: pty: Use OpenConsole.exe if available
  Cygwin: pty: Handle CSIc in pcon_start phase
  Cygwin: console: Fix master thread for OpenConsole.exe

 winsup/cygwin/environ.cc                |   1 +
 winsup/cygwin/fhandler/console.cc       |  23 +++
 winsup/cygwin/fhandler/pty.cc           | 233 ++++++++++++++++++++++--
 winsup/cygwin/globals.cc                |   1 +
 winsup/cygwin/local_includes/fhandler.h |   1 +
 winsup/cygwin/local_includes/tty.h      |   1 +
 winsup/cygwin/tty.cc                    |   1 +
 7 files changed, 244 insertions(+), 17 deletions(-)

-- 
2.51.0

