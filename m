Return-Path: <SRS0=CAkv=Z2=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by sourceware.org (Postfix) with ESMTPS id BA5A43858433
	for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 05:29:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BA5A43858433
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BA5A43858433
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b31
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752384578; cv=none;
	b=BjWCBQHG8TRWsFNYgbahRzrnHiZx0gtTqj02VK2X7XLVC1dy7XF0pfNOdkLUwrGMDxNqy9AlrDZs2Ln4RU+wHINgTU0pHOMnmaMCmZnmr1eQV0t5+j+xcTUBVCC31LflmDvvy4dC1Equw4bvaGAOw2E06ton/DQn+SWFLIHHl1c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752384578; c=relaxed/simple;
	bh=CGjfEDmSJafPSgEAFBxbvR9pVwC6On+zTEjkiKlS/lo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=FG96dbw8JVU5vy4uyT6VIetyGDyRLVTXKGdMzW7FB0DtZpGMsqyoB6guzudrA9YYMPUtJyFYIfNTLbeCPVTk0nFD4Ks4BUwF3Hoh4de2bVlkkDOMjR/iUGb8A/ETfPH7StUqJGhy9GR0Zc5Irmghksst+ghuaxPkC9Gc2kA5nKQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BA5A43858433
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=f1cjXtnV
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e818a572828so2272038276.1
        for <cygwin-patches@cygwin.com>; Sat, 12 Jul 2025 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752384578; x=1752989378; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sELMRB1wXy5k6Mx3ucWck6Ou3yyOkpllmWDXOLGIXGM=;
        b=f1cjXtnVlVjqYzyLGr7O7nY4m7iKfcBpGThft+0FFW21tM/1Vs5uqC4efw8bt0ZwCd
         kgIrmyfG9AT/233JEUAq8AgDkbp9YdnVZleuKgPAjFTKymxHegJPmSoheVjkiBkaeSBd
         fabdExWrL/iXR0wzkO6Z5x01H4WdXTiMIWVzG5D1K1MtiJpcBGyxRZrrwgmBU8Bmrxki
         EYX3rM8d8AHCyFPct9eKtBQg//hSyr79ju7oz5eYENnkb+EAeo8/6dbg51bjNPVOvvH8
         UjBQcJQ0C8fsIV+UVApWaJosybOZD6t+UseakZsq+0X+R4EC/242OddImyHB1J2CrAw1
         XVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752384578; x=1752989378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sELMRB1wXy5k6Mx3ucWck6Ou3yyOkpllmWDXOLGIXGM=;
        b=Sx78oLWUuXyii8amkjm0+p0o4kfQRQTO7bPCcOWSNWvvxKlvlElNp+z5PuK+IU+SIg
         CnoEWyq7tcvDRxxkIUZ+UNLr/iyRqc8dfJN4c6YpLLCgQCA/XB5eZSP5PwpOWlzMZx39
         8RchpdYY49G4vfKwfZHzPYHVf2gWSmflAcp57QiJQnzcNEbO7VjaYGbKvhJ48yk5roDS
         EaUyXRQ7ck2zuS7Ne2AJrMLQBJSgxjm0e6IBnSmMWkoKHuN30YMM/POxPMWyx/2G3E2v
         g+g9BAboMzxQmBSNUXDtJbovMrdqQ22LOYXw9xpWEkMGl//E0w6MoKo37eqyGmeVwiVY
         bjqA==
X-Gm-Message-State: AOJu0Yyv7VqGfZ1VwBLESILDFp++UejM75cyXjaEg0uM8smD6KuPLsWv
	gzCDyWkkGobsJaRf7xNWZAz0TDFIqVwcL2E5r6nvXRw5wEhtc+wp260T7M5dAQ==
X-Gm-Gg: ASbGncsj1OOTNnLRaHO8YoOV9mkPqMsxv/JAyL5Kwn1JjMxL+YsoJUYHnMyxBm1FD4l
	sWibsw4wtmDiFYnls2tm/7ysgG4UCy31lsW0fpgEcWgQuZh2Rk1Ztrznc9sRZ2ytIN6JsWhUNMC
	QdI6KXkbaapsXzEB83/r/VUR05H0NxQmULe8DJSF0L5aGek4Sg1980NArAuIk0zPDopqtAuBG+W
	t8C5OpaJvUGssf8zv6cABGk1mNz5tFGNfNB/m1pUcutjlXWqQ3KC1sQYKlPyQPfn2kmCmFyThyK
	Dca53ea1KvSoy49Tmraesz6mIxbPFsuWZhn0n72kb2mJJI5+mazTgcUeQ7pm91zPa5qGPks76Q1
	UfcOSif7mkpI5bPJ/Cf7m8LCmr8achztb2ixArRC2tjjaYFWKKN29gak+XCHUlOBajaNmfsoYnX
	zgxVL55mRGF/lIgiczoCPqbweaYh4K
X-Google-Smtp-Source: AGHT+IHQvVQP5hHr9ROf4EYTIQ34hmSy57Um8iY6bx1BK6xCULxAz47dh8/ndTFZdf4fFAfc6YYw0g==
X-Received: by 2002:a05:6902:4614:b0:e89:78fd:89fa with SMTP id 3f1490d57ef6-e8b85ac0149mr11285604276.3.1752384577596;
        Sat, 12 Jul 2025 22:29:37 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7aff2a4bsm2169924276.57.2025.07.12.22.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:29:36 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 4/4] cygwin: faq-resources-3.4 start local server
Date: Sun, 13 Jul 2025 01:29:13 -0400
Message-ID: <20250713052913.2011-5-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250713052913.2011-1-johnhaugabook@gmail.com>
References: <20250713052913.2011-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

This patch provides a copy/paste command to start the local host via the 
command line, and a note on alternatively using server software to start 
the local site.

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 winsup/doc/faq-resources.xml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/winsup/doc/faq-resources.xml b/winsup/doc/faq-resources.xml
index abe3f50f3..7c7bbac77 100644
--- a/winsup/doc/faq-resources.xml
+++ b/winsup/doc/faq-resources.xml
@@ -109,5 +109,13 @@ root of the cloned site and run:
 	$ cp -r [path_for]/newlib-cygwin/build/x86_64-pc-cygwin/winsup/doc/faq/*html doc/preview/faq
 </screen>
 </para>
+
+<para>
+Then run:
+<screen>
+	$ httpd.exe -f "%cd%\httpd.conf" -DFOREGROUND
+</screen>
+Or use server software to start the local server.
+</para>
 </answer></qandaentry>
 </qandadiv>
-- 
2.49.0.windows.1

