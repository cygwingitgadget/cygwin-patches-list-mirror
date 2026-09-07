Return-Path: <SRS0=ftRC=G7=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 9A0274BC0546
	for <cygwin-patches@cygwin.com>; Mon,  7 Sep 2026 05:28:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9A0274BC0546
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9A0274BC0546
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788758924; cv=none;
	b=iCjsTbFDlD3isNVXJIwD4HGhnwpHCRggtNe41BhG5Hzaa5qhEQH+XNckJPHAdjAmqd9ILJ/QazekN6okEWU0cPWr5m5/HT/5talPeZPkL2pxDHrcMNPR1NZXzKt9BXB4lu34yERKuCje/Ky4/TVAPqmZOXfArOtq3AbAEqQfoMw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788758924; c=relaxed/simple;
	bh=S/JWKNLBraJpbj2Noe5rWp1ArTseOcalIZfnh3GHVWs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=rm/YjQbBcs3lbwKewuHhAidixY2K8RFeyYV9IBLaTEoGPoVzeul+E/pN38Tohy76/QhNqb1ugxOEymz3XJMi5imRhPmJEOapW57K0+onygcl8ZQHUmRUBIJ5JLaLZYjuuDgzFr6BOd7AugzFwEreO3FBW3b3KvPIrhHMLvaWHnI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9A0274BC0546
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6875gi9q098826
	for <cygwin-patches@cygwin.com>; Sun, 6 Sep 2026 22:42:44 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdqxICCs; Sun Sep  6 22:42:35 2026
Message-ID: <57dbcbba-2fcc-43a6-8c82-5f0b6488bee1@maxrnd.com>
Date: Sun, 6 Sep 2026 22:28:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: proc: Cache system process information
To: cygwin-patches@cygwin.com
References: <20260906111103.102115-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260906111103.102115-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This v2 patch LGTM.  Thanks for investigating!
Regards,

..mark

On 9/6/2026 4:10 AM, Takashi Yano wrote:
> If a process reads /proc/<pid>/stat for multiple PIDs, current code
> every time calls NtQuerySystemInformation(SystemProcessInformation).
> In addition, the buffer size is estimated by calling that function
> with increasing buffer size. This takes 15 - 20 msec. This looks
> short time, however it is not negligible in some situation. If the
> number of processes is 100, reading /proc/<pid>/stat takes 1.5 - 2.0
> sec. Due to this behaviour, process pane of the btop is very heavy.
> 
> With this patch, system process information is cached per process
> for a short time (20 msec) to improve efficiency. The buffer is
> allocated first time when the corresponding /proc file system is
> read, and held until process exits. If the buffer size needed by
> NtQuerySystemInformation() is increased, the buffer will be re-
> allocated, however never freed. The buffer pointer and the buffer
> size are stored in the static area, so that the number of the
> function call is reduced much. As a result, the process pane of
> btop becomes significantly light. It takes only ~15 msec for 100
> processes.
> 
> Fixes: 9ba913a56dd6 ("* fhandler_process.cc (process_listing): Add 'stat' and 'statm'.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>
> ---
>   winsup/cygwin/fhandler/process.cc | 22 +++++++++++++++++-----
>   1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> index 537a4b370..404668661 100644
> --- a/winsup/cygwin/fhandler/process.cc
> +++ b/winsup/cygwin/fhandler/process.cc
> @@ -1524,14 +1524,24 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
>   {
>     /* This isn't really heavy magic - just go through the processes' threads
>        one by one and return a value accordingly.  Errors are silently ignored. */
> +  const ULONGLONG cache_time = 20;
> +  static NO_COPY muto cache_guard;
>     NTSTATUS status;
> -  PSYSTEM_PROCESS_INFORMATION p, sp;
> -  ULONG n = 0x4000;
> +  static PSYSTEM_PROCESS_INFORMATION p = NULL;
> +  static ULONGLONG t0 = 0;
> +  PSYSTEM_PROCESS_INFORMATION sp;
> +  static ULONG n = 0x4000;
>     int state =' ';
>   
> -  p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
> +  cache_guard.init ("get_process_state")->acquire ();
> +
> +  if (GetTickCount64 () - t0 < cache_time && p)
> +    goto reuse_query;
> +
> +  if (!p)
> +    p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
>     if (!p)
> -    return state;
> +    goto out;
>     while (true)
>       {
>         status = NtQuerySystemInformation (SystemProcessInformation,
> @@ -1550,6 +1560,8 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
>   		    status, RtlNtStatusToDosError (status));
>         goto out;
>       }
> +  t0 = GetTickCount64 ();
> +reuse_query:
>     state = 'Z';
>     sp = p;
>     for (;;)
> @@ -1579,7 +1591,7 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
>         sp = (PSYSTEM_PROCESS_INFORMATION) ((char *) sp + sp->NextEntryOffset);
>       }
>   out:
> -  free (p);
> +  cache_guard.release ();
>     return state;
>   }
>   

