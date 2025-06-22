Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by sourceware.org (Postfix) with ESMTPS id 63840391A0D3
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:20:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 63840391A0D3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 63840391A0D3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b31
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750580427; cv=none;
	b=IfsBPHjXz+CBdHC6CRL+7s6STZ0GmE4V4LjmqNR2y51NfyMhHguPdA9OolSNKwkGmmMk5wxXOYbPfs7xmdPLvosZy8DVXxWfKwQU4ZQ/u0vW65GsqqYyDhlBeBLJhO+xgVcbJMAWRhOMFOJWfjIxXxJUpgHYdEQFCT6ROFrv4mw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750580427; c=relaxed/simple;
	bh=YqSVObryq/IMwDgaGfr2iujG5rWWydLN86gsEk/XLHM=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Gg54E0kXLpAyQxtjIg7n8IKBk/imsxPGjyNJ9z+Dc0g2oBk9PTqE1hnzbuBzXeX4iU8jPrIH/vhXkLhEebXDUw7OJYpVbulCrigXhCgduhm/PAZXVyNnXt0U2P+bwm2g5IZltF5LWL7sbHIqkaY8CO9wZOkpdyr50MMU9bjpat4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 63840391A0D3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=c0V1sx2b
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e81f8679957so2591936276.2
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750580426; x=1751185226; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=liipMd0pZTvdNlBPmlUOa69gJvD0i/XYDFBSL9vfgZk=;
        b=c0V1sx2boLnBumsLt1f/PQZEj4FI7F0/88EqUs72Ka6VdPnhU2yFif3V/7rRuKfqAA
         sAsZyT3PlzvgI8XbT7GCWuSPOgLdZC3rxsGD11Wr5ge2vexrx/HhLJEByKtIisgudaJQ
         IrwpGzurK8Gbpj+mnRWE4IYStmli8A4Ln8awcCZOeCcsXQwdnFkTslVcOesA8ylLh7zo
         q+t+4FB635DVpTOBONTZJQKgPxJ0deiJDgRaO13KgXr/RFzZQN2/V9lxNVwmj9b6JC29
         KtST5dZuQALhUfFNufxqrdGOGgOEoE59bz/O4saQ1SrgJygr2Y8tvtlLg6U0G58IEL91
         sbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750580426; x=1751185226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=liipMd0pZTvdNlBPmlUOa69gJvD0i/XYDFBSL9vfgZk=;
        b=an4Ba05A2hRoXkCOLqxNMVEoDSvQaktmKuIsypsHuGWOqQgGW1RKqS6Uuh1hS1vxL2
         OyY7GVjgy+TQdOZ/JhZNZJxPQ2o2U3C8qpur+PuFUKetv26kqrlP7y/T7wuQJoyx0QUu
         0jm78PK1Ctf9lPYOc59BenkCqY+ElFlMYfBkGxECIvRtXeSKFUjwgtoKJFUq9FyHnX33
         WUUsl7acNc2oZOer6of+iXS/ITdY/4zoV8M3NCbDMWauQr3vLcRc+9IQSz8mdzY+M6RD
         ev+FCdWWQwdwB6Ed8Dnb9UcPtoDXQ7302NN4cxVtGl0ijLtBBlNUsvSk8SO0dj2pInMj
         3A+w==
X-Gm-Message-State: AOJu0YxaZqPoMM8A6m6W5W6UoKn1Kt2FoCbt3BC7R7M2cRYGJSx2i8Ow
	KbZno9zUapwlbqVc7WtMSWB1+mMNVUbNlE1k+rLPb29grdoV6MJ02o6NJQFRMQ==
X-Gm-Gg: ASbGnctDM8DzkSuHljsIdXy9ro711hJ+ZzbD/M7y+zyv8xHNoCsIlFpy3lE/AbtFhEx
	+cNHAkeXvYbZ1ujr1rLewrjKGHxOaZRqa6B2DlWpfT+aZPFslzqlbyzlbBRN67ZaYuZojvUM5B1
	IJSnG0jtuHGqtvigW3i/bhLzdNBcTfAThyTyDL51LA/Eq+ONUH1IBOzex1oN3O1KLnSgkZHP0sQ
	wLL2fumsv2h3G4yX7yaH73qv8/3MnjB6g9c5qwberin+ok9SuEjdAY2CEArF9AhsOiVqXPl4TTG
	+uz7MXDGewdj+ze4hRUHLxQNEtT+b4v7pf1AfouOHckpJsKOhG/7NoUy/PGh5eDuySkKqRDxTNg
	sfviUMzkcNbw0CYm0FYxY1kDzJt7l/Xdr47Upa0bpOtB74almepWT/vwoFWM=
X-Google-Smtp-Source: AGHT+IGgkKTW9+vh7cACVbatZLQ3Rbg6utKgV2H8TfufarirwyqIXLtGqgJ+ZpOOsOvNfyXOsfLAuA==
X-Received: by 2002:a05:6902:144c:b0:e7b:793:3d1 with SMTP id 3f1490d57ef6-e842bd1b5fbmr10658993276.47.1750580426253;
        Sun, 22 Jun 2025 01:20:26 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb932fsm1746692276.55.2025.06.22.01.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:20:24 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 0/4] cygwin-htdocs: faq.html edits
Date: Sun, 22 Jun 2025 04:19:58 -0400
Message-ID: <20250622082003.1685-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>=0D

This patch series contains several focused documentation edits to faq.html=
=0D
=0D
Changes include:=0D
- In section 6.21 - added additional required packages for installation of =
newlib-cygwin. The packages added are build: libtool; dumper utility: libic=
onv, libiconv2; documentation: perl-XML-SAX-Expat, docbook-utils. Also orde=
red packages alphabetically as this makes it easier when using GUI of setup=
-x86_64.exe when selecting packages.=0D
- In section 6.21 - added example of calling setup-x86_64.exe to do a preli=
minary search when installing packages, as there are nearly a dozen package=
s, and because it can take over 30 minutes for the installation to complete=
; and if all the required packages are not downloaded, the install will fai=
l at like minute 29.=0D
- In section 6.21 - added an additional paragraph and tips regarding the in=
stall process.=0D
- Added section 3.4 - instructions on how to build local version of site fr=
om "https://cygwin.com/git.html". Instructions mainly specify how to config=
ure local server's httpd.conf file, and downloading a command line tool. In=
 example used httpd install with "winget install ApacheLounge.httpd".=0D
=0D
These patches were created against the latest upstream `master` branch.=0D
=0D
Thanks for your review and feedback.=0D
=0D
jhauga (4):=0D
  faq.html: add 5 required packages and sort packages=0D
  faq.html: add ready-made -P download commands=0D
  faq.html: section 6.21 tips and additions=0D
  faq.html: add 3.4 run cloned site locally=0D
=0D
 faq/faq.html | 93 +++++++++++++++++++++++++++++++++++++++-------------=0D
 1 file changed, 71 insertions(+), 22 deletions(-)=0D
=0D
-- =0D
2.46.0.windows.1=0D
=0D
