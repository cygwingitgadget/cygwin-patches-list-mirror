Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by sourceware.org (Postfix) with ESMTPS id 2A846394654D
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:20:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2A846394654D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2A846394654D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750580434; cv=none;
	b=f3uhnzSfnRLTU4dbNbgi6pVLZzqdy/ZKUp5vJePCKeLSGM2Buwdptpk6BzrHYY8vM6NejasWuwAu9eUl8ETT9E1g4mePw2ziVM6+3O2WIKfIVDmTohZd5XSeBnQ2I74xomkDhLzFPXidAgK5ocMi3rkbD/ufPLoFXQtUzFwMbY8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750580434; c=relaxed/simple;
	bh=RpZ192KBkunEMHZUjQDHkQSRfilyR8rXGKx3Ayeu7tQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=tflJkv516vHyxLkZi7qTJxwTFJ4NiU4P1HVwwX9C+gNNAbtFyppmDCeh2+5XxVQLYOnOE4MhqdNwjGimDOd5goKfmm0b7POBvTTkLvZLfFxSpZM0JGk+BoMRF+90UgWJI6VGbAvfGd/ItaWLeAHOtjIU3vAkSJP8x/89rrA7WHY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2A846394654D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Kq/+2hAH
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-e81ec95d944so2581439276.1
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750580433; x=1751185233; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hQArmqrsb+tfmfJdDtcCbxKL9O489FHerNg8kyr6pY=;
        b=Kq/+2hAHBWsgSKKO5VbMe60tTQGr44wDaGuzbMLuh2KWdCig96iEkgQdrx5DfG9wWu
         e0KgGcDRHoBNRClEPbyyov0UCrz/N6ZXpNpEdM+/rArsRTA0kJ3qBQMQRsBBZ+LfzsF7
         s72LdoGvINYijsNA6ErDBh+w6C6YWmQlLreWL83FLWZs3DdNUfhBhq89zM4HQpJvEfIy
         kkj26PwVt+agGFI2KmxrP3K8byDU2h78U8rbs2fgcu0YfCm9Eky+WqHcU622JrIFJoeS
         quvt22T1n3IyQ2Xt9A+pSxuh1FiUj18KmgHOjja8Xm578F2Fn3g8StF6mSlWN37je4eh
         tpWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750580433; x=1751185233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hQArmqrsb+tfmfJdDtcCbxKL9O489FHerNg8kyr6pY=;
        b=ZuPD8JENlwaddGs70O9x0eMWBXtEpmWGlzxa6aU1x5/HsCocQHKYOmzwqW8MnkpPTc
         yXgbqZQ8uf5z+UMJTzNkE6PtrmWl39T0FzrSbD9sJIb/iwiw588AH+8vNpxwmmdArsYn
         UPBn6HqT57OOHLUDgLpmRt7UlJkcCNhkY/YYRBosJgcC8+SPpcTV4BUaUvaq+SWL0ELX
         RHLJ419Q0wC307GxZYjNoGkGl99KGR+W9VVj85D4fDkzgiu/EgglopPhMMZ/FSPMJCQw
         adtvqucB+TsMwjKwg0lcmgniibFUYugv6uJFC+8uv59t3us7eqtmqLk06YDnS9JPJo6e
         WpuQ==
X-Gm-Message-State: AOJu0YzM3kf9WHg3pHr1dohl7TT5Y1lRo3z1kEHrS0AmcgNNBWx5ltdy
	7e4O+ARKoCOCGFUT8OB+VhIkwQWhbmPK1hQmmMMHNwBnw+n971KzZ8VqK7cqCg==
X-Gm-Gg: ASbGncuaF3ZvK4RGep/vScI7pzjhXBiLYC/0V9FQqGlPCl6y6ZOqzSjPS8fO2qewYez
	oxlHyEuA1BOkj+suD5+gLdcc+wanpaa/iwsDccl5dBLYtBgY/cuAzcUEVTEMEPOKfMVSmT2e/Ed
	CIjY2SOrhESlXe4ehyIKdj3bn0UruFlNrnwgrSWigSGirZKoSS1+lJncRpFiejaTyDu4UKiVJ2O
	yLMAVBJltLKvPrBDlzHX/vU7OroBsm5OAcrummYpAzxym7pFKlxcDUuVXmMtfWkn/Gz6oO1/JNF
	snNThiliio2fAg/GffYzLxbXF5kp2Ijh8nNcq4HWR5iNg8YxTxmZV+LUtWF9oZ00MsYCs7la0ew
	D5WHz8FNZZ9lSQ0gDd8HGJjNq9U9RqDDIXfeDG0FP8cYUdrDz4iO100nsug0=
X-Google-Smtp-Source: AGHT+IHwTAGCeZg07DhjKGIrStG9iuWTGF4jB3zBqVzsbPl3eyohSIp5CkchWjbE/gaOf//7D2bM4g==
X-Received: by 2002:a05:6902:2748:b0:e84:4abe:3a26 with SMTP id 3f1490d57ef6-e844abe3cb8mr1435694276.5.1750580433104;
        Sun, 22 Jun 2025 01:20:33 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb932fsm1746692276.55.2025.06.22.01.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:20:31 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 3/4] faq.html: section 6.21 tips and additions
Date: Sun, 22 Jun 2025 04:20:01 -0400
Message-ID: <20250622082003.1685-4-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622082003.1685-1-johnhaugabook@gmail.com>
References: <20250622082003.1685-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 faq/faq.html | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/faq/faq.html b/faq/faq.html
index 5c6296f0..6be1e54e 100644
--- a/faq/faq.html
+++ b/faq/faq.html
@@ -2077,8 +2077,10 @@ with Cygwin development tools.
 </p><p>Note that this is a lot of work (half a day or so), but much less than
 rewriting the runtime library in question from specs...
 </p><p>Thanks to Jacob Navia (root at jacob dot remcomp dot fr) for this explanation.
-</p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.programming.building-cygwin"></a><a name="id1458"></a><p><b>6.21.</b></p></td><td align="left" valign="top"><p>How do I build Cygwin on my own?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p>First, you need to make sure you have the necessary build tools
-installed; you at least need <code class="literal">autoconf</code>,
+</p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.programming.building-cygwin"></a><a name="id1458"></a><p><b>6.21.</b></p></td><td align="left" valign="top"><p>How do I build Cygwin on my own?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p>There are two processes. One download the required 
+packages. Two installation. Note that the entire process may take anywhere from 30 minutes to over an hour,
+so be sure to download all required packages before beginning the installation.</p><p>First, you need to make
+sure you have the necessary build tools installed; you at least need <code class="literal">autoconf</code>,
 <code class="literal">automake</code>, <code class="literal">cocom</code>,
 <code class="literal">gcc-g++</code>, <code class="literal">git</code>,
 <code class="literal">libtool</code>, <code class="literal">make</code>,
@@ -2114,12 +2116,15 @@ $ setup-x86_64.exe -P dblatex,docbook-utils,docbook-xml45,docbook-xsl,docbook2X,
 This is the <span class="emphasis"><em>preferred method</em></span> for acquiring the sources.
 Otherwise, if you are trying to duplicate a cygwin release then you should
 download the corresponding source package
-(<code class="literal">cygwin-x.y.z-n-src.tar.bz2</code>). </p><p>You <span class="emphasis"><em>must</em></span> build cygwin in a separate directory from
-the source, so create something like a <code class="literal">build/</code> directory.
-Assuming you checked out the source to
-<code class="literal">/oss/src/newlib-cygwin/</code>, and you want to install to the
-temporary location <code class="literal">/oss/install/</code>, these are the required
-steps to build Cygwin:
+(<code class="literal">cygwin-x.y.z-n-src.tar.bz2</code>). </p>
+<p><b>Tip:</b> before installing run <code>ln -s /usr/bin/make /usr/bin/gmake</code> in the cygwin terminal before
+beginning the install procedure.</p><p><b>Tip:</b> ensure Perl's XML::SAX module knows about installed
+parsers by running <code>perl -MXML::SAX -e 'XML::SAX-&gt;add_parser(q(XML::SAX::Expat)); XML::SAX-&gt;save_parsers()</code>
+in the cygwin terminal. If an error appears, stating: <code>could not find ParserDetails.ini ...</code>, then
+running the command once more should resolve this.</p><p>You <span class="emphasis"><em>must</em></span> build cygwin
+in a separate directory from the source, so create something like a <code class="literal">build/</code> directory.
+Assuming you checked out the source to <code class="literal">/oss/src/newlib-cygwin/</code>, and you want to install 
+to the temporary location <code class="literal">/oss/install/</code>, these are the required steps to build Cygwin:
 </p><pre class="screen">
 $ mkdir -p /oss/src/newlib-cygwin/build    # create build dir
 $ mkdir -p /oss/install                    # create install dir
-- 
2.46.0.windows.1

