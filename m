Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
	by sourceware.org (Postfix) with ESMTPS id 0EC394BA2E13
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 01:28:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0EC394BA2E13
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0EC394BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778290113; cv=none;
	b=u1oGCstWq2xZW20TDSHbF7HZtEacP34e9ys1fMq636zaDiwQuXWmUkdZaIGLhyiDXrvJX93/xKfaCUFWM63k87gXKRljEwelwrI15qluc3Dnu6pTMsMv3MPOAb6vTREAo0zIeuVcqocfln5pvydmgOf7NY5Apfx7P5uOp+xeOBg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778290113; c=relaxed/simple;
	bh=XbSUENNPOgqFzB+ny3Dl5joMKtezyjTI4tSjFl38bAc=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=kCh5FYrkdUhecxHYHrdQwZtDuZUWP2FggSp771r5gLfoBDUikT692sP73O8Ov6oGJDWlGBd/m8pmiUhLTtpmgyBrb8Sfc04uMljTbirf97DozhpH2sZUf/ePGRtTSn7plFHgdUOSFCbHabZnef+RsBb6NEJUOs8FP4JhKeDw0Cw=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=es8SJ+6q
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0EC394BA2E13
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=es8SJ+6q
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-7bd5dde63dbso28252867b3.3
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 18:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778290112; x=1778894912; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7nwb3vdYgt+Bn7bRM9Dw99RcMyBedZrl6rbNmB0CbA=;
        b=es8SJ+6qTmG4q9tmNzkPGcRNVgZX5U3R+r9UjKwFOKkGx2jMLRRrphfbAL6MyhgbI9
         LfTo8m2kc2Yb5CI0uXRJJFCUKZu0fTCqfTcd/LmK3+NsSq459oLTatfb7chlVXIGGyZO
         LJO4/Q+wQE/OZmcxRd3KmVOm5fdzGTNg1KFU44WesKF9kRAetwJ4+Zh3fSXu5pXzJ5wC
         DgCvfiL0P/T9CegTxvp0APl+X3yEPbv95GvNSzmv19Al0yxfQbScCkmR32MLIR+azRFZ
         UpSceXallUSUQuBjnvd9UgfN2ELtZBd6qa5ki00VhNu2udw/uo5kazpXSyMCKGVTgCtR
         WJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778290112; x=1778894912;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=R7nwb3vdYgt+Bn7bRM9Dw99RcMyBedZrl6rbNmB0CbA=;
        b=s7rQc0tEvL8F61NT2oKWFmrA51L7zAnLJJ5wJ7FmR0BDMU8nhzkRPifnmaZbjkcDAj
         RZOQqUkI2BJDiqcKwVt0oyX89pMfKnDmIgd1oTfbojQP0noYXkmYGI7oFgRivZVX4oWF
         z1mQnYWz73lKfut4SJ4RXx63ZFcabTdpQjpnqBe0vgVjY0etfPuKd77yUH52Xq9OnMVm
         Plz48jEFR5F2pVMjSJ+OcITl6LCJ7bMKXWsSEN8TwyvYLfbbYYN4ZHdJamgFkBf11SG5
         g69tKqpuL46kUMlhpud84323HFK9iGlmF2F1gco5l4L78obxzLmWmXaVafsriD56V7zr
         pJBQ==
X-Gm-Message-State: AOJu0YxwA7yi0zTdLlSLpr+cLjYnhyJyX8nTPPtvSsmbon2z8dnxwMQy
	YsOjuJx6ClBdH5XQcXpxTwMpxNpjMZG56PMVniGAwP921qG+laTaVCNavGR6uA==
X-Gm-Gg: Acq92OGqJAB/pSGA+4jm21e3zTBCUlEfq6rR2M9650M3dVyllMAi15qYu63ZsHDI6xY
	k9JZn85vPoXlyikvKChuDkBu3kFbDgvsmd8N1JxZLloWPCqxIJ1+7i1/8VurvNC3Z/1Tti7utNX
	AtvEeSYkWGw+DK7gFzqa5fP7Z5vOQQ4R8/wZ4y5H9J4bRF9om7MTMner9/jimURBYyrvMPKUOIo
	F18qYLKFzGPI2cDqoUEar99O/GDe4e/UAnhrSU4MbQt4g4QKkRpI0Gqrdljy9G/ZxSCfwY76kGG
	psAehAEuxkKMGtnnaluK+28wLl9Lqda/YAYnt472jd0KwY7s0p0bB8xjISTdaJQNqcUjVGC2bWf
	AJ3sQDDh0vdaF6M7xnjZuWuZyz/PuB9jGbvLB39ryTuUnR6kYTUqgE6Xa3YFr+GUEnfGDLCm70W
	q13mtl9Q9IoVpjqJQOdI/bi4kJ6/aQ9D7RxPvhsmCTxbsHre9sYFW05n011a9eno+sjZkVBOkAS
	ZlCdaYI7John8vOYAw2gZyszGk=
X-Received: by 2002:a05:690c:6305:b0:7ba:eefe:9fb3 with SMTP id 00721157ae682-7bdf5d8cf5emr172972777b3.2.1778290111780;
        Fri, 08 May 2026 18:28:31 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd66888cc7sm113210917b3.44.2026.05.08.18.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 18:28:31 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 4/7] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 21:27:46 -0400
Message-ID: <20260509012815.1157-5-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20260509012815.1157-1-johnhaugabook@gmail.com>
References: <20260509012815.1157-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

style.css: remove gold star menu color

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/style.css b/style.css
index 78baef51..b7429c79 100644
--- a/style.css
+++ b/style.css
@@ -80,11 +80,6 @@ a:visited
   text-decoration: none;
 }
 
-#navbar a.gold
-{
-  color:gold;
-}
-
 #navbar ul ul
 {
   margin-top: 0em;
-- 
2.49.0.windows.1

