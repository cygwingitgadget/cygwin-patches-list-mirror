Return-Path: <SRS0=6Jdb=CH=gmail.com=joel.sherrill@sourceware.org>
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	by sourceware.org (Postfix) with ESMTPS id 5D1964BA540B
	for <cygwin-patches@cygwin.com>; Wed,  8 Apr 2026 15:23:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D1964BA540B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=rtems.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D1964BA540B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.128.173
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775661836; cv=none;
	b=uJCL2WJRFgCdpmUhAkFc8zGUxS4wQUoxRaRS/5l75ZqhYWYds9hStbNazudAqCNCZMX2nHQogVtNFIGeoTu9cK3O+EDIjFtw2HEAPlsyxg2NR/hJsEeIJMLKd7+qMBPfySn3F1cGDC1AXAKbb2hAdM57f3lPx7cf2R5Bnqv7Pvs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775661836; c=relaxed/simple;
	bh=a/x7TX3IriH7A6U79VxY+OWoBHfsJNqo5CREcLpDsW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=q+lTUll6RzY5zdrJi5Bt7uhZ9kVpqRKwlQeiT97k5VRZY/j5hkgnxOI2iDkFZafupugUiKSKCDfsz1mTKATTLUdD1u0fzCnMsEoBjV3krIt574EjZf7d3e66zk74cfLezQqaMsPAdtcpH/fgmHrHoqx6m5p3suy9SL9lQi9FemQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D1964BA540B
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-79ee5037d44so18371297b3.0
        for <cygwin-patches@cygwin.com>; Wed, 08 Apr 2026 08:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661835; x=1776266635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBKuCAihIjI+ex58AqED0hUp3JYlsIJF9tr3ljDDexg=;
        b=HvAeOPuIdjpcEOnK1Ixic5jAz+tY8i+y/YbbQAqRwY8bA/kxQLe2gc3SMfqEtazoQ8
         4qwlSPPkzVldl5iTKGogUKLKsQ2O14pStzxP0gXW21/5rO+Z7cjDNEeXL6HNV+Wcix22
         h4txDrymAsbtRtVIEwaH9as0UU5yp5f62FqNFuhklMk191i3E1vZLGXpwGjWej28ICyK
         xXOyCEMqaV6banJOys/akLtv7tk64dyUneS4F0umpOsNH0lBz1bgDkeeEx+/OZsu9XsX
         gB+GyjMxCeXUgoRnEjYdalgfZOp8U+Kn9BU4jt4o9arOePJ58LUSWQ6PouqW9mU1mwqf
         1obA==
X-Gm-Message-State: AOJu0YyvZBRBtqqtD04ousV6xgb67I0CY3QE0KHlVxyVUnzcqIdvd10i
	WSNInOZdnITj6nUR1eEWXstXhQ+S4rZTLMB638zGuFNveUNvTKANJlDTbYLUNA==
X-Gm-Gg: AeBDievPuxNRzaDJQqS+5npwa5taufDEcvxEnV6P1WJ7JHOmWwdNrKNcC8R7CrpD9Xp
	hEhgalkz4Ja00K4mUmRczIkuMxyJKg8mgvWM1fkfXSzzcOIKQvs+68OYJ+Smi15AIodiqh4S8iy
	f/p6+7K1AvtizUdE0NALazGDqafomgDfY962Ny10Ppc+dhlSmRI3xuruJG4G6yf/jVOgXuyzceD
	lFwSXHuSxCqC++Ku0GutRMxJ/r3+k9uuSciscP3+or9vfT7h73bd2Sm6LMeUVVJWu93I278zMSN
	NgKWQa53ehue+gnlDCmPm6+0DCy+gvUeLgdGXp//L4zcTfrfwJHKHauMsXCbHukTT9o9Pi4fLPl
	n1lOU9w2cAwXtPBnK7MzSj8o5UGdIY4TZxcchszzlCuALFw3aYqPHhU7mo5YldEKyjOQ2cJNuw3
	QjuSjCOTkXSZVcKC5L0AgLFskeBYWrsTerRuq0gHvpxESPuPArMIhpTzKK0SG84QZO5Q9aSQdM
X-Received: by 2002:a05:690c:4903:b0:7a2:46b8:3858 with SMTP id 00721157ae682-7a3be360aaamr186283537b3.24.1775661835286;
        Wed, 08 Apr 2026 08:23:55 -0700 (PDT)
Received: from gitlab.oarcorp.com (d27-96-189-151.evv.wideopenwest.com. [96.27.151.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a3712f8c8dsm86532617b3.46.2026.04.08.08.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:23:54 -0700 (PDT)
From: Joel Sherrill <joel@rtems.org>
To: cygwin-patches@cygwin.com
Cc: Joel Sherrill <joel@rtems.org>
Subject: [PATCH 0/1] Cygwin limits.h: Add C23 ..._WIDTH definitions
Date: Wed,  8 Apr 2026 10:19:01 -0500
Message-ID: <20260408151902.2022129-1-joel@rtems.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3029.6 required=5.0 tests=BAYES_00,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

While adding C23 stdbit.h support to newlib and using RTEMS targets
to build, there was no problem as the new C23 width constants were
provided by the GCC limits.h. But Cygwin does not include the GCC
limits.h so these were missing.

I added these following what appeared to be the pattern. But I have
no way to test these. I have never built the Cygwin target.

Joel Sherrill (1):
  Cygwin: winsup/cygwin/include/limits.h: Add C23 ..._WIDTH definitions

 winsup/cygwin/include/limits.h | 56 ++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

-- 
2.47.3

