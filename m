Return-Path: <SRS0=PYjw=VT=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 7659D3858C56
	for <cygwin-patches@cygwin.com>; Fri, 28 Feb 2025 13:42:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7659D3858C56
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7659D3858C56
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1740750171; cv=none;
	b=invKPwqcZXYdjut6JVb6D9rj8Clr06ngepHn7oCeFY6yjZttzW2sPi25ZZD4oQBsobkX0ZuSRanGk9XViYUV5f/f9X/D8WYm2KMDMRmBOgnbYp19lj7HAFa8GrwMqLg60wzq5Qv3n9bYMpROYkVZ+r6T3MMx9aQYGef/oHVKwz0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1740750171; c=relaxed/simple;
	bh=N35+YFCWaxhz8Pdy74/fJm7GPw1MMC6DIV2P8qWCuXg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=GxVijzqQ5Q95DmSvwSx30whYnz01inq2Rv7lQyiP6KVzUKfHLApNnOPF8xvjI/VgDxxgV69IMjlZHy+6S6r4e0Lvvx2fnWsFCG7LyJhRbjBik2ZfylWUqW4Ptmxp4ySTaCyxM0GWNcjf4ZVGo3CGFBGx6uCVrc6FDizE7XtVzno=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7659D3858C56
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=j4m6ZfYb
Received: from localhost.localdomain by mta-snd-e08.mail.nifty.com
          with ESMTP
          id <20250228134248642.ETRM.40215.localhost.localdomain@nifty.com>;
          Fri, 28 Feb 2025 22:42:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/3] A few fixes for signal handling
Date: Fri, 28 Feb 2025 22:42:17 +0900
Message-ID: <20250228134231.1701-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1740750168;
 bh=pCIIirvlCyfQqGHjkguKKtUzvvOpzVqK5ggpn4nidpc=;
 h=From:To:Cc:Subject:Date;
 b=j4m6ZfYbvBPXLMbu9Tgm4G0wJvt6w6ZcKnIU+mSZAdxo4i4zGAxbZOkWH8aI8pB6oAQ/bKyS
 BKhUhH71GBSeijRLDnRvMz+4D3g+jXsWoCP+JWRPtsz2gUvfsbbD3FEVK7ta+Udh7OvEBEd7OO
 X6Bd9IaoK/vumqyX47ocCCmXS6uPO2zj3nv0d7OAzB4VzvPmZWv9UoXniEHyu/JIU33f7jSy9t
 TPnNkSHqyJOxuX8bGsY29O7Y4VAsLQQJrUpXwhjs+Ze2h/l+JPfJkwac1Qwi+2AFhDKAIA6+eX
 w8gFnJBFBXmUTKBaD4D4wol/AgUjMlNCMRldYOAm0DPI1VoQ==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: signal: Fix deadlock on SIGCONT
  Cygwin: signal: Fix a race issue on modifying _pinfo::process_state
  Cygwin: signal: Fix a problem that process hangs on exit

 winsup/cygwin/exceptions.cc          | 29 ++++++++++++++++------------
 winsup/cygwin/fork.cc                |  5 +++--
 winsup/cygwin/local_includes/pinfo.h |  4 ++--
 winsup/cygwin/pinfo.cc               | 11 ++++++-----
 winsup/cygwin/signal.cc              |  6 ++++--
 winsup/cygwin/sigproc.cc             |  5 +++--
 winsup/cygwin/spawn.cc               |  6 +++---
 7 files changed, 38 insertions(+), 28 deletions(-)

-- 
2.45.1

