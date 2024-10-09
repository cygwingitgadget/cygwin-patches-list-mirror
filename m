Return-Path: <SRS0=VXfo=RF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 33FE33858D37
	for <cygwin-patches@cygwin.com>; Wed,  9 Oct 2024 05:20:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 33FE33858D37
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 33FE33858D37
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1728451239; cv=none;
	b=PBNxYYEKNdmYV88pjLAuRPjMGjrGOcmpsVgYWmS6c0sZxUWhgIVLTDw1lxyIA85y6UVFvvvKD5L8Icl6g7NGzLIw30UpkHYI2dGJKRBL39lRTEFGk+yM+A/BIVcxA88krF+J4aUOzlybjsDDEzoBk+6sg4Y7ixoiLw9nyzN0c5U=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1728451239; c=relaxed/simple;
	bh=JYCNiAR+qMeRrdwsfto4naOJGReatVUDzF0CCNHh2iY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Pk2+SILvIeyMNj6n/eJoNXrKVd0AI4EhBZd1Aim3C1WPeL0SCtXhTk0bqcMD1JnJeSdP8CKYTzFffFfQAVVmhtC84/1C4X5+2srxoKCH2R0V3yAzN1HcDz3g1bp4aVAoY0/6WAr4QCDCuQGUC/2WEUlsFmcF7IINsrJDdFQIzFc=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4995O7pb052177;
	Tue, 8 Oct 2024 22:24:07 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "localhost.localdomain"
 via SMTP by m0.truegem.net, id smtpdJM0D3n; Tue Oct  8 22:23:58 2024
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
Cc: Mark Geisert <mark@maxrnd.com>, Mark Liam Brown <brownmarkliam@gmail.com>
Subject: [PATCH] Cygwin: New tool loadavg to maintain load averages
Date: Tue,  8 Oct 2024 22:20:17 -0700
Message-ID: <20241009052024.3183-1-mark@maxrnd.com>
X-Mailer: git-send-email 2.45.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This program provides an up-to-the-moment load average measurement.  The
user can take 1 sample, or obtain the average of N samples by number or
time duration.  There is a daemon mode to have the global load average
stats updated such that 'uptime' and other tools provide a more reasonable
load average calculation over time.

Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
Signed-off-by: Mark Geisert <mark@maxrnd.com>
Fixes: N/A (new code)

---
 winsup/utils/Makefile.am |   2 +
 winsup/utils/loadavg.c   | 366 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 368 insertions(+)
 create mode 100644 winsup/utils/loadavg.c

diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
index 57a4f377c..3cb2f6bac 100644
--- a/winsup/utils/Makefile.am
+++ b/winsup/utils/Makefile.am
@@ -25,6 +25,7 @@ bin_PROGRAMS = \
 	gmondump \
 	kill \
 	ldd \
+	loadavg \
 	locale \
 	lsattr \
 	minidumper \
@@ -82,6 +83,7 @@ dumper_CXXFLAGS = -I$(top_srcdir)/../include $(AM_CXXFLAGS)
 dumper_LDADD = $(LDADD) -lpsapi -lntdll -lbfd @BFD_LIBS@
 dumper_LDFLAGS =
 ldd_LDADD = $(LDADD) -lpsapi -lntdll
+loadavg_LDADD = $(LDADD) -lpdh
 mount_CXXFLAGS = -DFSTAB_ONLY $(AM_CXXFLAGS)
 minidumper_LDADD = $(LDADD) -ldbghelp
 pldd_LDADD = $(LDADD) -lpsapi
diff --git a/winsup/utils/loadavg.c b/winsup/utils/loadavg.c
new file mode 100644
index 000000000..5b1e2127f
--- /dev/null
+++ b/winsup/utils/loadavg.c
@@ -0,0 +1,363 @@
+/*
+    loadavg.c
+    Outputs to stdout an estimate of current cpu load
+
+    Written by Mark Geisert <mark@maxrnd.com>.
+    h/t to Jon Turney for Cygwin's loadavg.cc which served as model.
+
+    This file is part of Cygwin.
+
+    This software is a copyrighted work licensed under the terms of the
+    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for details.
+*/
+
+#define _GNU_SOURCE
+#include <fcntl.h>
+#include <math.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/cygwin.h>
+#include <sys/stat.h>
+
+#include <pdh.h>
+
+int once = 0;
+int samples = 0;
+int verbose = 0;
+#define PIDFILE "/var/run/loadavg.pid"
+#define PDHMSGFILE "/usr/include/w32api/pdhmsg.h"
+
+/* the following assumes 15ms NT kernel counter update rate */
+#define COUNTS_PER_MSEC 0.066666666666666666
+#define COUNTS_PER_SEC  66.666666666666666666
+#define COUNTS_PER_MIN  4000
+#define COUNTS_PER_HOUR 240000
+
+PDH_HQUERY query;
+PDH_HCOUNTER counter1;
+PDH_HCOUNTER counter2;
+#define c1name  L"\\Processor(_Total)\\% Processor Time"
+#define c1namex L"\\Processor Information(_Total)\\% Processor Time"
+#define c2name  L"\\System\\Processor Queue Length"
+
+void
+usage (void)
+{
+  printf ("\n");
+  printf ("Loadavg estimates and displays current load average by sampling over time.\n");
+  printf ("Usage: loadavg                           take one sample\n");
+  printf ("\n");
+  printf ("       loadavg [ -v ] <count>            take <count> samples\n");
+  printf ("       loadavg [ -v ] <number>h|m|s|ms   take samples for <number> duration\n");
+  printf ("           (specifying -v displays every sample taken)\n");
+  printf ("\n");
+  printf ("       loadavg -h                        this help message\n");
+  printf ("       loadavg -d                        daemon (background) mode\n");
+  printf ("           (ensures 1/5/15-minute load averages computed for 'uptime')\n");
+  printf ("       loadavg -k                        terminates the daemon\n");
+}
+
+char *
+pdh_status (PDH_STATUS err)
+{
+  static FILE *f = NULL;
+  static char  buf[132];
+  static char  hexcode[32];
+         char  line[132];
+         char  prefix[80];
+         char  middle[80];
+  static char  suffix[80];
+
+  snprintf (hexcode, sizeof hexcode, "0x%X", err);
+  if (strstr (suffix, hexcode))
+    goto done; /* same as last time called */
+
+  if (f)
+    (void) fseek (f, 0, SEEK_SET);
+  else
+    f = fopen (PDHMSGFILE, "r");
+  if (!f)
+    goto bail;
+
+  while (!feof (f)) {
+    (void) fgets (line, (sizeof line) - 1, f);
+    if (strncmp (line, "#define PDH_", 12))
+      continue;
+    if (!strstr (line, hexcode))
+      continue;
+    int num = sscanf (line, "%s %s %s", prefix, middle, suffix);
+    if (num != 3)
+      continue;
+    snprintf (buf, sizeof buf, "returns %s", middle);
+    goto done;
+  }
+
+bail:
+  snprintf (buf, sizeof buf, "returns %s", hexcode);
+
+done:
+  return buf;
+}
+
+bool
+load_init (void)
+{
+  static bool tried = false;
+  static bool initialized = false;
+
+  if (!tried)
+    {
+      tried = true;
+
+      PDH_STATUS ret = PdhOpenQueryW (NULL, 0, &query);
+      if (ret != ERROR_SUCCESS) {
+	fprintf (stderr, "PdhOpenQueryW %s\n", pdh_status (ret));
+	return false;
+      }
+
+      /* The Windows name for counter1 can vary.. look for both alternatives */
+      ret = PdhAddEnglishCounterW (query, c1name, 0, &counter1);
+      if (ret != ERROR_SUCCESS) {
+	fprintf (stderr, "PdhAddEnglishCounterW#1 %s\n", pdh_status (ret));
+	ret = PdhAddEnglishCounterW (query, c1namex, 0, &counter1);
+	if (ret != ERROR_SUCCESS) {
+	  fprintf (stderr, "PdhAddEnglishCounterW#1 %s\n", pdh_status (ret));
+	  return false;
+	}
+      }
+
+      /* The Windows name for counter2 might be missing.. carry on anyway */
+      ret = PdhAddEnglishCounterW (query, c2name, 0, &counter2);
+      if (ret != ERROR_SUCCESS) {
+	fprintf (stderr, "PdhAddEnglishCounterW#2 %s\n", pdh_status (ret));
+      }
+
+      initialized = true;
+
+      /* prime the data pump, evidently */
+      (void) PdhCollectQueryData (query);
+      Sleep (15);
+    }
+
+  return initialized;
+}
+
+/* estimate the current load */
+double
+get_load (void)
+{
+  PDH_STATUS ret = PdhCollectQueryData (query);
+  if (ret != ERROR_SUCCESS) {
+    fprintf (stderr, "PdhCollectQueryData %s\n", pdh_status (ret));
+    return 0.0;
+  }
+
+  /* Estimate the number of running processes as
+     (NumberOfProcessors) * (% Processor Time) */
+  PDH_FMT_COUNTERVALUE fmtvalue1;
+  ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
+  if (ret != ERROR_SUCCESS) {
+    fprintf (stderr, "PdhGetFormattedCounterValue#1 %s\n", pdh_status (ret));
+    return 0.0;
+  }
+
+  SYSTEM_INFO sysinfo;
+  GetSystemInfo (&sysinfo);
+  double ncpus = (double) sysinfo.dwNumberOfProcessors;
+  if (verbose) {
+    fprintf (stdout, "%llu ", GetTickCount64 ());
+
+    fprintf (stdout, "ncpus: %d, %%ptime: %3.2f, ", (int) ncpus,
+		     fmtvalue1.doubleValue);
+  }
+  double running = fmtvalue1.doubleValue * ncpus / 100.0;
+
+  /* Estimate the number of runnable threads using ProcessorQueueLength */
+  double rql = 0.0;
+  PDH_FMT_COUNTERVALUE fmtvalue2;
+  ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
+  if (ret == ERROR_SUCCESS) {
+    rql = (double) fmtvalue2.longValue;
+    rql /= ncpus; /* make the measure a per-cpu queue length */
+  } else {
+    ++once; /* counter is missing; just print an error message once (below) */
+  }
+
+  double load = running + rql;
+  if (verbose ) {
+    fprintf (stdout, "running: %3.2f, effrql: %3.2f, load: %3.2f\n",
+		     running, rql, load);
+  }
+  if (once == 1)
+    fprintf (stderr, "PdhGetFormattedCounterValue#2 %s\n", pdh_status (ret));
+
+  ++samples;
+  return load;
+}
+
+int
+start_daemon (void)
+{
+  char  buf[132];
+  int   fd = -1;
+
+  fd = open (PIDFILE, O_RDWR | O_CREAT | O_EXCL);
+  if (fd == -1) {
+    fd = open (PIDFILE, O_RDONLY);
+    if (fd == -1) {
+      fprintf (stderr, "unable to open pid file\n");
+      return 1;
+    }
+
+    memset (buf, 0, sizeof buf);
+    read (fd, buf, sizeof buf);
+    fprintf (stderr, "daemon already running as pid %s\n", buf);
+    close (fd);
+    return 1;
+  }
+  fchmod (fd, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+  (void) daemon (0, 0);
+  snprintf (buf, sizeof buf, "%d", getpid ());
+  write (fd, buf, strlen (buf));
+  /* don't close(fd).. keep it open to protect against another daemon */
+
+  double loadavg[3];
+  while (1) {
+    (void) getloadavg (loadavg, 3);
+    Sleep (5000);
+  }
+  return 0;
+}
+
+int
+stop_daemon (void)
+{
+  char    buf[132];
+  int     fd = -1;
+  ssize_t len = 0;
+  pid_t   pid = 0;
+  char   *winpath = NULL;
+
+  fd = open (PIDFILE, O_RDONLY);
+  if (fd == -1) {
+    fprintf (stderr, "unable to open pid file\n");
+    return 1;
+  }
+  memset (buf, 0, sizeof buf);
+  read (fd, buf, sizeof buf);
+  close (fd);
+
+  pid = atoi (buf);
+  /* does pid still exist? */
+  if (kill (pid, 0) == -1) {
+    fprintf (stderr, "daemon pid %d already gone\n", pid);
+    unlink (PIDFILE);
+    return 1;
+  }
+
+  /* using kill() to terminate the daemon fails; work around that */
+  winpath = getenv ("SYSTEMROOT");
+  len = cygwin_conv_path (CCP_WIN_A_TO_POSIX | CCP_PROC_CYGDRIVE,
+                          winpath, buf, sizeof buf);
+  len = strlen (buf);
+  snprintf (&buf[len], (sizeof buf) - len,
+            "/System32/taskkill /f /pid `cat /proc/%d/winpid`", pid);
+  fprintf (stdout, "Windows says: ");
+  fflush (stdout);
+  system (buf);
+
+  /* if pid is gone, delete pid file */
+  if (kill (pid, 0) == -1)
+    unlink (PIDFILE);
+  return 0;
+}
+
+int
+main (int argc, char **argv)
+{
+  (void) setvbuf (stdout, NULL, _IOLBF, 120);
+  if (!load_init ())
+    return 1;
+
+  /* If program launched with no args, print load once and exit; else loop */
+  if (argc == 1)
+    fprintf (stdout, "%3.2f\n", get_load ());
+  else {
+    int     arg = 1;
+
+    while (arg < argc && argv[arg][0] == '-') {
+      switch (argv[arg][1]) {
+      case '\000':
+	goto bail;
+
+      case 'd':
+	if (arg != 1 || (arg != argc - 1))
+	  goto bail;
+	return start_daemon ();
+
+      case 'k':
+        if (arg != 1 || (arg != argc - 1))
+          goto bail;
+	return stop_daemon ();
+
+      case 'h':
+	usage ();
+	return 0;
+
+      case 'v':
+	verbose = ~verbose;
+	break;
+      }
+      ++arg;
+    }
+    if (arg != argc - 1) {
+bail:
+      usage ();
+      return 1;
+    }
+
+    /* deal with last arg whether it's a number or a duration */
+    int    count;
+    double number = 0.0;
+    char  *ptr = argv[arg];
+    char   units[80];
+
+    units[0] = '\000';
+    int num = sscanf (ptr, "%lg%s", &number, units);
+    switch (num) {
+    case 1: /* arg looks like just a number */
+      if (number > 0.0 && !strlen (units))
+	goto ready;
+      // fallthru
+    case 0: /* arg looks like garbage of some kind */
+      goto bail;
+
+    case 2: /* arg looks like it could be a duration */
+      if (!strcmp (units, "h"))
+	number *= COUNTS_PER_HOUR;
+      else if (!strcmp (units, "m"))
+	number *= COUNTS_PER_MIN;
+      else if (!strcmp (units, "s"))
+	number *= COUNTS_PER_SEC;
+      else if (!strcmp (units, "ms"))
+	number *= COUNTS_PER_MSEC;
+      else
+	goto bail;
+      // fallthru
+    }
+
+ready:
+    count = (int) ceil (number);
+    double totload = 0.0;
+    while (samples < count) {
+      totload += get_load ();
+      Sleep (12); /* 12 seems to work better than canonical 15 here */
+    }
+    fprintf (stdout, "%3.2f\n", totload / samples);
+  }
+
+  return 0;
+}
-- 
2.45.1

