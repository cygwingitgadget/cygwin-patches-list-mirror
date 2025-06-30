Return-Path: <SRS0=55nn=ZN=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by sourceware.org (Postfix) with ESMTPS id E3EC23858294
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 21:32:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E3EC23858294
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E3EC23858294
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751319140; cv=none;
	b=f1/6rVlQig/0zXqG3C7/cPkABT+SQNUQUMNqmYiJrFUz955SzhS3XRFE4UsRAtlSuRA3bvhqy3HJo4pQVpDa2ARvOeqtQZo6J8ZprWRMa9iyI3H4iE8we53rI6vOA2ghGRPvtEPJ3KTVPgcLR0+yeO2ZHtvl6oqnw5FlM4YpwaE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751319140; c=relaxed/simple;
	bh=iEwo0SbWpEIApc8C2kHQiPvHeiyTrxGvcZgF1a33308=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=vXQvPCTxJAzph7OBLqERc9b2Vm456afd5vtvuzA8vbOQAhRlVk74lsiDJsK5EZGN4felYAkCRwFhXpRDDIKnOQQP3dQi6hPu+OC1fsrqKqx9EHIHVzRiSUISJyHwdJFVCK+tH45Blnn0Ppa05o8CyFyOPPNRv/m0SR6Fy71a/yM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E3EC23858294
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=Z8RSWZnF
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-70e767ce72eso26683557b3.1
        for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319139; x=1751923939; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WT6qAoKKYpanOLIsVl+o3gRp2uEzenbdP+rsgNkPiog=;
        b=Z8RSWZnF2NtnA2xD2Qofxm21dff6rK74fdxq1zqEPFIEZO9cxLrV/YIm+Rm1MET8wJ
         p2efXuQLVwUHHRv7Zw1H+uGFEzH5dO8HBtnHPC9F/MPaJQ+kos0TkquxpVLMU+ftT5+e
         DO6Bl4QuZhi11SgNWCJe73WhCFuyxjPBlb1PZbO6uXuvJDVIKFMPdAUNZBYXumogMar+
         IhP4c5tfDFZgagxYXzPcP1d+x8fCdG0wjYdSkyZVqGMQQMMKgfwzO6COHRszAN1SDicd
         L493y7zM3V37EEpkt4oHhl2lUNwqC/0KYXtEZthcoiGmEwOZW0QBjVXehGUoWefFsuB/
         ic6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319139; x=1751923939;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WT6qAoKKYpanOLIsVl+o3gRp2uEzenbdP+rsgNkPiog=;
        b=ludsaF2yTU43kF+2UKeYHKSy9uWmS1RX22ySF8fvX4lRCyFYvfTnZaX6Xfr/3B/nGW
         7360VFiMFcNtpOJu3QBd2aLhQ8o5LHRkCLrLs6aoI2c0x/SA806Dk276h5XM2Z6zKfID
         EOll9NDv+UoyOLU+2JQEqyhLJus6SMFqSoyNHMcUZZDzBuZvRq+d1+a2be4GEsQKnw8I
         jfYdteSQ76NZUxeftAArdnwf+LHqm69VoauBLg+pgFF/4V85bvpYV2Ju73kePTREhduo
         GdWKrVXgGdRl2bi/HFVGg/5q4hudXheDQTliOquCZw3m4azjtH7r6zDULpdeR2ZAVjHH
         B2kw==
X-Gm-Message-State: AOJu0YzgH8QL6+T33pCRC5YSrcO13IA3/HzS45rjbyO5T2QHm6mY9bS4
	6FnN+SRYi7S+bsD/qDm+V6uxglDdvIfNwChPQyLcbTTP51n0S/QiID6hh4uySQ==
X-Gm-Gg: ASbGncuFWnbWpb1PjZPdNWRsPOakpMQqs3lV89PLH5YNzF8oySnNdG3g80LkvEMClVJ
	/0yFHslraJbsOOCPWNMwvLx9zaBmYPp9O4v5gStLIXgwnMkiHuogbo/M8OtoNJxdbDzLRIyQXDF
	maN8U49CT8NJtO3LYvK6SNWw0ZTBR1dmGr2R/0+a4mubkaoq8kCCinYFIJsSwJx2x9MqoyQVepm
	Kkn6C9fbzfn16pn7AN+WFKEvm75bNUEEtjLaMi7fY4i1Bvu767jlxZExZ0dQvOICAPn8F/STcko
	VaLpij5UetnWarnYO/GSwHwDqYK/ldwE/oNcWwk7vmxf7ZdyV/sFtO+hJ80PZYA9c/1/KMVwV9n
	T+0EaLWwD8C8zbUkTwPqF8xXiYKzZEmNFAH+uXtjAegTcswnd1umoiygd9JecAbqLWfoZ04XDQ6
	AgbyE=
X-Google-Smtp-Source: AGHT+IExs2jHCS7t9CzE7ZU7osJXe/zehRfpgFbJwSLj4BSuLymgds+z6xs4AH1MwkwlHEODgy4aqw==
X-Received: by 2002:a05:690c:45ca:b0:70e:29af:844a with SMTP id 00721157ae682-71517196047mr225682167b3.18.1751319138682;
        Mon, 30 Jun 2025 14:32:18 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bee26csm17046267b3.17.2025.06.30.14.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:32:17 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH v2 0/4] cygwin: 6.21 faq-programming.xml edits
Date: Mon, 30 Jun 2025 17:32:01 -0400
Message-ID: <20250630213205.988-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Removed "[PATCH 4/5] cygwin: faq-programming-6.21 install tips" from prior =
patchset, =0D
which included unecessary tip for the install process.=0D
=0D
This set of patches applies changes to faq-programming.xml at section 6.21 =
=0D
"How do I build Cygwin on my own?". The changes include:=0D
  1. Adding 5 additional required packages=0D
  2. Add ready-made commands to run setup-x86_64.exe to install required pa=
ckages relevant to the use case=0D
  3. Additional paragraph about the build process and an estimate of instal=
l time=0D
  4. And a typo fix.=0D
  =0D
The details for each patch are expanded further in the commit message inclu=
ded in =0D
the patch. Also, you can visit the support repo that illustrates the render=
ed html=0D
and doc build changes:=0D
-  https://github.com/jhauga/patch-newlib-cygwin-faq=0D
=0D
John Haugabook (4):=0D
  cygwin: faq-programming-6.21 add 5 required packages=0D
  cygwin: faq-programming-6.21 ready-made download commands=0D
  cygwin: faq-programming-6.21 para about process and time=0D
  cygwin: faq-programming-6.21 unmatched parenthesis=0D
=0D
 winsup/doc/faq-programming.xml | 45 +++++++++++++++++++++++++---------=0D
 1 file changed, 33 insertions(+), 12 deletions(-)=0D
=0D
-- =0D
2.49.0.windows.1=0D
=0D
