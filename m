Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by sourceware.org (Postfix) with ESMTPS id 99B8C3A46E40
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:32:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 99B8C3A46E40
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 99B8C3A46E40
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750581147; cv=none;
	b=acpGdyZjDHsGOUi+SjvilffJejdT3PMbS6sT7YzNFYw0OBQduNaLx6DoQ1CuAcv7YVVAsncNTN40FqwxPMSVBDt68lxj5VBsyGw0Gh39NRj52s48WKVzwdpPyVNQkGTzFXslskz03/dfj2IeHNIQMIq74HKufiDHdlDSCjD2crI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750581147; c=relaxed/simple;
	bh=BOMbgpo+KPRK0Ko6ddgvtG7JEjSP0pkd6QyL53Vc5qo=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ti9XREyEwNwkinyjOXopCIx9nQDZZj6EKZsW3EabcmzZBKdM5Q/SFDN+WdLqzEuHttfJLzD/ViU9Uzq9UpXio3yFZ+K2zdtmmjDU2T6LfaxFk2Nmir4aU6sTlq3tasxv4tTB/HoVNxkz/nDP9lQJesjTiMEYuyREHcxiiwYXrgk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 99B8C3A46E40
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=bldVf5OH
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-e812c817de0so2085546276.0
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750581146; x=1751185946; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6rscHCxpZf9A6zLHoUk4uz45EPdBgK2lchRcmJZybxg=;
        b=bldVf5OHYq1D/NiYbTpOzbLWVM5QEh+YVdsH+jGtu1g7wrcZLGDBOv8G6xf5C50pdW
         PYKAQmbfClgVelRiBFegQ28MMQEU7hFYO+E91PsyKcgpimuHYeOk8oTGfMpD9xv+bzHu
         lONgTihI+RA5JuUeOvemcE1aHWe8e1czzCTSKo+wZM7ok4ukvwQUpUowSul2QSoUDO0K
         SZ/fN5CgJWujw6Oj2+rg8m0V2JEEGgFlT579mdZS0vVPIt9wLikAyq2mkXotp2rjZIIM
         NED8mHgvGwnPyyGEbjKdzjrm6O6KkmbQuCpHjZdJgV66IegCW/ftQDu8WRfosp2ZnzdZ
         fK9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750581146; x=1751185946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6rscHCxpZf9A6zLHoUk4uz45EPdBgK2lchRcmJZybxg=;
        b=Xw0dJdtBZAqLMw1TMnAOK57zkoZQB1fCnF8z4MovFEbgUWvUFAZj9/jJO9CKA5NO7i
         7x8sETKvwfR7Ny7P7scSBLyZy2XPvnAD9TcAk00iR0SQlM7SiH682PpA6rlzblapS+So
         +F9ln5WylVqw0dc0QznK6hnb6CyY5NFNmctEX8+/kSchqbrCHUBEitz4R2DdGGPcXFol
         1ela4xgBqsVYZsIYNaHG8MoHI6AXRDbB5GAI2gnBzJLGSzpxJVUod2pZMbhKOHgd6lHx
         oLJP7kJRoavxnxoAE7zuqbFhopsfI1muXjPpL2FYT6BSiNsqymDIfRcf7fNaw8Jx0z91
         U2LA==
X-Gm-Message-State: AOJu0YzUHO8DlDgK6MrHOrd1SCKhXLttmXsajJp02Bw8Rqn8/r9nxp22
	mGf7D7MencIuRY02IVnXYNwnmK0DULSdD4qCjAprTrXiJuSKt0yIfU1HFCu9sg==
X-Gm-Gg: ASbGnctT3tAODQTyIK1d45C+o3Vj2gSgK/5MgmZjqrVspJg5aaQR1JU/EsZQ10Qi2QP
	wJWw/StY6+taA8VwKJPVFEY1KilL6FscGlFsoeYeLIoOZAdBp42kFeK/weZVC6UkeOsQTqEhbUd
	r/nOvGm3+iGmhfy0chPvzMRWgWFb7YYqR6D8V+CqVSI507WVbI/qKdu1ii5r2W7denQYuesoiW4
	IHwDnRkEy+sYO0J66ST1IN10o4X3NLhm/mzu5kz3F1aj4ul1ohqWQhG4sYoP5TbYEtSNJ2t9zTx
	dESol58B1ZvCdzpyzBTjIof6Exmzjt+Vm/JbpySYY27eQzptuwMGZ6ZQe8IYUiyzv/g0ugy+4qx
	3T6XpZYK8TFvkxEJyWHcLq1U5M55YfzUITzORasMUs05jSugCNJJgE02kuhI=
X-Google-Smtp-Source: AGHT+IGALrC44/xd5UacQoPedaYmmOPLl5qNtbFeINZRdryAH67vje6B6S+uSTmSJ7h0CN9M/YHA7Q==
X-Received: by 2002:a05:6902:1286:b0:e82:568:7ec1 with SMTP id 3f1490d57ef6-e842bd4978emr11306499276.49.1750581146627;
        Sun, 22 Jun 2025 01:32:26 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aab9809sm1774586276.1.2025.06.22.01.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:32:25 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 0/4] cygwin-htdocs: install.html edits
Date: Sun, 22 Jun 2025 04:32:09 -0400
Message-ID: <20250622083213.1871-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>=0D

This patch series contains several focused documentation edits to install.h=
tml=0D
=0D
Changes include:=0D
- Add alternate syntax for using -P option.=0D
- Tip on using -P as a preliminary package search.=0D
- Add tip downloading setup-x86_64.exe to bin and using from command line.=
=0D
- Bold the text "Tip:".=0D
=0D
These patches were created against the latest upstream `master` branch.=0D
=0D
Thanks for your review and feedback.=0D
=0D
jhauga (4):=0D
  install.html: add -P option tip=0D
  install.html: add tip for -P as preliminary search=0D
  install.html: add tip on using setup-x86_64.exe from bin=0D
  install.html: bold Tip: in q and a=0D
=0D
 install.html | 22 ++++++++++++++++++++--=0D
 1 file changed, 20 insertions(+), 2 deletions(-)=0D
=0D
-- =0D
2.46.0.windows.1=0D
=0D
