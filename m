Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [106.153.226.33])
	by sourceware.org (Postfix) with ESMTPS id E56583857738
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 06:44:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E56583857738
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E56583857738
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753166676; cv=none;
	b=AEym7s6XPLZdcrX4QA6CpM7U4b7k2c2hL9QMG29IOcFJOjRUOu9PTEHZ3jjFUhx1A1BxFWyEDepdhmPWHkPySNuCrpY4D9xCyUIkj0YoUbk78xSvSXf2Kc0lLuyW90ZJeS4BVZX8g068oknoeNE8GNDIQ3FknT/JvY4HGdpwTRM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753166676; c=relaxed/simple;
	bh=UZwgTXC0Y9tTZKkIp2EutIH0bbWf5+0+B0+lFP5RUXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TlBRH0FWDyofHxm3TcPN12H6XovvTrAyPAod0Wk8bWpf80+/OX1RhopcrMUc0eA2iEy+TFFvdkNPEeZJL4KOkPPa5CMWTNuYbZtEuSCYcqzkV52nK0Zk7bM1GFONDCIQndx0P4jH7YXuFlO+3lLz4WC9YliXaaGIFgnDCqZN4yU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E56583857738
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=aUIQ5wlD
Received: from localhost.localdomain by mta-snd-e01.mail.nifty.com
          with ESMTP
          id <20250722064432752.TQVG.62593.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 15:44:32 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v6 0/3] Make system() thread-safe
Date: Tue, 22 Jul 2025 15:43:59 +0900
Message-ID: <20250722064415.1590-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753166672;
 bh=2XrLkc2wfzVdGEswlnETSN4bOS9HkdVV8KhgkwrP1yI=;
 h=From:To:Cc:Subject:Date;
 b=aUIQ5wlD1Q0+eE/zUnbkRFEAochQVx9o2qo//eTcKO+M61s/Q8tpi7JV4k8pzbH+pWSpv92s
 bZl/yGjYFacRY3ZaG7OEuDdBZpWKdwOI5D3ZAIzj1wH7x2T3bZXfQJ8AkfMx7BFPH3KU3kofG2
 oNxBNZjYpBxzlyXXAUEyIdKOJ6O6YQtHiu3SA44r00HaYHqbA5LgTx+HXJwttZB88Su1vMprZr
 zBa5c8QmI69P1CDLu8ml8YalGq+H2ZU9guC2z16XUvqKRvhh62pdQYscogq0aU/8tBUT2xXyDU
 6DlAY+aHd2CQt6o85qJWOsYsreTrI84rU7V3+c/rCZioL3cQ==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: cygheap: Add lock()/unlock() method
  Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
  Cygwin: spawn: Make system() thread-safe

 winsup/cygwin/local_includes/child_info.h | 10 ++++++++++
 winsup/cygwin/local_includes/cygheap.h    |  5 +++++
 winsup/cygwin/mm/cygheap.cc               | 12 ++++++------
 winsup/cygwin/spawn.cc                    | 10 ++++++++--
 winsup/cygwin/syscalls.cc                 |  5 +++--
 5 files changed, 32 insertions(+), 10 deletions(-)

-- 
2.45.1

