Return-Path: <SRS0=IQA0=2D=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e06.mail.nifty.com (mta-snd-e06.mail.nifty.com [106.153.226.38])
	by sourceware.org (Postfix) with ESMTPS id D2356385C41F
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 00:32:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D2356385C41F
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D2356385C41F
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.38
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753144323; cv=none;
	b=sCPchGuG2mXRh0n3yl12wi9pX+b8V53gXwHAIZW7BmOyiHd3q6PIHQeC+hqrNbfMVMbpKCm8I7E5ywwjhMldNasRWAh0xf0SGuw1ej5wtriqQeRV9teWhHv/bfwK3FAsc+8MiItvUnKIIdwLKXEldwcH18kNaw5r5UbsqUv1Sro=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753144323; c=relaxed/simple;
	bh=KRrCVKBDyehs8fbASc5zqthaBdgJbZFgucrEbtRYV5Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=UVlTbFlEGQD7zx6AHnU0cSi4EsDql4h9RWB1py0iuM79aIDz1hWr8WcKsXppTov0ZiIq9ZkYzUn/NqSSr+1jLqFLkeqKKx3HBGP1R+aUhJT3YinYP4hBYz/1QRRDOCp3DOaVafUz3eb6F/HsambvTkBD4ey5vgITRyr2gOzWvrM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D2356385C41F
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=oxRhser1
Received: from localhost.localdomain by mta-snd-e06.mail.nifty.com
          with ESMTP
          id <20250722003159587.NVGQ.42575.localhost.localdomain@nifty.com>;
          Tue, 22 Jul 2025 09:31:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v5 0/3] Make system() thread-safe
Date: Tue, 22 Jul 2025 09:31:30 +0900
Message-ID: <20250722003142.4722-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753144319;
 bh=QyU5eLHOJuc+xtSaI6zGiEJ2hs7r8g4NyFxQ6+/7/4c=;
 h=From:To:Cc:Subject:Date;
 b=oxRhser1VldfnHDJ96cj9X3pGrUwQZgo7uROoUo6rJLtCb4yGrrH8x9fquBKp9Lj0Iku3qTs
 PNG/LHGCgfZw0TSuhEmcaD+cqfcYfHtT9FjiQ4VNoGR0/1rIDNAGbSEnnD12XvQwFXnKkilOJg
 tQZNiNZtPj0g+w/IwfXKUEo44vvm6Pw4+SrLU5zgSO1NpE7P0N2aht2JS50rEy4kpGKCtpYtGu
 gzqNxbd2+GFOH2yZaueQ9Fkze1AhdiCu6GGFh0HRYcnEUW+OS1AU/GJ/iiizduK8NKmUieYD4f
 eRhSBCv7f7bwoAk7Sv3E25Kw7gZGGQjcAj1flc4aqAVgJGzg==
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: cygheap: Add lock()/unlock() method
  Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
  Cygwin: spawn: Make system() thread-safe

 winsup/cygwin/local_includes/cygheap.h |  5 +++++
 winsup/cygwin/mm/cygheap.cc            | 12 ++++++------
 winsup/cygwin/spawn.cc                 | 15 +++++++++++++--
 winsup/cygwin/syscalls.cc              |  5 +++--
 4 files changed, 27 insertions(+), 10 deletions(-)

-- 
2.45.1

