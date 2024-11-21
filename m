Return-Path: <SRS0=Byep=SQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 2512D3858414
	for <cygwin-patches@cygwin.com>; Thu, 21 Nov 2024 10:07:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2512D3858414
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2512D3858414
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1732183667; cv=none;
	b=fNESP4Il8DNwJ4btECmuQT2Kkix0qSH5/oXfj/ECJp+RKPZCXVgabarmhovs+zUe6tCq5VwDYxCG+7z5f9XvHEgCgK3JVJaaDl1dNUq+rdICu1fhXbZ1cSb4R8idQATXgMDTtXfgzp9yh+xWb541537b7uZB5KJIChZuYEkNlf4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1732183667; c=relaxed/simple;
	bh=Y7mESOj3Nv5IDTiqNEZGUfYbavr6Yic/6NO/mPHtMew=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=cYWaUaxe7F+F3XuJz/Z9hzgN1mvzWoU9CK2R6+yNKDLamaCSVHOPlTM0dcpsySVroYsBCYlHh2QrEECTPUkgfGR4G2wyMvs8a+eBuyvBqt/xpFBdhONw5hmGv9sfx0smneQBTI0GM9ZG7TiA1v/5UWSRVYD32M7vhN8/G0omOi4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 4ALAAhW1013407;
	Thu, 21 Nov 2024 02:10:43 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdfaAnfK; Thu Nov 21 02:10:34 2024
Message-ID: <b77f5110-1ee9-4529-9cd0-3a061301ee4b@maxrnd.com>
Date: Thu, 21 Nov 2024 02:07:37 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: New tool loadavg to maintain load averages
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
References: <20241113062152.2225-1-mark@maxrnd.com>
 <3987e096-9510-4fc0-8121-ca32773c09e4@dronecode.org.uk>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <3987e096-9510-4fc0-8121-ca32773c09e4@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On 11/18/2024 12:58 PM, Jon Turney wrote:
> On 13/11/2024 06:21, Mark Geisert wrote:
>> This program provides an up-to-the-moment load average measurement.  The
>> user can take 1 sample, or obtain the average of N samples by number or
> 
> Sorry about the inordinate time it's take for me to look at this.

No worries, I understand.

> So, this seems like two separate things shoved together
> 
> * A daemon which calls getloadavg() every 5 seconds
> * A tool which exercises the loadavg estimation code
> 
> Does it really make sense to bundle them together?

I considered putting the daemon's loop in cygserver as a new thread. 
That's what one user on the main list suggested; another user suggested 
a separate program.  I thought shoving it into cygserver was less 
appealing somehow.

The point of the non-daemon mode is in the first line of mine quoted up 
top.  The program outputs a load average number that can be used to gate 
steps within a multi-step workload.  Given the wacky volatility of the 
counters necessary to calculate a load average, the program can help one 
decide how many loadavg samples result in a reasonable result given the 
activity on the user's system.

>> time duration.  There is a daemon mode to have the global load average
>> stats updated such that 'uptime' and other tools provide a more 
>> reasonable
>> load average calculation over time.
> 
> I'm wondering what's "unreasonable" about the current behavior (estimate 
> is calculated on demand, in a rate-limited fashion)
> 
> If it's that working correctly (after your fixes), is this actually 
> needed (i.e. what difference does also having loadavg in daemon mode 
> running make)?

I think the steady-state behaviour of 'uptime' is fairly good.  It's the 
getting it to move up from zero initially that seems to be a problem, 
per multiple posts on the main list.

I say "fairly good" because the volatility of the counters sabotages the 
effort.  When getloadavg() determines it's time to recalculate, it just 
reads the counters once.  But the counters are being updated at 64Hz; on 
a system with no compute-bound processes they have a fairly high 
probability of being zero when read.

BTW that's why I added the "-v" option.  To see the volatility.

>> A release note is provided for Cygwin 3.5.5.
>> Documentation for doc/utils.xml is pending.
> 
> A man page isn't optional :)

It's now written and waiting to be included in v3 of this patch.

> Or, I wonder if it really makes sense to ship this as useful to end- 
> users (as opposed to marking it noinst_ in Makefile.am, so we just keep 
> it around for developers)

I don't think I've seen any Cygwin devs or package maintainers mention 
load average.  They're either cross-building from Linux and/or happy 
with whatever their systems can provide :-).  There was some activity a 
few weeks ago on the main list and random complaints about 'uptime' 
reporting zero a couple of times before that, going back a ways.  So 
this tool is a response to the user posts.

>> Reported-by: Mark Liam Brown <brownmarkliam@gmail.com>
>> Addresses: https://cygwin.com/pipermail/cygwin/2024-August/256361.html
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>> Fixes: N/A (new code)
>>
>> ---
>>   winsup/cygwin/release/3.5.5 |   8 +
>>   winsup/utils/Makefile.am    |   2 +
>>   winsup/utils/loadavg.c      | 380 ++++++++++++++++++++++++++++++++++++
>>   3 files changed, 390 insertions(+)
>>   create mode 100644 winsup/utils/loadavg.c
>>
> [...]
>> +
>> +/* estimate the current load based on certain counter values */
>> +double
>> +get_load (void)
>> +{
>> +  PDH_STATUS ret = PdhCollectQueryData (query);
>> +  if (ret != ERROR_SUCCESS) {
>> +    fprintf (stderr, "PdhCollectQueryData %s\n", pdh_status (ret));
>> +    return 0.0;
>> +  }
>> +
>> +  /* Estimate the number of running processes as
>> +     (NumberOfProcessors) * (% Processor Time) */
>> +  PDH_FMT_COUNTERVALUE fmtvalue1;
>> +  ret = PdhGetFormattedCounterValue (counter1, PDH_FMT_DOUBLE, NULL, 
>> &fmtvalue1);
>> +  if (ret != ERROR_SUCCESS) {
>> +    fprintf (stderr, "PdhGetFormattedCounterValue#1 %s\n", pdh_status 
>> (ret));
>> +    return 0.0;
>> +  }
>> +
>> +  double ncpus = (double) sysinfo.dwNumberOfProcessors;
>> +  if (verbose) {
>> +    fprintf (stdout, "%llu ", GetTickCount64 ());
>> +
>> +    fprintf (stdout, "ncpus: %d, %%ptime: %3.2f, ", (int) ncpus,
>> +             fmtvalue1.doubleValue);
>> +  }
>> +  double running = fmtvalue1.doubleValue * ncpus / 100.0;
>> +
>> +  /* Estimate the number of runnable threads as
>> +     (ProcessorQueueLength) / (NumberOfProcessors) */
>> +  double rql = 0.0;
>> +  PDH_FMT_COUNTERVALUE fmtvalue2;
>> +  ret = PdhGetFormattedCounterValue (counter2, PDH_FMT_LONG, NULL, 
>> &fmtvalue2);
>> +  if (ret == ERROR_SUCCESS) {
>> +    rql = (double) fmtvalue2.longValue;
>> +    rql /= ncpus; /* make the measure a per-cpu queue length */
>> +  } else {
>> +    ++once; /* counter is missing; just print an error message once 
>> (below) */
> 
> I'd tend to make this static with function scope, rather than a global, 
> but you are entitled to a different opinion.

I like your choice on this.  I'll update.

>> +  }
>> +
>> +  double load = running + rql;
>> +  if (verbose ) {
>> +    fprintf (stdout, "running: %3.2f, effrql: %3.2f, load: %3.2f\n",
>> +             running, rql, load);
>> +  }
>> +  if (once == 1)
>> +    fprintf (stderr, "PdhGetFormattedCounterValue#2 %s\n", pdh_status 
>> (ret));
>> +
>> +  ++samples;
>> +  return load;
>> +}
>> +
>> +int
>> +start_daemon (void)
>> +{
>> +  char  buf[132];
>> +  int   fd = -1;
>> +  pid_t pid = 0;
>> +
>> +top:
>> +  fd = open (PIDFILE, O_RDWR | O_CREAT | O_EXCL);
>> +  if (fd == -1) {
>> +    fd = open (PIDFILE, O_RDONLY);
>> +    if (fd == -1) {
>> +      fprintf (stderr, "unable to open pid file\n");
>> +      return 1;
>> +    }
>> +
>> +    memset (buf, 0, sizeof buf);
>> +    read (fd, buf, sizeof buf);
>> +    close (fd);
>> +
>> +    pid = atoi (buf);
>> +    /* does pid still exist? */
>> +    if (kill (pid, 0) == 0) {
>> +      fprintf (stderr, "daemon already running as pid %d\n", pid);
>> +      return 1;
>> +    }
>> +    unlink (PIDFILE);
>> +    goto top;
>> +  }
>> +  fchmod (fd, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>> +
>> +  (void) daemon (0, 0);
>> +
>> +  /* this code runs in the daemon; the parent process has exited via 
>> daemon() */
>> +  snprintf (buf, sizeof buf, "%d", getpid ());
>> +  write (fd, buf, strlen (buf));
>> +  /* don't close(fd).. keep it open to protect against another daemon */
>> +
>> +  double loadavg[3];
>> +  while (1) {
>> +    (void) getloadavg (loadavg, 3);
>> +    sleep (5/*seconds*/);
>> +  }
>> +  return 0;
>> +}
>> +
>> +int
>> +stop_daemon (void)
>> +{
>> +  char     buf[132];
>> +  int      fd = -1;
>> +  ssize_t  len = 0;
>> +  pid_t    pid = 0;
>> +  char    *winpath = NULL;
>> +
>> +  fd = open (PIDFILE, O_RDONLY);
>> +  if (fd == -1) {
>> +    fprintf (stderr, "unable to open pid file\n");
>> +    return 1;
>> +  }
>> +  memset (buf, 0, sizeof buf);
>> +  read (fd, buf, sizeof buf);
>> +  close (fd);
>> +
>> +  pid = atoi (buf);
>> +  /* does pid still exist? */
>> +  if (kill (pid, 0) == -1) {
>> +    fprintf (stderr, "daemon pid %d already gone\n", pid);
>> +    unlink (PIDFILE);
>> +    return 1;
>> +  }
>> +
>> +  /* using kill() to terminate the daemon fails (why?); work around 
>> that */
> 
> Yeah, why! This is hugely suspicious.
> 
> I forget if getloadavg() is sigwrapper wrapped, but if not, that might 
> explain it (or not, the daemon should spend nearly all of it's time in 
> sleep(), right?)

I agree.  I'll try to debug further.  Yes the daemon is mostly in Sleep().
Thanks for your review,

..mark
