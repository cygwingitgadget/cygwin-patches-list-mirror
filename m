Return-Path: <SRS0=6Jdb=CH=gmail.com=joel.sherrill@sourceware.org>
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	by sourceware.org (Postfix) with ESMTPS id 2DB264BA540B
	for <cygwin-patches@cygwin.com>; Wed,  8 Apr 2026 15:10:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2DB264BA540B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=rtems.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2DB264BA540B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.128.176
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775661009; cv=none;
	b=i2WmEui9O5LyG0UsFe1J65om7Nh4eDrgyyKtON7oRQlbu45PTsFxqU/rm4MmVbWRR9n3IDrpAB0y6GVU9f5vB4APIjtf0X1DDHYGeJRcmglv3TGPUzSch5ne9mhisbT8i0CJXticA0OmfiP4kxBhAmNaiwMIXG+1CGBAmmz6qho=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775661009; c=relaxed/simple;
	bh=a/x7TX3IriH7A6U79VxY+OWoBHfsJNqo5CREcLpDsW8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=G3RM26svbjkOe0ihh7vJEKDyjDRu09zXpSR4+MLbmAHZOkpMHb1hxz+lpzje57Fxkm1FAFz26u7EsLZO15QU6bpF7xsrrozxlxM/Tohbx/9D3quEUw7E/cbjfoN0O1TE0ljggSRxa8AMAoFH6Ag0Ie4PYw8uYh+4rK0StTvN+rQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2DB264BA540B
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79d991c7b6aso30847b3.2
        for <cygwin-patches@cygwin.com>; Wed, 08 Apr 2026 08:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775661008; x=1776265808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBKuCAihIjI+ex58AqED0hUp3JYlsIJF9tr3ljDDexg=;
        b=ddLoRzFj8es3myGrarZ5FTx3LRI9lOn2pBOQZMVgfdtBa+N9kP5dNxXjIpi84Zv71R
         KsoVtXjKbAZmurVdNnOYRdb9o1sDIIYYE5Qq6Pfgh8nDrHHv9YDrk0h82eGmBE4B3z84
         eFRHAmLJEgRBrp1X+6QYYA5dWw9ikN5KgFdDNB7p3MKV2JFrVgtS0C3ylmRFXA7zqC3J
         ZN0V3kRTv18747zSBOIhPMB67rSnbCHDVw0Yu8BJF9+6C/iBJ0XjmP1zXkowFJrbsJSy
         +bPWcspEHXCkb3gzia+CmZ+vZHkYG08jJQsZ5dhCndFZ+Qei59QMf+wTkpmGNEFepTWI
         HLUg==
X-Gm-Message-State: AOJu0YzxDZ8LbtUyRnRfCssHN2J8ul4NUwfLEcLJkP++PmpC33fePkEv
	BwW4oatMtTnziAw+OeiG55Jpe3Mh4TEcYZIMW0x0ZKQErmHFE4dtNN4DI5gaeQ==
X-Gm-Gg: AeBDies5BMxfbUbjJ8FdMKPTB4RIXS6R3Uyp9Oh06u2rPxuz3gTOnYswG8hgBA1jkmJ
	H88PuSh/TQ3HLPanXN8T2yXXkkQsw1jN05/4XOHuCyKs7HtlCWwh0Cl+vZuhsLz+D84aw8yN9Ww
	9vy/vqicAAA8uywYVyyxYYuvUqNhvivDzFSLkdYRe3TWJFfuYfBDJKKkTa7lvC2fRkviQOhsfPE
	CHefpbhoxpX3pPZBHPQf5GJGJfeakAton6ap24f0XQu0TRo9F4Srrejs01aoYVOAjurBUMc0rWI
	KaUVzbHGOOH6jpADB46uBPphT0q8GNzLzDz4KfJIkikcZ515oZbL5dJnqqGOPaQZli0GHUhVpFz
	Ufm+EghBKgRZtCAiPeBjpdYq3TqR8BzWiLJbgC4NSqmkHobwk92o+PwddLySRo6xkYMxqy93ulk
	l7xF0PCKxKhLCJ8xaFCkpBgJZQQ60GZihR9kfVixXIaKT4uLK+HLbeWAAZDmyyuQ==
X-Received: by 2002:a05:690c:6ac9:b0:798:1636:c330 with SMTP id 00721157ae682-7a4d5371e63mr211512537b3.34.1775661007799;
        Wed, 08 Apr 2026 08:10:07 -0700 (PDT)
Received: from gitlab.oarcorp.com (d27-96-189-151.evv.wideopenwest.com. [96.27.151.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7a370906c94sm88322917b3.28.2026.04.08.08.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 08:10:07 -0700 (PDT)
From: Joel Sherrill <joel@rtems.org>
To: cygwin-patches@cygwin.com
Cc: Joel Sherrill <joel@rtems.org>
Subject: [PATCH 0/1] Cygwin limits.h: Add C23 ..._WIDTH definitions
Date: Wed,  8 Apr 2026 10:09:29 -0500
Message-ID: <20260408150930.1766201-1-joel@rtems.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3029.2 required=5.0 tests=BAYES_00,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
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

