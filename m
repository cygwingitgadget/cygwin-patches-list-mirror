Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by sourceware.org (Postfix) with ESMTPS id 7FA1B3A3BA21
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:32:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7FA1B3A3BA21
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7FA1B3A3BA21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750581154; cv=none;
	b=H2fcvbYV/9fsJeAc4S5u+0JOBO4reMHZUkW3TyZNlyG4XoOX/SkfCuqY3nk9YOsh3L2wXtUhMIgbWWhiECYrmpu2M89UF/5HCM37hnAIBJWD9oKgZNhJop6sKGhRZLoegcDC+6SPoNithXh1t3EeHtIsRN/NlbzlblWsCkUfYdM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750581154; c=relaxed/simple;
	bh=3DSAvO4ptTF0llwF1/urmETVtxrQq30hf6oNvPJKOFE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=PFQPHgIdTnPjLWeDQCa7kv6p0BYgebvAfZecqLZiDQPixxXfJXOtKsyfnhZzGkrNeYLaAXDCgosR70Bgrli0oRH9deeA/PTQ6zVXzqR873Pk4kgC3eQpRQLisCXJNrmmM4Hqg22T/2CS6N6q+K0Zz5IeeUlbWDwVpFp9qI3U5gU=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-e817b40d6e7so2622896276.1
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750581152; x=1751185952; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=knv1EE49VyvQf6aLW6wgjSj2rn28T7JtrQgZ6Q1CsUI=;
        b=Kg8Zra+affOVh/ocDRHFF+nOQ7SYfld0fMlDKBKUko+Zj8icaxAIwJ6naUuOQuJEoN
         Ux1cCYMuNE8rzj2eAKf6wF7QgvsBtdgo4W6CUWBg8hjZJDJf46vMhTdZ5qvGOaaZctVN
         qbEZi7cMW0qyORKU+at3udSTKYNntkZUBMuUvqwHaqO+HM9y8qANBCPU+OVrLGbJFwv0
         H1+JjnTzdWiGOjNiTtUP0UnOVmhtnovB0NR12Nwrq9sD83ORN2QvGtu92YQe/pj/Aagg
         qcViD0irYz5PPikJHq+o3PWyZ7/GWg7DYjV675ZtWifwyu1TNYZ8TWuBBGGUGcgWuieT
         spsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750581152; x=1751185952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=knv1EE49VyvQf6aLW6wgjSj2rn28T7JtrQgZ6Q1CsUI=;
        b=XifzU2sWuLCVkLKU+HYn0FLaYELaEz2qrIfdh191a4jBWqBTyxuV3DOs2o5Am70zHS
         3JBcU7xLOSEQ9amof6Wd99jWweBgOWVUjQSVW35SnMBsLsN5jcsEhsdzuY8AYxAhFFpq
         umZ9VRm34vJN9B+kmsKyWp4qS0TscFuwKARJCdOgaAm5i+CbDQbrR48nUuUjSiiVtEjD
         DkmtAAlTFWfixXXtOfSURuyiOyeAXyS/InDyDHDFndSV8McRm4tx3or1/FBHjLdjnjOy
         H35qCc96xbG7LuBEGPUGOi68f/eOTjq1EPBsQK1V77trOXeoVzEdn5QaZFYFqkwB9KKV
         Hpjw==
X-Gm-Message-State: AOJu0Yz963TIGYb+jKO8GM5FIcyhOQV3Qpe0pOhzN3vj+oONnbwrlLzc
	jPuiYv88jv6fOwxtZGAKiTEnahuh3LrVPTeloaHnwe8Qdzbnviu4rKnnng0h4Q==
X-Gm-Gg: ASbGnctgA9h4YVIhZ3DOSwyehaGF0D/TBX9AYAgHwMfLPKeXa8C2xUKGoyd0WmGaCU7
	UWpGtTaHbSlHJObFPLNBIlTHp0TJHbGd3ilJHC1Ko5g/xlV79Lu+5E2PNGJ6ydFaBiNfzL/IoO6
	7YhuTYnZGS0ynrE8KyyxGm3eGGQmdoPU/Y7+R9xGSjJoz1R3KIYacI87cEPdJ9LbLahpz7v0aS0
	l5n1VU6MpjcEwYR9sbZXagLn6Z3c+TNOVeOfF40VxpnL96Q5WOF55f/hLoEGPeOwsS2yQihG9Zq
	LrPKy0v9PphR3mKzHcvC7sY8DwqJvBjqJYODo6a5yRoFzIop2n5YOH1qfiNbeQT70P6o/W2XON1
	wIjWGjQupzER/gmxhyK/rDRtibofip+lcBFTVtO+c2vT7e6xeR9/ZElpqO2I=
X-Google-Smtp-Source: AGHT+IFvpu/gY5lXFaZ4rIgWE78H3ActeTHytRxha4CnVK1ykMIB7eHtwQ2M3L4pyY6yibFloefwAg==
X-Received: by 2002:a05:6902:1286:b0:e82:568:7ec1 with SMTP id 3f1490d57ef6-e842bd4978emr11306679276.49.1750581152454;
        Sun, 22 Jun 2025 01:32:32 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aab9809sm1774586276.1.2025.06.22.01.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:32:31 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 3/4] install.html: add tip on using setup-x86_64.exe from bin
Date: Sun, 22 Jun 2025 04:32:12 -0400
Message-ID: <20250622083213.1871-4-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622083213.1871-1-johnhaugabook@gmail.com>
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 install.html | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/install.html b/install.html
index 13acf430..c5c797f3 100755
--- a/install.html
+++ b/install.html
@@ -85,6 +85,14 @@ Tip: if you have trouble with the <code>-P</code> option, try altering the synta
 i.e. <code>-P <i>package1</i> -P <i>package2</i> -P <i>etc</i></code>.
 </p>
 
+<p>
+Tip: you can download <code>setup-x86_64.exe</code> in the <code>/bin</code> directory,
+and use it from the command line to install packages (<i>ensure C:\cygwin64\bin is
+in path</i>). Additionally, you can also change the name of <code>setup-x86_64.exe</code>
+i.e. <code>pkg.exe</code>, and use that to install packages e.g. 
+<code>pkg -P <i>binutils</i></code>.
+</p>
+
 <h2 class="cartouche" id="why-not">Q: Why not use <code>apt</code>, <code>yum</code>, my
 favourite package manager, etc.?</h2>
 
-- 
2.46.0.windows.1

