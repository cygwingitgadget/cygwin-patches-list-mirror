Return-Path: <SRS0=55nn=ZN=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
	by sourceware.org (Postfix) with ESMTPS id E748A38560AB
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 21:32:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E748A38560AB
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E748A38560AB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b33
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751319144; cv=none;
	b=NheKqDAg3Z7bdQ231vGug60G0uvmPHSrFpBTbtgVxkgIPkhf+vXy9QwXfXF0DEkakEtr2BlBd2yobrmjFvkZ8eZ/v4t6pTZsTC1DmjCMuuY4SfPYHl19Atjd1C6GZD2Yt42mW6U8uOC4TNYGOJ9aDigUa+tUiPuollIXexLJJPA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751319144; c=relaxed/simple;
	bh=cUme0pKe2med5uXaxzZ0SP08bpA+VnG8nigoDa/lPzs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=ZFgZxKgKTEj5fQ57Jb79oFkONONj5Ctn7Hb6A5VaPDKckXSe1wTM/8rL0h1lsX5psQOIC2jHK+ZrEkiicv9Kj7VNL8KQSkZpFmaIh2v4oDJLFh63IEzZOS6BUVfJtlkWlQR8cMp2J9551rso95Hfsy7vGWJFRFdFwm5/FuE3ZYU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E748A38560AB
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=UrDhVNy2
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-e82278e3889so3117363276.2
        for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319143; x=1751923943; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUme0pKe2med5uXaxzZ0SP08bpA+VnG8nigoDa/lPzs=;
        b=UrDhVNy2J1donoXIvjbJeOmECKeizUjja6sRmMxl0HTjbikldx1FmBItEenTBtuJ8d
         ZqPXLWjzBGVw5/21h7L/raph2JHJR4GkgaUhd/8Dbl3H8mufx2NN7/PXe1pYY5lZV9If
         +XF6qW08jHF/24Y2n2Gc3NpbTQAWDhXyP7phY5498UYPVVMfILe1ZuxMUuxG9F9fa/iG
         Hbn+qDjQrfs/SZfdkaUUZDQWYpTEdhVFsb3alXKVZtZjjajTaQNM/c7Od0v207kS2Arr
         EVljQtp75EroI5CrlzeMbw0MssfRItXQkRHV2hW16333REnrzYJldCEWTySxwWUVHDjD
         lZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319143; x=1751923943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cUme0pKe2med5uXaxzZ0SP08bpA+VnG8nigoDa/lPzs=;
        b=VdXsOlM4/4WDliIGdqPf2n9Q4w+jPbDIKPG4G+1gFmqHI/zOiFDA9Rh3qgb2NNJ0nq
         66UuQWupF4XxIBGGMzP1ABG6v2QZ/zgANLvL+VHSFzMyjoXSDUxmgNygKRG5qmbRpiQ3
         wID/FQe9GmGM3Tn7g2he6IJzkf14cfRngkTUjcKul1hemTdd4juStNnG0cpE9Kwx3WyB
         X6nxVR1ItU1yt3PO3Zg28ChW5uHg66QcQMxF0YloK/KBNASUW7M6iMhPHPcFdbDAX6tX
         OQaDTXmlwklnZjGB0amz0F8SEP7vWKcqM8fXXYrifO0Q4MA+O5HyY3NLV48Vbb2PLFAf
         +JTQ==
X-Gm-Message-State: AOJu0YwCKAt5pNNmg/gH3pTYl56P0OXCDW2M6fJvvkfzgPR9iMIJ/NWN
	439GpXDz1DC69RhC3sZYd/EgEVr7F/eobqb9g0IBDZETUD7KOSVxLnoSaLdSjw==
X-Gm-Gg: ASbGncvX72lQDaECLQZGOvJvXN2QfSmnxX/2YBkiLge5lNW40G9IuDPk+YrX3J7pMMz
	AVlg6UE6MW/9eM0Y8HW4SdYdLq6nJ/jW4dhjx6VH0yMl2EBKWhIF/OmWgFGQXmpahCPzEpfkz60
	xB6dR3os01QTRcjsEHaBKmwdgrSOuz+uPFa2kQ20mXQcMSw0QVVry2C2DxA1OByDwn2iCFFzbht
	TxKm77TNX4CrnnBwq8rcmbUzUkSclXXS6ix4dyEcERvWNqL72DiAl9pA3RJX4Lnu7WOSS9aCN/d
	4n+1dqQHqNtYQFZ054CWTCkwM/xUJ4KGlwGTUrwanlXWxHWlE+Beuji7qMX/Bas+SLROFMudKjm
	NvQvZtPGu/7/h6lWiLA5Jm0Vp1AM/jYfEB1olBcRCr7lQQiHVqZaR8jum8CEpErcl6Sy5
X-Google-Smtp-Source: AGHT+IFMwrOwr7/6N5pzaAYvKGDKgN/gANcj20jusvyK8a9bwPdOVwkQeHW3OBiR+117yCBTvGWVEw==
X-Received: by 2002:a05:690c:8311:10b0:70f:8913:ed66 with SMTP id 00721157ae682-715171b87b2mr149802207b3.38.1751319142741;
        Mon, 30 Jun 2025 14:32:22 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bee26csm17046267b3.17.2025.06.30.14.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:32:21 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH v2 3/4] cygwin: faq-programming-6.21 para about process and time
Date: Mon, 30 Jun 2025 17:32:04 -0400
Message-ID: <20250630213205.988-4-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250630213205.988-1-johnhaugabook@gmail.com>
References: <20250630213205.988-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Adding a paragraph that breaks down the build in two steps; installing the =
=0D
required packages, and the install itself. Includes an estimate of the tota=
l =0D
install time, as I got varying times for install to complete using Windows =
10, 11 =0D
on both a sandbox environment and on PC's as is.=0D
=0D
This is to make people who have installed the binaries of cygwin, which tak=
es =0D
under 5 minutes, aware that this install will take significantly longer, an=
d =0D
making them aware that the install will fail if required packages are not i=
nstalled.=0D
=0D
Signed-off-by: John Haugabook <johnhaugabook@gmail.com>=0D
---=0D
 winsup/doc/faq-programming.xml | 7 +++++++=0D
 1 file changed, 7 insertions(+)=0D
=0D
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0D
index b9269187c..fa3f097a9 100644=0D
--- a/winsup/doc/faq-programming.xml=0D
+++ b/winsup/doc/faq-programming.xml=0D
@@ -675,6 +675,13 @@ rewriting the runtime library in question from specs..=
.=0D
 <question><para>How do I build Cygwin on my own?</para></question>=0D
 <answer>=0D
 =0D
+<para>=0D
+There are two processes. One download the required packages.=0D
+Two installation. Note that the entire process may take anywhere=0D
+from 30 minutes to over an hour, so be sure to download all =0D
+required packages before beginning the installation.=0D
+</para>=0D
+=0D
 <para>First, you need to make sure you have the necessary build tools=0D
 installed; you at least need <literal>autoconf</literal>,=0D
 <literal>automake</literal>, <literal>cocom</literal>,=0D
-- =0D
2.49.0.windows.1=0D
=0D
