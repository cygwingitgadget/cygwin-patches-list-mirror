Return-Path: <SRS0=9Csj=H7=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by sourceware.org (Postfix) with ESMTPS id 20B4E4BA543C
	for <cygwin-patches@cygwin.com>; Fri,  9 Oct 2026 09:23:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 20B4E4BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 20B4E4BA543C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::c32
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791537829; cv=none;
	b=wWWXKb9Rx7VElXalHLgcXHLY/lRWZ2FtZLiiUlSpDYcaKiw6OFcoGLlhH7732FOTWYxAbzvpi8QRoSATb7FW5gKPLfKWkoQLNOaaBDOw06yxWlBn3bSIaFkn/rdywbxRDGthiGoH5iqO0PpOxtVqcp/izeO5+JuNpc69gw4veHg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791537829; c=relaxed/simple;
	bh=uzwIkgqCnuzT615NBffBCAfaXzQ32J+wyxtYNi/fVPE=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=EZsxNjm9iIys6bkPXCwOq1PR5mM48N6y+NZ/0LkhhWnEJGKmqRbVKg5QuNo6A8rkkofqNIBmu2zNy8PN7Nj8vE1ctR3dN17Zv4oFSMnEsS87zjoGjd8+jXfeOLNt4A218/zYdSEIiT3seZnF8AL44ZZ1aTDQ02Z2ppUbNWN3Uuk=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WjGb0id8
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 20B4E4BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WjGb0id8
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-6dd7070699eso4467064eaf.3
        for <cygwin-patches@cygwin.com>; Fri, 09 Oct 2026 02:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791537828; x=1792142628; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rhuDnochb6Lqm87KOh1MCgzeYvM6K3HJ/oC2XsyfHGI=;
        b=WjGb0id8QDYiavdzMOf302LMrhYlH+Xtvn1D9dawwfzylicf/daf0S/PMdaL4EeLYq
         3+lSZm5sAdrwLZV/eUuNOg+HS/iE/iNYOwvh9rFjEwJYyk1iz1l8z4R3xoPvb7DyGgHr
         B3IFtOvdCLQs7ARJTKCZk4uoh4nSPITqZnb79H4uZ4rCFRXoYCcF+7HzfARVrnj0gQl5
         /2tYTGOiWiU8JA2qy+sEvVB26vPzyGuXBfcfPBojumnQO3ouNM/Ck4i5xcGJfkoP2GNN
         I/fM/eyqhsa3kBxJisAZjM6+vEen3r9bo0a5bo2BML42WFegPLcMyMCIW45ci0uo+IIW
         1dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791537828; x=1792142628;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rhuDnochb6Lqm87KOh1MCgzeYvM6K3HJ/oC2XsyfHGI=;
        b=uFzsyfcAdEnFDvD4P8huoVrRa9OUZORzzvGk+OTGR8cHXhgyoIfKLrwHzGXPhZMUN0
         kDl3eUrb2jmII562QZxezDam+uJJmB7KpOD/O+iLubqiHkYjim5hIdKTPMg5SkOWIbgr
         lQHM5vYEZh42TUsaOo5mDtoiW44CfSDYyU+8gsRpY3/1MLs2mEQ76VCBOgIC8s++8pUL
         mASN9r94ZYg6sVheIuhFKlLKeIsKXak27ZZxBv941I5oDuRKY4YB1FQJXofSIQlh44QY
         jPx3kSxZygBsmFO29bWI0mVzkDUqRaIcZo6dpk6YvMUHpGShipfQESTBwMiQ2eKoxtjH
         3WlA==
X-Gm-Message-State: AFuF++nk6UHVsnSZym7XjOzSngI+KeZm4gC3ekw2ytKXmub2XKhNieAC
	xN8hzrJae8uQmHnojf+d9kzjpvo6+SW2XnJjl3Dv964j+ciCnurGlEhq0Hma00qy
X-Gm-Gg: AYBFou1OjTFvfX1D6SwbxOomy30j2ui7LSjHxz1rc7ymzEAw6hz9aejhyfrwyKy1/nw
	xfAantjHlfhyR0QImIA0KChU+HKJmGDalwva9A02sN+OUDWXUI2FSiPLb+xGGvHRmJoFnyDfLqW
	csARbQFZPNJcpbvREKhwXsVW2lYPEaIR0w+4pRSMhsyuQZW6AvZerePExiisxRBQifEAyM/KOdj
	ViU2o/+OtOOAsdK5ci0vjH0T1KytXaoWMuzZHH+hwLjBKTJEnZcAoBX0dtYTCGDLz0l/4Ck9yWx
	lfRvz+cPT3Q+rBTpcl7hZhyvbVj1h9IOlRZUTe6HdRN6MI9E18cek9BE+NcsTioUPodIE2zxxJ+
	HyAVzm3JInjObzjKh4eLXUoCCWl5t+eeuZrPoqtCHSyRK96L85ALE0zFcWhtqJxptZaGgfcdMOO
	lvn4w6HUDXVSYdRJzZaRAT7+3+Ap6SdxomfzpRncXHGG7G6IvLOJpuRHW7mLhqqv6QB0oUkOjE7
	AnCHETX2BcH
X-Received: by 2002:a05:6820:d0e:b0:6cd:3ffc:e33c with SMTP id 006d021491bc7-6ef131ca31cmr990131eaf.90.1791537828360;
        Fri, 09 Oct 2026 02:23:48 -0700 (PDT)
Received: from [127.0.0.1] ([132.196.31.81])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a2a86317a5sm1262722fac.17.2026.10.09.02.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 02:23:47 -0700 (PDT)
Message-Id: <a26e054148ba05dc91c9094caef8dde5db595c6c.1791537820.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
References: <pull.13.cygwin.1791537820.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 09:23:40 +0000
Subject: [PATCH 2/2] Cygwin: testsuite: cover console mode preservation with
 redirected stdio
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
 winsup/testsuite/winsup.api/console-mode.c | 66 ++++++++++++++++++++++
 2 files changed, 67 insertions(+)
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
index 000000000..08537de92
--- /dev/null
+++ b/winsup/testsuite/winsup.api/console-mode.c
@@ -0,0 +1,66 @@
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
+  assert (getenv ("cygrun"));
+  /* cygrun starts the child without Cygwin's spawn bookkeeping. */
+  for (int i = 0; i < 2; ++i)
+    assert (spawnv (_P_WAIT, getenv ("cygrun"), arguments) == 0);
+  assert (GetConsoleMode (output, &mode));
+  return !(mode & ENABLE_PROCESSED_OUTPUT);
+}
-- 
cygwingitgadget
