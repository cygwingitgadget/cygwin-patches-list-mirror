Return-Path: <SRS0=Jqgh=2C=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id DA2163858D35
	for <cygwin-patches@cygwin.com>; Mon, 21 Jul 2025 13:46:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DA2163858D35
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DA2163858D35
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753105607; cv=none;
	b=p/e/SFjHzVXt0Zq9ur03N+BRymV44d/5oH8C5ootZU+e3jtSYVBAOviU+wCXO7+0+fSlocvbb7fQa9sliAS9BM2zKn8IJl1hvbrRf1CHchFXhj5BgD3qJb/xrlwuFLRjNre2n7KleLzuSQSeJg3QslNXxVcRwMLWyCw8vAGwZRY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753105607; c=relaxed/simple;
	bh=vJtli18At0mNuElKpaZ43QaDGv5iG9crv1thKIxtOxM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:DKIM-Signature; b=sVvOdkCDlZhrXvoA9AYq0MjSkoezjUy0qYfIvmlVgIfuA9eMjUnt/edujY7gDbVkkNPeq2swNtjupgq8CYbfyGlKeSqN5CXZn1H/a+HOWeTs7/f7AldlSHcoWeTiWhiATtv57EDD33z1NF41AyBNcclN4Urz2KVGvsWE8EMj+Ng=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DA2163858D35
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=FHPwI58G
Received: from localhost.localdomain by mta-snd-w03.mail.nifty.com
          with ESMTP
          id <20250721134644315.SKBF.74565.localhost.localdomain@nifty.com>;
          Mon, 21 Jul 2025 22:46:44 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Takashi Yano <takashi.yano@nifty.ne.jp>
Subject: [PATCH v3 0/3] Make system() thread-safe
Date: Mon, 21 Jul 2025 22:46:16 +0900
Message-ID: <20250721134628.2908-1-takashi.yano@nifty.ne.jp>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753105604;
 bh=5ay1Qkk+gO2FBzTjNUFW5cNkRM76I1E+DRCFNcF9/84=;
 h=From:To:Cc:Subject:Date;
 b=FHPwI58GiLcIQvB9ex4RCXOieHUMGlhViTS4U00dM2pwHnXenEnWpZw5kOaOct8VLwCu0NOU
 dhTNtv5+PoN/xU1gI5QlXDJdJ4rp+o0urruH9JND7qsglHBCNoDROurorawqEpE1Y4kE4pP+da
 lqnWlaDlfFQ1NpeHHtwUMZnOew/XJdyi8PXlq1o+YH0hiGpGtfCwEXJ3g/PzZmTOF8eaMA0Ryy
 peJkpdNDKsrISYV72xqR5Lq66UQ7kjCiWaUQLwwo/BqTVqwGSYE+pE4t+bTIkVIebFz02FrMNp
 r6buief97w0GM3ZtqN0JjGGJ4pFOXn4hY0EBQn3iyYzqIopA==
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Takashi Yano (3):
  Cygwin: cygheap: Add locl()/unlock() method
  Cygwin: spawn: Lock cygheap from refresh_cygheap() until child_copy()
  Cygwin: spawn: Make system() thread-safe

 winsup/cygwin/local_includes/cygheap.h |  2 ++
 winsup/cygwin/mm/cygheap.cc            | 22 +++++++++++++++++-----
 winsup/cygwin/spawn.cc                 |  7 +++++--
 winsup/cygwin/syscalls.cc              |  5 +++--
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.45.1

