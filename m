Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1329.google.com (mail-dy1-x1329.google.com [IPv6:2607:f8b0:4864:20::1329])
	by sourceware.org (Postfix) with ESMTPS id 31E9F4BA2E16
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:07:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 31E9F4BA2E16
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 31E9F4BA2E16
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1329
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336072; cv=none;
	b=Hcyfse89dLMmrl+nsfzK7yFF3EhqcvvAN02KWtg3qgaxOxkgvkLu4aq2P3Q5ZH53ao98dEsVAja83GFnFC5SrhDzK/NkFhWWTRe1fbvm7spm3pMbBM9ZSQVyry4bY1wSTcqy6u67gS02glw43M8zRdq8uXe2vRnr4RM2RnY+NEQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336072; c=relaxed/simple;
	bh=Y2TXtHmbS2aEH4/QQ7rNANGGUJAiSSkM7r8Uo83RW28=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=BGad0aBOHD70vpTuerp4sEqGH8LqwUyj0cWAnqT7hQU1s7hkY+rbFL5RHf388iJw4sVVwydrhP/+y2jF3qFzvJTim4a1GHTlBF1l0HsIn2OI19V+zuxyWY38yDnQ2VH3A9liT0Ck5RHUzdsA9rNmU1Xmg2xtmP1TRW/+xeuaWps=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N/lPDiHo
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31E9F4BA2E16
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N/lPDiHo
Received: by mail-dy1-x1329.google.com with SMTP id 5a478bee46e88-35cd4e8bdbdso3329947eec.1
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336071; x=1792940871; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qDjsBw3UjPeX66+dbAL4Jto64fkQRW9PfUbnjq7kfPY=;
        b=N/lPDiHoAUt3wm//HKhaag+7EVzVFOsKo1ITHDM/3fpKmDbGlgcPZVEHvMioRsG09I
         nBS1eWw02U5PAK4KxpX8gmV1iT2eFP+pqdKzY7gPvV53g3k+w5Htcu1j5/YYsy8g8WdT
         FkTomqJc7isZhl7cVnOGkld3T+gLdJ7s6eRlVADRUrbnY1cGLE1dM8b1YXJxxy42sYN+
         34SM0H2AmW+qPIZVkxXsZpcHjxbDuAfgeNxQJRyR4cRJMkmV5LTvF+lm7JRgjzkmuaHt
         kMdyqIba0mkpAUox0jRlIDAjXUAHrOHrH0f+Qy4mnXWfK4rEOjweincpYDgQgHA4OrRm
         oLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336071; x=1792940871;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDjsBw3UjPeX66+dbAL4Jto64fkQRW9PfUbnjq7kfPY=;
        b=zxYWqELf70psCpKS2jveHqV3nm36tleuDiuBxkOAR8wnVf75XMrr6ToKNMEjyyNpMv
         +KLd17n1pe6FOYqOuI5tyZvilLVvq3BhHn74XaydxWI59dLawbYYWckEN2IjTHkrcvKb
         k7tCSpvmKOCNQI2GeGIAExMKDyGRv0RJK2tmUzIC8Of2P3LTGQX7m3iRKF1EjKzSorPf
         2Lj4tN8U/PK6kySkhMqreLPw9baICZMHbsklKQ9SOjGh8lmebXZNPdJgyN/k8tW932VM
         9ci/elZHjTfpA/gaBMCEDoHYIfNWNpDNAcSLLe3CJpTpwL8yzHwFpSPJzrS7x4I821wK
         D3ww==
X-Gm-Message-State: AFq9FYI0ZVCq66gsRxNVEbzYyKtXYrgmSRgNc4ibAk24Yb45FnlHEXVZ
	n3LOyNOKg6mbsqaC0o+pfUWKSKHiaclwacl9aHf8czXWAtuhZ//aVATakcAQ5OTL
X-Gm-Gg: AYBFou1JUSeT2FLhXI3Q7wAD27wgPBuGVC2e57uBDH9c/G7KZKTGh1Wu0pmPpgUY3gJ
	jJ8lnHR52asXV051j09OYuodOBdp+osI/Hc0ATtoE+VatlJMpz4/YPkkfyR/Sr4RwrHpX9szlz8
	Gt4j7V1xFWkV/klMJX4+PNU22fBDWkUQ9Njqm0U1lLEJb4GC0dKT1neIx9q4tkACXIN6Yu2nxNL
	nf2U6Eg3o05BaC8n0xgUxFuNO1Bgt7X5m7dObShjVHLtCKLPQ7QPBWOg3yD3vuD4266DwFh0Zq4
	+XFI0/WS2kR/kIlwe6OfpY12Gm7ZQPP5DQkun3PemdWJV0tLkKMF3Xm5pb0XJPda/udnXtftUu6
	loXrasBp/Ui24GZjpsL18bh7i1huw9xAOPlvE4GJZQOv+xhbLdJ4mKMCuWEBjZwxapeKuHxMoW6
	vWPaYOaU4VN4IlrT3sYuiG6HENyLYkllJ9lAf3kTjXea2qi5kjXOx1BsDjMf1MfoDu1xiD+hMaN
	w==
X-Received: by 2002:a05:7301:fc09:b0:359:2f0b:aa89 with SMTP id 5a478bee46e88-361a16681bemr7280251eec.10.1792336070892;
        Sun, 18 Oct 2026 08:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608308a87csm41606081eec.28.2026.10.18.08.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:07:50 -0700 (PDT)
Message-Id: <ebf384575c7770da066008fc20c70e78e826f29c.1792336066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:07:42 +0000
Subject: [PATCH v3 2/6] Cygwin: testsuite: allow cygrun without the testing
 namespace
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

An executable beside an isolated build of the Cygwin DLL does not need
the build-date-specific testing namespace. Provide an explicit -notesting
opt-out so such runs do not depend on the native CYGWIN_TESTING flag
surviving a Cygwin exec.

Keep the testing namespace enabled by default and leave production
environment handling unchanged.

Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/testsuite/cygrun.c  | 12 ++++++++++--
 winsup/testsuite/cygrun.sh |  7 ++++++-
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/winsup/testsuite/cygrun.c b/winsup/testsuite/cygrun.c
index 50c51876e..b7e6d17bc 100644
--- a/winsup/testsuite/cygrun.c
+++ b/winsup/testsuite/cygrun.c
@@ -23,10 +23,11 @@ main (int argc, char **argv)
   DWORD res;
   DWORD ec = 1;
   DWORD timeout = 60 * 1000;
+  const char *testing = "1";
 
   if (argc < 2)
     {
-      fprintf (stderr, "Usage: cygrun [program]\n");
+      fprintf (stderr, "Usage: cygrun [-notimeout] [-notesting] program\n");
       exit (1);
     }
 
@@ -35,6 +36,8 @@ main (int argc, char **argv)
     {
       if (strcmp (argv[i], "-notimeout") == 0)
 	timeout = INFINITE;
+      else if (strcmp (argv[i], "-notesting") == 0)
+	testing = NULL;
       else
 	break;
     }
@@ -47,7 +50,12 @@ main (int argc, char **argv)
       exit (1);
     }
 
-  SetEnvironmentVariable ("CYGWIN_TESTING", "1");
+  if (!SetEnvironmentVariable ("CYGWIN_TESTING", testing))
+    {
+      fprintf (stderr, "Cannot set testing environment: %lu\n",
+	       GetLastError ());
+      exit (1);
+    }
 
   memset (&sa, 0, sizeof (sa));
   memset (&pi, 0, sizeof (pi));
diff --git a/winsup/testsuite/cygrun.sh b/winsup/testsuite/cygrun.sh
index bf1d5cc6b..6ad2a373e 100755
--- a/winsup/testsuite/cygrun.sh
+++ b/winsup/testsuite/cygrun.sh
@@ -13,5 +13,10 @@ then
     windows_runtime_root=$(cygpath -m $runtime_root)
     $cygrun "$exe -v -cygwin $windows_runtime_root/cygwin1.dll"
 else
-    cygdrop $cygrun $exe
+    # Executables beside their private DLL need no extra testing namespace.
+    case "$exe" in
+        testinst/bin/*|./testinst/bin/*) set -- -notesting "$exe" ;;
+        *) set -- "$exe" ;;
+    esac
+    cygdrop "$cygrun" "$@"
 fi
-- 
cygwingitgadget

