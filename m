Return-Path: <SRS0=fihM=G5=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 82E794BA7980
	for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2026 08:00:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 82E794BA7980
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 82E794BA7980
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788595236; cv=none;
	b=VmX0aQN/9jT/hPxPEhkS8ABa6pQt1YzHU6V+dmqef157RihRUV4cjhYDgcErMZZPZHtpYjwUH57lvqSqf/BqtdHcYuTOydYKQXhNkIINUcmXlqzF/qHttxPUb71YUeZYALPM6OspXeIhxEzVWYm9zXMWJaaDnm7A1ueD3vKc+YY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788595236; c=relaxed/simple;
	bh=1JWiWrjsYKKL8yNXiDcaVFfbekVE+Fj9W/oh1PQRmDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=k0XZ1BLOVH7JurkIlz71yQk1SkUm1DNKx3+MfFVAoDwwUkea1nryQP7ItX2GzAmVe25sPGfmq4Erso4beQumuqSdlMucLjX541GMCwt60C1fj0Ys5MroGVaCM1BlPAjiL37tYxLECjf0O4zTOdaTsdzlhKrWNXU8Ku/E3nI4StE=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 82E794BA7980
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6858EcE2049937
	for <cygwin-patches@cygwin.com>; Sat, 5 Sep 2026 01:14:38 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdtjQo1G; Sat Sep  5 01:14:36 2026
Message-ID: <cdc9d74e-f95b-4fb9-849c-b9f80f99bbb2@maxrnd.com>
Date: Sat, 5 Sep 2026 01:00:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: proc: Cache system process information
To: cygwin-patches@cygwin.com
References: <20260904035910.1376-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260904035910.1376-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 9/3/2026 8:58 PM, Takashi Yano wrote:
> If a process reads /proc/<pid>/stat for multiple PIDs, current code
> every time calls NtQuerySystemInformation(SystemProcessInformation).
> In addition, the buffer size is estimated by calling that function
> with increasing buffer size. This takes 15 - 20 msec. This is looks
> short time, however it is not negligible in some situation. If the
> number of the process is 100, reading /proc/<pid>/stat takes 1.5 -

   ^^^^^^^^^^^^^^^^^^^^^ number of processes

> 2.0 sec. Due to this behaviour, process pane of the btop is very
> heavy.

(I've noticed that 'top' seems to use somewhat excessive cpu for what 
it's doing; maybe this area of Cygwin has something to do with it.)

> With this patch, system process information is cached per process
> for a short time (20 msec) to improve efficiency. Also, the buffer
> size needed by NtQuerySystemInformation() is stored in static area,
> so that the number of function call is reduced (~1/7). As a result,
> the process pane of btop becomes significantly light (takes only
> ~15 msec for 100 processes).

I think you're on the right track with this fix.  I would suggest 
keeping the address of the malloc'd buffer in static storage too.  That 
way the buffer can be extended as needed (but not shrunk), over many 
calls to the function, and doesn't have to be freed.  What do you think?

> Signef-off-by: Takashi Yano <takashi.yano@nift.ne.jp>
   ^^^^^^ Signed

   Also needs a Fixed: line.

> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/process.cc | 27 +++++++++++++++++++++++----
>   1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/process.cc b/winsup/cygwin/fhandler/process.cc
> index 537a4b370..97f3e0a2f 100644
> --- a/winsup/cygwin/fhandler/process.cc
> +++ b/winsup/cygwin/fhandler/process.cc
> @@ -1524,14 +1524,30 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
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
> +  static ULONG last_n = 0x4000;
> +  ULONG n;
>     int state =' ';
>   
> +  cache_guard.init ("get_process_state")->acquire ();
> +  n = last_n;
> +
> +  if (GetTickCount64 () - t0 < cache_time && p)
> +    goto reuse_query;
> +  else if (p)
> +    {
> +      free (p);
> +      p = NULL;
> +    }
> +
>     p = (PSYSTEM_PROCESS_INFORMATION) malloc (n);
>     if (!p)
> -    return state;
> +    goto out;
>     while (true)
>       {
>         status = NtQuerySystemInformation (SystemProcessInformation,
> @@ -1550,6 +1566,9 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
>   		    status, RtlNtStatusToDosError (status));
>         goto out;
>       }
> +  last_n = n;
> +  t0 = GetTickCount64 ();
> +reuse_query:
>     state = 'Z';
>     sp = p;
>     for (;;)
> @@ -1579,7 +1598,7 @@ get_process_state (DWORD dwProcessId, DWORD *num_threads)
>         sp = (PSYSTEM_PROCESS_INFORMATION) ((char *) sp + sp->NextEntryOffset);
>       }
>   out:
> -  free (p);
> +  cache_guard.release ();
>     return state;
>   }
>   

Thanks for taking this on!

..mark

