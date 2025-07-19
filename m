Return-Path: <SRS0=jPCG=2A=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w06.mail.nifty.com (mta-snd-w06.mail.nifty.com [106.153.227.38])
	by sourceware.org (Postfix) with ESMTPS id 999573858C2D
	for <cygwin-patches@cygwin.com>; Sat, 19 Jul 2025 21:48:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 999573858C2D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 999573858C2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752961721; cv=none;
	b=piTtLVIktbbUu5EVMNRB90Gd8gjWO7ezfNryOpYfR9h7CrjMxKLd9l3tYZtiD+SUEyXO1Q0FFt5pQMphe4B6oEJ9PkHiaiGjVLKh8wAWlCtM2CVsBONTJ2EzH8WRUsRKRThAyC+8Uu43imzEMxZBrnCXASf6yuHVY0JG1RQxYLY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752961721; c=relaxed/simple;
	bh=umoJd0UKY0Eom82VMMVwW9PZlG2OPrXQm+xs4n4o2TM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=TBBenVc/Ky+gim+bs9zUTu9yu6hJ9sLhqKrOkpjQR7CjyOP+hQeoD20B2YzZV2mBjA5THBbEoiWzU0BtP/TsarhOvEv+B+cI5BGVVhtINjUu5sho0I8eX6+CPqZ2eP8BbYTE76p0GO2lpj9nU0KAjllZ/itWvgR3cFbZksC4gXM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 999573858C2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oN+EsmMz
Received: from localhost.localdomain by mta-snd-w06.mail.nifty.com
          with ESMTP
          id <20250719214838538.XWZK.116286.localhost.localdomain@nifty.com>;
          Sun, 20 Jul 2025 06:48:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v2 0/2] Make system() thread-safe
Date: Sun, 20 Jul 2025 06:48:11 +0900
Message-ID: <20250719214823.1556-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1752961718;
 bh=NUGydZh5f8Nro4MRQuvtFyDnZNER4raAHtLLr+UDVpw=;
 h=From:To:Cc:Subject:Date;
 b=oN+EsmMzvt7rSIA0i6SfhMWTnOlcEoONvVkxnrkCL7kTjJY8skqCsoEE78PiASIOysLPjlI3
 tKJWKMCxRV6oZhyxLVSFEltba3k0Aj+3SVuJ3iGypPZXO52HLIAcHs/cAJ9vEwmM7RQwY1RghH
 3650gvEZWEkZSygp7SBRnJkdZrCCNl0SWW1NOH9FYKfnjSdOwGjshuHRfzhenRVuH021zzkHyx
 4s6tjBT7OBoMjgVXEkBetG+IeOqs75+esxYUfFpLBmUG68x3sEryy845bMyKn5+x0e2ggCUcGG
 WYlRIGtK46MoUtKufPd2/jTF9TIDZdgU+CYDXzKDKe9jJwCg==
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (2):
  Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
  Cygwin: spawn: Make system() thread-safe

 winsup/cygwin/local_includes/cygheap.h |  2 ++
 winsup/cygwin/mm/cygheap.cc            | 22 +++++++++++++++++-----
 winsup/cygwin/spawn.cc                 |  7 +++++--
 winsup/cygwin/syscalls.cc              |  5 +++--
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.45.1

