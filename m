Return-Path: <SRS0=9Csj=H7=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	by sourceware.org (Postfix) with ESMTPS id C34FE4BA5435
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 12:13:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C34FE4BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C34FE4BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::102b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791547983; cv=none;
	b=MLMDn3kxDvf8v1hnE2GtplbQ1B2kEXrLmKDgPd75P0H35n5VhMOPdRhIyrsyuePmOPxIu7AtMerZxvUbnyB8QHj2iZqUzTsXLacj6vDfWWXDLYNg4IWx7/x9rGP3c7jmqRlQxAaf9GEM2+VdmzIu76VN2nhfOePUvHcW7wZ0Ut0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791547983; c=relaxed/simple;
	bh=loK4f3rG7H6maGRqYxA4OyxCqf7dNHPcpFXZPhFAwWw=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=IXIzccMucqf//o4iE5W79I5g/4WRF9Ai0R7KPA+axQEsGpUFBXPluVQYSaC/SmQgGGAzXg6mKAvmbC1Y3mZ+Hez2aga/Kaw/GwaT5G/qggn6IzkG1AzaKO6zOAJBCkW5gMD3V/fXPV9IM+vUxAE6XVrZ8gReCRjnrbqUn87f+Ao=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X7lQbMSc
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C34FE4BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=X7lQbMSc
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3ab67ff8f16so41321a91.3
        for <cygwin-patches@cygwin.com>; Fri, 09 Oct 2026 05:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791547982; x=1792152782; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5Tm/OLwOoMk6ImMdYfPgioCjNV58A+xKdc+w77lUpBs=;
        b=X7lQbMSc5EiqJWfl+bfVEyAKR4I6lv67++SMw0kaFomGWmnqRCZo4RiZ4quPNmEJF/
         3FXKtR1AI7iRjAwTllbwVGzuyOMAaXUcCqQkL5GDAOQ1GJ/cQLUp2XgyY3ylKAlrbiKR
         zQm+4g7scVnpdTDRFnxz2yxB0zIPU2dm8nLU1z5DOor+I4SBLcv6BGtyCkQJLRj1fTJE
         TW1SsUi6q7pDmy9rLjJB3BG0TMCriR7bW9ERWGwyudfKjV0wTedIuwHAKb+0rKo/3JvO
         a3pr8dMzBlKw3tllJcKa4UKc6luAoNtKDLVDqvXcFNgFJRg+OTP9tzwjAvfwGl0PB7d5
         aaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791547982; x=1792152782;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Tm/OLwOoMk6ImMdYfPgioCjNV58A+xKdc+w77lUpBs=;
        b=dkJYmolJv0RMkYEN08DqjOPGnySSZZU5xOFe5/11GIN8dmvMejGjcQDb0jMTYKcIik
         TySC5wI12s++6I67jlXK4RBiRvHWsqiebLC3TLmVYAd0Tds04nZwYKezRuJQEZ4owqCX
         6hVitLVRInM4oIUh9yLLSbnsWFu9J2DsaA0JUMKrW6y6vV168z5Xyg20SbR+QwIowDI0
         +JOoT6FaobVgzgtnD/yxbr41dX9pWWcn6Vh45Sq3H+WER3rDedXzS7j4WCtjcykpah5+
         KtOyiPmjWG0QYc3k8Ac7aTf4cwtYanUfZ3G23+iZhpzI66OA33J37g3GD+HN7t+XUaC/
         gJsw==
X-Gm-Message-State: AFq9FYKpLqiqfdX0Xyy4tD35YeQ4QNjqYJwl7plOjS4JE95DMSy+uhsn
	2QP6LCpFD7ENYsVRISmYXrIy+AgJqsC58DqCOZV3DFodrD1D/Jie/56l0I6zUw==
X-Gm-Gg: AYBFou0f8bq+Sg3lAQ1r6e4FSpGCYLqxABVh3/Y1rXaZv/ZfAITkbRTlpg8Gx3av4hT
	MY55275N9Lx23OqpVgQkmO34zxBW1MfAcE+rfztW+sun50BVxQ7RCrGUvCfkQBVIFxnhCCrJ4zT
	CwqprWtoUZTQIY2yYj1MPkoYvThtNsV7jlhjNE1LDTsAP6HAVmPOTD4Vme0jzfGPw1+0+fwDrzh
	BXzlQZlEwrh2P7y7LAgcQoJOwY8NZT391Yi+dhWopZcr3uVlP63b1iZlmXlu9VpOWBBaC92sLr8
	CDJugP7N7I3lrEJf8x0Js9ijRMxNHaCZGtpmtJIXumioFbMAhrA2pqdkl6GHsHRyCbasnQ8D7Av
	d2LV7LzUgJbzkhD+6YA4qp8ZL4sav0Q0GqaYvqcft6JUVoJUCP6n5zWNwaAvUCTVVs1FR9axxhB
	WXf/PvtjSBj52msXF6rAdgJ4gX8Fx6E8tzpa3vO7U/ktnUw5A6EKsmmfuNfaTVIn5RDGr8rH+r
X-Received: by 2002:a17:90b:5109:b0:3a7:92c9:eacd with SMTP id 98e67ed59e1d1-3ab3a10494cmr1563221a91.0.1791547981712;
        Fri, 09 Oct 2026 05:13:01 -0700 (PDT)
Received: from [127.0.0.1] ([20.169.102.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38dd5864sm3173593a91.8.2026.10.09.05.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 05:13:01 -0700 (PDT)
Message-Id: <b9c0afe80c4a0cdd62f7ac53e421cb6070dfbb5c.1791547975.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.v2.cygwin.1791547975.gitgitgadget@gmail.com>
References: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
	<pull.13.v2.cygwin.1791547975.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 12:12:55 +0000
Subject: [PATCH v2 2/2] Cygwin: testsuite: cover console mode preservation
 with redirected stdio
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When stdout and stderr are redirected but stdin remains attached to the
console, starting a Cygwin child via a native launcher must not clear
ENABLE_PROCESSED_OUTPUT.

Protect the behavior restored by 717d7aac57 (Cygwin: console: Preserve
saved modes with redirected stdio) against future regressions.

Addresses: https://github.com/msys2/msys2-runtime/issues/379
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/testsuite/Makefile.am               |  1 +
 winsup/testsuite/winsup.api/console-mode.c | 69 ++++++++++++++++++++++
 2 files changed, 70 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/console-mode.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 529853849..7aa25cd4e 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -33,6 +33,7 @@ libltp_a_SOURCES = \
 
 check_PROGRAMS = \
 	winsup.api/checksignal \
+	winsup.api/console-mode \
 	winsup.api/crlf \
 	winsup.api/devdsp \
 	winsup.api/devzero \
diff --git a/winsup/testsuite/winsup.api/console-mode.c b/winsup/testsuite/winsup.api/console-mode.c
new file mode 100644
index 000000000..7c07b4746
--- /dev/null
+++ b/winsup/testsuite/winsup.api/console-mode.c
@@ -0,0 +1,69 @@
+/* Check console-mode restoration with redirected standard handles.
+
+   This file is part of Cygwin.
+
+   This software is a copyrighted work licensed under the terms of the
+   Cygwin license.  Please consult the file "CYGWIN_LICENSE" for details. */
+
+#include <assert.h>
+#include <fcntl.h>
+#include <process.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <windows.h>
+
+int
+main (int argc, char **argv)
+{
+  char exe[MAX_PATH], command[MAX_PATH + 32];
+  DWORD mode, result;
+  HANDLE output;
+  int fd;
+
+  if (argc > 1 && strcmp (argv[1], "child") == 0)
+    return 0;
+
+  result = GetModuleFileNameA (NULL, exe, sizeof (exe));
+  assert (result > 0 && result < sizeof (exe));
+  if (argc == 1)
+    {
+      STARTUPINFOA startup = { .cb = sizeof (startup),
+			      .dwFlags = STARTF_USESHOWWINDOW,
+			      .wShowWindow = SW_HIDE };
+      PROCESS_INFORMATION process;
+      snprintf (command, sizeof (command), "\"%s\" worker", exe);
+      assert (CreateProcessA (exe, command, NULL, NULL, FALSE,
+			     CREATE_NEW_CONSOLE, NULL, NULL,
+			     &startup, &process));
+      assert (WaitForSingleObject (process.hProcess, INFINITE)
+	      == WAIT_OBJECT_0);
+      assert (GetExitCodeProcess (process.hProcess, &result));
+      assert (CloseHandle (process.hThread));
+      assert (CloseHandle (process.hProcess));
+      if (result)
+	fprintf (stderr, "Console-mode worker failed: %lu\n", result);
+      return result != 0;
+    }
+
+  output = GetStdHandle (STD_OUTPUT_HANDLE);
+  assert (GetConsoleMode (output, &mode));
+  assert (mode & ENABLE_PROCESSED_OUTPUT);
+  fd = open ("/dev/null", O_RDWR);
+  assert (fd >= 0);
+  assert (dup2 (fd, STDOUT_FILENO) == STDOUT_FILENO);
+  assert (dup2 (fd, STDERR_FILENO) == STDERR_FILENO);
+  assert (close (fd) == 0);
+  snprintf (command, sizeof (command), "\"%s\" child", exe);
+  const char *arguments[] = { "cygrun", "-notimeout", command, NULL };
+  const char *mingwtestdir = getenv ("mingwtestdir");
+  assert (mingwtestdir);
+  char cygrun[strlen (mingwtestdir) + sizeof ("/cygrun")];
+  sprintf (cygrun, "%s/cygrun", mingwtestdir);
+  /* cygrun starts the child without Cygwin's spawn bookkeeping. */
+  for (int i = 0; i < 2; ++i)
+    assert (spawnv (_P_WAIT, cygrun, arguments) == 0);
+  assert (GetConsoleMode (output, &mode));
+  return !(mode & ENABLE_PROCESSED_OUTPUT);
+}
-- 
cygwingitgadget
