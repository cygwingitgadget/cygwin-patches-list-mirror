Return-Path: <SRS0=/1rB=D5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.6])
	by sourceware.org (Postfix) with ESMTP id 947414BA2E0D
	for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2026 12:51:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 947414BA2E0D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 947414BA2E0D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.6
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780318264; cv=none;
	b=DXiBQs0AchHGMdm3tg5ZHF51T8CwonFYDtzA9clWuJMCYEuVsPpns9YJekEGh63HVGV5paeBNcp0NJOgiCsY4wKDp7HMhboF9VA3SNKUGm82KWpV+dfxB5+VJu03lV46YVEdf8o0nBZDwixiDTOKoNVML6Nv1erh7bo7js8Rhag=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780318264; c=relaxed/simple;
	bh=+UscBA3nDnDkKwExDQwua3pRIMplQ/DUeHAQUfYz7Ek=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=DSy8fuYerNSD3K9McQH6EMPZ6epFCCRy+AgtT1FEfanVqSAgMu72EaZWpgA78/e5awTnY8ybIAg3Gf1yEvC8m5hJpeQYOmPnQCgEvFogfWpsuyOeKqeBPtvvBLdKhtxcm2vR++3XhCFDTNqTNXQjuU6KAivoMC04WBhtIHgBPKA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 947414BA2E0D
Authentication-Results: btinternet.com;
    auth=pass (LOGIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69E784C5035B42B1
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFIAxT6dCLwmsQRhrNx+Fmw6k7YEIAoM/I5cN1kM+hTTyIizdMUOI4Ie28AMNBCM8zDDqsVOLRtymtPjRrDulhgftcyZJGCbDs4XI1UC7hcDwDQCydTBOfHNE5wMUFL4a1CQBaL37UKC6RyAkGHJHoVC28f5D851rVdbbS8tY9meak/EqT970hZV+fpBXX3B1G/Ll5g4yqqQyxbPx8Cwee4IfMVo1rP2Oepro7Kyr1StU0enyC8TdU73i8xw+QoHlNAKQg8G2KqW9cjYg8+mKg5Hdz+KVbbYdqWVEHG+GLFjvlsYVFLPfKTD9MKI1Ykt5P991ijkW/zZqZQQRkx7cKiG18X1y0WUoXd7VVu6aK0G034w8jCBEA2wCJVvLNu/2drSWOK6zYFJcVf5SUpjAzlgBMSXk+ceQkZLQM3oeSYBqQfcNQVYEPE91Q9wMdtqTP0Jb+6SeblBQyv4v4bL1ZeIyWOrC1pBvS7hrXR2EJg0efa8BDx+3NoNCuxbNsCfBTIhBpdPX6XtnCJlcUyZ+JcVVYdNxN6nuYLv8SzBwqwPnCo8/ELui6xvy7c9OmdoyTb6oBy2xRdOr4iFHW7Id80YDDSb6ADyKQDcWhUe/iyROJp0a/9SyGx90B2C6WtVk+JQdy5EZj1qcgMVvYFtsXIAujGoXvAr9UzAWkMFJ2KgQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from tambora (83.105.142.8) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69E784C5035B42B1; Mon, 1 Jun 2026 13:51:03 +0100
From: Jon Turney <jon.turney@dronecode.org.uk>
To: cygwin-patches@cygwin.com
Cc: Jon Turney <jon.turney@dronecode.org.uk>
Subject: [PATCH 0/2] gcc 16 compilation error fixes
Date: Mon,  1 Jun 2026 13:50:52 +0100
Message-ID: <20260601125055.1341979-1-jon.turney@dronecode.org.uk>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

These fix new errors (not warnings!) when compiling with gcc 16 (I'm guessing
due to the change of the default -std from gnu++17 to gnu++20?).

The first one seems obvious, but the second I'm not so sure about...

Jon Turney (2):
  Cygwin: Use bool return type for comparison operators in class pinfo
  Cygwin: Fix compilation of c8rtomb with gcc 16

 winsup/cygwin/local_includes/pinfo.h | 8 ++++----
 winsup/cygwin/strfuncs.cc            | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.51.0

