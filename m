Return-Path: <SRS0=WEyG=JR=gmail.com=gitgitgadget@sourceware.org>
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by sourceware.org (Postfix) with ESMTPS id DC9A64B0A6DD
	for <cygwin-patches@cygwin.com>; Sat, 28 Nov 2026 07:04:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC9A64B0A6DD
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DC9A64B0A6DD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::42b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795849469; cv=none;
	b=h9VOpaelm0CjMdbz2G2L+y6fIhcCXydyUiWUQ6RUxiOV+s0fUQxfnNc3TqeoR99DK028N+37eJBaf3VkrMmbMTubuxzlz87i7w1AVk0EUubGhkhtwtuEPZa4YCQO5qZxT9e0SzgCqF8a9tHmwNR9/4mroPLwgDQjKHn53HkSsSw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795849469; c=relaxed/simple;
	bh=ExnP/sEn1INiFJ5daGWAB4XiWxQCf9TouNUS1k3DY3c=;
	h=DKIM-Signature:Message-Id:From:Date:Subject:MIME-Version:To; b=ZFX78EcCvVgYLSoHkiTV9L0mnhBcQthCPX5ROcTLpTKKQCef8ZPoSmyinSbo2+1DRdgaJUwcfDA7I+EFhE4wgMUAYyGdNRpAPge/bQc14/8ZW/Omca4lJlfnepWq/9+UEMc/N5g8/Ijg4JhSpTH6HEq7/eRnjI8QF4woUJ1bQBU=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGDWQJPs
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DC9A64B0A6DD
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nGDWQJPs
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8b9c51097e2so3521267b3a.1
        for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 23:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795849468; x=1796454268; darn=cygwin.com;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uOy3AnzTQe4vuVN/P0RGhYzf2fknmme/xVSyEEwnwQc=;
        b=nGDWQJPs3xNHNc0JDq+G8+t6o4nxrbqRPxtldN5lMxn4t5QI407euON5F/uj5tZTST
         +G1g/2/jLBHMDqHw7kePQwAXCsG7jZZC5V82CrH8NfhJ4XFY9psgGPReKBo+56zw5DoD
         G1Qbkg80oBYhvgKN+iyMQOzjM22UUZuPPUfoMSLYd3CYwxUUXHCJE6YYcvKZnvVy37Sg
         xk1ukCT15s81CGbvUP/2fAgT4JZfXSpgw+q+ScnPOIPrcGgJ1zOC/URA9OIpv//N0JDy
         d3Ln805qDVQnxuRnTzigY4po/Ciy990Mzj+F6JPeuEYkuPKvaHxBrm3RERLQl7JEfhgv
         PBXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795849468; x=1796454268;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uOy3AnzTQe4vuVN/P0RGhYzf2fknmme/xVSyEEwnwQc=;
        b=pUkaN5q2maSbzemf5ET1A1nhuNnVXD+irYbKVDnv9hDZg6jyFLeFoqv32eKMF8jzM9
         q0P4ouQiR6jT7hbdjdKCZTVrAqTG5Pl4dhxkoFKubZwKVwkbFUYPR66t072SFNkXU55j
         f1B+JcpDyOKFzDATACp9NKGQsnY4JoityNI5qK+75W8fjkR+jbLSSiMRalxItQX3slr4
         a2N24t9WFZPwyqPSbCjvP3RqXOdY9dHV84NvWbP3XsLWH+xCYHoEBVsJMiKypOz0w24/
         Mq6K+VIhG3dwsK3qljX4yIoMG1mo4AoYn/lI2jc4eYp485aai6IFfSjppqeYRpPHylls
         s+Gg==
X-Gm-Message-State: APuU4Z9cMIh6A1YocgJEgsje3Xcj+ilB7UGxxoF7H/lniqGdQVFM/ven
	R6hrh/uH58mznVrbWe9ztM2l9BS5CcMgTDgcvqAV518vCbCflaaBEgD3qgkVwcTy
X-Gm-Gg: AZFdTZdiXrFcw9lr365nC/q0NxqAr+xMArUHkl9gTSUnF8vqS32q/q+cJoxPm3DnMcg
	1twrXSxWQXdo+SlkXw0BMwUcfL8kpgNnUOmLaGm4czdyIeD1FqgWJFafWpHPtrKZ62xF+Si0lVO
	WFQV750F5OppTRH/LX2fXfB4/HHQor5hDQhQ+I+mrq0kMu0+31SaIA/ihAHpxBdAeK4H0RC6pJ6
	gqXynPGUzOgrbB/hNU2wTkSTmWduWEsJSZKjamRIkUF9nUTbub+kuIEIzYYJjPqKlX8OsXrpkim
	VS5wN4H/+sjC7glBADxqZO+YscwPK11NyfySlI6mwrdvoXBcrrv7KlR3PS8eBJun3dRZuq2gXSZ
	Y0ibzMIkC72lD0FBCa28VeGixnzB27oA2zs+BzacuEwT2Z3ouByZ0mW6D+yiksEotx5DqB1RA96
	M8cF8gmMCxhWFQ9g4WN2trOOoiJNGytC8SlyMQwjR3dqRqaKco+VN2jizF/AugXl/2cVkQnqkDl
	q4LJB2v1W8DLIXd+38szQCYd69jdjUcLQQNOWosTczZpRW7LfCZG0/bbwuLylSCl2SeUSkPOUd1
	aCerUoZDk1J8n+roy8c4XNtWcRYgEIVDrQ==
X-Received: by 2002:a05:6a00:2e22:b0:880:4b56:dc2c with SMTP id d2e1a72fcca58-8c87c8630f9mr24488347b3a.34.1795849467761;
        Fri, 27 Nov 2026 23:04:27 -0800 (PST)
Received: from [127.0.0.1] ([128.85.44.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87077fe3fsm14228198b3a.4.2026.11.27.23.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 23:04:27 -0800 (PST)
Message-Id: <b703e8e9370871f9fdcf54ef6e3b8a78d76433b5.1795849462.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.19.cygwin.1795849462.gitgitgadget@gmail.com>
References: <pull.19.cygwin.1795849462.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 28 Nov 2026 07:04:22 +0000
Subject: [PATCH 2/2] Cygwin: testsuite: cover FIFO handle loss across fork
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

Closing an inherited FIFO reader must not invalidate unrelated child
handles. If the reader thread adds pipe handles after Windows captures
inheritable handles but before the child copies the client-handler list,
the copied values can alias events subsequently created in the child.

Keep the regression to 100 forks to fit the stock runner's 60-second
timeout.

Addresses: https://github.com/msys2/msys2-runtime/pull/402
Assisted-by: GPT-6.1 Sol
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 winsup/testsuite/Makefile.am            |   1 +
 winsup/testsuite/winsup.api/fifo-fork.c | 294 ++++++++++++++++++++++++
 2 files changed, 295 insertions(+)
 create mode 100644 winsup/testsuite/winsup.api/fifo-fork.c

diff --git a/winsup/testsuite/Makefile.am b/winsup/testsuite/Makefile.am
index 65320a8aa..cb956242e 100644
--- a/winsup/testsuite/Makefile.am
+++ b/winsup/testsuite/Makefile.am
@@ -36,6 +36,7 @@ check_PROGRAMS = \
 	winsup.api/crlf \
 	winsup.api/devdsp \
 	winsup.api/devzero \
+	winsup.api/fifo-fork \
 	winsup.api/iospeed \
 	winsup.api/mmaptest01 \
 	winsup.api/mmaptest02 \
diff --git a/winsup/testsuite/winsup.api/fifo-fork.c b/winsup/testsuite/winsup.api/fifo-fork.c
new file mode 100644
index 000000000..02c4b138d
--- /dev/null
+++ b/winsup/testsuite/winsup.api/fifo-fork.c
@@ -0,0 +1,294 @@
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/stat.h>
+#include <sys/utsname.h>
+#include <sys/wait.h>
+#include <unistd.h>
+#include <windows.h>
+
+enum { FORKS = 100, EVENTS = 1000 };
+
+static void
+win32_error (const char *operation)
+{
+  fprintf (stderr, "%s: Win32 error %lu\n", operation,
+	   (unsigned long) GetLastError ());
+}
+
+static pid_t
+wait_for (pid_t pid, int *status, int options)
+{
+  pid_t waited;
+
+  do
+    waited = waitpid (pid, status, options);
+  while (waited < 0 && errno == EINTR);
+  return waited;
+}
+
+static int
+drain_fifo (int fd)
+{
+  char buffer[4096];
+  ssize_t n;
+
+  do
+    n = read (fd, buffer, sizeof buffer);
+  while (n > 0 || (n < 0 && errno == EINTR));
+  if (n < 0 && errno != EAGAIN)
+    {
+      perror ("read FIFO");
+      return 2;
+    }
+  return 0;
+}
+
+static void
+writer_churn (const char *path, HANDLE stop)
+{
+  unsigned long writes = 0;
+
+  for (;;)
+    {
+      DWORD stopped = WaitForSingleObject (stop, 0);
+      if (stopped == WAIT_OBJECT_0)
+	{
+	  if (!writes)
+	    fprintf (stderr, "FIFO writer completed no writes\n");
+	  _exit (writes ? 0 : 2);
+	}
+      if (stopped != WAIT_TIMEOUT)
+	{
+	  win32_error ("wait for writer stop");
+	  _exit (2);
+	}
+
+      /* Each open makes the parent's reader thread add a pipe instance. */
+      int fd = open (path, O_WRONLY | O_NONBLOCK);
+      if (fd < 0)
+	{
+	  if (errno == EINTR || errno == EAGAIN)
+	    continue;
+	  perror ("writer open FIFO");
+	  _exit (2);
+	}
+      ssize_t n;
+      do
+	n = write (fd, "x", 1);
+      while (n < 0 && errno == EINTR);
+      if (n != 1 && !(n < 0 && errno == EAGAIN))
+	{
+	  if (n < 0)
+	    perror ("writer write FIFO");
+	  else
+	    fprintf (stderr, "FIFO writer made a short write\n");
+	  _exit (2);
+	}
+      writes += n == 1;
+      if (close (fd))
+	{
+	  perror ("writer close FIFO");
+	  _exit (2);
+	}
+    }
+}
+
+static int
+check_child (int reader, int writer, HANDLE *events, int iteration)
+{
+  for (int k = 0; k < EVENTS; k++)
+    if (!(events[k] = CreateEventA (NULL, TRUE, FALSE, NULL)))
+      {
+	win32_error ("create child event");
+	return 2;
+      }
+
+  if (close (reader) || close (writer))
+    {
+      perror ("close inherited FIFO");
+      return 2;
+    }
+  for (int k = 0; k < EVENTS; k++)
+    {
+      DWORD flags;
+      if (!GetHandleInformation (events[k], &flags))
+	{
+	  DWORD error = GetLastError ();
+	  fprintf (stderr, "fork %d: event %d lost (Win32 error %lu)\n",
+		   iteration, k, (unsigned long) error);
+	  return error == ERROR_INVALID_HANDLE ? 1 : 2;
+	}
+    }
+  return 0;
+}
+
+int
+main (void)
+{
+  char directory[] = "/tmp/fifo-fork.XXXXXX";
+  char path[sizeof directory + sizeof "/fifo"];
+  struct utsname runtime;
+  SECURITY_ATTRIBUTES attributes = { sizeof attributes, NULL, TRUE };
+  HANDLE stop = NULL, *events = NULL;
+  pid_t writer = -1;
+  int reader = -1, persistent_writer = -1;
+  int status, result = 2, fifo_created = 0;
+
+  if (uname (&runtime))
+    {
+      perror ("uname");
+      return 2;
+    }
+  fprintf (stderr, "Runtime: %s %s %s %s\n", runtime.sysname,
+	   runtime.release, runtime.version, runtime.machine);
+  if (!mkdtemp (directory))
+    {
+      perror ("mkdtemp");
+      return 2;
+    }
+  snprintf (path, sizeof path, "%s/fifo", directory);
+  if (mkfifo (path, 0600))
+    {
+      perror ("mkfifo");
+      goto out;
+    }
+  fifo_created = 1;
+  stop = CreateEventA (&attributes, TRUE, FALSE, NULL);
+  if (!stop)
+    {
+      win32_error ("create writer stop event");
+      goto out;
+    }
+  reader = open (path, O_RDONLY | O_NONBLOCK);
+  if (reader < 0)
+    {
+      perror ("open FIFO reader");
+      goto out;
+    }
+  persistent_writer = open (path, O_WRONLY);
+  if (persistent_writer < 0)
+    {
+      perror ("open persistent FIFO writer");
+      goto out;
+    }
+  events = malloc (EVENTS * sizeof *events);
+  if (!events)
+    {
+      perror ("allocate child events");
+      goto out;
+    }
+  writer = fork ();
+  if (writer < 0)
+    {
+      perror ("fork FIFO writer");
+      goto out;
+    }
+  if (!writer)
+    writer_churn (path, stop);
+
+  for (int i = 0; i < FORKS; i++)
+    {
+      pid_t waited = wait_for (writer, &status, WNOHANG);
+      if (waited)
+	{
+	  if (waited < 0)
+	    perror ("wait for FIFO writer");
+	  else
+	    {
+	      fprintf (stderr, "FIFO writer exited early (status 0x%x)\n",
+		       status);
+	      writer = -1;
+	    }
+	  goto out;
+	}
+      if (drain_fifo (reader))
+	goto out;
+      pid_t child = fork ();
+      if (child < 0)
+	{
+	  perror ("fork test child");
+	  goto out;
+	}
+      if (!child)
+	_exit (check_child (reader, persistent_writer, events, i));
+      if (wait_for (child, &status, 0) != child)
+	{
+	  perror ("wait for test child");
+	  goto out;
+	}
+      if (status)
+	{
+	  result = WIFEXITED (status) && WEXITSTATUS (status) == 1 ? 1 : 2;
+	  fprintf (stderr, "%s: fork %d (child status 0x%x)\n",
+		   result == 1 ? "Lost child event" : "Test child failed",
+		   i, status);
+	  goto out;
+	}
+    }
+  result = 0;
+
+out:
+  if (writer > 0)
+    {
+      if (!SetEvent (stop))
+	{
+	  win32_error ("stop FIFO writer");
+	  result = 2;
+	}
+      /* A nonblocking writer open can still wait for a free pipe instance. */
+      for (;;)
+	{
+	  if (drain_fifo (reader))
+	    result = 2;
+	  pid_t waited = wait_for (writer, &status, WNOHANG);
+	  if (waited == writer)
+	    {
+	      if (status)
+		{
+		  fprintf (stderr, "FIFO writer failed (status 0x%x)\n",
+			   status);
+		  result = 2;
+		}
+	      break;
+	    }
+	  if (waited < 0)
+	    {
+	      perror ("reap FIFO writer");
+	      result = 2;
+	      break;
+	    }
+	  Sleep (1);
+	}
+    }
+  if (reader >= 0 && close (reader))
+    {
+      perror ("close FIFO reader");
+      result = 2;
+    }
+  if (persistent_writer >= 0 && close (persistent_writer))
+    {
+      perror ("close persistent FIFO writer");
+      result = 2;
+    }
+  if (stop && !CloseHandle (stop))
+    {
+      win32_error ("close writer stop event");
+      result = 2;
+    }
+  free (events);
+  if (fifo_created && unlink (path))
+    {
+      perror ("unlink FIFO");
+      result = 2;
+    }
+  if (rmdir (directory))
+    {
+      perror ("remove FIFO directory");
+      result = 2;
+    }
+  if (!result)
+    printf ("OK: %d forks preserved %d events per child\n", FORKS, EVENTS);
+  return result;
+}
-- 
cygwingitgadget
