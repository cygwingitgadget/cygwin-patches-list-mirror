Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by sourceware.org (Postfix) with ESMTPS id 706CC393C492
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:20:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 706CC393C492
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 706CC393C492
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750580432; cv=none;
	b=QK7yCFocmAtTq9nYKxmWAMumfFXGKK3trZzu5WD7f/xlKQL155zQ+Gzb+y0QmO/x3vcWItr/8kSse7d/S5D93NQHBlcuiM8UMorttljGohn88sNqYbJ2pDX3MEgOwev/H7Pm5c+XbFsDiMshkZoti+fFYZaTv4x2IKcSqRHlECQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750580432; c=relaxed/simple;
	bh=d3QujlW9kGvZcFAQ7wTStcSoqWMvQXQg4KBFGNv3/lY=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=YhXkiuK3sqHz4zw8s9By3Or+MDIrgeqXfSZlFSBlnzU4K9fbhFazdXF66pR/PZXUXA+cqwrbFvwwOblnTWyYd1sPL7OnTWPm97j3GuYYF2mChUCCrmjzelRSLJeUaAUZBogykWLcUiVw9BzUvTAcFQE6FuvE50Kj06SoMhcmmSU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 706CC393C492
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VergBcFk
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-e75668006b9so2812743276.3
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750580431; x=1751185231; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3rwqHzTsX67/tk343HBvCFfZtue2b4R1NyzyAVuDAlM=;
        b=VergBcFktVZqF3EurmxxuPQ2zIHyo+t7r2+61PXRjzN9XARuJ97NFVSqNTYpf1PKJo
         O3xjjJ+Vxd0ktSaiFMHE3K2Sr4rfHYnjvKjEmMIC4tEHD19IFJFJ+awBnCSSROuwfuPE
         dJuohY03lNbMShNSjBi9eV29S94kF2mTBbGgRaI1gObbVFM/If7s3rdDZe6Y3zFOUEUm
         ql6aJ+bSGjlfbu5cmY4SEbPhUWNUTaJOwGHPx4ZWy26RzGaMWdfdun/qUJMOrW9crszp
         vOK4dpCK4/fabk1UNV5cY7Rnzi+EPywC7XmliniohC+jze4fimNZLK4EcuWfK37PUmRO
         3YuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750580431; x=1751185231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rwqHzTsX67/tk343HBvCFfZtue2b4R1NyzyAVuDAlM=;
        b=MzLFoyYJxZwnE16GypQ5wj/6wgOT0R/BeRBVg9XyfP9QdkK0jXvhR5xfm1nU8r+fRq
         SlcESj6jY8/pp8+sFDT1I8iRrf1zxGlNdxJqlcYH1b+vubWdA4vPKUVqc5Ri2GthiA2C
         /OyXlIPtRZO73NOUKn+TNgWDH4QsGn4NzBH96rEXi4DpYhi/wefaVOcXZN0BJqbliZqd
         NyUmI8KEUZ8QUo4waFb7xhXclNGqn1R7NrEoYRiYOLDQZecVP506MSVx6LBCgc5KPLb1
         nii9A1XnJrOX+fwBtp1dTdqwWBYjVz8b9Zl5kxj7AHYiaRRVMGtVDZFTrE048BO+3kl+
         AAUQ==
X-Gm-Message-State: AOJu0YyQVbPnVzJIq1rxGQaiv2J7Y5plA95Ubebuj4hF9K4V4657/Erk
	XNNXID1/5TNUdFZsA2gm98Bw6ldycVXs6vDtn6YxXCrfoq1bAEkAkUV9JCoKAg==
X-Gm-Gg: ASbGnctGxHog4R2Mb7jzU7ioIdLRbH+q2rN6UXwN+nz7KDiwUd/jBrKPtNbHK11nE4+
	LuMGsBnDho96QRwSTcjM+StadQAnOjaNjDA5YcZXR/pyeeKHL7xUS/41M7vHP2lwfXthZWf4iQB
	mPLAva4/lb5cVKpl7vqEtz3eclCUDWlz36vEVDLgxeVUK5gRjxl9YC5cU9lvdQmKLXWUSleoa+h
	UpdA8I5Uiw88Kk0Zy1MWy/Rah5BTHtDVh8uJ2jWjV+wR/9KiT2lnPTJDLsgRx5d4UoCruJuFJXq
	6MtltnM0xc+tWdxcCmNO1CVcKhe0uPfC84FjAey5QxhJmpGT7jwMHE/Sno+IaTJbh/09i6nmo9j
	Kf0A2uJwlpgWx/5cPrHNoHeVRHgXvx6Wgg/xi1pFIIE0f8ZZO2DJt5/ERYfQ=
X-Google-Smtp-Source: AGHT+IFzBWTLxhzCDjtchq2EgWgKAGgDWVW0ZvwFv+oioiMZl4iQlf9L513JL3zeNTeKZTVlRNLCCA==
X-Received: by 2002:a05:6902:2493:b0:e84:ccb:1148 with SMTP id 3f1490d57ef6-e842bc68af6mr11897636276.10.1750580431310;
        Sun, 22 Jun 2025 01:20:31 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb932fsm1746692276.55.2025.06.22.01.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:20:29 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 2/4] faq.html: add ready-made -P download commands
Date: Sun, 22 Jun 2025 04:20:00 -0400
Message-ID: <20250622082003.1685-3-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622082003.1685-1-johnhaugabook@gmail.com>
References: <20250622082003.1685-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 faq/faq.html | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/faq/faq.html b/faq/faq.html
index d8d19fce..5c6296f0 100644
--- a/faq/faq.html
+++ b/faq/faq.html
@@ -2102,7 +2102,14 @@ Building the documentation also requires the <code class="literal">dblatex</code
 <code class="literal">docbook-xsl</code>, <code class="literal">docbook2X</code>,
 <code class="literal">perl-XML-SAX-Expat</code>, and <code class="literal">xmlto</code>
 packages. Building the documentation can be disabled with the <code class="literal">--disable-doc</code>
-option to <code class="literal">configure</code>.</p><p>Next, check out the Cygwin sources from the
+option to <code class="literal">configure</code>.</p><p>Below are ready-made commands to download the required 
+packages. When you reach the "Select Packages" screen, these packages should be amongst the search results.</p>
+<pre class="screen">
+$ setup-x86_64.exe -P autoconf,automake,cocom,gcc-g++,git,libtool,make,patch,perl                           # download build tool packages
+$ setup-x86_64.exe -P gettext-devel,libiconv,libiconv-devel,libiconv2,libzstd-devel,zlib-devel              # download dumper packages
+$ setup-x86_64.exe -P mingw64-x86_64-gcc-g++,mingw64-x86_64-zlib                                            # download utility packages
+$ setup-x86_64.exe -P dblatex,docbook-utils,docbook-xml45,docbook-xsl,docbook2X,perl-XML-SAX-Expat,xmlto    # download documentation packages
+</pre><p>Next, check out the Cygwin sources from the
 <a class="ulink" href="https://cygwin.com/git.html" target="_top">Cygwin GIT source repository</a>).
 This is the <span class="emphasis"><em>preferred method</em></span> for acquiring the sources.
 Otherwise, if you are trying to duplicate a cygwin release then you should
-- 
2.46.0.windows.1

