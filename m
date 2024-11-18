Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C1986385841C; Mon, 18 Nov 2024 12:26:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C1986385841C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1731932778;
	bh=m69zHWYqPYnq/se0eHqySx7iN3H0Vz5ByLtdVRbPQhc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=FeInCMD7iBRkFOHOk/u5wSM+sdvhEo1pTrpvJBl7A89M2rfdYEbAjsyDa189VlGZF
	 k8x5mqIQ4oG+jd6sGJUtSuprgNV0LSaP6WIxjtUGQICgOVDqFjEDUraXbsQYBheDZu
	 phj1V1BLGIPKxOxO+pJ6V0DWH1CvXa4dzziYEjLU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9290FA80650; Mon, 18 Nov 2024 13:26:16 +0100 (CET)
Date: Mon, 18 Nov 2024 13:26:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: New tool loadavg to maintain load averages
Message-ID: <ZzsyaAObt_lYWKUD@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20241113062152.2225-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113062152.2225-1-mark@maxrnd.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Mark,

Not being a bugfix, this patch should go into the main branch and only
update release/3.6.0.


Thanks,
Corinna

On Nov 12 22:21, Mark Geisert wrote:
> This program provides an up-to-the-moment load average measurement.  The
> user can take 1 sample, or obtain the average of N samples by number or
> time duration.  There is a daemon mode to have the global load average
> stats updated such that 'uptime' and other tools provide a more reasonable
> load average calculation over time.
> 
> A release note is provided for Cygwin 3.5.5.
> Documentation for doc/utils.xml is pending.
> 
> Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: N/A (new code)
> 
> ---
>  winsup/cygwin/release/3.5.5 |   8 +
>  winsup/utils/Makefile.am    |   2 +
>  winsup/utils/loadavg.c      | 380 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 390 insertions(+)
>  create mode 100644 winsup/utils/loadavg.c
> 
> diff --git a/winsup/cygwin/release/3.5.5 b/winsup/cygwin/release/3.5.5
> index a83ea7d8a..7db82631d 100644
> --- a/winsup/cygwin/release/3.5.5
> +++ b/winsup/cygwin/release/3.5.5
> @@ -1,3 +1,11 @@
> +What's New:
> +-----------
> +
> +- New tool loadavg that provides up-to-the-moment load average measurement.
> +  It also has a daemon mode to continuously update the global load average.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> +
> +
>  Fixes:
>  ------
>  
> diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
> index 57a4f377c..3cb2f6bac 100644
> --- a/winsup/utils/Makefile.am
> +++ b/winsup/utils/Makefile.am
> @@ -25,6 +25,7 @@ bin_PROGRAMS = \
>  	gmondump \
>  	kill \
>  	ldd \
> +	loadavg \
>  	locale \
>  	lsattr \
>  	minidumper \
> @@ -82,6 +83,7 @@ dumper_CXXFLAGS = -I$(top_srcdir)/../include $(AM_CXXFLAGS)
>  dumper_LDADD = $(LDADD) -lpsapi -lntdll -lbfd @BFD_LIBS@
>  dumper_LDFLAGS =
>  ldd_LDADD = $(LDADD) -lpsapi -lntdll
> +loadavg_LDADD = $(LDADD) -lpdh
>  mount_CXXFLAGS = -DFSTAB_ONLY $(AM_CXXFLAGS)
>  minidumper_LDADD = $(LDADD) -ldbghelp
>  pldd_LDADD = $(LDADD) -lpsapi
> diff --git a/winsup/utils/loadavg.c b/winsup/utils/loadavg.c
> new file mode 100644
> index 000000000..0bc3ffe1d
> --- /dev/null
> +++ b/winsup/utils/loadavg.c
> @@ -0,0 +1,380 @@
> +/*
> +    loadavg.c
> +    Outputs to stdout an estimate of current cpu load
> +
> +    Written by Mark Geisert <mark@maxrnd.com>
> +    h/t to Jon Turney for Cygwin's loadavg.cc which served as a model
> +
> +    This file is part of Cygwin.
> +
> +    This software is a copyrighted work licensed under the terms of the
> +    Cygwin license.  Please consult the file "CYGWIN_LICENSE" for details.
> +*/
> +
> +#define _GNU_SOURCE
> +#include <fcntl.h>
> +#include <math.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <unistd.h>
> +#include <sys/cygwin.h>
> +#include <sys/stat.h>
> +
> +#include <pdh.h>
> +
> +int once    = 0;
> +int samples = 0;
> +int verbose = 0;
> +SYSTEM_INFO sysinfo;
> +#define PIDFILE "/var/run/loadavg.pid"
> +#define PDHMSGFILE "/usr/include/w32api/pdhmsg.h"
> +
> +/* the following assumes standard 64Hz NT kernel counter update rate */
> +#define UPDATES_PER_MSEC 0.064
> +#define UPDATES_PER_SEC  64
> +#define UPDATES_PER_MIN  3840
> +#define UPDATES_PER_HOUR 230400
> +
> +PDH_HQUERY query;
> +PDH_HCOUNTER counter1;
> +PDH_HCOUNTER counter2;
> +#define c1name  L"\\Processor(_Total)\\% Processor Time"
> +#define c1namex L"\\Processor Information(_Total)\\% Processor Time"
> +#define c2name  L"\\System\\Processor Queue Length"
> +
> +void
> +usage (void)
> +{
> +  printf ("Loadavg estimates current system load average by sampling certain Windows\n");
> +  printf ("kernel counters over time.  The counters are updated 64 times per second.\n");
> +  printf ("\n");
> +  printf ("Usage: loadavg                           take one sample\n");
> +  printf ("\n");
> +  printf ("       loadavg [ -v ] <count>            take <count> samples\n");
> +  printf ("       loadavg [ -v ] <number>h|m|s|ms   take samples for <number> duration\n");
> +  printf ("           (specifying -v displays every sample taken)\n");
> +  printf ("\n");
> +  printf ("       loadavg -h                        this help message\n");
> +  printf ("       loadavg -d                        daemon (background) mode\n");
> +  printf ("           (ensures 1/5/15-minute load averages computed for 'uptime')\n");
> +  printf ("       loadavg -k                        terminates the daemon\n");
> +}
> +
> +/* Convert PDH error status to PDH error name, if possible */
> +char *
> +pdh_status (PDH_STATUS err)
> +{
> +  static FILE *f = NULL;
> +  static char  buf[132];
> +  static char  hexcode[32];
> +         char  line[132];
> +         char  prefix[80];
> +         char  middle[80];
> +  static char  suffix[80];
> +
> +  snprintf (hexcode, sizeof hexcode, "0x%X", err);
> +  if (strstr (suffix, hexcode))
> +    goto done; /* same as last time called */
> +
> +  if (f)
> +    (void) fseek (f, 0, SEEK_SET);
> +  else
> +    f = fopen (PDHMSGFILE, "r");
> +  if (!f)
> +    goto bail;
> +
> +  while (!feof (f)) {
> +    (void) fgets (line, (sizeof line) - 1, f);
> +    if (strncmp (line, "#define PDH_", 12))
> +      continue;
> +    if (!strstr (line, hexcode))
> +      continue;
> +    int num = sscanf (line, "%s %s %s", prefix, middle, suffix);
> +    if (num != 3)
> +      continue;
> +    snprintf (buf, sizeof buf, "returns %s", middle);
> +    goto done;
> +  }
> +
> +bail:
> +  snprintf (buf, sizeof buf, "returns %s", hexcode);
> +
> +done:
> +  return buf;
> +}
> +
> +/* Initialize state for reading counters once or many times */
> +bool
> +load_init (void)
> +{
> +  static bool tried       = false;
> +  static bool initialized = false;
> +
> +  if (!tried)
> +    {
> +      tried = true;
> +
> +      PDH_STATUS ret = PdhOpenQueryW (NULL, 0, &query);
> +      if (ret != ERROR_SUCCESS) {
> +	fprintf (stderr, "PdhOpenQueryW %s\n", pdh_status (ret));
> +	return false;
> +      }
> +
> +      /* The Windows name for counter1 can vary.. look for both alternatives */
> +      ret = PdhAddEnglishCounterW (query, c1name, 0, &counter1);
> +      if (ret != ERROR_SUCCESS) {
> +	fprintf (stderr, "PdhAddEnglishCounterW#1 %s\n", pdh_status (ret));
> +	ret = PdhAddEnglishCounterW (query, c1namex, 0, &counter1);
> +	if (ret != ERROR_SUCCESS) {
> +	  fprintf (stderr, "PdhAddEnglishCounterW#1 %s\n", pdh_status (ret));
> +	  return false;
> +	}
> +      }
> +
> +      /* What we call counter2 might be missing.. carry on anyway */
> +      ret = PdhAddEnglishCounterW (query, c2name, 0, &counter2);
> +      if (ret != ERROR_SUCCESS) {
> +	fprintf (stderr, "PdhAddEnglishCounterW#2 %s\n", pdh_status (ret));
> +      }
> +
> +      GetSystemInfo (&sysinfo); /* get system number of processors, etc. */
> +      initialized = true;
> +
> +      /* obtain+discard first sample now; avoids PDH_INVALID_DATA in get_load */
> +      (void) PdhCollectQueryData (query); /* i.o.w. take the error here */
> +
> +      /* Delay a short time so PdhCQD in caller will have data to collect */
> +      Sleep (16/*ms*/); /* let other procs run; one|more yield()s not enough */
> +    }
> +
> +  return initialized;
> +}
> +
> +/* estimate the current load based on certain counter values */
> +double
> +get_load (void)
> +{
> +  PDH_STATUS ret = PdhCollectQueryData (query);
> +  if (ret != ERROR_SUCCESS) {
> +    fprintf (stderr, "PdhCollectQueryData %s\n", pdh_status (ret));
> +    return 0.0;
> +  }
> +
> +  /* Estimate the number of running processes as
> +     (NumberOfProcessors) * (% Processor Time) */
> +  PDH_FMT_COUNTERVALUE fmtvalue1;
> +  ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, &fmtvalue1);
> +  if (ret != ERROR_SUCCESS) {
> +    fprintf (stderr, "PdhGetFormattedCounterValue#1 %s\n", pdh_status (ret));
> +    return 0.0;
> +  }
> +
> +  double ncpus = (double) sysinfo.dwNumberOfProcessors;
> +  if (verbose) {
> +    fprintf (stdout, "%llu ", GetTickCount64 ());
> +
> +    fprintf (stdout, "ncpus: %d, %%ptime: %3.2f, ", (int) ncpus,
> +		     fmtvalue1.doubleValue);
> +  }
> +  double running = fmtvalue1.doubleValue * ncpus / 100.0;
> +
> +  /* Estimate the number of runnable threads as
> +     (ProcessorQueueLength) / (NumberOfProcessors) */
> +  double rql = 0.0;
> +  PDH_FMT_COUNTERVALUE fmtvalue2;
> +  ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, &fmtvalue2);
> +  if (ret == ERROR_SUCCESS) {
> +    rql = (double) fmtvalue2.longValue;
> +    rql /= ncpus; /* make the measure a per-cpu queue length */
> +  } else {
> +    ++once; /* counter is missing; just print an error message once (below) */
> +  }
> +
> +  double load = running + rql;
> +  if (verbose ) {
> +    fprintf (stdout, "running: %3.2f, effrql: %3.2f, load: %3.2f\n",
> +		     running, rql, load);
> +  }
> +  if (once == 1)
> +    fprintf (stderr, "PdhGetFormattedCounterValue#2 %s\n", pdh_status (ret));
> +
> +  ++samples;
> +  return load;
> +}
> +
> +int
> +start_daemon (void)
> +{
> +  char  buf[132];
> +  int   fd = -1;
> +  pid_t pid = 0;
> +
> +top:
> +  fd = open (PIDFILE, O_RDWR | O_CREAT | O_EXCL);
> +  if (fd == -1) {
> +    fd = open (PIDFILE, O_RDONLY);
> +    if (fd == -1) {
> +      fprintf (stderr, "unable to open pid file\n");
> +      return 1;
> +    }
> +
> +    memset (buf, 0, sizeof buf);
> +    read (fd, buf, sizeof buf);
> +    close (fd);
> +
> +    pid = atoi (buf);
> +    /* does pid still exist? */
> +    if (kill (pid, 0) == 0) {
> +      fprintf (stderr, "daemon already running as pid %d\n", pid);
> +      return 1;
> +    }
> +    unlink (PIDFILE);
> +    goto top;
> +  }
> +  fchmod (fd, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
> +
> +  (void) daemon (0, 0);
> +
> +  /* this code runs in the daemon; the parent process has exited via daemon() */
> +  snprintf (buf, sizeof buf, "%d", getpid ());
> +  write (fd, buf, strlen (buf));
> +  /* don't close(fd).. keep it open to protect against another daemon */
> +
> +  double loadavg[3];
> +  while (1) {
> +    (void) getloadavg (loadavg, 3);
> +    sleep (5/*seconds*/);
> +  }
> +  return 0;
> +}
> +
> +int
> +stop_daemon (void)
> +{
> +  char     buf[132];
> +  int      fd = -1;
> +  ssize_t  len = 0;
> +  pid_t    pid = 0;
> +  char    *winpath = NULL;
> +
> +  fd = open (PIDFILE, O_RDONLY);
> +  if (fd == -1) {
> +    fprintf (stderr, "unable to open pid file\n");
> +    return 1;
> +  }
> +  memset (buf, 0, sizeof buf);
> +  read (fd, buf, sizeof buf);
> +  close (fd);
> +
> +  pid = atoi (buf);
> +  /* does pid still exist? */
> +  if (kill (pid, 0) == -1) {
> +    fprintf (stderr, "daemon pid %d already gone\n", pid);
> +    unlink (PIDFILE);
> +    return 1;
> +  }
> +
> +  /* using kill() to terminate the daemon fails (why?); work around that */
> +  winpath = getenv ("SYSTEMROOT");
> +  len = cygwin_conv_path (CCP_WIN_A_TO_POSIX | CCP_PROC_CYGDRIVE,
> +                          winpath, buf, sizeof buf);
> +  len = strlen (buf);
> +  snprintf (&buf[len], (sizeof buf) - len,
> +            "/System32/taskkill /f /pid `cat /proc/%d/winpid`", pid);
> +  fprintf (stdout, "Windows says: ");
> +  fflush (stdout);
> +  system (buf);
> +
> +  /* if pid is gone, delete pid file */
> +  if (kill (pid, 0) == -1)
> +    unlink (PIDFILE);
> +  return 0;
> +}
> +
> +int
> +main (int argc, char **argv)
> +{
> +  (void) setvbuf (stdout, NULL, _IOLBF, 120);
> +  if (!load_init ())
> +    return 1;
> +
> +  /* If program launched with no args, print load once and exit; else loop */
> +  if (argc == 1)
> +    fprintf (stdout, "%3.2f\n", get_load ());
> +  else {
> +    int     arg = 1;
> +
> +    while (arg < argc && argv[arg][0] == '-') {
> +      switch (argv[arg][1]) {
> +      case '\000':
> +	goto bail;
> +
> +      case 'd':
> +	if (arg != 1 || (arg != argc - 1))
> +	  goto bail;
> +	return start_daemon ();
> +
> +      case 'k':
> +        if (arg != 1 || (arg != argc - 1))
> +          goto bail;
> +	return stop_daemon ();
> +
> +      case 'h':
> +	usage ();
> +	return 0;
> +
> +      case 'v':
> +	++verbose;
> +	break;
> +      }
> +      ++arg;
> +    }
> +    if (arg != argc - 1) {
> +bail:
> +      usage ();
> +      return 1;
> +    }
> +
> +    /* deal with last arg whether it's a number or a duration */
> +    int     count;
> +    double  number = 0.0;
> +    char   *ptr = argv[arg];
> +    char    units[80];
> +
> +    units[0] = '\000';
> +    int num = sscanf (ptr, "%lg%s", &number, units);
> +    switch (num) {
> +    case 1: /* arg looks like just a number */
> +      if (number > 0.0 && !strlen (units))
> +	goto ready;
> +      // fallthru
> +    case 0: /* arg looks like garbage of some kind */
> +      goto bail;
> +
> +    case 2: /* arg looks like it could be a duration */
> +      if (!strcmp (units, "h"))
> +	number *= UPDATES_PER_HOUR;
> +      else if (!strcmp (units, "m"))
> +	number *= UPDATES_PER_MIN;
> +      else if (!strcmp (units, "s"))
> +	number *= UPDATES_PER_SEC;
> +      else if (!strcmp (units, "ms"))
> +	number *= UPDATES_PER_MSEC;
> +      else
> +	goto bail;
> +      // fallthru
> +    }
> +
> +ready:
> +    count = (int) ceil (number);
> +    double totload = 0.0;
> +    while (samples < count) {
> +      totload += get_load ();
> +      Sleep (11/*ms*/); /* tested best at capturing a sample every 15|16ms */
> +    }
> +    fprintf (stdout, "%3.2f\n", totload / samples);
> +  }
> +
> +  return 0;
> +}
> -- 
> 2.45.1
