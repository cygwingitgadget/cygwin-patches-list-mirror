Return-Path: <SRS0=C3e4=6V=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	by sourceware.org (Postfix) with ESMTPS id 6F4F24BA2E04
	for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 14:37:26 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6F4F24BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6F4F24BA2E04
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=209.85.222.178
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1765809446; cv=none;
	b=DIi9mc25qF/OZCvtK5To7mYl2Fn/JG2eH5YDv1DMe0nKppEXkCgqDJ5ychUFp91BmSvIJP989GiBOyPnw4lnqzqZ7/8NH18Aoeos3k9K39zeiavnFVD+0bXODW2J8hKyXBPO/75crxZacn/rGv8+EvzTM/4bNw6ULDlGRPqwTKk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1765809446; c=relaxed/simple;
	bh=Et+CnyoOdGzGeOfuclaj0NIlmLBwRKRoODLOLm4XvZA=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=r9WWlXHH/b23qY+I3u7gHzY0cN/36gpBBs6VCjyZdRjkHn2wwNJA3blNvs2w9mpWuHN0E7EHSWjNZqMyBLSeQt5E+arlYkywjlaV6bo8OU91yKBxplwJ/5u97uu2ApDLMsyHwvD7BfNzrgtmfrx4UTNddgvmdu3AGRNJBTvlrow=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6F4F24BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=VMRdSRSi
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b9f73728e8so327042685a.0
        for <cygwin-patches@cygwin.com>; Mon, 15 Dec 2025 06:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765809445; x=1766414245; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7c7IPhGz35k94B99Q1Suv/ZkcSad522kzvYBPWUy0g=;
        b=VMRdSRSiI7IxsFtTUmK8Z4GgyR8Hhok2Ou7A3vDa3ogAK47NHOS5Tl2/6L1q17LqMP
         uWKBRVV5kPCJWGimG1cfxQS20DdB11ZhXK/Y4lH+2R8b6ocLZ3+B2mdo46SLDqKGcknj
         aOIW6FKnJB4g8puJUpVdT4xdTNwl0l3D77aUY9TdPQUNWd+v2hphSP3Xfnrc6kcOcWj5
         qIFWvdOJg9k2/heG5c4LyX3FLt4pqNoygj2kvxI3Eax8Rrs5ihYOgx7OS3GsKYvNQoF6
         gwm/WFRXbB+AItLJ2DkxU/l3/YHQncvbQ1nvkGDGqNJpYBKzfFwGSpjI05Lu94QAwuDU
         UGew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809445; x=1766414245;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E7c7IPhGz35k94B99Q1Suv/ZkcSad522kzvYBPWUy0g=;
        b=mj5y3ECBuvEbMa3iJUJxBY1G+hDtaHL432fJLf3nKUVEUuFNUBrdqCMNfJ32o8AieV
         ILcdwpaIfa+u6miZNWQtVgZlIt9lnyP9F5UaXSMQbW0PoBL2VP/970Z1vTQ2s6Ar2xaT
         5ZOIVzbf2EgKHuLgCdwZG58/M3X3UhyeBiKPcyT5c4INzTSbtSuEuFYUWjmYwFv39Fbc
         eQZsyRSIjT83ESLhPab2NMEpLauXNTiXggeK/oNMySwKA2i3ngp+mn2b9BwvwW2XFBrj
         G93EIm+jdfiGrLW/3SvPKI/9lhXvcrKwlEm0oQms8ty1H9EBQTQUE7r9Y1gmrRJmSw3Y
         Nv+A==
X-Gm-Message-State: AOJu0YyFZ0f/3XvKuhkvhLpW+dAfVzbysXPH4eLFfjXtBF/rJcV7/rVY
	1XP2iaD1Va/hx46ycAVbUOBaLhj3TUcA7o6UvHckFplTE/xWzioXAuo05EQo0Be9
X-Gm-Gg: AY/fxX7zmFYCNVCPZfsr49SNSQzb2I2jh13FuNHSOOJlN+Zeb/IvKH2zoRs2BEwVMqt
	2yNK6xvFOdL9lsCahG/r13ghARyUa6aCl45PENvIeRTU2T2CHyzYg+BohDrLqlcC4Zz03aqVyAg
	JQizZFnGYIehRjyTOtTKhAHGiiVWxim2GxxRfigHYqJpYX2ijz/sIPDW57xqcC9t7I3aLbnsn5P
	bhankFebG6zrbhDzpQQwwYP2cMz6r2D4NKdiQkbLnwctlEhZ9qASnuC0fJ5Vw6SunU/SfI1W0/F
	p9uChlz/O/h1S70/Z2imLY4MfUDPcO3579vnyLHbmSVepiM32hrmcy5mBcLSyWlJgHXEEr/i+/Q
	j5W5lgNCi5M0VtANmw7zJ6v8YRxYymz559EsS4kBmuK95TBPiEcGmjZx8wOMJUrOckMck7mt3vZ
	k84f/7kktoeRmSexc=
X-Google-Smtp-Source: AGHT+IGvuAmkTnb20E0p8lGF41FdADxmW1GpIWOee4/7BARc+2+X+RbMW5k05WCt5dE1CTLDqSbqZQ==
X-Received: by 2002:a05:620a:40ca:b0:89f:5057:974d with SMTP id af79cd13be357-8bb399dc124mr1750431385a.10.1765809445159;
        Mon, 15 Dec 2025 06:37:25 -0800 (PST)
Received: from [127.0.0.1] ([172.208.126.104])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8899ea36210sm51879756d6.27.2025.12.15.06.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:37:24 -0800 (PST)
Message-Id: <6ae42c5d17102a7805ed6539b9548df437df88a1.1765809440.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
References: <pull.5.cygwin.1765809440.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Dec 2025 14:37:20 +0000
Subject: [PATCH 3/3] Cygwin: is_console_app(): handle app execution aliases
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Cody Tapscott <cody@tapscott.me>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In 0a9ee3ea23 (Allow executing Windows Store's "app execution aliases",
2021-03-12), I introduced support for calling Microsoft Store
applications.

However, it was reported several times (first in
https://inbox.sourceware.org/cygwin/CAAM_cieBo_M76sqZMGgF+tXxswvT=jUHL_pShff+aRv9P1Eiug@mail.gmail.com
and then also in
https://github.com/msys2/MSYS2-packages/issues/1943#issuecomment-3467583078)
that there is something amiss: The standard handles are not working as
expected, as they are not connected to the terminal at all (and hence
the application seems to "hang").

The culprit is the `is_console_app()` function which assumes that it can
simply open the first few bytes of the `.exe` file to read the PE header
in order to determine whether it is a console application or not.

For app execution aliases, already creating a regular file handle for
reading will fail. Let's introduce some special handling for the exact
error code returned in those instances, and try to read the symlink
target instead (taking advantage of the code I introduced in 0631c6644e
(Cygwin: Treat Windows Store's "app execution aliases" as symbolic
links, 2021-03-22) to treat app execution aliases like symbolic links).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/cygwin/fhandler/termios.cc | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/winsup/cygwin/fhandler/termios.cc b/winsup/cygwin/fhandler/termios.cc
index 5505bf416..6edd5be9b 100644
--- a/winsup/cygwin/fhandler/termios.cc
+++ b/winsup/cygwin/fhandler/termios.cc
@@ -710,6 +710,19 @@ is_console_app (const WCHAR *filename)
   HANDLE h;
   h = CreateFileW (filename, GENERIC_READ, FILE_SHARE_READ,
 		   NULL, OPEN_EXISTING, 0, NULL);
+  if (h == INVALID_HANDLE_VALUE && GetLastError () == ERROR_CANT_ACCESS_FILE)
+    {
+      UNICODE_STRING ustr;
+      RtlInitUnicodeString (&ustr, filename);
+      path_conv pc (&ustr, PC_SYM_FOLLOW);
+      if (!pc.error && pc.exists ())
+	{
+	  tmp_pathbuf tp;
+	  PWCHAR path = tp.w_get ();
+	  h = CreateFileW (pc.get_wide_win32_path (path), GENERIC_READ,
+		           FILE_SHARE_READ, NULL, OPEN_EXISTING, 0, NULL);
+	}
+    }
   if (h == INVALID_HANDLE_VALUE)
     return false;
   char buf[1024];
-- 
cygwingitgadget
