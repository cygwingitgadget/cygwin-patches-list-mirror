Return-Path: <SRS0=fihM=G5=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id F23614BB3BDE
	for <cygwin-patches@cygwin.com>; Sat,  5 Sep 2026 06:32:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org F23614BB3BDE
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org F23614BB3BDE
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788589953; cv=none;
	b=PH+d8OGjNl99praMGOVMYKPUPoszlLlG8ab3DbLSQ1JPPekno4QDfG/5H2R4/NI06ZNpg+xj4wrIl2r4Nn9JZy7IdebonWF4VkUvcZcWZ39RGJcy0lyXGk5iZs9hBGmoKHTyMhcQvklpVkk+L1KYgfFvjuE3SYUjd8Q0mbvGLEw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788589953; c=relaxed/simple;
	bh=2NqYN8Am10U7Nb9mpYmwW7gN5acWdcKJpL5yj3LcQc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=D0LNq224yYpNK5BmWJtSwXfUIiHyvLRcbAvT2QNqyVoMvVf3v6AtFCEjWBKngGajC64AfbKC5GFY55JSw8MUaV78NCkn9OGJCXv76xd7IE4TegISi1e5i2yb2eUEldqNPV3Oachg37am5aE1scMk3TVnZuMFtZqMNmJHOdTsfAE=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F23614BB3BDE
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6856kWRU041138
	for <cygwin-patches@cygwin.com>; Fri, 4 Sep 2026 23:46:32 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdjazUML; Fri Sep  4 23:46:26 2026
Message-ID: <4ee063d7-90d7-46df-8d01-ce66fad4fa1d@maxrnd.com>
Date: Fri, 4 Sep 2026 23:32:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: proc: Fix loadavg calculation
To: cygwin-patches@cygwin.com
References: <20260904012420.456-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260904012420.456-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 9/3/2026 6:24 PM, Takashi Yano wrote:
> Previously, format_proc_loadavg() wrongly passed an argument `i` to
> get_process_state(). This should be windows process ID (pids[i]->
> dwProcessId). This patch fix that.

Nice catch!

> Fixes: 9ca65531e0ed ("* fhandler_proc.cc (format_proc_loadavg): Add running/total processes as fourth component of output.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/proc.cc | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> index f1cd468fc..af3cfdb16 100644
> --- a/winsup/cygwin/fhandler/proc.cc
> +++ b/winsup/cygwin/fhandler/proc.cc
> @@ -442,7 +442,7 @@ format_proc_loadavg (void *, char *&destbuf)
>     winpids pids ((DWORD) 0);
>   
>     for (unsigned i = 0; i < pids.npids; i++)
> -    switch (get_process_state (i)) {
> +    switch (get_process_state (pids[i]->dwProcessId)) {
>         case 'O':
>         case 'R':
>   	running++;

The code update LGTM.  As an aside, how did you determine the proper 
Fixes: reference?  The original code here goes waaaayy back.

..mark
