Return-Path: <SRS0=R8AU=6X=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e04.mail.nifty.com (mta-snd-e04.mail.nifty.com [106.153.226.36])
	by sourceware.org (Postfix) with ESMTPS id 9BC5F4BA2E04
	for <cygwin-patches@cygwin.com>; Wed, 17 Dec 2025 09:30:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9BC5F4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9BC5F4BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765963812; cv=none;
	b=mJ1SNGOiWB3Q5sTiCWZYBm86b1z5MlcAaibLRpcGwr6GIyTNa/WAF65MtOkQ6kyjafIutHkbQEBQlDDxgP9L+v9lbsHXZrESfZtBr9KBARCQC/EfS0vHxO5xoICCWiVbfsHou7UFeHjfQly1VPwfX/YE+WOhwD0auC9jgxHTZmc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765963812; c=relaxed/simple;
	bh=s+dEWe2nXNIrQruCH+SGqyi/w4flPHT7dUotbmaa1B4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=wBDFD9t07V+uv1lbc9fUni7J8jTK7MrE8ZirfDt7Fmt280qpv3ReJ7oGw0ffUB+Y8QVYWvdlgvC0HBbTwMiv/c3DgB5pYZhQAmRzRSQa5P5wtXBFYkwAlLSSEGz8pQwIX3PkE9PKrzEJlMHHSOIycCtQNCTiUGf3mZUHOg9Qc7o=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9BC5F4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ZMPnC+f0
Received: from HP-Z230 by mta-snd-e04.mail.nifty.com with ESMTP
          id <20251217093009737.JYML.38814.HP-Z230@nifty.com>;
          Wed, 17 Dec 2025 18:30:09 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/2] Cgywin: termios: Follow symlink in is_console_app()
Date: Wed, 17 Dec 2025 18:29:53 +0900
Message-ID: <20251217093003.375-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1765963809;
 bh=I/fFtWItbAhaFR2g+1GpY/5CNfhbcTSUvJwJcWZzWeU=;
 h=From:To:Cc:Subject:Date;
 b=ZMPnC+f04Ha+wenhwMcUIFNja6UBPYI9y71H6TR8ZMEGoEUgLRE6d5L13NZ0PeG8BmD0aGnm
 gTOzhSs2jcxvq/bhkMryA14xIvE3GuSiBZR+JhQae7eQqtSZwC//rl0lVrp8rxOSERhwivMaDv
 6wE12cR5PzqcOQG9WdDs8x36AZrd4AayzMr+cbzXSZR3NdBFsnsfUsZLZ/NFPYVH9ybGvj72jm
 07yPsYbSi6oPMBWpTNVJHuxbCGzU5oekiiZqsKoR7FOXHW7cgoU0aOlDd5YK9T+S4U2vTO1J6/
 qCCyU4EhAA8nkFFhJkayeD2vaG+TB1X298WUWgfO8HjRJRlw==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

v3 patch:
- Use is_app_execution_alias(), which is newly introduced, instead
  of issymlink().
- Change argument of is_console_app() to a reference, not a pointer.

Takashi Yano (2):
  Cygwin: path: Implement path_conv::is_app_execution_alias()
  Cygwin: termios: Handle app execution alias in is_console_app()

 winsup/cygwin/fhandler/termios.cc       | 21 ++++++++++++++++-----
 winsup/cygwin/local_includes/fhandler.h |  2 +-
 winsup/cygwin/local_includes/path.h     |  5 +++++
 winsup/cygwin/path.cc                   |  2 +-
 winsup/cygwin/spawn.cc                  |  2 +-
 5 files changed, 24 insertions(+), 8 deletions(-)

-- 
2.51.0

