Return-Path: <SRS0=/D8B=EJ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4E2764B99F48
	for <cygwin-patches@cygwin.com>; Sat, 13 Jun 2026 05:55:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4E2764B99F48
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4E2764B99F48
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781330110; cv=none;
	b=Y7hrLpaUHkGTdqzs2qh3n4FjirRlnNdCaAIDbk0ijS4fNf5pcvgBcPB6dCMhvUtWme2ABHOJ5ca0zxN0EQpFixZoyD7qaXiGYEhBp5fyARF5zLPabQvzqKNeUhdEhJ1H+MawOGPpylduH9P9ttO0t7WysSM67Obq39oRoSWvIoQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781330110; c=relaxed/simple;
	bh=iCc2S3AXAzmJneDcF+ohevW16/XRdZUbiyI9qKC+VbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=KQeloGZo/Izq9UpyYaUhjXJX/tBbwYNGbvbjP8jbZspzAv/Izcuolv29YZkd1yy9YrIaZn3e5FMJfKnA/2W5802aJidyNQ8XF7AIQTCDoZO5+FXIhMwhWqMD/0FK7Zsk1NCG9s96ZA2Ma8rgJGG+dBsAO7T0qDXSy34ImhflPMk=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4E2764B99F48
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65D6AGnb035020
	for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 23:10:16 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdxD9H5n; Fri Jun 12 23:10:07 2026
Message-ID: <a141abf4-29f6-4259-bb10-d4f45a9996d1@maxrnd.com>
Date: Fri, 12 Jun 2026 22:55:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Cygwin: clipboard: Add workaround for
 ERROR_CLIPBOARD_NOT_OPEN
To: cygwin-patches@cygwin.com
References: <20260613025412.642-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260613025412.642-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/12/2026 7:54 PM, Takashi Yano wrote:
> SetClipboardData() and GetClipboardData() occasionally fail with
> ERROR_CLIPBOARD_NOT_OPEN, even though OpenClipboard() succeeded if
> NULL HWND is used. Retry until GetClipboardData() does not return
> ERROR_CLIPBOARD_NOT_OPEN.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2026-February/259438.html
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>
> ---
> v2: Handle ERROR_NOT_FOUND case. Call CloseClipboard() in the loop.
> v3: Change the timing of CloseClipboard().

Thanks for catching this ^^^ I was just about to mention it myself...

>   winsup/cygwin/fhandler/clipboard.cc | 19 +++++++++++++++++--
>   1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
> index 12691c7c1..1273863f4 100644
> --- a/winsup/cygwin/fhandler/clipboard.cc
> +++ b/winsup/cygwin/fhandler/clipboard.cc
> @@ -25,11 +25,26 @@ details. */
>   static inline bool
>   open_clipboard ()
>   {
> -  const int max_retry = 10;
> +  const int max_retry = 20;
>     for (int i = 0; i < max_retry; i++)
>       {
> +      /* No appropriate HWND exists here. */
>         if (OpenClipboard (NULL))
> -	return true;
> +	{
> +	  /* SetClipboardData() and GetClipboardData() occasionally
> +	     fail with ERROR_CLIPBOARD_NOT_OPEN, even though
> +	     OpenClipboard() succeeded if NULL HWND is used.
> +	     Retry until GetClipboardData() does not return
> +	     ERROR_CLIPBOARD_NOT_OPEN. */
> +	  if (GetClipboardData (CF_UNICODETEXT))
> +	    return true;
> +	  DWORD err = GetLastError ();

Given the ambiguity of "ERROR_NOT_FOUND" I would add a one-line comment 
here saying ERROR_NOT_FOUND means GetClipboardData() couldn't find 
CF_UNICODETEXT data, but it would return data if you ask for the correct 
format. This latter case means the clipboard is indeed open. (Or some 
briefer way of saying this complicated case.)

Hmm. Maybe more than one line for that comment. With that, patch is GTG.

> +	  if (err == ERROR_NOT_FOUND)
> +	    return true;
> +	  CloseClipboard ();
> +	  if (err != ERROR_CLIPBOARD_NOT_OPEN)
> +	    return false;
> +	}
>         Sleep (1);
>       }
>     return false;

Thanks & Regards,

..mark

