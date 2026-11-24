Return-Path: <SRS0=UvTC=JN=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 17F2244615BE
	for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2026 02:47:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 17F2244615BE
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 17F2244615BE
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795488478; cv=none;
	b=Z5LJy5LtCxbI4INOE0J1WS+FfMmvUq/fFIlVfhTOCWvvU+Yf4ZxmKA7coPRw0wzhEtLscSKWs94eLNtI7ONO0tv8yF1TtXH7GhePVxsjPPyLsvpjlMzVMBwjJcor/wDFWr7WnpoAe7qap47ce9jFI87Li2MHX4cazcB20N1h1Hw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795488478; c=relaxed/simple;
	bh=8AR23I4VsRAmLEsfXCcDFgJ/52vmXcwYRImgEZQ8uUM=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=xv5gkurbqyHc/rcePYTLffhBs4W95fP5MX7mvMbon85thvMJA0gNRmr744Dty4G1L1BFEuKcqmJSg9wd9qoi/UhK9C3q1Wxm1hHdWa0XIlAZVcmY4rNQID7BULZIV3ZGA1+f6pvGq3Pda88UCOLBQs720gLKAPKBA8uZkVn3y2c=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TsxNMaNT
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 17F2244615BE
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=TsxNMaNT
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20261124024755056.SLZF.117312.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 24 Nov 2026 11:47:55 +0900
Date: Tue, 24 Nov 2026 11:47:53 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: [Request for review] pty, console related patches
Message-Id: <20261124114753.49c6221093b1a5d5252da3c4@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1795488475;
 bh=9HJSau+1bCNjIYkImBSPmXXrHvWYuWETZOi968uw9ik=;
 h=Date:From:To:Subject;
 b=TsxNMaNTqbYtXicsVHWujGCB2TI8QL6b3Tgmy4EBD7X8iArHU/FKAheaxUBC+3AbQ2I9V9We
 lmlUjuCNDjH6TEqKtJVGEDde30PVIykxkx0AK4zILpF2ojky6bdfbCAc7ADJVOfMrZPqpKaxqt
 CW6gCHydo8c7niviTl4IKE3GYZh5pkFdQQS5hXezruLmRbsJHwpvNH2f0RQlXUpTwibz5U82jd
 guRUmXdyK5a36LRpHKaAkloofP8JDH9iua4/5herbTDHNRX0g8Y59mbmHUo464TjjtUIzvZgwb
 B5cFBfDAcjdx3MqR9szOJGC2qLm+1Z/d1UqZvmnnazWNZNyQ==
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi,

Could anyone review the following patches?

[PATCH] Cygwin: pty: Do not use terminfo to determine the terminal capability
[PATCH 1/2] Cygwin: console: Set ENABLE_PROCESSED_INPUT only when ISIG is set
[PATCH v5 2/2] Cygwin: pty: Handle win32 input mode rather than omitting it

These patches have been awaiting review for three weeks.
If there are no objections by the end of this week,
I'll go ahead and apply these patches.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
