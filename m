Return-Path: <SRS0=iP9N=BR=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 509454BBC085
	for <cygwin-patches@cygwin.com>; Tue, 17 Mar 2026 12:24:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 509454BBC085
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 509454BBC085
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773750284; cv=none;
	b=SgoPmnlr/k/AUnth6DwHjHud2vBOFZzrEOyiOiEeX0AhpwMo54qjICLtqQjo2f7IO7XjIPsCSdvi0JYFKITjZfOOnUV8HArsuU5fnyZt7eAUeIg4ZQnywh6yPEI1wMXt5A0ir+VtqfgWTqGxaOVT7pYtgKWbOG6gFo5on1fRljc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773750284; c=relaxed/simple;
	bh=BRQmBpCxxhFswyhLYmMmT4W9MPPOW8jOY2pZUAB9330=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=RaWg0FHOqU7XjAZtGoGEon3FSiVg7EDCHvLKRkLefSGmEdRfEqm8f/XvdIC6Gy0DiJPh0tFlzu/qchEpgA/FXG6g5XvpUds2gLp1y+Z4VXyBH/m4oe16BgI2THr8Z5JtEZAt4nNUfIUkkbEkmek0hFf145Dl3DGM0MK9Kq7yj/A=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 509454BBC085
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=AiMeg8Y9
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260317122442342.NPOQ.36235.HP-Z230@nifty.com>;
          Tue, 17 Mar 2026 21:24:42 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH 0/6] Fix out-of-order keystrokes
Date: Tue, 17 Mar 2026 21:23:04 +0900
Message-ID: <20260317122433.721-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
References: <22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773750282;
 bh=A7SG/0dUwVWCTvFI9WIGiMAjPiZhR+5KEPtaHK3TJzo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=AiMeg8Y9Lq4Oo9n4Q8SqzW3AK/nAjQtWw4Wh5HoHZujSp1Rt/O8gYQHq4QeSABCzAzkhi9iV
 E4oMWxPHncP9ZD+UKsKU4Lr0yJBy2aSqwtPgDHISWArhCB8DXPyZJgxR0lW3nVM1/abMzua5KJ
 Rm6nXfpL6qrGN1q8WqHn9MhIDJN43mqnHs6lyyDgWZvyWpE8dRwhKTl5OJZ4Wr33DnDUDRUVeZ
 83elAPkUT0H8/CPyTFbFdsS00F1gZ/llQ3d1ziuKMZlmJZSCV3Bxbbq6XGgzGDMUkE/A1aiZH/
 f0pL6q3gTTGu/MNsHs0xiEuI0jX8mS7TDMYwWMQ5/rVqypXA==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The reproducer that uses AutoHotKey provided by Johannes:
https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
uncovered several issues regarding input transfer between nat-
pipe and cyg-pipe. Most of the issues happen when non-cygwin
shell start cygwin-app. This patch series addresses these issues.

Takashi Yano (6):
  Cygwin: console: Fix master thread for a pseudo console
  Cygwin: pty: Add workaround for handling of backspace when pcon
    enabled
  Cygwin: console Use input_mutex in the parent PTY in master thread
  Cygwin: pty: Apply line_edit() for transferred input to to_cyg
  Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
  Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex

 winsup/cygwin/fhandler/console.cc       | 111 ++++++-----------
 winsup/cygwin/fhandler/pty.cc           | 158 +++++++++++++++++++++---
 winsup/cygwin/local_includes/fhandler.h |   2 +
 winsup/cygwin/local_includes/tty.h      |   2 +
 winsup/cygwin/tty.cc                    |   1 +
 5 files changed, 181 insertions(+), 93 deletions(-)

-- 
2.51.0

