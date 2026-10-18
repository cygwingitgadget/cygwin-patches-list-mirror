Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x1333.google.com (mail-dy1-x1333.google.com [IPv6:2607:f8b0:4864:20::1333])
	by sourceware.org (Postfix) with ESMTPS id A810C4BA23C2
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:07:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A810C4BA23C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A810C4BA23C2
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::1333
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336078; cv=none;
	b=V4Y1lSSjOk9IdASTHUP4OUQjVz3CtyZgplVz9fvEKikQVHCGbHMDLWty588Db56AvGbsglzcUbz+kLwum6fA5+H11+7TBqv/Qw5cb2JM5ulzQEmsgYOkx+NtnCdd4nOU7OmetT/KJRLwxgnIFl+Eym8pPsYfHcM32D3Wmfucw70=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336078; c=relaxed/simple;
	bh=0K2Qb8AziI3VF+g0qquWkCwYfmimuxVzkOjlXsDi+V4=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=m9SF4y0pxbSlHBC8KRb00S6TYPExlZzYtG6OpRrHoehO7u886SkG0aDvqHDxpKcw8tUlVFiVmKWsZo+aGLKzIBpWugQtFlImT1Hb0LKLV+SLln1AwtgREfznSm2Hs50jgcWaQ+/d20f+nFHd7d/sGH8taVOmfP5J9uyP7Op2WTs=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bz0eXuXO
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A810C4BA23C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bz0eXuXO
Received: by mail-dy1-x1333.google.com with SMTP id 5a478bee46e88-35c76e9614aso2479910eec.0
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336078; x=1792940878; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=40cp+fzdjVGDzEURIY9KHv91ctUOlDhkBC97zcMK2f8=;
        b=bz0eXuXOr6+BjrpBI4DZBbg1I/MfMQ7LEH3Q15354xAnkzgYXwpoaylVPG+BISA8ja
         xLVPa7hpYgL7erqJAidViNU0NnMR6+0SAJvjBJ2s0t1iWVCN0w2kNEbvep8dgULXlVDM
         jZmYmovHCLW/QS1/BCH89yABEk03e8dVssOJlhhbUJ6r+sToZX45FZQEWibDIRjPKvmS
         +9OkejSjWMrZf6rKJye8JkJEUGNodUL4FucIQYJNBzSs3l4RcJH5xi5N04p+vzf1somv
         Ex07GGR8H/SL37FdYjSUh5ZthQMP0gcq/hhYUQ5c8+CqeDN4DNSZFrISTHOLONh5bHWy
         xR6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336078; x=1792940878;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=40cp+fzdjVGDzEURIY9KHv91ctUOlDhkBC97zcMK2f8=;
        b=f6sNqQgzvVH/5sZ/MXbiVdXu9GxjczyNsI3M2fY2NN474uddYFRWSmoiVgzXZFQC0d
         JGayTlPKCJ4P6eRGvArLxljRonB5IjDeIj1+p9WOM+Kq61oXUIhLNJJ1x4cTKYp4OKiJ
         4q+m8aZCeojdQjVRbstzAwXGhLwCorKbkSxIxag8EqguRQE9TxQvEBGxOzL/vjEmYj8j
         vrDLYV2C73asGAMZr/3mq4v0F8z35LVuMeYdqzcKtxeg1uWVzK9O6lsISIxK0Tc23ozE
         /EdMRnaRiTUqaqxlSWJX/OtA6j7LMRB8CiXJ1pveGt+UqWhFAMFAgVzijnQMw7QCcoJD
         bHgg==
X-Gm-Message-State: AFq9FYIgJ/mbqYhSPegB0HaDzFMuD08M0yyj4AnNE0gF856tkKWk/eY/
	MnYDAcQovn8sviEYSWssvJZRyKGTypjjaWdkljk1fZBJfua6C1BBUBytJSQ6aMP+
X-Gm-Gg: AYBFou0LSnpZ6fO9XJZCLATIIaFNqoMKZsNl5qJaFI9dA10r+sjVC6VME/x5YhOqNOO
	jV3KHJZUu5tMuKc+C8uP8VgJ6VTqKw3588mw//4foqtbvk69Bo2wh8BPOdwpdJyOztkygOv4hb+
	qFkgLwORxk9a+nOkKCS2oIYO8iwvNv8a00UNtL68DXdHkHE4PS1v5pL3lOVP7gyCRynOtFS4GdG
	tLx1dabGgSCREtKOgB63QCOvR96oMcfPer+oBSJmdD2C1tyx/5rwg7Bucxo9h9xNGMTZgM3ISV5
	rIRwebZtaUJUnwrnXyDuoNyUzUxatDMMyoINPWtQaeIaCFTSyonS3EOzS2O1WsICluff66BY5hT
	XAvcbdglZlFA8Wt36zwdQfSGXoy+UIexY1l3og0BtsIpUlMNMVMToGhHES3T9x/Ym3ozJ5Nw7T+
	vJCqCZA2FmwHgYjoS3NCODQgg8ppFU0OwJ13DktbOkYHYR4BWqByqgfq/9HOwUWYCozcTp+m1tl
	A==
X-Received: by 2002:a05:693c:60dc:b0:35f:a2ad:603 with SMTP id 5a478bee46e88-361a195d55dmr9067461eec.16.1792336077503;
        Sun, 18 Oct 2026 08:07:57 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3607ee0cab0sm30562341eec.3.2026.10.18.08.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:07:56 -0700 (PDT)
Message-Id: <4469693b51342e9527eb10366597cbc5de533b7b.1792336066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:07:46 +0000
Subject: [PATCH v3 6/6] Cygwin: testsuite: cover queued native input with pcon
 disabled
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

The existing PTY tests miss the loss of queued native-shell commands
during early handover with CYGWIN=disable_pcon. This was pointed out by
Takashi Yano in the review of the preceding patches, explaining in
https://inbox.sourceware.org/cygwin-patches/20261017152213.9394289b21159f4c56815788@nifty.ne.jp/
that the following should work:

  1. Run `env CYGWIN=disable_pcn script`
  2. Run `cmd`
  3. Run `sleep 10`
  4. Type ps<enter>ps<enter> while sleeping.
  The the second `ps` will not be executed in cmd.

A Cygwin child (in this instance, `sleep`) must leave the next command
available to its native parent (in this instance, `cmd`), not consume it
during initialization or `exec()` handoff.

Extend the registered pty-background-native test to protect both paths.
Having both commands pending before the first child starts makes the
regression deterministic, without arbitrary sleeps or external shell
dependencies. Since the child never reads terminal input, a missing
second command exposes unintended consumption by either handover path.

Suggested-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/testsuite/mingw/pty-native-input.c     | 82 +++++++++++++++++++
 .../winsup.api/pty-background-native.c        | 34 +++++++-
 2 files changed, 112 insertions(+), 4 deletions(-)

diff --git a/winsup/testsuite/mingw/pty-native-input.c b/winsup/testsuite/mingw/pty-native-input.c
index 542badf0a..ca75e1370 100644
--- a/winsup/testsuite/mingw/pty-native-input.c
+++ b/winsup/testsuite/mingw/pty-native-input.c
@@ -1,9 +1,91 @@
 #include <stdio.h>
 #include <windows.h>
 
+static int
+typeahead (char *command)
+{
+  HANDLE input = GetStdHandle (STD_INPUT_HANDLE);
+  const char ready[] = "TYPEAHEAD_READY";
+  DWORD n;
+  if (GetFileType (input) != FILE_TYPE_PIPE
+      || !WriteFile (GetStdHandle (STD_OUTPUT_HANDLE),
+		     ready, sizeof ready - 1, &n, NULL)
+      || n != sizeof ready - 1)
+    {
+      fprintf (stderr, "Typeahead pipe readiness failed: %lu\n",
+	       GetLastError ());
+      return 1;
+    }
+  /* Emulate cmd reading two queued commands and launching ps for each. */
+  for (int i = 0; i < 2; i++)
+    {
+      DWORD available;
+      ULONGLONG deadline = GetTickCount64 () + 3000;
+      do
+	{
+	  if (!PeekNamedPipe (input, NULL, 0, NULL, &available, NULL))
+	    {
+	      fprintf (stderr, "Cannot inspect queued input: %lu\n",
+		       GetLastError ());
+	      return 1;
+	    }
+	  if (GetTickCount64 () >= deadline)
+	    {
+	      fprintf (stderr, "Queued command %d did not reach native input\n",
+		       i + 1);
+	      return 1;
+	    }
+	  if (available < (i ? 2 : 4))
+	    Sleep (1);
+	}
+      while (available < (i ? 2 : 4));
+      char line[2];
+      if (!ReadFile (input, line, sizeof line, &n, NULL)
+	  || n != sizeof line || line[0] != '1' + i || line[1] != '\n')
+	{
+	  fprintf (stderr, "Cannot read queued command %d: %lu\n",
+		   i + 1, GetLastError ());
+	  return 1;
+	}
+      STARTUPINFOA si = { 0 };
+      PROCESS_INFORMATION pi;
+      si.cb = sizeof si;
+      si.dwFlags = STARTF_USESTDHANDLES;
+      si.hStdInput = input;
+      si.hStdOutput = GetStdHandle (STD_OUTPUT_HANDLE);
+      si.hStdError = GetStdHandle (STD_ERROR_HANDLE);
+      char child_command[MAX_PATH + 32];
+      int len = snprintf (child_command, sizeof child_command, "%s", command);
+      if (len < 0 || (size_t) len >= sizeof child_command)
+	{
+	  fprintf (stderr, "Typeahead child command is too long\n");
+	  return 1;
+	}
+      if (!CreateProcessA (NULL, child_command, NULL, NULL, TRUE, 0,
+			   NULL, NULL, &si, &pi))
+	{
+	  fprintf (stderr, "Cannot launch typeahead child: %lu\n",
+		   GetLastError ());
+	  return 1;
+	}
+      DWORD status;
+      if (WaitForSingleObject (pi.hProcess, 3000) != WAIT_OBJECT_0
+	  || !GetExitCodeProcess (pi.hProcess, &status) || status)
+	{
+	  fprintf (stderr, "Typeahead child did not finish successfully\n");
+	  return 1;
+	}
+      CloseHandle (pi.hProcess);
+      CloseHandle (pi.hThread);
+    }
+  return 0;
+}
+
 int
 main (int argc, char **argv)
 {
+  if (argc == 2)
+    return typeahead (argv[1]);
   SECURITY_ATTRIBUTES sa = { sizeof sa, NULL, TRUE };
   HANDLE input = CreateFileA ("CONIN$", GENERIC_READ,
 			     FILE_SHARE_READ | FILE_SHARE_WRITE, &sa,
diff --git a/winsup/testsuite/winsup.api/pty-background-native.c b/winsup/testsuite/winsup.api/pty-background-native.c
index f1c55bff9..2fd264833 100644
--- a/winsup/testsuite/winsup.api/pty-background-native.c
+++ b/winsup/testsuite/winsup.api/pty-background-native.c
@@ -15,7 +15,8 @@ static const struct
 {
   const char *query, *reply;
 } replies[] = {
-  { "\033[6n", "\033[1;1R" }
+  { "\033[6n", "\033[1;1R" },
+  { "TYPEAHEAD_READY", "1\n2\n" }
 };
 
 /* Emulate MinTTY answering terminal queries, not rendering a screen. */
@@ -128,7 +129,11 @@ run_case (const char *program, int native_parent)
       char path[MAX_PATH], command[MAX_PATH + 32], handles[64];
       DWORD length = GetModuleFileNameA (NULL, path, sizeof path);
       assert (length && length < sizeof path);
-      snprintf (command, sizeof command, "\"%s\" worker 0", path);
+      snprintf (command, sizeof command, "\"%s\" %s", path,
+		native_parent == 2 ? "typeahead-child" : "worker 0");
+      if (native_parent == 2)
+	assert (execl ("/bin/pty-native-input.exe", "pty-native-input",
+		       command, (char *) NULL) != -1);
       HANDLE input, output;
       /* Preserve the terminal handles across the native Git process. */
       assert (DuplicateHandle (GetCurrentProcess (),
@@ -171,6 +176,15 @@ run_case (const char *program, int native_parent)
 int
 main (int argc, char **argv)
 {
+  if (argc == 2 && !strcmp (argv[1], "typeahead-exit"))
+    return 0;
+  /* Exercise startup and exec without reading the next native command. */
+  if (argc == 2 && !strcmp (argv[1], "typeahead-child"))
+    {
+      assert (execl (argv[0], argv[0], "typeahead-exit",
+		     (char *) NULL) != -1);
+      return 1;
+    }
   if (argc == 3 && !strcmp (argv[1], "worker"))
     {
       int pid;
@@ -179,7 +193,8 @@ main (int argc, char **argv)
       return worker (pid);
     }
   assert (argc == 1
-	  || (argc == 2 && !strcmp (argv[1], "native-parent")));
+	  || (argc == 2 && (!strcmp (argv[1], "native-parent")
+			   || !strcmp (argv[1], "typeahead"))));
   if (!GetProcAddress (GetModuleHandleW (L"kernel32.dll"),
 		      "CreatePseudoConsole"))
     {
@@ -188,7 +203,18 @@ main (int argc, char **argv)
     }
   assert (!setenv ("TERM", "xterm", 1));
   if (argc == 2)
-    return run_case (argv[0], 1);
+    {
+      if (!strcmp (argv[1], "native-parent"))
+	{
+	  if (run_case (argv[0], 1))
+	    return 1;
+	  assert (execl (argv[0], argv[0], "typeahead",
+			 (char *) NULL) != -1);
+	  return 1;
+	}
+      assert (!setenv ("CYGWIN", "disable_pcon", 1));
+      return run_case (argv[0], 2);
+    }
   if (run_case (argv[0], 0))
     return 1;
   /* Keep the terminal-emulator state independent between scenarios. */
-- 
cygwingitgadget
