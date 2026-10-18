Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dy1-x132b.google.com (mail-dy1-x132b.google.com [IPv6:2607:f8b0:4864:20::132b])
	by sourceware.org (Postfix) with ESMTPS id 3BBF24BA23CA
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:07:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3BBF24BA23CA
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3BBF24BA23CA
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::132b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336077; cv=none;
	b=TB+R7H9OzxozHNhWjaa0YJKul1FmTJrc+lNEqtvPajErP11p5CEObGrmdlIl3bBgo/nOD4dwiJZ9NiDUAVh5l2xDBTDiPOxrsOK/ymTf84kH0vxSADkO4TAq3ya3qDfeZGP2run4nHeT5Q3qVPUNHThl7Rc3V9UgF/wR5TVOg54=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336077; c=relaxed/simple;
	bh=q3ABOwcjArNoQ9OxwM74bssktvKBc2+1eXaxptHc/s8=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=AlgkMW4XGQnevjl/q4ivpeLf/i+WFiMOIMK+cYT/Cpo+Yr0BvrQrYk4445JxVie7tLHHJyNfP5R0HieTZe6jbYJeLdzIRo3And94tjmBNHBQLpb/1D3jN3K1Z2sm8nrWCMJok1WcpohLLUeyklwPOy0eA1RfwpT88FT5eBllv38=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gew6LVWG
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3BBF24BA23CA
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=gew6LVWG
Received: by mail-dy1-x132b.google.com with SMTP id 5a478bee46e88-35c76e9614aso2479843eec.0
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336076; x=1792940876; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5x+pvgLSg0u0jWTRy8d1UCqNLl36wn/cRIVG9kx2rFk=;
        b=gew6LVWGr0kHiAj0MS6QxOT0eIIzthN1csWqAP/PotmMO9bnrCwWWAYq/p0fVSPYVl
         qiJNbn8MxrqrwEunAugUID61CAtKU13pXfv3BcsoepV5rG2zyaTgzaRDKiN2jLYi/4JR
         Ebm0GphUHSDZoM/O6H9moUTmWyXIEvmKx3WrI6mpKIclzb6FvzGW6dG336gD/Mp6UFId
         UnG2vZqtEeDHrjXSNs5dpRAZU6vJ73U9OOxowHSpv+cRX36JRP21hnwZEpX4SlbMaXdL
         56Jo8wcLZR8qHrQWPtKGfGrNjdlk6L706irmNUq27PduCaOguYaIaR/RquWvTwT5IJtY
         /1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336076; x=1792940876;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5x+pvgLSg0u0jWTRy8d1UCqNLl36wn/cRIVG9kx2rFk=;
        b=h1h976JPCsU++Tw7C6vRZdt9IJ4K/FLuhT7nU7p1qRTWKSgYP0ICrqOiIKRGnYLFcS
         mB/uXhw/01T4SAVcDgP3JPbVK7hJqN55sPvJ5jw4kF+BL2eoE0oh5iQ7QuqhW8BOOH60
         klQhl5OFlgclVswiw+IQ1H7Utcu09O3KjQoBjFQt3yQRRE+959oXC34Fup0xMzKhFfI3
         /lCG80X0VCcgmFnrt9LLFSUl0JJBLo0Q2/FqNLLqrAHPwNWPdCxDeIO+M4OGwCEkgxzp
         MmSYLHIgdJPLTpmWrPMYniloJW2/Py8v++HmJp+5fCUZq+C9yS1hZ0UPr/t83KCUm1IW
         aAkQ==
X-Gm-Message-State: AFq9FYKJL7iJU4AHGcAIoUYx5CsuaJDCEmg6r/y+jZwDM+mDoQBnx/So
	cVmuJPJ1ZpaRz4M8EL6FIeTwBCH/HwQBMocPVxQjrlSX57jXviAl72ojdkheABlD
X-Gm-Gg: AYBFou04iaR34Yl2eSPsM+X4tv7uiTC5aipd/QpjLI+ZcklW2MwdNYvvxsk76nS6rBv
	PVSz9Ln1CNtBt09CTZTv53FAU9ahkJrvCeOjwuKSxUI24ksL/Gs3EEIogQWRfyrUpwBwEAy4BHy
	jyS/tzoN0zBYV+j59QrkxEuwLwtnCdzT5nme46DusqsXBRQnmQQQC+beO/9ccO1zY20RhBEI4F9
	PAM+Wld3bKz3yDRinv49YWUYasEIaIpvKE2nz/nYBj9klUoaSt3R1Euv5L711QS9ydsHTtwHfXC
	zxy9uf2+uauKo/w+eMkRxcN81g7glTIY1BKonmU5QSDoWJkCY07QXbVzKvuDEiZYWygEGfmC+Wx
	lIZ7zBb80f4vlR3h4Lb71QZ1K/O20rOdcTC8o54soIRr3EjMAYRR+1NKvsMAB/ZnwV/ef9x1fxG
	dWHxdxMjcptGVPGj4CxiRB52pz7xDYblV3OHaEeM/g/U2MVBuJ8tPoDMhJpIizHJ+wrUS3mc35z
	w==
X-Received: by 2002:a05:7301:70f:b0:351:68e8:4646 with SMTP id 5a478bee46e88-361a2d387a5mr7004328eec.37.1792336075936;
        Sun, 18 Oct 2026 08:07:55 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36082a7b33bsm45036720eec.24.2026.10.18.08.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:07:55 -0700 (PDT)
Message-Id: <cdd3d9ce996397b37a41c8baa861f47ee9c4c4b6.1792336066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:07:45 +0000
Subject: [PATCH v3 5/6] Cygwin: testsuite: cover PTY input recovery with a
 native parent
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

The existing test exercises a foreground Cygwin `exec()` with a native
background process, but not a Cygwin child launched by a native program
without Cygwin startup metadata. Therefore, let's also make that case
mandatory in the registered test to catch regressions in either handoff.

The child must query the terminal before its first read, which would
otherwise recover input and conceal the missing startup handoff. Only
`stdin` may be a PTY: setting up `stdout` on the same PTY later could
perform the handover `stdin` missed. An ordinary pipe for `stdout` and
`stderr` keeps this case focused on recovery for inherited PTY input.

Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/testsuite/mingw/pty-native-input.c     | 73 ++++++++++++++-
 .../winsup.api/pty-background-native.c        | 88 ++++++++++++++-----
 2 files changed, 135 insertions(+), 26 deletions(-)

diff --git a/winsup/testsuite/mingw/pty-native-input.c b/winsup/testsuite/mingw/pty-native-input.c
index 688e87482..542badf0a 100644
--- a/winsup/testsuite/mingw/pty-native-input.c
+++ b/winsup/testsuite/mingw/pty-native-input.c
@@ -2,13 +2,80 @@
 #include <windows.h>
 
 int
-main (void)
+main (int argc, char **argv)
 {
+  SECURITY_ATTRIBUTES sa = { sizeof sa, NULL, TRUE };
   HANDLE input = CreateFileA ("CONIN$", GENERIC_READ,
-			     FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
+			     FILE_SHARE_READ | FILE_SHARE_WRITE, &sa,
 			     OPEN_EXISTING, 0, NULL);
   DWORD mode, written;
-  if (input == INVALID_HANDLE_VALUE || !GetConsoleMode (input, &mode)
+  if (input == INVALID_HANDLE_VALUE || !GetConsoleMode (input, &mode))
+    {
+      fprintf (stderr, "Native console readiness failed: %lu\n",
+	       GetLastError ());
+      return 1;
+    }
+  if (argc == 3)
+    {
+      /* Emulate native Git launching a Cygwin editor. */
+      STARTUPINFOA si = { 0 };
+      PROCESS_INFORMATION pi;
+      HANDLE output, child_pipe;
+      si.cb = sizeof si;
+      si.dwFlags = STARTF_USESTDHANDLES;
+      if (sscanf (argv[2], "%p,%p", &si.hStdInput, &output) != 2)
+	{
+	  fprintf (stderr, "Invalid inherited terminal handles\n");
+	  return 1;
+	}
+      /* Only stdin is a PTY; stdout must not mask a missed input handoff. */
+      if (!CreatePipe (&child_pipe, &si.hStdOutput, &sa, 0)
+	  || !SetHandleInformation (child_pipe, HANDLE_FLAG_INHERIT, 0))
+	{
+	  fprintf (stderr, "Cannot create child output pipe: %lu\n",
+		   GetLastError ());
+	  return 1;
+	}
+      si.hStdError = si.hStdOutput;
+      if (!CreateProcessA (NULL, argv[1], NULL, NULL, TRUE, 0,
+			   NULL, NULL, &si, &pi))
+	{
+	  fprintf (stderr, "Cannot launch Cygwin editor: %lu\n",
+		   GetLastError ());
+	  return 1;
+	}
+      CloseHandle (si.hStdOutput);
+      /* Forward Vim's queries to MinTTY without another Cygwin PTY fd. */
+      char buf[128];
+      DWORD n;
+      while (ReadFile (child_pipe, buf, sizeof buf, &n, NULL))
+	if (!WriteFile (output, buf, n, &written, NULL) || written != n)
+	  {
+	    fprintf (stderr, "Cannot forward child output: %lu\n",
+		     GetLastError ());
+	    return 1;
+	  }
+      if (GetLastError () != ERROR_BROKEN_PIPE)
+	{
+	  fprintf (stderr, "Cannot read child output: %lu\n",
+		   GetLastError ());
+	  return 1;
+	}
+      CloseHandle (child_pipe);
+      DWORD status;
+      if (WaitForSingleObject (pi.hProcess, 8000) != WAIT_OBJECT_0
+	  || !GetExitCodeProcess (pi.hProcess, &status))
+	{
+	  fprintf (stderr, "Cygwin editor did not finish\n");
+	  return 1;
+	}
+      if (status)
+	fprintf (stderr, "Cygwin editor exit status: %lu\n", status);
+      CloseHandle (pi.hProcess);
+      CloseHandle (pi.hThread);
+      return status;
+    }
+  if (argc != 1
       || !WriteFile (GetStdHandle (STD_OUTPUT_HANDLE), "R", 1, &written, NULL)
       || written != 1)
     {
diff --git a/winsup/testsuite/winsup.api/pty-background-native.c b/winsup/testsuite/winsup.api/pty-background-native.c
index e4128b54a..f1c55bff9 100644
--- a/winsup/testsuite/winsup.api/pty-background-native.c
+++ b/winsup/testsuite/winsup.api/pty-background-native.c
@@ -62,6 +62,7 @@ terminal (int master, pid_t child)
   close (master);
   if (!WIFEXITED (status) || WEXITSTATUS (status))
     {
+      fprintf (stderr, "Terminal child status: %d\n", status);
       fwrite (window, 1, used, stderr);
       return 1;
     }
@@ -73,8 +74,8 @@ static int
 worker (pid_t native)
 {
   struct termios raw;
-  assert (tcgetpgrp (0) == getpgrp () && getpgid (native) == native
-	 && native != getpgrp ());
+  assert (tcgetpgrp (0) == getpgrp ());
+  assert (!native || (getpgid (native) == native && native != getpgrp ()));
   assert (!tcgetattr (0, &raw));
   raw.c_lflag &= ~(ICANON | ECHO);
   raw.c_cc[VMIN] = 0;
@@ -99,31 +100,22 @@ worker (pid_t native)
 	       || memcmp (buf, replies[0].reply, used);
   /* Misrouted reports can become keystrokes that edit Vim's first line. */
   if (result)
-    fprintf (stderr, "Bad terminal reply (%zu bytes)\n", used);
+    {
+      fprintf (stderr, "Bad terminal reply (%zu bytes):", used);
+      for (size_t i = 0; i < used; i++)
+	fprintf (stderr, " %02x", (unsigned char) buf[i]);
+      fputc ('\n', stderr);
+    }
   int status;
-  assert (waitpid (native, &status, 0) == native
-	 && WIFEXITED (status) && !WEXITSTATUS (status));
+  if (native)
+    assert (waitpid (native, &status, 0) == native
+	    && WIFEXITED (status) && !WEXITSTATUS (status));
   return result ? 1 : 0;
 }
 
-int
-main (int argc, char **argv)
+static int
+run_case (const char *program, int native_parent)
 {
-  if (argc == 3 && !strcmp (argv[1], "worker"))
-    {
-      int pid;
-      char extra;
-      assert (sscanf (argv[2], "%d%c", &pid, &extra) == 1 && pid > 0);
-      return worker (pid);
-    }
-  assert (argc == 1);
-  if (!GetProcAddress (GetModuleHandleW (L"kernel32.dll"),
-		      "CreatePseudoConsole"))
-    {
-      fprintf (stderr, "ConPTY unavailable\n");
-      return 77;
-    }
-  assert (!setenv ("TERM", "xterm", 1));
   struct winsize size = { 24, 80, 0, 0 };
   int master;
   pid_t child = forkpty (&master, NULL, NULL, &size);
@@ -131,6 +123,27 @@ main (int argc, char **argv)
   if (child)
     return terminal (master, child);
 
+  if (native_parent)
+    {
+      char path[MAX_PATH], command[MAX_PATH + 32], handles[64];
+      DWORD length = GetModuleFileNameA (NULL, path, sizeof path);
+      assert (length && length < sizeof path);
+      snprintf (command, sizeof command, "\"%s\" worker 0", path);
+      HANDLE input, output;
+      /* Preserve the terminal handles across the native Git process. */
+      assert (DuplicateHandle (GetCurrentProcess (),
+			       GetStdHandle (STD_INPUT_HANDLE),
+			       GetCurrentProcess (), &input,
+			       0, TRUE, DUPLICATE_SAME_ACCESS));
+      assert (DuplicateHandle (GetCurrentProcess (),
+			       GetStdHandle (STD_OUTPUT_HANDLE),
+			       GetCurrentProcess (), &output,
+			       0, TRUE, DUPLICATE_SAME_ACCESS));
+      snprintf (handles, sizeof handles, "%p,%p", input, output);
+      assert (execl ("/bin/pty-native-input.exe", "pty-native-input",
+		     command, handles, (char *) NULL) != -1);
+    }
+
   int ready[2];
   assert (!pipe (ready));
   pid_t native = fork ();
@@ -151,5 +164,34 @@ main (int argc, char **argv)
   assert (!setpgid (native, native));
   char pid[24];
   snprintf (pid, sizeof pid, "%ld", (long) native);
-  assert (execl (argv[0], argv[0], "worker", pid, (char *) NULL) != -1);
+  assert (execl (program, program, "worker", pid, (char *) NULL) != -1);
+  return 1;
+}
+
+int
+main (int argc, char **argv)
+{
+  if (argc == 3 && !strcmp (argv[1], "worker"))
+    {
+      int pid;
+      char extra;
+      assert (sscanf (argv[2], "%d%c", &pid, &extra) == 1 && pid >= 0);
+      return worker (pid);
+    }
+  assert (argc == 1
+	  || (argc == 2 && !strcmp (argv[1], "native-parent")));
+  if (!GetProcAddress (GetModuleHandleW (L"kernel32.dll"),
+		      "CreatePseudoConsole"))
+    {
+      fprintf (stderr, "ConPTY unavailable\n");
+      return 77;
+    }
+  assert (!setenv ("TERM", "xterm", 1));
+  if (argc == 2)
+    return run_case (argv[0], 1);
+  if (run_case (argv[0], 0))
+    return 1;
+  /* Keep the terminal-emulator state independent between scenarios. */
+  assert (execl (argv[0], argv[0], "native-parent", (char *) NULL) != -1);
+  return 1;
 }
-- 
cygwingitgadget

