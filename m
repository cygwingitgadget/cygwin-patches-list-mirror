Return-Path: <SRS0=6I6Q=SN=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id 130663858D21
	for <cygwin-patches@cygwin.com>; Mon, 18 Nov 2024 20:58:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 130663858D21
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 130663858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1731963526; cv=none;
	b=RMyuCE/3NgR9ahaOQ8PbuDlOQnuwFo2g7cV43xlGAT9NcIDvSbDZL97VjzUVwSdfraQ8Zbf2SXHi/ksiHt8ohJqjWCpJrlVnrL9K2NAvNtZ1Kc+xkJ0S+0Xxh08AXZR2l/kp/oc5/SCcvAyHRphQ7KGWwmFDfmC22tfZqxq9Ch4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1731963526; c=relaxed/simple;
	bh=28XBSD7mhLAfvaKcrAsclIafOTHjIFARuEhMSaNxvIk=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=rzag1gsxD8A3JuDJf0b43fCy7zxX3xK8ux/bOWKNc7yuFlIfA1ziCRcqfHzGkOl6aoWQMEik1a8lTeH01gPxuQXfCjmDp5VR358ZL727ke0/x4a8mfQF+bYorY8rmEraRbFyTkA+sgUJIW0/RlBrsyxXlS1OX5LlYIJ9kc+Rej0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 130663858D21
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6722AF4202270F3B
X-Originating-IP: [81.152.101.74]
X-OWM-Source-IP: 81.152.101.74
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeefuddrfedtgddugeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeghfdvvdeijeettdfgleetffetfedtuefgfeevhedthefgffelfeethfdvleffnecuffhomhgrihhnpegthihgfihinhdrtghomhenucfkphepkedurdduhedvrddutddurdejgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtlegnpdhinhgvthepkedurdduhedvrddutddurdejgedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhrvghvkffrpehhohhsthekuddqudehvddquddtuddqjeegrdhrrghnghgvkeduqdduhedvrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpegsthhprhgurhhgohdttdegpdhnsggprhgtphhtthhopedvpdhrtghpthhtohep
	tgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgtphhtthhopehmrghrkhesmhgrgihrnhgurdgtohhm
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (81.152.101.74) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6722AF4202270F3B; Mon, 18 Nov 2024 20:58:41 +0000
Message-ID: <3987e096-9510-4fc0-8121-ca32773c09e4@dronecode.org.uk>
Date: Mon, 18 Nov 2024 20:58:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: New tool loadavg to maintain load averages
To: Mark Geisert <mark@maxrnd.com>
References: <20241113062152.2225-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-US
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20241113062152.2225-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/11/2024 06:21, Mark Geisert wrote:
> This program provides an up-to-the-moment load average measurement.  The
> user can take 1 sample, or obtain the average of N samples by number or

Sorry about the inordinate time it's take for me to look at this.


So, this seems like two separate things shoved together

* A daemon which calls getloadavg() every 5 seconds
* A tool which exercises the loadavg estimation code

Does it really make sense to bundle them together?

> time duration.  There is a daemon mode to have the global load average
> stats updated such that 'uptime' and other tools provide a more reasonable
> load average calculation over time.

I'm wondering what's "unreasonable" about the current behavior (estimate 
is calculated on demand, in a rate-limited fashion)

If it's that working correctly (after your fixes), is this actually 
needed (i.e. what difference does also having loadavg in daemon mode 
running make)?

> A release note is provided for Cygwin 3.5.5.
> Documentation for doc/utils.xml is pending.

A man page isn't optional :)

Or, I wonder if it really makes sense to ship this as useful to 
end-users (as opposed to marking it noinst_ in Makefile.am, so we just 
keep it around for developers)

> Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
> Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: N/A (new code)
> 
> ---
>   winsup/cygwin/release/3.5.5 |   8 +
>   winsup/utils/Makefile.am    |   2 +
>   winsup/utils/loadavg.c      | 380 ++++++++++++++++++++++++++++++++++++
>   3 files changed, 390 insertions(+)
>   create mode 100644 winsup/utils/loadavg.c
> 
[...]
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

I'd tend to make this static with function scope, rather than a global, 
but you are entitled to a different opinion.

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

Yeah, why! This is hugely suspicious.

I forget if getloadavg() is sigwrapper wrapped, but if not, that might 
explain it (or not, the daemon should spend nearly all of it's time in 
sleep(), right?)

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
