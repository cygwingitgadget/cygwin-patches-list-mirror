Return-Path: <SRS0=koVj=IF=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
	by sourceware.org (Postfix) with ESMTPS id C7E344BA2E37
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 07:45:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C7E344BA2E37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C7E344BA2E37
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::32f
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792050310; cv=none;
	b=bU1yJ5AxyVjcKJ8gbfGvqrCUJWTxZLTXdmR1f5hQegPmah0bHjXEuaycMu+xVhb9DtzNAxzKAAyRUtUyO+VKLl9no6V77pQy2xTym7P/AGhJExRKLEzOYQW4kEob80UnDr8INuKv4tXjB7gIPpGhDGphReOE6Fr+kZjaSMDzIhs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792050310; c=relaxed/simple;
	bh=ePt1Vb9gcrB/moA8whD0o2mNroNcx3DcQgCm6JkaQy4=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=SWm7DMFa1YjiIW6Esuf3HMfA8wtMpr8m9gmr+dmmE7vMbOELcyUZbvwkkBdpVebZVSCCoXECq1oDclAuvJsikdctsi2g3BosTeiHHsMhuIffA9DD+DBcZZkgVdRlWCaoBkgOm1wDQqERaISE8j5fjGZLAeOW5LMqgXiPIfI8zuc=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PduhuhzM
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C7E344BA2E37
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PduhuhzM
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-82374c2d7aeso3174553a34.1
        for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 00:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792050310; x=1792655110; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q5TtlbgEHIMB/DLbSa8s0zYg+0LxtN45ejto3Bvx0tQ=;
        b=PduhuhzMXB+yab5QyumIABqmPFNWvoo6nlNamMpFrLRuMzx40gP20wZPcKDmr+iOoa
         1r8niWxNJtv2OY2tMI/UzSBLN8lk3VFU1Pj+qAfRizgrltIHzRMR/29/Tc6cZeVZqPUy
         JPAC2+Wrun9skDRb9PWkDC3VowF5ckubRQcfFt8B/J5Xy0Dzl7kfwhghmx4DZSiQ627i
         cVU9QBp4kPs2NP4DqmC6XZy8PXmgLjJ1wAG/ZbmpodFck0pgBl0mVKf/Vv0b5UdR+ixy
         9oNEJJtP2TvK4qD32eTQeSRNGtUq1xLioEY+b4W9AIG6p5uTPoX9AJAAiA1o5/THRapS
         I7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792050310; x=1792655110;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5TtlbgEHIMB/DLbSa8s0zYg+0LxtN45ejto3Bvx0tQ=;
        b=FA/OjIqoGqz+L4OsrjzF1JNxAIgSGF+hBCMxoGpUd/BB38HRSbQ/cNwJDPmkihAz9U
         55segZix1gSWYIWIkqx3AranTHcM7fKfj8w4Su+N6qLr/9PS6ot3e2vWQDXsj0tcmwph
         WLZXQmPECPi1wI96UWB+iKlxPMeUsvTVkF5/ei9kriK/ElG6r0kFP30cTADTia5yDhcU
         Dtd45INMzIE4VjqS0WelAFi3xS8e8UESmhZ/Dm59OQ/cIr199Yo+jeV8s4SqbHSGmf7U
         YzoFCNbQSb8m+USs7DCzZOujowfaOV3i8ZKNUlly2XBcQ2Ojk0wiHUywMstfvY6fldbp
         IlPw==
X-Gm-Message-State: AFq9FYIKCp5pD6ItxgybLbg8JDn6o5EUWdInkdUA5KBAZ4YxW0fMOtyC
	4F8YVYxwRBbUlkDQNeXiySY10ibX+0OolvA2ihNietOyTvp4dFvk78hJHA31gGlkcvI=
X-Gm-Gg: AYBFou1hAntMpddY6Rcz5qIy1LIhbbbkB+OdUsWE+etr9cMVHV24xYP9cpARj/seR+/
	ky/LIGOmrgfxQbx6JQuhufXptAPvPSMYmcwKF9MEs+gxEgwDDTMz2MpJtSysA8hdPH+BjvEiTMG
	cx8qL5pWA9y0lVXcmHyX7PMoBrPTbLiOMUHhCIMKhok+eObzsQS/WhyZLX91YxyonRmVz6g553r
	rsMNzarJiirtcf4LVD2vfXzAnOzsZfq9xA3Ih+oC0367N2l6XVgVMR6/29iGjkz7+cwqoBDQbsG
	AnayP7A5qZ54PFJIbnwAVg1GHrZVFf7Nxb97camZ8fHCBGBpojzUH9WXjRS2R/eqdFpdJTvt6VY
	G3rujxsKWWrHuHocS8Fdf5OF+zAzJdzGzJzvr7nGxAhJB67JYIzk9MtPcihhCRMN5DjAq+E5UXc
	bppI/SsMkj4lrB6m0TgKhDDi8sBwXc+SkZ5WxqYk4jYrFXSCXQDSzocGyf4gmBbD9Vkmps1MK1r
	mY=
X-Received: by 2002:a05:6830:3366:b0:81e:375d:3963 with SMTP id 46e09a7af769-83028c5912cmr10921962a34.18.1792050309915;
        Thu, 15 Oct 2026 00:45:09 -0700 (PDT)
Received: from [127.0.0.1] ([52.176.123.176])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83bf78d27a1sm5121513a34.15.2026.10.15.00.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 00:45:08 -0700 (PDT)
Message-Id: <92d13761feba33e0f560ed8c87481068e728080c.1792050298.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
References: <pull.10.cygwin.1789302605264.gitgitgadget@gmail.com>
	<pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 15 Oct 2026 07:44:56 +0000
Subject: [PATCH v2 3/5] Cygwin: testsuite: cover foreground PTY input recovery
 after exec
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Terminal replies arriving after a foreground Cygwin `exec()`, but before
its first read, must reach that process rather than remain on the native
input path. This was broken, with the symptom that a `vim.exe` started
from a native Console program could inadvertently cause input
corruption, and this was just fixed. Let's try to verify that this stays
fixed in the test suite.

An actual Cygwin `exec()` and a native background process are needed to
exercise the routing transition responsible for this failure. Checking
only replies sent after reading begins would miss the pre-read case.

Assisted-by: GPT-6.1
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/testsuite/.gitattributes               |   1 +
 winsup/testsuite/Makefile.am                  |  27 +++
 winsup/testsuite/mingw/Makefile.am            |   5 +-
 winsup/testsuite/mingw/pty-native-input.c     |  22 +++
 .../winsup.api/pty-background-native.c        | 155 ++++++++++++++++++
 5 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 winsup/testsuite/.gitattributes
 create mode 100644 winsup/testsuite/mingw/pty-native-input.c
 create mode 100644 winsup/testsuite/winsup.api/pty-background-native.c

diff --git a/winsup/testsuite/.gitattributes b/winsup/testsuite/.gitattributes
new file mode 100644
index 000000000..6313b56c5
--- /dev/null
+++ b/winsup/testsuite/.gitattributes
@@ -0,0 +1 @@
+* text=auto eol=lf
diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 8f2967a6d..b2b0e0b41 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -378,4 +378,31 @@ clean-local:
 
 if CROSS_BOOTSTRAP
 SUBDIRS = mingw
+check_PROGRAMS += testinst/bin/pty-background-native
+testinst_bin_pty_background_native_SOURCES = \
+	winsup.api/pty-background-native.c
+
+testinst_bin_pty_background_native_DEPENDENCIES = \
+	$(filter-out -%,$(LDADD)) \
+	testinst/bin/pty-native-input$(EXEEXT) \
+	testinst/bin/cygwin-console-helper$(EXEEXT) \
+	testinst/usr/share/terminfo/78/xterm
+
+testinst/usr/share/terminfo/78/xterm: /usr/share/terminfo/78/xterm
+	$(MKDIR_P) $(dir $@)
+	$(INSTALL_DATA) $< $@
+
+testinst/bin/pty-native-input$(EXEEXT): mingw/pty-native-input$(EXEEXT)
+	$(INSTALL_PROGRAM) $< $@
+
+testinst/bin/cygwin-console-helper$(EXEEXT): \
+	../utils/mingw/cygwin-console-helper$(EXEEXT)
+	$(INSTALL_PROGRAM) $< $@
+
+mingw/pty-native-input$(EXEEXT): $(srcdir)/mingw/pty-native-input.c
+	$(MAKE) -C mingw pty-native-input$(EXEEXT)
+
+../utils/mingw/cygwin-console-helper$(EXEEXT): \
+	$(top_srcdir)/utils/mingw/cygwin-console-helper.cc
+	$(MAKE) -C ../utils/mingw cygwin-console-helper$(EXEEXT)
 endif
diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/mingw/Makefile.am
index 772e73405..4e6b2fc68 100644
--- a/winsup/testsuite/mingw/Makefile.am
+++ b/winsup/testsuite/mingw/Makefile.am
@@ -16,7 +16,7 @@ override CC = @MINGW_CC@
 override CXX = @MINGW_CXX@
 AM_CPPFLAGS =
 
-noinst_PROGRAMS = cygrun cygload
+noinst_PROGRAMS = cygrun cygload pty-native-input
 
 cygrun_SOURCES = \
 	../cygrun.c
@@ -24,3 +24,6 @@ cygrun_SOURCES = \
 cygload_SOURCES = \
 	../winsup.api/cygload.cc
 cygload_LDFLAGS=-static -Wl,-e,cygloadCRTStartup
+
+pty_native_input_SOURCES = \
+	pty-native-input.c
diff --git a/winsup/testsuite/mingw/pty-native-input.c b/winsup/testsuite/mingw/pty-native-input.c
new file mode 100644
index 000000000..688e87482
--- /dev/null
+++ b/winsup/testsuite/mingw/pty-native-input.c
@@ -0,0 +1,22 @@
+#include <stdio.h>
+#include <windows.h>
+
+int
+main (void)
+{
+  HANDLE input = CreateFileA ("CONIN$", GENERIC_READ,
+			     FILE_SHARE_READ | FILE_SHARE_WRITE, NULL,
+			     OPEN_EXISTING, 0, NULL);
+  DWORD mode, written;
+  if (input == INVALID_HANDLE_VALUE || !GetConsoleMode (input, &mode)
+      || !WriteFile (GetStdHandle (STD_OUTPUT_HANDLE), "R", 1, &written, NULL)
+      || written != 1)
+    {
+      fprintf (stderr, "Native console readiness failed: %lu\n",
+	       GetLastError ());
+      return 1;
+    }
+  /* Keep native console input active during the foreground Vim startup. */
+  Sleep (4000);
+  return 0;
+}
diff --git a/winsup/testsuite/winsup.api/pty-background-native.c b/winsup/testsuite/winsup.api/pty-background-native.c
new file mode 100644
index 000000000..e4128b54a
--- /dev/null
+++ b/winsup/testsuite/winsup.api/pty-background-native.c
@@ -0,0 +1,155 @@
+#include <assert.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <windows.h>
+
+#include <errno.h>
+#include <poll.h>
+#include <pty.h>
+#include <sys/wait.h>
+#include <termios.h>
+#include <unistd.h>
+
+static const struct
+{
+  const char *query, *reply;
+} replies[] = {
+  { "\033[6n", "\033[1;1R" }
+};
+
+/* Emulate MinTTY answering terminal queries, not rendering a screen. */
+static int
+terminal (int master, pid_t child)
+{
+  char window[256];
+  size_t used = 0;
+  int status;
+  ULONGLONG deadline = GetTickCount64 () + 10000;
+  for (;;)
+    {
+      assert (GetTickCount64 () < deadline);
+      struct pollfd fd = { master, POLLIN, 0 };
+      int ready = poll (&fd, 1, 100);
+      assert (ready >= 0 || errno == EINTR);
+      if (ready > 0)
+	{
+	  char buf[128];
+	  ssize_t n = read (master, buf, sizeof buf);
+	  assert (n >= 0 || errno == EINTR || errno == EIO);
+	  for (ssize_t i = 0; i < n; i++)
+	    {
+	      if (used == sizeof window)
+		memmove (window, window + 1, --used);
+	      window[used++] = buf[i];
+	      for (size_t j = 0; j < sizeof replies / sizeof *replies; j++)
+		{
+		  size_t len = strlen (replies[j].query);
+		  assert (len && len <= sizeof window);
+		  if (used >= len
+		      && !memcmp (window + used - len, replies[j].query, len))
+		    assert (write (master, replies[j].reply,
+				  strlen (replies[j].reply))
+			   == (ssize_t) strlen (replies[j].reply));
+		}
+	    }
+	}
+      pid_t done = waitpid (child, &status, WNOHANG);
+      assert (done >= 0 || errno == EINTR);
+      if (done == child)
+	break;
+    }
+  close (master);
+  if (!WIFEXITED (status) || WEXITSTATUS (status))
+    {
+      fwrite (window, 1, used, stderr);
+      return 1;
+    }
+  return 0;
+}
+
+/* Emulate Vim entering raw mode and querying before its first input read. */
+static int
+worker (pid_t native)
+{
+  struct termios raw;
+  assert (tcgetpgrp (0) == getpgrp () && getpgid (native) == native
+	 && native != getpgrp ());
+  assert (!tcgetattr (0, &raw));
+  raw.c_lflag &= ~(ICANON | ECHO);
+  raw.c_cc[VMIN] = 0;
+  raw.c_cc[VTIME] = 1;
+  assert (!tcsetattr (0, TCSANOW, &raw));
+  assert (write (1, replies[0].query, strlen (replies[0].query))
+	 == (ssize_t) strlen (replies[0].query));
+  /* Emulate Vim's startup work while replies arrive before the first read. */
+  usleep (100000);
+  char buf[64];
+  size_t used = 0;
+  for (int i = 0; i < 30 && used < sizeof buf; i++)
+    {
+      ssize_t n = read (0, buf + used, sizeof buf - used);
+      assert (n >= 0 || errno == EINTR || errno == EAGAIN);
+      if (n > 0)
+	used += n;
+      if (memchr (buf, 'R', used))
+	break;
+    }
+  int result = used != strlen (replies[0].reply)
+	       || memcmp (buf, replies[0].reply, used);
+  /* Misrouted reports can become keystrokes that edit Vim's first line. */
+  if (result)
+    fprintf (stderr, "Bad terminal reply (%zu bytes)\n", used);
+  int status;
+  assert (waitpid (native, &status, 0) == native
+	 && WIFEXITED (status) && !WEXITSTATUS (status));
+  return result ? 1 : 0;
+}
+
+int
+main (int argc, char **argv)
+{
+  if (argc == 3 && !strcmp (argv[1], "worker"))
+    {
+      int pid;
+      char extra;
+      assert (sscanf (argv[2], "%d%c", &pid, &extra) == 1 && pid > 0);
+      return worker (pid);
+    }
+  assert (argc == 1);
+  if (!GetProcAddress (GetModuleHandleW (L"kernel32.dll"),
+		      "CreatePseudoConsole"))
+    {
+      fprintf (stderr, "ConPTY unavailable\n");
+      return 77;
+    }
+  assert (!setenv ("TERM", "xterm", 1));
+  struct winsize size = { 24, 80, 0, 0 };
+  int master;
+  pid_t child = forkpty (&master, NULL, NULL, &size);
+  assert (child >= 0);
+  if (child)
+    return terminal (master, child);
+
+  int ready[2];
+  assert (!pipe (ready));
+  pid_t native = fork ();
+  assert (native >= 0);
+  if (!native)
+    {
+      close (ready[0]);
+      assert (dup2 (ready[1], 1) == 1);
+      close (ready[1]);
+      assert (execl ("/bin/pty-native-input.exe", "pty-native-input",
+		    (char *) NULL) != -1);
+    }
+  close (ready[1]);
+  char byte;
+  assert (read (ready[0], &byte, 1) == 1 && byte == 'R');
+  close (ready[0]);
+  /* Emulate a native job remaining alive while foreground Vim starts. */
+  assert (!setpgid (native, native));
+  char pid[24];
+  snprintf (pid, sizeof pid, "%ld", (long) native);
+  assert (execl (argv[0], argv[0], "worker", pid, (char *) NULL) != -1);
+}
-- 
cygwingitgadget

