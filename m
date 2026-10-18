Return-Path: <SRS0=ISKq=II=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-dl1-x122b.google.com (mail-dl1-x122b.google.com [IPv6:2607:f8b0:4864:20::122b])
	by sourceware.org (Postfix) with ESMTPS id 90A5D4BA2E25
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 15:07:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 90A5D4BA2E25
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 90A5D4BA2E25
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::122b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792336073; cv=none;
	b=R/KYDgwkzuS/OeKoHDvXIykD+5d0M9TAX/NvF1kkNHKwZVAUrrDh/SVDMXuyDGu/O+K74u1OVRgTp0Rqo+M88m9nR8Wv6WnK0bqkh2NbnzFDbyKq+Fvyva1BqiiX0CCZ9RJNZfT8udXEFxHj25Pffy0vmI9iPD48DN1B0xyyfOg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792336073; c=relaxed/simple;
	bh=ePt1Vb9gcrB/moA8whD0o2mNroNcx3DcQgCm6JkaQy4=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=FOwbjF9Y3GRg/r9P5Epe0M9B1USOhVtoZLdYC3CbGjdwk+6AABz2H6YtgSapSdnbebad7qGsocTMbABMYE/q3/JLZ0ZCpBB1gvYSXZ6XSH+TpG0axVaKYZhtfPb7LOngAM71vO/8bFInFS/sXFCeJH9Lfp+saPh46IS8sk0IF5Q=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MkLXwZRj
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 90A5D4BA2E25
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MkLXwZRj
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-15354aa70e8so1049674c88.1
        for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 08:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792336072; x=1792940872; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q5TtlbgEHIMB/DLbSa8s0zYg+0LxtN45ejto3Bvx0tQ=;
        b=MkLXwZRjfSDHTaYwv0rKBsfP6ZyXwYn+U4bL86DolRNmvSn59TuNmpjVDwWCl64g2C
         JIGvxxddV4WuY7x6lcK5ulf0cOnUn/ctLV5DUfniOsCLLHD8Jz//JQO8u/AcRUvrfxqa
         i4j47eY0rsRaGLc70qLO3d+QFwS8SksD870yFXvybyXybOHBm8fgo7X/2nnhnKvyH1ea
         Vjroc2mq6skRO3/Q/SRAF66lk6L32ZPczTxORhOtxJLkOx7B5zpoln5NUHrmXYlqW+pV
         puCaedGwaHTkiM9V7ux+YIj3d0HQFC3J6AgsfQdKlphhr2cVOMbcdjEwopLVk4byENPT
         vghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792336072; x=1792940872;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q5TtlbgEHIMB/DLbSa8s0zYg+0LxtN45ejto3Bvx0tQ=;
        b=typ6pw4nHuaWex5NyGufjWbaks2OSd8P10RtUDdEg0ZOAckJZvSyVcFBIqjKavtzvS
         h5W2L1dVpmjUYI2vS0U3WmdmC/nsp6dfxFtyzpKdWrJw+uy0c3eiUt66sfT9GBSQ/T/R
         F0KAp9MS9fTsUeSooxlIlKCZUCP1F5ZbGCyzmH9OSL7WX4wTWGcxeIi1V9dTSYr2bAEb
         AffRxNSsg2go5H1U8zx2Aa9sVoKcSzhpJ+XH5vUb/XFdjGPnNHFxihEQqL/EwT0/uxD1
         4DmciFduq2pAMm5XHVXokfEUWFzUt1qnPiDgi39JZbqSOxjPi3TGeATUkM6aIhZwGNGr
         KRaA==
X-Gm-Message-State: AFq9FYKrpdAIknz7BX0K12CLQm1C5ShyhvMyWH5g+Y9H6IE3k0Fotkw+
	4V2DQzaOpA4aNQSAjh6BhjZoqtl65VK74ZA2mR452eDKAwKWQOsM6ip9zwBXSkzI
X-Gm-Gg: AYBFou15yAYwP+GMJ/Xpx6EZKmulzNBOjVM/xQ4zilhXoRqgyB/te2LG66oYgFIwEdM
	x6rYVHdJMWVS4iLKmo2zUMBy2GZMnI5gEM/PMbBny6Ic/ZCXiucCSwH9VvEwk5X7xEIwCEGD5qO
	j80Ftgn2Yli8uLVhiHKYK1NHeJ1qd3cYer1VzczWrKy3Re0x8xGFQos4WBdtVBbdtsIkTn+4NxD
	TUFHJIDLHtU+33+W0L6dFT81OYJC/2CHP6+qRvNDbcCkiflG3mi1gPjvRqgsqahY1OVbNK5EuFh
	advVmEUQ0S2erZdRPB0fGrSEkhC83vXXh03rPvpxRO6+iXiuVCVpwiD0yTc0XcvEcB18/4S/yQ4
	rXS2+XzDOSJgJEMvw2mq7clOhXx93WGWn+b2QXfhLR7YNrkO0hTDVTVLGTx5zSWpj+z0LtpZa0a
	n62C830n1OQrDGeQZcucsLC72DnazCDMoyLJS9pIjGYBOR4ui0aNe6Jc5PvmN0MaJhNQPeHOu5g
	Q==
X-Received: by 2002:a05:701b:2906:b0:141:4a06:ad6f with SMTP id a92af1059eb24-1851238b5f2mr7979919c88.8.1792336072358;
        Sun, 18 Oct 2026 08:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.203.60])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa7bbsm21211014c88.5.2026.10.18.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 08:07:51 -0700 (PDT)
Message-Id: <cceb823afd2815120d9d853c1de25a5a4a15b651.1792336066.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
References: <pull.10.v2.cygwin.1792050298.gitgitgadget@gmail.com>
	<pull.10.v3.cygwin.1792336066.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 18 Oct 2026 15:07:43 +0000
Subject: [PATCH v3 3/6] Cygwin: testsuite: cover foreground PTY input recovery
 after exec
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

