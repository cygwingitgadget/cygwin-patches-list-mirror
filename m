Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
	by sourceware.org (Postfix) with ESMTPS id 1BA583A46E45
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:32:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1BA583A46E45
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1BA583A46E45
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750581150; cv=none;
	b=bKPaEOg90F4yrhylHVEmUIZf/+JFcgwt9U1HC3hSVJYByslNjXCSxL2dub7SQJCHr4h3HDBG7jOQ5q1guFBFAyTarvTGuKuZDiDMSDhpnPb+X6qcxxJQprxGNMCTU8o/h9+49v2NgtLeEMX1PNwqLbU/1+owxVbNaPK5vwWNabM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750581150; c=relaxed/simple;
	bh=puSjP5DvublnHE32tFTm3qAS8AZtj9YrYHwekrzX3nQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=X4lmcNXOy7KVgklhO4r3+/+1k24/LDvSrGFFpRRhd7L7RHiqxvHHdSzC7IAKUztMMKtMcP+CbyRuYEevEcFEjZrlTaolBvarDNFVgPprwDB8NVCLY+nzgdEBLAYzYd1A3OCenMChBD0nld15qiwB+WJhlQEUZnGjzGNwwjo+ui8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1BA583A46E45
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ae018lH1
Received: by mail-yb1-xb2c.google.com with SMTP id 3f1490d57ef6-e812fc35985so2235432276.0
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750581149; x=1751185949; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJfZ/aU4Gf0QoAq3scCYzqFeYN8UUrMJbTRztcFYMJc=;
        b=ae018lH1M7GrWJq9SytZIs4s6hHhsVcUugVoT9+JJQYF8VGFJqETQuYLm7oD+JRsIT
         mg3AJrgstxdBU4/JesotKP2hp7XBPlFbzLnxr4bslGsqvdEYLfGyf6McJLMKnGqJqCWF
         sQfwM9OJoNsFBJMwu4y3z+j2vON7IPCvI9O5ysM3byP7afHGMcxnTeKmLZdz+eSmc9kC
         pkAc/TkobnWF3fsGibwuYkaJi7pzT6N/2E8AcK2tniWvoYKqLGvyER38rpxscs9Ytoln
         e4cq5p1L6/Mbku+YRdvJyrPNS3Gn+5E8a31mAgvLCm/0Bl0ZjDm42liXuUCNgaKAt4CO
         eZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750581149; x=1751185949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DJfZ/aU4Gf0QoAq3scCYzqFeYN8UUrMJbTRztcFYMJc=;
        b=QbN33WgE0c4FvkrkQYVdZbR7UdJr37t1DlePPBoXCLDG5fjUQ7i/BTAXHCkCz2yTlb
         Ca0yMR2NXH2VvO8cZfKvWb+dWAt9neqfOUhteIxo5Upd1PDRSDCjGhXPbgh9lMxtxN3e
         Q2e7aimcwBekAS5fzlPNTpx6nZt9x54/P6+tw3MwqTDuydLj7lzgNq9QHNWGCM1pwchs
         AM4UK9DndyKsLiAYUUGjynk3F9OpsGhDCws8i1jKEpOQQsTs4T/MS7O0keB2PLQUWraZ
         w0Hm1/xndkabqYztntWbzbmr3bKLTGIJL29o4M8aMvrKYbbiTcf5QU0RRsuaoegjVie8
         9gTg==
X-Gm-Message-State: AOJu0YxpxUC07QUFlCZtkaXpZCd78TB2BQQb8eGqnM3vzpbFZa/KVPDJ
	JF4cDDaj+JD95BUCnwe+iCmgxYR+h3xn85vmGsmbZGOh+SMxZgV6VQcDisiCXQ==
X-Gm-Gg: ASbGncvaF6wdhsaBXGhhDAXedUvRf8t9z1DHx6wCfZ6QdDbIgeivjBmb2tXXzfDSXK6
	V4J9QUhQee7daz78cc/B2w/XMst9NVjs16YPhaqoVNfxLC5P/Ag3U7owH6cUzAmYmqUwnE+Ha2C
	ozSIJsJeGO7cWF8yvIjGxPxuhfyZqM8N7QDqSmSFsFC6hI4VW9lJ03aPUScsN77Cq72o5CgMdP8
	9MGKJ55BdeND3fILicaeNo4G7NHjqPKLNaQOQqvmPKDKy27kMd4/eG/qOnBh5LgkREwSnB51sDW
	i2q2lahYqI7y280ToQi5jZYCcJ2+PCHmK7Njh4LIW/tkPYhhO/r/78LQzczPl6yQAT9bah3+Edx
	Hc4UBlrsKKGDPJ7Ye4s3wo0ZyJ+ylgkpV1LM4uE7kk1xrZ58JgHTCCPeV03w=
X-Google-Smtp-Source: AGHT+IF2YP8eK9EgIlU3ITP6e63V+Ep3jZIEjFSzpyIqO3adJOesVN44V5NpOSLrKXxf9HyLzCNQjQ==
X-Received: by 2002:a05:6902:2208:b0:e82:5142:7c9f with SMTP id 3f1490d57ef6-e842bd135d6mr9959873276.35.1750581149088;
        Sun, 22 Jun 2025 01:32:29 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aab9809sm1774586276.1.2025.06.22.01.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:32:27 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 1/4] install.html: add -P option tip
Date: Sun, 22 Jun 2025 04:32:10 -0400
Message-ID: <20250622083213.1871-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622083213.1871-1-johnhaugabook@gmail.com>
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 install.html | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/install.html b/install.html
index 16206a06..4a9e54ff 100755
--- a/install.html
+++ b/install.html
@@ -72,7 +72,12 @@ full-featured as those package managers.</p>
 
 <p>
 Performing an automated installation can be done using the <code>-q</code> and
-<code>-P package1,package2,...</code> options.
+<code>-P <i>package1</i>,<i>package2</i>,<i>etc.</i></code> options. 
+</p>
+
+<p>
+Tip: if you have trouble with the <code>-P</code> option, try altering the syntax
+i.e. <code>-P <i>package1</i> -P <i>package2</i> -P <i>etc</i></code>.
 </p>
 
 <h2 class="cartouche" id="why-not">Q: Why not use <code>apt</code>, <code>yum</code>, my
-- 
2.46.0.windows.1

