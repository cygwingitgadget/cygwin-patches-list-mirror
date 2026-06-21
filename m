Return-Path: <SRS0=iHxA=ER=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 10E6B4BA2E0E
	for <cygwin-patches@cygwin.com>; Sun, 21 Jun 2026 06:45:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 10E6B4BA2E0E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 10E6B4BA2E0E
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1782024329; cv=none;
	b=QVFWWjLh3+9MlvJ0LMBVSbtXzTywyoDl5+YORmGEyyt3DNuaPmyy4bMPfsF0mHx3wsIS6nOmh+RZAQ0ttBI8qwU4pmO2BQnrqqLtcAeIhK0ZtNSOPdbAGJXbCh3mofCsEiwpzQ7GkwMPxaJgFA8uZWmz9OS/tMq/QaQne4Pd+as=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1782024329; c=relaxed/simple;
	bh=IgXz1VjYuq/XvGTuA9XPfbGGkR+jCua2f65mQQPfWpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=NSGI9nfS96x2Cb/KWx1qDKNRGKljnsVQD4++7vGOUM8F1B+vjeJZ/MZcCtOx91mzxKBButohxq8wbzBjxIm4N88uDJBNHUe93GWQxRnOQvJWY3SjYpuNypbXq0TCC01KbAsiovwP1jIcC5fFyzFtqG9JFyZMGx2KDfQbLekiC+s=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 10E6B4BA2E0E
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65L70VcU056512;
	Sun, 21 Jun 2026 00:00:31 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdwp1LJq; Sun Jun 21 00:00:24 2026
Message-ID: <fc159923-bb9c-46cd-b633-23f56a7c2fad@maxrnd.com>
Date: Sat, 20 Jun 2026 23:45:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: pty: Do not set input_available_event when
 applying line_edit()
To: Takashi Yano <takashi.yano@nifty.ne.jp>, cygwin-patches@cygwin.com
Cc: Koichi Murase <myoga.murase@gmail.com>
References: <20260608133414.1979-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260608133414.1979-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/8/2026 6:34 AM, Takashi Yano wrote:
> The commit a0b38a81b9be sets input_available_event even if the
> transferred input is still in the readahead buffer and is not ready
> to read. The SetEvent() is called in accept_input() via line_edit(),
> so setting this event here is not correct. This causes the issue
> that read() returns 0 instead of blocking until accept_input() is
> called. This patch removes this SetEvent() call.
> 
> Fixes: a0b38a81b9be ("Cygwin: pty: Apply line_edit() for transferred input to to_cyg")
> Addresses: https://cygwin.com/pipermail/cygwin/2026-June/259776.html
> Reported-by: Koichi Murase <myoga.murase@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/pty.cc | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index 80331c36d..2558fa799 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2946,7 +2946,6 @@ fhandler_pty_master::apply_line_edit_to_transferred_input ()
>         n -= ret;
>         p += ret;
>       }
> -  SetEvent (input_available_event);
>   }
>   
>   static DWORD

LGTM.  OK to push.

..mark
