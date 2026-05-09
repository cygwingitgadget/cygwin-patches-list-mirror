Return-Path: <SRS0=xB0n=DG=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
	by sourceware.org (Postfix) with ESMTPS id 9CAE74BA2E04
	for <cygwin-patches@cygwin.com>; Sat,  9 May 2026 02:24:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9CAE74BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9CAE74BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778293459; cv=none;
	b=BUa1IwloSkW34oNipd8rum347LLdeGIMJ0KuCZwk8doU8c2bnpffYaFGLx59oeqhT5+BigGViFEc1vOMNPYlJDjdrMEd1sxm3ul85mS97R1CzbvfRQU09bdQXYXJEiFN/S9Y51QzVf7VeWwlgKc3aDoeYoZxyyK3e7JCV7tRy4M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778293459; c=relaxed/simple;
	bh=pNxsAFW22+dIexXlgftca3Ho0NNjDTd2ZK5/n4bMhuQ=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=w3JTyKD7G4SxECYjq4PtgSYET7Nr55vlybFeaLuGgnSvwIX4zaB71PiB9kVNEHgOhCVikwC9s7yQXqMahVVUJGu0FF6EihqaIFLZF/DqhsSSJExE7RNj6piNS3YElZmId1REbPNiURdgrlo7rQ5jmv9D6r8+uqHlLSF12UDNevo=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fIw/9qKy
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9CAE74BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fIw/9qKy
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-7c04749d739so8279147b3.3
        for <cygwin-patches@cygwin.com>; Fri, 08 May 2026 19:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778293458; x=1778898258; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iwLh2FWCVKk1mnVmN+yrGjlzf4rsb9gaspibxLRNL0w=;
        b=fIw/9qKyPck09/nGDKzxVP8uosJBErOTw6IABRVmkfVzTaWcYHVHUauMgrAgoTYWoa
         4uSUQItqXGLdCcjZ3FfbyA5jhdshrX+gmhsiztsEutS5IHy/dTIoqYQiAWK8qQ++nCTT
         9mRtaH6ZyNZm0eEuDuvzInlR/lYH6bJ0Vl2/zeuXvswEfZCOm25NmbIYhrycg2473KVa
         oWPZIYHD9VX/y0i/hOHsoVvN7ESTnjUgjtiuIpT51MxQO9QmgVyxlEIUY8oKYfuN92Mr
         Ps3GumfDqOYyX00VHB8gaGclNVY2rgHja7tS2VZwTqhA46jjj30TP9SlVP+et+Mb8rfN
         g+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778293458; x=1778898258;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwLh2FWCVKk1mnVmN+yrGjlzf4rsb9gaspibxLRNL0w=;
        b=YIcJL3vP3cFar1i+IknD1ZXFHNqAxkm+fxNAseE4ioDx3G1E8Mmq2uscIv0jJ6tDAO
         p/K7cTXU5bTeWvKqo87csMRh4KagbPqADIV274cnGmUiWreN6Xj291syCz4GSvREOWOf
         8kH6SfAWfJgL/jOaDLXxFcqLEZemap0d7AqcmprZ+Rb1EN/6qTAtbQ1fo8oJZ+CPIz6c
         GD7Lbu8UReKiad/H/YormkIO5erqvOK3kaIfeXTIw7LfrpKoz192cymN9qeZmoC/O6XD
         2R4Xw8i1QRSewTHb4mZnL1U18w8/An7iQgz2Nf5lCa+8rtvhabrzIN7b2MYtWW8i3O2o
         934g==
X-Gm-Message-State: AOJu0YwBsq+yadgII1O84aWQdzJwdxtgN0JESp3yfbtnbXrPi9q1Rg8b
	TGX6Ip5914Hf3kDjwRjOePBAtNwyMuxWivv3AAzBAQkInUnOtWCVHsTUW8ZRIg==
X-Gm-Gg: Acq92OEN7CN5nvPx1UhcE2zFcXozKFB7VwZrYLpOQq/AFOEe5q5q6J95JEtjHTydXGH
	Kt5imjdQFYR1xQHc+sh7Y5ma5zZWO0gK9ayekJo2N5+lTPxAdoa8HJ2i11xiYpPJmf3ipeV/vG8
	em/C6JgVB8S2C78bkVdtANplZpsOnnf0PnCnYpFTyPhrP8swg51rnfZSM7VDvtMKqKMuwUNXvH9
	bUkkkULidj7yc13ik7M+DfXf6DRZ9aVjrkL16knyJ5h1m2/7n59O1ECnMt1nwwmKEhhC3jhgMx7
	iy6Yso3v5/LAE02wz90dnk5/xJGwx2Xlhg+BZ37AYY0c9hBBGxd4eDzT+HovEPrc6KX4sDwDpKu
	oDbll7G3dPHLehx10TiMOdvE4zkCli47IHJuSFt0aSVnI80azpHS+e52S+gjHLi5QxIiTan2hkq
	Z+5bxpKJVVGX2ToNBz1LX734gtm86ky8DDKDbTGPG1qdybeG2LJ+L6zjLFai75HKqmkis314Jtd
	zSZdRnICT05sdCFcz3TGFtX/rU=
X-Received: by 2002:a53:b9d1:0:b0:65c:2738:c684 with SMTP id 956f58d0204a3-65c798f1d10mr11640581d50.16.1778293458489;
        Fri, 08 May 2026 19:24:18 -0700 (PDT)
Received: from localhost.localdomain (h231.205.88.75.dynamic.ip.windstream.net. [75.88.205.231])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65d96c5719dsm1672767d50.21.2026.05.08.19.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 19:24:18 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 0/1] cygwin-htdocs: website fresh coat of paint
Date: Fri,  8 May 2026 22:24:05 -0400
Message-ID: <20260509022406.1037-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

Sorry, this is a follow-up to the May 8th, 2026 patch series, sending an updated
revision of the responsive-styling patch only. All other patches in that
series are unchanged.

What changed since the prior submission:

- The responsive section removed and added (cut/paste) 2 rules to last `@media (max-width: 800px)` CSS query:

```
    /* Cells: allow word breaking so long URLs in cells don't force the table wide */
    table td, table th
    {
      overflow-wrap: anywhere;
      word-break: break-word;
    }

    /* Long URLs / unbroken strings should wrap rather than overflow */
    p, li, dd, dt, td, th, figcaption, blockquote
    {
      overflow-wrap: anywhere;
      word-break: break-word;
    }
```

Previously this caused some section numbering to stack, or block-wrap the numbering.
They were removed, and placed in the `@media (max-width: 800px)` CSS media query. This
is to allow for responisve tables.

The HTML side of the patch (switching pages over to the shared
`head.html` include and adding the hamburger markup in `navbar.html`)
is unchanged from the prior submission.

This single patch supersedes the prior `0006-responsive-styling.patch`
in the May 8th series.

John Haugabook (1):
  responsive: add responsive style section, update html to `head.html`
    template

 acronyms/index.html                           |   3 +-
 contrib.html                                  |   3 +-
 contrib/dll.html                              |   3 +-
 cygwin-api.html                               |   3 +-
 cygwin-api/index.html                         |   3 +-
 cygwin-ug-net.html                            |   3 +-
 docs.html                                     |   3 +-
 donations.html                                |   3 +-
 faq.html                                      |   3 +-
 git.html                                      |   3 +-
 goldstars/index.html                          |   3 +-
 goldstars/src/index.html.tpl                  |   3 +-
 head.html                                     |   3 +
 index.html                                    |   3 +-
 install.html                                  |   3 +-
 irc.html                                      |   3 +-
 licensing.html                                |   3 +-
 links.html                                    |   3 +-
 lists.html                                    |   3 +-
 mirrors-report.html                           |   3 +-
 mirrors.html                                  |   3 +-
 navbar.html                                   |   7 +
 news.html                                     |   3 +-
 package-server.html                           |   3 +-
 package-upload.html                           |   3 +-
 packages.html                                 |   3 +-
 packages/index.html                           |   3 +-
 packages/package_docs.html                    |   3 +-
 packages/package_list.html                    |   3 +-
 packages/src_package_list.html                |   3 +-
 packaging-contributors-guide.html             |   3 +-
 packaging-hint-files.html                     |   3 +-
 packaging-package-files.html                  |   3 +-
 packaging/build.html                          |   3 +-
 packaging/cygport_tips.html                   |   3 +-
 packaging/key.html                            |   3 +-
 packaging/repos.html                          |   3 +-
 .../trusted-maintainer-policy-manual.html     |   3 +-
 problems.html                                 |   3 +-
 profiling/index.html                          |   1 +
 setup-packaging-historical.html               |   3 +-
 snapshots/index.html                          |   3 +-
 style.css                                     | 249 ++++++++++++++++++
 who.html                                      |   3 +-
 44 files changed, 300 insertions(+), 80 deletions(-)
 create mode 100644 head.html

-- 
2.49.0.windows.1

