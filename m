Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
	by sourceware.org (Postfix) with ESMTPS id E892C392BB8D
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:20:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E892C392BB8D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E892C392BB8D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2d
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750580430; cv=none;
	b=UWkopCv0mWABNqTZJyt8qY8SxgsQXoGIuswlqBvm8vBJGuVHenRPfjILWb63LNVX97AtiAGYB8T6+8Eca0uHJ6CWF9FUj93MvzvdDnfObzluOZ3YgbCgBmpH97fIZxdW1pCYopXKz43rMVsGymPpoWNfuW+OBSEM1DpO/ZLzaag=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750580430; c=relaxed/simple;
	bh=wAglcvxOpaeyQvCCPlsG/TmYLZHAFXUau2tSfOYTJ/k=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=c9xb7ftovVP7Ks+3Ulm11pUPincSt8x9HqRSlsOsIvwjoMqqPehfRSa4wgFqaIGiOk1Hv5lKgE+cof3+dY1w085alK9tRcHpxeEIq2gvdsXQvEj+TTCIVTXOGHqPcRHfoSoPA8AsusJuclXS0roJqTUsAxVl2Y5tDe9o7dqgzwI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E892C392BB8D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=A34BI238
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-e82323de932so2775386276.1
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750580429; x=1751185229; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2KFu8haEs0qucJ8puv2bAzECl82f7h+172DxoheBr1w=;
        b=A34BI238wzEllRnCziZKVPmlbLivuoLVRfByNjA+TAgxSC4bHXyEaORbXFiYdKUPta
         tUv6aJRM7a/Aw9M9/UVMFUAwx+qgSAMFlRUdNm+cWw43vqG/mrGc8aCAnUKMRzG3daRx
         tenlvJU9o6aRE6Np44nAr4JdI+vkdaLurD8s3FqY3CAdopCY83qNBW8HVDTfNuOCamja
         GotS4p7oy/Cqskhj/Fv3EwFBSMfVfNhPvsRyK+JDL0+RhRmbg0+8ZyTqq2Enti1zlMxc
         jieIwmIvPTTLnYNaMf8gZoeuigvG9vjNvN5pVEFqJVpcpbs4uT1MB3irFbOg8l0oeROb
         1gvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750580429; x=1751185229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2KFu8haEs0qucJ8puv2bAzECl82f7h+172DxoheBr1w=;
        b=AmU6jSUMEPEwZhCc/mG5fuhO0SGfjRkwI2iSxJevGZJmwCkooGeXwrwekXHE/YOK9y
         PFiGkHBi48aBJ6poD7YxznCX8cqyTfwB4/7oY0g3LD9VOJ1ruaQXVAa7POptrQ7WIqTD
         m9tc5fCxGoNzmAPSAYLvTDXU3+XNFeAiOxTINhj81iX0PITmD7a0vfnmaIOvgUtHEzjL
         Scwj8A3MvCDN4EifghzkQCspH8qsCL+1XSbKq16tUW4DW9+Wf3xDrijwyJqgMwI+l4lv
         05xoRxhZlfgJCv6ihvHrtC1xBzV3uLN2IzDndB4d6FVDpi6hzImB5zWZjKQ4UwcnbrTC
         q/4Q==
X-Gm-Message-State: AOJu0YzG5kypLw+sLrha5A9oagWhLa+8lDoZh5MoStnJ37BMAd4rbCTZ
	zD+Z2CJ0uJhjp5Js7pD4P1RjEeHAK7dABGWqbED1YdHN2bShgylCLLKcAxJ7bA==
X-Gm-Gg: ASbGncsVnOQ48hsT/DVuwtV2Mp3DQ/Ih+riFJ3b+Kz9zSiXxSb4kPMp2tU7Oy/F6oxs
	uRD0IdxyPEAPk31bc4QPHxXvhW1mCyH1GkDUXS5LTX9krZoAMHzBcLRAY1eCnVLQSmmyT9736Zu
	LbcVz3ATYk4qyuMPVrYzqz9Ip6dKksspW4FxH5ncHECsdCb3ySY59mUHNFMlHmw0YsWQ1FGjrcp
	1c0POh7J30I33wuTYOtLFhtWRX1q1p9zxqMSr/fnmjaroegqL1cstkJI21RX325m5swAWfLa7DL
	E0dOirJBrXxcFmNfrF5+JVuPkTJfQx1cOPHQiT4bLOFBH4dri1twyR2xe7tppRGPLhrEFHKTWqT
	R/P1sJW2QEtL4awhZWKhSXEkac/eZKNw4OzTlQG67WibUg8HyET/0aUT55WQJhxR27q1cWg==
X-Google-Smtp-Source: AGHT+IHMmX23KWd803d8/N+2vpKL6+r8jKFfxDoBaiwaLq0xV6Pqa7KqPSKRj92QNfbYS7Bywqx4Sg==
X-Received: by 2002:a05:6902:2192:b0:e82:71ab:21c9 with SMTP id 3f1490d57ef6-e842bd32c22mr10635013276.44.1750580428851;
        Sun, 22 Jun 2025 01:20:28 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb932fsm1746692276.55.2025.06.22.01.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:20:26 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 1/4] faq.html: add 5 required packages and sort packages
Date: Sun, 22 Jun 2025 04:19:59 -0400
Message-ID: <20250622082003.1685-2-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622082003.1685-1-johnhaugabook@gmail.com>
References: <20250622082003.1685-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 faq/faq.html | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/faq/faq.html b/faq/faq.html
index 565eecc2..d8d19fce 100644
--- a/faq/faq.html
+++ b/faq/faq.html
@@ -2078,14 +2078,17 @@ with Cygwin development tools.
 rewriting the runtime library in question from specs...
 </p><p>Thanks to Jacob Navia (root at jacob dot remcomp dot fr) for this explanation.
 </p></td></tr><tr class="question"><td align="left" valign="top"><a name="faq.programming.building-cygwin"></a><a name="id1458"></a><p><b>6.21.</b></p></td><td align="left" valign="top"><p>How do I build Cygwin on my own?</p></td></tr><tr class="answer"><td align="left" valign="top"></td><td align="left" valign="top"><p>First, you need to make sure you have the necessary build tools
-installed; you at least need <code class="literal">gcc-g++</code>,
-<code class="literal">make</code>, <code class="literal">automake</code>,
-<code class="literal">autoconf</code>, <code class="literal">git</code>, <code class="literal">perl</code>,
-<code class="literal">cocom</code> and <code class="literal">patch</code>.
+installed; you at least need <code class="literal">autoconf</code>,
+<code class="literal">automake</code>, <code class="literal">cocom</code>,
+<code class="literal">gcc-g++</code>, <code class="literal">git</code>,
+<code class="literal">libtool</code>, <code class="literal">make</code>,
+<code class="literal">patch</code>, and <code class="literal">perl</code>.
 </p><p>
 Additionally, building the <code class="code">dumper</code> utility requires
-<code class="literal">gettext-devel</code>, <code class="literal">libiconv-devel</code>, <code class="literal">libzstd-devel</code> and
-<code class="literal">zlib-devel</code>.  Building this program can be disabled with the
+<code class="literal">gettext-devel</code>, <code class="literal">libiconv</code>,
+<code class="literal">libiconv-devel</code>, <code class="literal">libiconv2</code>,
+<code class="literal">libzstd-devel</code>, and <code class="literal">zlib-devel</code>.  
+Building this program can be disabled with the
 <code class="literal">--disable-dumper</code> option to <code class="literal">configure</code>.
 </p><p>
 Building those Cygwin utilities which are not themselves Cygwin programs
@@ -2095,11 +2098,11 @@ Building these programs can be disabled with the <code class="literal">--without
 option to <code class="literal">configure</code>.
 </p><p>
 Building the documentation also requires the <code class="literal">dblatex</code>,
-<code class="literal">docbook2X</code>, <code class="literal">docbook-xml45</code>,
-<code class="literal">docbook-xsl</code>, and <code class="literal">xmlto</code> packages.  Building
-the documentation can be disabled with the <code class="literal">--disable-doc</code>
-option to <code class="literal">configure</code>.
-</p><p>Next, check out the Cygwin sources from the
+<code class="literal">docbook-utils</code>, <code class="literal">docbook-xml45</code>,
+<code class="literal">docbook-xsl</code>, <code class="literal">docbook2X</code>,
+<code class="literal">perl-XML-SAX-Expat</code>, and <code class="literal">xmlto</code>
+packages. Building the documentation can be disabled with the <code class="literal">--disable-doc</code>
+option to <code class="literal">configure</code>.</p><p>Next, check out the Cygwin sources from the
 <a class="ulink" href="https://cygwin.com/git.html" target="_top">Cygwin GIT source repository</a>).
 This is the <span class="emphasis"><em>preferred method</em></span> for acquiring the sources.
 Otherwise, if you are trying to duplicate a cygwin release then you should
-- 
2.46.0.windows.1

