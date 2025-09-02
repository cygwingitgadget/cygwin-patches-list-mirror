Return-Path: <SRS0=71sz=3N=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
	by sourceware.org (Postfix) with ESMTPS id F017A3857BA0
	for <cygwin-patches@cygwin.com>; Tue,  2 Sep 2025 11:40:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F017A3857BA0
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F017A3857BA0
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d2c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1756813242; cv=none;
	b=HTHaMAP+XgfgepvvcGU9nFdbUnlAyGSVa2YA+shGkHy4O60Usn/tLgcP+H/AJPfpLFcONR+AB0x8GUh1e27ISXKwCJujzkvvPhVLB5C9vbVQdNxdumjrsuIzpBjp9BGULlT/sY7rQGsW5FLeWWjoDcGQRmIvJ2F5yMzA/iVw8wY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1756813242; c=relaxed/simple;
	bh=fDWdQVZk7hpBnxMYapeZ6bokidn1IMoxYdpUt9TbFlk=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=xKcr4SfQeRIlgdKPa/4A9coYY8fG/cu0+Y0HN5bWjHSSNYsmURjXyvQKhIQPjWr/UgIQ8HmVqdpgPH6Rvl7L66D2NuSshksOeN2XQFaBeOCKzjCLeXsc9uAfom1nMBsSY2/7/1e75664RM+n7XjRoVQoCAAjwbN4m+duc5agdY8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F017A3857BA0
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=QsJNVaSF
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-884328c9473so62049339f.0
        for <cygwin-patches@cygwin.com>; Tue, 02 Sep 2025 04:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756813241; x=1757418041; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mzx2V5xOwVVm7XurbsD3n13z2XhG2ZxED0MzPfxACEI=;
        b=QsJNVaSFfh3fVnZRrCxJsGt+Hoa2meMoNXvjI6uRwemKVCr2DPGOY32QgqrsMjY33w
         9mvl2A7n6JQdNCrsjbbRFgDP0gQethPd9lveOsEuKsY+M2cFf8NfMKAwHy6wu5OiG4AQ
         myq5UfMdFZ14/P8Iwm4h2i/PiM9MDTLQY+YqaanJGxdOF4WoNEKS1x60TmGNFW7fs8jg
         tQggAX0c1/5SWX6zOACfFWpmIuG2CO3/cCM9AWdaiBJpI+LWumKAL3v2IOeChNw9REPV
         66k0A8yLzYdBtrPAstSW+1Y1z3eBOVnydNcyGMYUTGG53B7vjotVgmrpV897QLoDl/Vi
         kWFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756813241; x=1757418041;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mzx2V5xOwVVm7XurbsD3n13z2XhG2ZxED0MzPfxACEI=;
        b=owhIQvJnneOWHFUxKicR8tCPQKhcNpWFtoYPIGX3cb919mmB6gzqYYLZSPlIMxMTbC
         De/o3VWMYnDws1MlXc/o9jn39EUYWaUTB5QZYMUVOrLZrFzKse7I4EhXMfwEhJJxChGT
         RepJc4UT/NN7/90xnT1jPh7B89x1eWZIMm+X2xi2klfrIp04W6ageKu0V/lw0/tz7EF4
         pI3dYpJPWWDuEHEDYg3p1CPamBZA7Vj3tolekK6kutiJvgwJ58lEP4JcehJOQCYTfgiV
         HDEGH4BIdcr821VFv16SFsezAmfCHDcLp6XrM0UZfaeAPBxuIgsuW7pP8LJaoVIqAxfK
         eH3w==
X-Gm-Message-State: AOJu0YzRcAoeHDCbVcT7ZB5d9v344WTzzJTsDBwqhkSTwTCAbv2b0ZBA
	9t+MLQLVg28EOQ6H0Z5ceNyrn95W5jjEydQOxaKIXpn/hiRM53bTjkn0EiJ/CA==
X-Gm-Gg: ASbGncvjOzm6xJ/Idu7s32y59QsOscUdLJ4U9NYNelIkEdpjLdKTi1v/k7YOP6yNVpN
	+85qWx3obARTCdQgZdLK0Hv6+B38PnBep4fw4MBhB0kwSuyIWVUQZQZ82Js5BSqEv0MXAA+J1mG
	zbpm3PxmSMV9Ux6hYXpST7TV7Shk2Pu0/9W6uKPIOqC1UM7yX7ryrV2gRsxEfSAoifAYtVZVBk/
	oWf15MlPhptcIPq4W2lxtrwkJot7ViIWKzPaFhCofUIF+LARuuPF60kCZHctKQemRFbuxVRckac
	Ku64gu/Nr/7mat0EPPO+2QZzgXDJ3nhCZDdwFMEr3vv3lOV5bbLwAMURCUD27fW+A/HnyK9AKak
	HVQaC1qopVy1JPsiWaaXCZSytaA==
X-Google-Smtp-Source: AGHT+IGrvCuyAodjoHhTdYrvSAkwig9Vvy/a/PVOn9yQpvz15ME0HmpBxdEwAuH2ovEpQMRLgWePyQ==
X-Received: by 2002:a05:6602:140d:b0:883:fc4a:ea55 with SMTP id ca18e2360f4ac-8871f421e06mr2223312239f.3.1756813240628;
        Tue, 02 Sep 2025 04:40:40 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.88])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-8871e3d714csm306464939f.18.2025.09.02.04.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 04:40:39 -0700 (PDT)
Message-Id: <pull.1.cygwin.1756813237801.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 02 Sep 2025 11:40:37 +0000
Subject: [PATCH] ci: bump actions/checkout from v3 to v5
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There were two major version bumps:

- v3 -> v4: new runs using Node.JS v20 instead of v16
- v4 -> v5: now runs using Node.JS v24 instead of v20

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    ci: bump actions/checkout from v3 to v5
    
    I have carried the v3->v4 patch in Git for Windows for quite a while
    already; The main reason for contributing this now, though, is to verify
    that GitGitGadget [https://gitgitgadget.github.io/] can be used to
    submit Cygwin patches, too, not only Git patches.

Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-1%2Fdscho%2Fgithub-actions-updates-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-1/dscho/github-actions-updates-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/1

 .github/workflows/cygwin.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/cygwin.yml b/.github/workflows/cygwin.yml
index 877f54cde..40670cce8 100644
--- a/.github/workflows/cygwin.yml
+++ b/.github/workflows/cygwin.yml
@@ -24,7 +24,7 @@ jobs:
       HAS_SSH_KEY: ${{ secrets.SSH_KEY != '' }}
 
     steps:
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v5
 
     # install build tools
     - name: Install build tools
@@ -111,7 +111,7 @@ jobs:
       run: |
         icacls . /inheritance:r
         icacls . /grant Administrators:F
-    - uses: actions/checkout@v3
+    - uses: actions/checkout@v5
 
     # install cygwin and build tools
     - name: Install Cygwin

base-commit: 822b49e97af9c6551911c0ff5297d31b61150e03
-- 
cygwingitgadget
