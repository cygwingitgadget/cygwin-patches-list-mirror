Return-Path: <SRS0=koVj=IF=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
	by sourceware.org (Postfix) with ESMTPS id 893A94BA23C8
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 07:45:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 893A94BA23C8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 893A94BA23C8
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::32c
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792050307; cv=none;
	b=i4qNNbqDIQ4H92yoE2EEshumugoFARflpn8kF19YBX0kJm7OvqPIvyTDfg8yRG0WAXgxowrEEc48XfHm6Rr27uey4YYp6Kf0Ywtn9vX7ajT/hMo2gvZSpR/mEt+OVdy9uryrJRyTR+atpyhKXJSvEsOLjmorj1KYO2QKp3AQiX4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792050307; c=relaxed/simple;
	bh=Y2TXtHmbS2aEH4/QQ7rNANGGUJAiSSkM7r8Uo83RW28=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=THMjVcgIzf8STQzOaM4rU/35lgaduFJbKiw0SVlKV/2e5iJ2naZO/hJ0flrXjrxbpdeKbIJ3FFbzD6MEL0/GUwobznfZyRz1X3uGLku1ZfouN2h2WNfSK3j6fkx22zIMajUEK9YXQ1oIUh5REqOt0YWJFpZWUqYiPPC8Dp0jHDg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UhhPusOU
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 893A94BA23C8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UhhPusOU
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-828f4eeba13so3563719a34.1
        for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 00:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050307; x=1792655107; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qDjsBw3UjPeX66+dbAL4Jto64fkQRW9PfUbnjq7kfPY=;
        b=UhhPusOUMGEbt75xMAF1qYw/oS/cWcAgbTUN1TV6ZyD6UcHW/QYWiESNgYvFfs/s7Y
         TWXQJl6kxItnXKcGIq/Zqhda2UdVdAh7Us+gtODRpbJeHEaCgZV5ETubX6vjAnzoozTq
         n7puAWsPSKNlKKmrvH11zriQaZDai7x9+Wjnl+jXf6UifeUmdOJ15sXCFpbNYxbX96oQ
         tiyZSmR4ag4k+hOfzP+aOQCKA+MPaSoFnxLa3yq/sUHoU6OJ++cQj/+jIacz5TNpk03H
         EB05PHGWG6cNkBafKeO+E0an/c8fK4rrRu05vdAv2i9KQXXR7isEqn7b0xaKRvyKEBuV
         MU9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050307; x=1792655107;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qDjsBw3UjPeX66+dbAL4Jto64fkQRW9PfUbnjq7kfPY=;
        b=EidMwGXqAWl883lFt4lqUOaIsB96mttGlAzGSjU2IR0on7nVpsg7eXYVBoeqLqc0T1
         bCvXQz+2pbhLrVvVhD3VzpAGmvk/RAsj8Q4WxNyjymjUc1sPEbB6Cx9o7miQjiAnH4n3
         g5IH4VC/sQGk8BJEJueeiMcCU3/fEPUoxNaM/LOh+dWC0L5Nj0WEPeSMgnP4KzJfpHA9
         cOW1VkxfIBsxkuhln8hOvF1Ae17xycdBlcixRRtF4Jlr9QF6YTm+yqTK9Osbay2CEVZS
         Fyzpc+FM72vAkR06PHi72un0t6eH+rpzYe7UYD+lh2Q61ikkcX5q5PmABMH3nW4IR+at
         +4Zw==
X-Gm-Message-State: AFq9FYKUe3wngPxY/N0s9ttUtZ4DberLq9WnJazvuZQr5Ezuji/Y/nWO
	9EY7rFGXtdoUJLN7FCN4WvpgR2fk9vFUmYChnlRdC37h3F9hfsdbHgnPjmeDCmGdh/s=
X-Gm-Gg: AYBFou0MnJbD3oLMd1+4zMgpDlCL9LWgpmSe8iFWQx2uYJUbRO1Ezn50ilJHDDVpYqN
	2SEXsAARMelgX92+qIa6mzx4CiqjlF3XrrXrsy1azNf+eHvcieEIi9ygXQiUYazgjYEvwMImPyA
	ntH7AQTp28DMPL7MjCXtFlm/Voj/Dn/JHO6FDKcFrClJrHCpTpJZaT7Y8xgdaZHe4MwYGnMZv/h
	E2MiJ4jg+vx9YzdHJv3+J8hSV0D+w+yBWpFcvW51M5Rsz2l8V+MZphvDsBgpWZNikt8vsj2ti54
	z0CQBL0WvrgJu6nuzSDxleaMgnjt83I78yMEzVb5M1oYeRd4XIqgRjmZaT746NoEFuyGFnffmB+
	+50NETo0QwvjRHrxiBsw0MPysJl4GaiAvEv17rogijXNfPiVT8CHtLc/Xp4J8wwuoUAL5w438nD
	KMMps1hNJ0cM1AaK3voPXxHzx1xsUwsPA8C3X9bayMraEEM4+lGJxCfFSS86xS2eVO97KQnJ07T
	uY=
X-Received: by 2002:a05:6830:2107:b0:81f:6e05:c1aa with SMTP id 46e09a7af769-83096fa8197mr18299840a34.18.1792050306782;
        Thu, 15 Oct 2026 00:45:06 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.123.176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8303494f76fsm16626219a34.2.2026.10.15.00.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:05 -0700 (PDT)
Message-Id: <4f53a727d391467eccdbd752fce1b920506954a9.1792050298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 07:44:55 +0000
Subject: [PATCH v2 2/5] Cygwin: testsuite: allow cygrun without the testing
 namespace
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
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

