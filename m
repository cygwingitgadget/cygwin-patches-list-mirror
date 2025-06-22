Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
	by sourceware.org (Postfix) with ESMTPS id C597D398E469
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:32:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C597D398E469
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C597D398E469
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b32
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750581151; cv=none;
	b=c3CdFbcY5ciEiDSDnrESuCX2sUE0rgWwdm/pqSZHfbOCQ7lxkLNLAFdbrrUyvvkwcQZ/keJ28ogzeik5S3kZ0YZ2Bd7cizuKr5vhqC0JJAhkLKVrYBZ8j9DXQzBO/6yYNKOQMGJ80i7TR5XQRt7vJTCv9S8kuzp4GW2PH7enucE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750581151; c=relaxed/simple;
	bh=MVs27FG+PZYS3QoDqReqLC8g8RMWSAXqg5MODNsjnNU=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Xll2oshjKeX831E11+wGmd1UV+8vsL/s7aCJvbHP56Irn7z/DSm9kNn+E+KxKP1E/+2dQatEkBQ6y4g1pVo1dwToclAvPZTJ9dwt+/FO1lNM5NLdcsyED3Djj7jxEUJofYLh/iUjr46hysZAPdG8EkwjguBjQzhgHRVV8WqIZNI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C597D398E469
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ZpK/3V65
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-e81cf6103a6so2790392276.3
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750581151; x=1751185951; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cek39uoBNf/vgP+3R34HzPlrveYWWlSIEmHDk9qbyZQ=;
        b=ZpK/3V65udw3HvGY+jayEffRvaZaSyDPswkzW67d84Cw8zdiz/E8LsFi9huJsk6252
         ohfwmME31OV4euGaa9lvdhqlSaSPmYbPpzq36V5ixEsAa2K5/dT5OS20p7+payNOXhjU
         8r7naOFe6OxpijkU/Vt21v89MTItuvRFlWFTSeDBecScnJlY0qAC64RzotWuV+6Y69Ay
         AOqPIEr1mTRv6MkrjsXfr9Y7sjbTxA7y4SBhzxjjKUlcTJHrYPIah33cs+z0bKAxElSK
         IC/SjcUCdPJcmTfTERddiiUBBwyTdZFGHNbULpzEwwHrfceLN89ogRIyYzvDcbRNWWLa
         9sAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750581151; x=1751185951;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cek39uoBNf/vgP+3R34HzPlrveYWWlSIEmHDk9qbyZQ=;
        b=FDpGw0AeJeC/M0imdAkqWPtyJWm8vMX2Z8dgkvRA5oK0bIfWwcXY0KV8vhemAJ+DQo
         k2MkKY1vCAI2egYS2bh6T9t43oDoJ3tHykX4EHCuT5GOAiSIXM2Yo02HkavQY9CC6nmC
         yVkFrTyq8VDzkLqH4pp3HbDrEaAimJBoso7uYqePTS0ZYn1O773n2AjRIa6JCJ5c5t3E
         Sy14rvsuZHqJ58wH+aVPEduh4ll0E24anXXB/vel6R3VSgeXs3pZFCj2wN5CcaD5gsnS
         TsGLZ4fqdu9o/BLEUSBKu8WnO0zasJrbJWMB5YC7fFpXdcTt20Q5phKSd/htPVW5qfLU
         K0HQ==
X-Gm-Message-State: AOJu0Yxd4GaYKj60g847Nwg7GS42DRRHYcMbFL1779IDRpu3bmv+HsVc
	yxm3oilYWzlrpQtMGXKrhUcQkO3uAuoKvxfJnpF5L4I/pSmeAswAyU1Gktib3g==
X-Gm-Gg: ASbGnctEgHW/zKYJ0nuLB+uVba3IMPzMjibITvBKUKd4gJMfe1lfXCmlnC0ZTerMbaS
	cRFcWrnPxKgO3v1M6mG2WEt+6QaJ3hZ3L06SIfPv9nQMJGYTROSe+4NegErvZtoZIZS1U3UMkQe
	kUcMBDUTdcKUN5tNgpEaLTYkkmO2fpWrEzDir8TmV7vdlmWy/UPzQ/Pd5uEcd8uNHiRIODZqtmQ
	lxdHTc7fD2/X1x5sHDGOeJi5hIvwcd7SGMk6SfTWJCxBxMvhSMNMW2X9BgbTCGt9YEuwfTm3hC9
	5Gcv1xvTp78SeLjji6E3capOm9dNkFEzYyfG0+XXnqXU+LNEKrWpW33ipQ4GvYwVgfQMNHMeMM3
	wSfqaZukMsSJ2b+s0SNKRJhmw/SAEyhiKuueNwOz50/oK+EnzO9DrZ+eM/Nw=
X-Google-Smtp-Source: AGHT+IFVGVgAVpDQjAbxvbsRuSeC4OYTl0KRextiqKLL8M4mzYMC4WXopmbX63L/FwoZJRBgfc1lmw==
X-Received: by 2002:a05:6902:10ce:b0:e84:4c18:feec with SMTP id 3f1490d57ef6-e844c1902eamr962175276.8.1750581150733;
        Sun, 22 Jun 2025 01:32:30 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aab9809sm1774586276.1.2025.06.22.01.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:32:30 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 2/4] install.html: add tip for -P as preliminary search
Date: Sun, 22 Jun 2025 04:32:11 -0400
Message-ID: <20250622083213.1871-3-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622083213.1871-1-johnhaugabook@gmail.com>
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 install.html | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/install.html b/install.html
index 4a9e54ff..13acf430 100755
--- a/install.html
+++ b/install.html
@@ -61,6 +61,11 @@ Tip: if you don't want to also upgrade existing packages, select 'Keep' at the
 top-right of the package chooser page.
 </p>
 
+<p>
+Tip: use the <code>-P</code> option to perform a preliminary package search i.e.
+<code>setup-x86_64.exe -P <i>packageName</i></code>.
+</p>
+
 <h2 class="cartouche" id="cli">Q: Is there a command-line installer?</h2>
 
 <p>A: Yes and no.  The setup program understands
-- 
2.46.0.windows.1

