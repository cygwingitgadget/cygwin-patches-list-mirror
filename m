Return-Path: <SRS0=/1rB=D5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo003.btinternet.com (btprdrgo003.btinternet.com [65.20.50.240])
	by sourceware.org (Postfix) with ESMTP id 3AC0E4BA2E0D
	for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2026 13:31:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3AC0E4BA2E0D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3AC0E4BA2E0D
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.240
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780320664; cv=none;
	b=eQDTEzHDpwOC0CMXXQOlIXBzw3DpTgjgvLp633gzl5d4XHAZUdGN+nrqowc+W6gCvDlOsNm/OLIIBSI/ZeW+ti4uPE6ZtIYOSYpwFOSKJczcsiXXW/Gt7il+21MtUnPU1ZQDp4jKrAjm1ZB/4nAWrdSj50OuRqv10s6m+jfp1Ic=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780320664; c=relaxed/simple;
	bh=lTk+CqM8Agv7HgSoV65k2N4FmnjejWkxxltCvyP7xoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=JZOevm7QHLGsIqsfsO1oBAnib0VS+mB/4Pd6bHoie0xpwSaSlD3cXvCfYWil9+4NzDVZx1cx2Y8g/uSIJmrvYNARFTaL7Cqve0wm3vNYlEEXMJYaq8Qn2NgJFJfWnZXD492ajfjDtTc7Vd1Qi/uetlti3Uv2uJhYdBXg62IGTc0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3AC0E4BA2E0D
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A02527801A8447B
X-Originating-IP: [83.105.142.8]
X-OWM-Source-IP: 83.105.142.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGMpTHQESk7w04HjGjrBe/z2wPdF1OA2WdhQO4I/gjdx783b8Bj1MvL8pb9d8+en+RBvCJrnG1W4D1lL2Qp6NQLeyoMDi8RvyjPIHGfCMIi2ujCUg2mot8XoqHt8ZuroA5OLUzExlVXJ3bUI9lbn2bd17Rt7llRs/fRaKwrQ7F4kVok4oez1GBCk2uMrmGXNga6jWCsRGyWKgkDkY/TD9FAjvnShq5BZvGYTOHvM5Q09xbocRXLfP/xjBlh31RrNGWZTxP6KHPevlHsw3NI0yt6zhe0AMswuDqecTw+B01+SNAgLryqFikL8ES9oKZa96eNFF+xnqYMha8uNyPjr8xPMMbZbf5LWZXkmzFM77+9MZHzD+Gt/L3qD60ba921x7vNM4v9d4nnwiNt0tDjvgkNYC3awKCwnDmX4CoiGs+B1UxfzHJWYkOcGX5zVcEczkDCbpnvvtTtuMI7vD1LoKxad2aseY4GB3Q77eaqnVzpqryuGh4I3X18KmdlCZFHTpTI/BkWJOytTjQDvB2GBO2sN9/4V49nUGeJcztbTY9xw9pPzWh9LpiUHlCK9FF596HmrRt9JQRK7r4q+dDZaIfv3ntbiDLUszmT+jysoAPORJe+d9WqhhPdI6OK5QTMX290vK1XG9rj2ji/gXZN92OBgBhLvcPHMhA7x4S6tsdOVw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (83.105.142.8) by btprdrgo003.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A02527801A8447B; Mon, 1 Jun 2026 14:30:51 +0100
Message-ID: <19ae30b8-610c-465f-94aa-4599b03c2363@dronecode.org.uk>
Date: Mon, 1 Jun 2026 14:30:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Ensure unused fd available for open()
To: Mark Geisert <mark@maxrnd.com>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260528054307.16582-1-mark@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20260528054307.16582-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 28/05/2026 06:42, Mark Geisert wrote:
> The existing logic for open() assumes an fd is always available in
> the fdtable for a created file.  This leads to a situation where, if
> there is no fd available due to the OPEN_MAX limit being hit, the
> file is created but cannot be referenced by a Cygwin fd.
> 
> Move the fd reservation code to an earlier location within open().

Hmm... the more I stare at cygheap_fdnew, the less sure I am I 
understand what's going on.

I'm sure you considered this, but just so I can tell myself I've done 
due diligence, perhaps you can briefly explain why this doesn't create 
the opposite leak? (i.e. the reserved fd is released if actually opening 
the file fails).

> Reported-by: Christian Franke <Christian.Franke@t-online.de>
> Addresses: https://cygwin.com/pipermail/cygwin/2026-May/259664.html
> Signed-off-by: Mark Geisert <mark@maxrnd.com>
> Fixes: e859706578ba (* autoload.cc (NtCreateFile): Add.)
> 
> ---
>   winsup/cygwin/syscalls.cc | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 7a8e5d4fd..2bea79768 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1547,6 +1547,13 @@ open (const char *unix_path, int flags, ...)
>   	  fh = fh_file;
>   	}
>   
> +      /* Reserve an fdtable entry here, before calling open_with_arch() below.
> +         Otherwise there's a tiny chance of hitting OPEN_MAX further on which
> +         could create a new file without any way for Cygwin to refer to it. */
> +      cygheap_fdnew fd;
> +      if (fd < 0)
> +        __leave;		/* errno already set */
> +
>         if (fh->dev () == FH_PROCESSFD && fh->pc.follow_fd_symlink ())
>   	{
>   	  /* Reopen file by descriptor */
> @@ -1573,14 +1580,6 @@ open (const char *unix_path, int flags, ...)
>   	try_to_bin (fh->pc, fh->get_handle (), DELETE,
>   		    FILE_OPEN_FOR_BACKUP_INTENT);
>   
> -      cygheap_fdnew fd;
> -
> -      if (fd < 0)
> -	{
> -	  fh->close();
> -	  __leave;		/* errno already set */
> -	}
> -
>         fd = fh;
>         if (fd <= 2)
>   	set_std_handle (fd);

