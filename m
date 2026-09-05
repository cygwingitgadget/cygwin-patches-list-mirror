Return-Path: <SRS0=fihM=G5=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 54B054BB5882
	for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2026 06:38:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 54B054BB5882
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 54B054BB5882
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788590311; cv=none;
	b=xZ9fx7kyGuntCxAMIWkUGNG3hm1202tfXmTv8Dwxco6ieyvqrs2evxA1mYpr162wkGrQmFp2fJeezaZb4/0yueSu9IDcBezh1+y1UgGC2mYV8wB37AQwI1Cg12fxoEsnLoabd5jFjGCE6mlGfSlPDJVwzGMQ8p02vIm+ISiwg8k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788590311; c=relaxed/simple;
	bh=adM7kdBxgXQOZmWgPaols8Sez6shhsVQ2ET9nGLgnnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Zaqj9qRy7Dc4rUhkOqIpTlfmqCq74g2v+jtwEdlj21VFW3JO2UayxmDKyujKWQgG8nCV7ecdkJR9qXpetuStw5mzbwDB7BnYQgxhkEqWQhyNdNSiivxP8t4H+cq1xSz5ONgGn+neHWc3hxVOopND+ODI/sJ0VCKMhl1IbuFLhco=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 54B054BB5882
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6856qXDg041792
	for <cygwin-patches@cygwin.com>; Fri, 4 Sep 2026 23:52:33 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdztxOkL; Fri Sep  4 23:52:28 2026
Message-ID: <4b926817-53b0-4ef6-b1f5-23f15a2c94ff@maxrnd.com>
Date: Fri, 4 Sep 2026 23:38:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: proc: Provides correct number of thread rather
 than 0
To: cygwin-patches@cygwin.com
References: <20260904012457.466-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260904012457.466-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,KAM_NUMSUBJECT,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 9/3/2026 6:24 PM, Takashi Yano wrote:
> Currently, /proc/<pid>/stat always reports 0 as the number of thread.
> However, get_process_state() does know the thread count for the
> process, so expose that value in /proc/<pid>/stat. Additionally, add
> a "Threads:" entry to /proc/<pid>/status.

A Fixes: line is needed around here.

> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/proc.cc    |  4 ++--
>   winsup/cygwin/fhandler/process.cc | 18 ++++++++++++------
>   winsup/cygwin/release/3.7.0       |  3 +++
>   3 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> index f1cd468fc..12a43afe2 100644
> --- a/winsup/cygwin/fhandler/proc.cc
> +++ b/winsup/cygwin/fhandler/proc.cc
> @@ -437,12 +437,12 @@ format_proc_version (void *, char *&destbuf)
>   static off_t
>   format_proc_loadavg (void *, char *&destbuf)
>   {
> -  extern int get_process_state (DWORD dwProcessId);
> +  extern int get_process_state (DWORD dwProcessId, DWORD *num_threads);
>     unsigned int running = 0;
>     winpids pids ((DWORD) 0);
>   
>     for (unsigned i = 0; i < pids.npids; i++)
> -    switch (get_process_state (pids[i]->dwProcessId)) {
> +    switch (get_process_state (pids[i]->dwProcessId, NULL)) {
>         case 'O':
>         case 'R':
>   	running++;
> diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> index e00cae58d..537a4b370 100644
> --- a/winsup/cygwin/fhandler/process.cc
> +++ b/winsup/cygwin/fhandler/process.cc
> @@ -81,7 +81,7 @@ static const virt_tab_t process_tab[] =
>   
>   static const int PROCESS_LINK_COUNT =
>     (sizeof (process_tab) / sizeof (virt_tab_t)) - 1;
> -int get_process_state (DWORD dwProcessId);
> +int get_process_state (DWORD dwProcessId, DWORD *num_threads);
>   static bool get_mem_values (DWORD dwProcessId, size_t &vmsize, size_t &vmrss,
>   			    size_t &vmtext, size_t &vmdata, size_t &vmlib,
>   			    size_t &vmshare);
> @@ -1121,6 +1121,7 @@ format_process_stat (void *data, char *&destbuf)
>   {
>     _pinfo *p = (_pinfo *) data;
>     char cmd[NAME_MAX + 1];
> +  DWORD num_threads = 0;
>     int state = 'R';
>     unsigned long fault_count = 0UL,
>   		vmsize = 0UL, vmrss = 0UL, vmmaxrss = 0UL;
> @@ -1155,7 +1156,7 @@ format_process_stat (void *data, char *&destbuf)
>     else if (p->process_state & PID_STOPPED)
>       state = 'T';
>     else
> -    state = get_process_state (p->dwProcessId);
> +    state = get_process_state (p->dwProcessId, &num_threads);
>   
>     int nice = 0, prio = 0;
>   
> @@ -1241,14 +1242,14 @@ format_process_stat (void *data, char *&destbuf)
>   				   "%d %d %d %d "
>   				   "%d %u %lu %lu %u %u "
>   				   "%U %U %U %U "
> -				   "%d %d %d %d "
> +				   "%d %d %u %d "
>   				   "%U "
>   				   "%lu %ld %lu\n",
>   			  p->pid, cmd, state,
>   			  p->ppid, p->pgid, p->sid, tty_nr,
>   			  -1, 0, fault_count, fault_count, 0, 0,
>   			  utime, stime, utime, stime,
> -			  prio, nice, 0, 0,
> +			  prio, nice, num_threads, 0,
>   			  start_time,
>   			  vmsize, vmrss, vmmaxrss
>   			  );
> @@ -1259,6 +1260,7 @@ format_process_status (void *data, char *&destbuf)
>   {
>     _pinfo *p = (_pinfo *) data;
>     char cmd[NAME_MAX + 1];
> +  DWORD num_threads = 0;
>     int state = 'R';
>     const char *state_str = "unknown";
>     size_t vmsize = 0, vmrss = 0, vmdata = 0, vmlib = 0, vmtext = 0, vmshare = 0;
> @@ -1281,7 +1283,7 @@ format_process_status (void *data, char *&destbuf)
>     else if (p->process_state & PID_STOPPED)
>       state = 'T';
>     else
> -    state = get_process_state (p->dwProcessId);
> +    state = get_process_state (p->dwProcessId, &num_threads);
>     switch (state)
>       {
>       case 'O':
> @@ -1327,6 +1329,7 @@ format_process_status (void *data, char *&destbuf)
>   				   "VmStk:\t%8lu kB\n"
>   				   "VmExe:\t%8lu kB\n"
>   				   "VmLib:\t%8lu kB\n"
> +				   "Threads:\t%u\n"
>   				   "SigPnd:\t%016lx\n"
>   				   "SigBlk:\t%016lx\n"
>   				   "SigIgn:\t%016lx\n",
> @@ -1340,6 +1343,7 @@ format_process_status (void *data, char *&destbuf)
>   			  vmsize * kb_per_page, 0UL, vmrss * kb_per_page,
>   			  vmdata * kb_per_page, 0UL, vmtext * kb_per_page,
>   			  vmlib * kb_per_page,
> +			  num_threads,
>   			  pnd, blk, ign
>   			  );
>   }
> @@ -1516,7 +1520,7 @@ format_process_mountinfo (void *data, char *&destbuf)
>   }
>   
>   int
> -get_process_state (DWORD dwProcessId)
> +get_process_state (DWORD dwProcessId, DWORD *num_threads)
>   {
>     /* This isn't really heavy magic - just go through the processes' threads
>        one by one and return a value accordingly.  Errors are silently ignored. */
> @@ -1554,6 +1558,8 @@ get_process_state (DWORD dwProcessId)
>   	{
>   	  SYSTEM_THREADS *st;
>   	  st = &sp->Threads[0];
> +	  if (num_threads)
> +	    *num_threads = sp->NumberOfThreads;
>   	  state = 'S';
>   	  for (unsigned i = 0; i < sp->NumberOfThreads; i++)
>   	    {
> diff --git a/winsup/cygwin/release/3.7.0 b/winsup/cygwin/release/3.7.0
> index 3f6a0ecd7..831c8d189 100644
> --- a/winsup/cygwin/release/3.7.0
> +++ b/winsup/cygwin/release/3.7.0
> @@ -26,6 +26,9 @@ What's new:
>     runs on a pty rather than on the console device originating from the pseudo
>     console.
>   
> +- Expose the number of threads in the process in /proc/<pid>/stat and
> +  /proc/<pid>/status.
> +
>   Fixes:
>   ------
>   

The code update LGTM.  Thanks for resolving this issue.

..mark

