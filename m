Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by sourceware.org (Postfix) with ESMTPS id B5CFA3858410
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 01:39:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B5CFA3858410
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B5CFA3858410
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750815564; cv=none;
	b=NkRTrgPYOPw0vdLzBiqhZNVUayU8prmVLunmG//rFK2buY78P3eVKKwfhXwYRBlYOip+6nHcS/vYBd87pojBPSoCYZvvkO4GCUfW+jniwxdICZxCwsd8RjT7Y5bhiyjhInfUV47QKQFQmRHYovD2owzKa3PYHdhq/vT+SWUVn78=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750815564; c=relaxed/simple;
	bh=bB9WqUxrskNUA1C1wOuW6Jcq/c0iwjM7Ttxx1AOXAkY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=u6suNB8kFoOwvh1VtLDIqji9X3kq1Tsk9AaQNF5ZSVZtA6dqD9oY4/NUK5DPhmKLjSZ8ElqArM5UB8CfVCXkBVdzCSyE6y5jxEYpiSdoPWwu2d4Lq4maGZH8zLYDY/P8NvdUv5WQYoYPmG6wgoUHbMLQ7ebn5y1pAdt5i8l7dHk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B5CFA3858410
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=DaJ+8cIq
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-e812fc35985so917645276.0
        for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 18:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750815563; x=1751420363; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4wypjSk0B1H98WN0AXgKCxyidLs3aLtTTCBtMXDojLk=;
        b=DaJ+8cIqzL3JfiLnx+vtE+t32lafi9nJU/fWIRNJfUcwB7oRRcdu8Xc6C13d53ziyn
         URospLgoVQZeBjYSoN+WUkjRBcIQNAvF2XZ0OmLKInFmkAZUGDRuBk7Ndf7PMkLBS24z
         toW7duP9r6wL9EAk5Enkum3NSoNcr2QimjSuhQH/3uJ4pjKAx4oFQzTuGqI5IeU+fQf0
         UbxaSk5P01q17iB39tij1jHvc2+R7vlGdh/jDRSz65pOH+Zzbq1iwE3GsPhx1R5DSp/8
         pCby1sdkSnwHGibZuk+PQiO57lefHfQGhx1KozRMaBvuwlN1T6sZMAssiqvFcPe4M02C
         poSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815563; x=1751420363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wypjSk0B1H98WN0AXgKCxyidLs3aLtTTCBtMXDojLk=;
        b=Sdsqux6CSVldWsOHpTMtXmo3bXsjtscZkrNRZlBCDfksj0MJw+fcS4PAqSlhWtKczK
         K37KkcGlTiQcC14LpqKhINZGh9DkBwMia4PoLUcOxGWaCJjnPp0o5SZQS7i5hTDR45N4
         XsTCaAJGXgz4TdPcStj/YemC29xf8VDLFaDxAmKZ7Ab6fl0KTjOv9zxh5QTywOh07Pv6
         Re+jmGkz9lVfXljyRi9WCfiJ9UWD4xhl5Xhs/AFZxDVoE3aHcKRJXlz65mdESB2D8+WV
         8WhJFcfX1hJ1KXrdiR9zW62L++RXrUKKU66ofNHOavFkZEKSEmX2MqY2G8VgbIV2A+cW
         MOUQ==
X-Gm-Message-State: AOJu0Yx/mUnbtfN5lM+fPnE6U8etLBlVkc27gm1OpNU1S28mURoeQLoT
	jMDqe2F9QvZnwOcJrvvDZMA4JW+8ocDDmU4rKkfPQCOvFz4a5xLpBgShZ2id4Q==
X-Gm-Gg: ASbGncs2SKd2N0jkZbF3PcrtKWfd+lo29x8kL3vAbpKekgvWhwDlq3CjtipN7rXcNc4
	dvBxboRNJgSEPFMRQtaa4Fo3+9ZRh3XzHm7ZFEcEdlAySd4fQMiH+IFR9s3MWvvc2F/glL0IzNV
	azvBBxw+MYhC4/RxuLW95dX/YF7z1OVKYexCKq4OEo99Ju4EYTzRJhJFj8bZF7qezGmeKlc9Ak+
	esmjhyUTpBJR0/P8sqo1Dq6gRKSPYpEdSRUmsjQK7pQK4R2VUUWAOth9zFKWPYQpqAo6P7evFWN
	mFc7TMeVFl6spG8peQyiiijzjPU01SDMnWeLR/wkAgJX8TLUuaoACR6CwzWSfvrn6iz9sI9mMK/
	XKYYeINTqSuOVPpqiQRX2ta9lgFN4uysFmg6EWqaBGlbgUQ7R5mxdvMFH2DCdhXZoRPx8
X-Google-Smtp-Source: AGHT+IEVE7hCv9SpBiOWlGXjpOyn3FccJQqM90y5eYlcTv9iKXQ4B+A8SyqcF638jLtsAJouNRfm4Q==
X-Received: by 2002:a05:6902:461a:b0:e7f:6815:ce6e with SMTP id 3f1490d57ef6-e8601756f3emr1460449276.20.1750815563444;
        Tue, 24 Jun 2025 18:39:23 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb1fadsm3327676276.50.2025.06.24.18.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:39:22 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 0/5] cygwin: 6.21 faq-programming.xml edits
Date: Tue, 24 Jun 2025 21:39:03 -0400
Message-ID: <20250625013908.628-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

This set of patches applies changes to faq-programming.xml at section 6.21 =
"How do I build Cygwin on my own?". The changes include:=0D
  1. Adding 5 additional required packages=0D
  2. Add ready-made commands to run setup-x86_64.exe to install required pa=
ckages relevant to the use case=0D
  3. Additional paragraph about the build process and an estimate of instal=
l time=0D
  4. An install tip for building cygwin from newlib-cygwin=0D
  5. And a typo fix.=0D
  =0D
The details for each patch are expanded further in the commit message inclu=
ded in the patch. Also, you can visit the support repo that illustrates the=
 rendered and doc build changes:=0D
-  https://github.com/jhauga/patch-newlib-cygwin-faq=0D
=0D
John Haugabook (5):=0D
  cygwin: faq-programming-6.21 add 5 required packages=0D
  cygwin: faq-programming-6.21 ready-made download commands=0D
  cygwin: faq-programming-6.21 para about process and time=0D
  cygwin: faq-programming-6.21 install tips=0D
  cygwin: faq-programming-6.21 unmatched parenthesis=0D
=0D
 winsup/doc/faq-programming.xml | 57 +++++++++++++++++++++++++++-------=0D
 1 file changed, 45 insertions(+), 12 deletions(-)=0D
=0D
-- =0D
2.49.0.windows.1=0D
=0D
