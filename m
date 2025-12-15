Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	by sourceware.org (Postfix) with ESMTPS id E8AE54BA2E07
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 14:37:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8AE54BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E8AE54BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.160.169
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765809443; cv=none;
	b=mvfXftK9qj6OLGeSKeZh0j6p3Dur5GqbnHwCoG2B8VTBELSEQR1RFRVN8A4O5D65Rt2lGZGrF/guIvvioKSi+/oGxH6J94uRK8LJnAGpNchzPoWoIv2/ibsL+FDktbFcqfpaXit3LZVYmyTaYz43XUP+7N8ECmxSngPNTIBTsgs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765809443; c=relaxed/simple;
	bh=dH00X6zBLOkSLbLq8nMpxbexlUrmwLYmJpOORcJunBE=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=WKXjuO3/zzZ25dUuiQtTILJn65WatwHoLCjShOB971dgaQBGnXCtThwOzt6WCjZsBlyCmwL42tRIp9y309R2CfwfKbPIKPOhHY+NE3joIfQMtKswNlhbPZFjouCfbDh1R1hYdurf5Oo6k5Nqs0q5YLj1fPFl9nvhkcKdny/C4SM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8AE54BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=OJl/egba
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4ee1fca7a16so27832931cf.3
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 06:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765809442; x=1766414242; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=F4m/zDX1AGz+Coy/IQtSzhNljgiariFLAYo5AXPTEhA=;
        b=OJl/egbadm5cFdiNoGZ8d+i23K7OG8LREzCEUXzCvEZp7si319u01r6Bw3mFZKU9wy
         aW1p++0D2DNzMGw9JlNAczKI3mJeDgSMbkdnOVgUt5nXOWw3ESan+idDP3VPoE7lTT9b
         m5+WkDFSsS8TK8STflolUMeLYMR8PjsCrNFE/HBoMAuYYobmZS1zqO2ONkSJVfLQ7VrS
         TxQjIEvtOuxDcGN2oI/3Q0zvttGKierPbqRbvv3abemgTQwSJlBYncEAa9qDXsNVlxLI
         oqAY4DOS79XrjBTltvtU9i+9FoRMurNmN6xSZZWxPZC45z5C71awCqBa68aTLP67Iv0v
         +KmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809442; x=1766414242;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4m/zDX1AGz+Coy/IQtSzhNljgiariFLAYo5AXPTEhA=;
        b=KJuyCy8yl2lB+2UVC9bFUnZYiaUZEXDFuCNluAA42i+Y9KAYeDofALrNYcuPFPZzyA
         AmBoF9nRnDbH5MsRo/OPYtR3dpHytUY4Sq5qbyfvrQUvaL6J27GYa3n0BWEdf4YK4NUG
         UtzIYNMv5b+/vMvaCpVpR+3bLGT6riq8tJx4Dr3Uj7/Z5sVYjWVpkgQEN5vPIcI04BhA
         3xi5MNXu7cgIXl2VAEN08noeTxJM1TrohnpepJ8Xyksxa3cWhmE95PydfZ4IZHfdiZb+
         i6iJtwy8OkrmPJLq8XMicNJ0BZ+04I7KfQp+6CI/OfZ0GM6e5JQ8nhh658vjouN407Zj
         Qncg==
X-Gm-Message-State: AOJu0Yw34uNHbFIebITSUXTsbJGuIkvp2rwA1manfCOya6WxMwxBLGdq
	p19Yt3mSyrDElPt73xdIlwN/4JzUR+yCBUD4WJZNRrzVnfGdoyBmny7tcHIvCZ5m
X-Gm-Gg: AY/fxX5VjIb59KTD1llesTtEtrIbVbsc53TPAGJcUb4kWl8xD9ObN8XAstZ4j8biOBS
	C45xcynj+ioOz++oLPHqBFm7QZKR8IKmwSZ9tbJOYIX5sUSlj2/rIKobd9cMGuUCME7yTvUxEQ1
	V9RAIr0ua6w59F2sSIukdwYRPbe4DpLPeK0DjbP+NxadyqGPUp9ld4I67iWqvELBlZ5HQQFzQRM
	oo8jaVkTKEj3XNnnAa7FHdf5LmberCo+ylIjPGe+Un8nPbE39sAiJwYMrYUScl8yycQd5c73qUg
	QqVa90tJ0tVQ/VSw/lSG/9zVmXD50h8k7nfBJeJyrQFCYeEtRbfMDheANhZJW5mkHTDbJsLN9i8
	75ZHV2wmYbuvN/x6V7Kvzm0DFnywe12u6/N1TUOewK1iC6qfrKrGd0MZ5KdAV64ww70NRJEcbGs
	xF8QgAaJv0ITNqo18=
X-Google-Smtp-Source: AGHT+IHhZ/VcBy5K6dWkAXtijitWjbvEIKidCYajXEUrL7sAmKerm1X7jMh2eVyxLrkbKOIVA779DQ==
X-Received: by 2002:ac8:58c4:0:b0:4eb:a216:c070 with SMTP id d75a77b69052e-4f1d06438ecmr137155181cf.84.1765809441700;
        Mon, 15 Dec 2025 06:37:21 -0800 (PST)
Received: from [127.0.0.1] ([172.208.126.104])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8bab5d4cd3fsm1089957885a.49.2025.12.15.06.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:37:21 -0800 (PST)
Message-Id: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 14:37:17 +0000
Subject: [PATCH 0/3] Fix stdio with app execution aliases (Microsoft Store applications)
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Cody Tapscott <cody@tapscott.me>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

When I introduced support for executing Microsoft Store applications through
their "app execution aliases" (i.e. special reparse points installed into
%LOCALAPPDATA%\Microsoft\WindowsApps) in
https://inbox.sourceware.org/cygwin-patches/cover.1616428114.git.johannes.schindelin@gmx.de/,
I had missed that it failed to spawn the process with the correct handles to
the terminal, breaking interactive usage of, say, the Python interpreter.

This was later reported in
https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com/t/#u,
and also in https://github.com/python/pymanager/issues/210 (which was then
re-reported in
https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583078).

The root cause is that the is_console_app() function required quite a bit of
TLC, which this here patch series tries to provide.

Johannes Schindelin (3):
  Cygwin: is_console_app(): do handle errors
  Cygwin: is_console_app(): deal with the `.bat`/`.cmd` file extensions
    first
  Cygwin: is_console_app(): handle app execution aliases

 winsup/cygwin/fhandler/termios.cc | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)


base-commit: 7d43942e7c3b56799e9e46c4701f86a8eb0ed579
Published-As: https://github.com/cygwingitgadget/cygwin/releases/tag/pr-5%2Fdscho%2Ffix-stdio-with-app-exec-aliases-v1
Fetch-It-Via: git fetch https://github.com/cygwingitgadget/cygwin pr-5/dscho/fix-stdio-with-app-exec-aliases-v1
Pull-Request: https://github.com/cygwingitgadget/cygwin/pull/5
-- 
cygwingitgadget
