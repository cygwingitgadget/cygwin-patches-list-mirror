Return-Path: <SRS0=CAkv=Z2=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
	by sourceware.org (Postfix) with ESMTPS id 4D8043858C42
	for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 05:29:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4D8043858C42
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4D8043858C42
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752384572; cv=none;
	b=ja2x7hbuosQ109KyEobIbwsWLj+wL7jWm1QB6rbsNvMWz/SDVR5AQzwes2FBed4su4QpjMCbuZFfN4oODvT9M29A2hdsn2dJdm4ADuVbg4mSHLxZyOxDf3Uj67pRuJdCHv6IjU9wEMKvBpeH5DLA5adtqeqx+Q38imMpiPknQs0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752384572; c=relaxed/simple;
	bh=jjzEZ4iIkM1p1E5X33Z0r7voQrGlPReE1OzkX8Pkw/Y=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=qpQvngs6y6tpO0fOBoz92cwVIzR98mzusesRk8Me01QIdTnPhtSG4e/b89ORdTvGsTd4eCoLarphv2qS1oWe3lBZ7dr8o3mi20IHxtfGvFpSxgJ5v5XkGAK0wpqDoiZqcRjisHL41hNrIsVI6fqoG0aXjDeunQH84dQRiQ5qCY0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4D8043858C42
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=j+uflx+T
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-e75668006b9so3285123276.3
        for <cygwin-patches@cygwin.com>; Sat, 12 Jul 2025 22:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752384570; x=1752989370; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eZvSFHulyDrRkndr1xxzVdBR4Lwu9gjhmYszEOrCWo8=;
        b=j+uflx+Tm7KCiIhz3L9Olxvfcs/Uia41aAAx/psw1E4XlCuiJ9qSn824Pn2hdWSjmQ
         DquPChejtOolhFBnZqpels7FGDuNDOS1CaYTmcaDSJkt2sdTl1uz6J/azcFBC43AzuvZ
         S1qDzM3uhzY+v3gFFz37Jr+ryesC37l+j561Ix3oQQeNXL7yqK7tKREN1Skzbh9J+nCJ
         ko4aemyDj6tiHILyz0FyGFESRKwGUJEaLs712e0h8L/nXMokTkl7qk1u5zo3IRdvE/IV
         DhLiLbho5fZ8xi7XJ3sT4QClJJDE3kqOjDAZO/s74wPzAebKu4wsOPSwb49QJn0+OCFs
         GU9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752384570; x=1752989370;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZvSFHulyDrRkndr1xxzVdBR4Lwu9gjhmYszEOrCWo8=;
        b=fDI+6MtlZbipzzLQlMmORojx5N0FUMVey8GJ6WLEq7hliDYr+JjabZs0MW94rz7qE+
         95Z7IfYhucfFCZz0ecnijvNPFd+XEzJzAmh/83RxE/lksLki6z81L3xOzIMfN2c2kKgM
         f7SrX07ZnVzWJD/AnfbLSQz29oMdwHOfG5mbtUy9RwmfIhyRu3PeyswN4IcgR1kT/Jct
         TQ/Hsen9sd4w9qjghCeiV9JM4gpqYnrcap/pkWqLao+WyKB6JMquRvGbJ7A09zaC361Y
         JHp0yoBifm2xYTQxFGkR4PdlUBupyIh0txxhqQCFDa/AGpkQeJdM0RO3bkhvAl4mbH/o
         9FXw==
X-Gm-Message-State: AOJu0YyQrfn0xVqM+smLpWTSFh9x2ekGJXYBwaMZnYr0DY3wj8wKCLYm
	k1RKUV+uuFQXpKAqAMbwqEX/JLfJYo0oxLQ/ZARMFqbrzSNRTFxhPGfRvYNAYg==
X-Gm-Gg: ASbGncvVwl6+n25TwpMOpGAL/a2+TrQTEehlcMLGiwG3ZLEZUmaipZHrSiy7/IXBDoq
	0VhchCzna0TcM+JIoAVi2s9U0P+s2Gln1RZtcmg7dmPQ3ZFsqyE0tyP0niRSx5A7qW6dqkPteCI
	05uhSBRxPV/FSuY3PsWHl2VAfffU+v++a6TO7Rijd0lFCEMVMvGKJr5W9kn5mZT+mh8TNpnHEap
	myUrCzYHcesKE1y5ygcBZcKrSwr2uhC9ULFEZvPNHRvNpBPve+XZz23Y2VQ0nJbqoHXnTmzRfHM
	j8/BMF4v4i3ZSstc2QLDslVuC3W33GmARP5Xii5nflK4x2r1mrqbSHPuNmi3XKGg4RA7uhTZMcv
	d+FK2B3nY+R03olsLYhHj3qQ8jBPn7IR6GMqY0HEmp0Mst1oF6/0lCVOt06jLTlrPEBrqvTvtGM
	l1QJDl7cCTEMowZ3opVtceF7T49+Gy
X-Google-Smtp-Source: AGHT+IGzFCm1eOZb1HIcQJIsHQrSrs4I/Ce/ky9SYo5SiKodsQOm8bznaBnDEcXbaUxZMzzNklaspg==
X-Received: by 2002:a05:6902:703:b0:e89:76dc:4417 with SMTP id 3f1490d57ef6-e8b85a4f268mr12944930276.14.1752384570272;
        Sat, 12 Jul 2025 22:29:30 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7aff2a4bsm2169924276.57.2025.07.12.22.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:29:28 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 0/4] cygwin: faq-resources.xml add 3.4 reproduce local site
Date: Sun, 13 Jul 2025 01:29:09 -0400
Message-ID: <20250713052913.2011-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

This patchset adds a section for reproducing a clone of the website locally. 
It allows people who want to contribute to the website to be able to run the 
site locally, allowing for rendering of the virtual includes e.g. 
"<!--#include virtual="navbar.html" -->". The patches are:

 1. General steps and overview of how to build local site.
 2. An example httpd.conf file, which allows the virtual include elements to be rendered.
 3. Instructions on building and extracting the html docs from newlib-cygwin.
 4. The command to run to start the localhost, or note on using server software.

Also, I made a support repo that illustrates:
 - The built faq.html.
 - The process of reproducing a local site that uses a Windows Sandbox environment.
 - And a working example of a locally built site that was built from the sandbox tool.
 
Visit https://github.com/jhauga/patch-newlib-cygwin-faq/tree/reproduce-local-site and see the README.md in the root, sandbox, and cygwin-htdocs folders for more details.

John Haugabook (4):
  cygwin: faq-resources add 3.4 reproduce local site
  cygwin: faq-resources-3.4 example httpd.conf
  cygwin: faq-resources-3.4 reproduce site docs
  cygwin: faq-resources-3.4 start local server

 winsup/doc/faq-resources.xml | 66 ++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

-- 
2.49.0.windows.1

