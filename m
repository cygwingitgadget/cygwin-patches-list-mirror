Return-Path: <SRS0=wGG/=EI=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id ABEF84BAD17F
	for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 23:08:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org ABEF84BAD17F
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org ABEF84BAD17F
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781305704; cv=none;
	b=vTs5G94IJCJ+x1tZ54HOTOwISKyZxJ8LAkfrunwuPjuGm2LaBHQ7uHs9ZXUZOQ5IGfyRy9niUghiDAvDMBVZGuH9XGygL2WUQD1H2Xjhro0Yu5A8jwvm51pxsbEfX6p4xUZU3Kr+XVz3+X6UHBLzGkWXR6XMDSQoQUpWe5ws4v0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781305704; c=relaxed/simple;
	bh=DojGIwSc22Rt2xi53HfIeehaktzROKNql9eCL7cAry0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=cy6uEdQLYcViqUt6a9+x1CkOO8BNr61wsFwj2H7RVrTIddV7wzmUgPGaf7B+tito5xxwYLUT1kGJ2VtnKtuRnMHftk4iz8+CVUrjLgG0w9HGLuKec9JebNa5n/q5ti9duCNp4TK7KTFAUOCROF9jR5Ujlp6ZCiQkT7B9pOiGuWU=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org ABEF84BAD17F
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65CNNVuc099285
	for <cygwin-patches@cygwin.com>; Fri, 12 Jun 2026 16:23:31 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdHzMmDZ; Fri Jun 12 16:23:29 2026
Message-ID: <0fcb54fd-6369-4904-ad97-26882cf151f9@maxrnd.com>
Date: Fri, 12 Jun 2026 16:08:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: clipboard: Add workaround for
 ERROR_CLIPBOARD_NOT_OPEN
To: cygwin-patches@cygwin.com
References: <20260609002100.615-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260609002100.615-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/8/2026 5:20 PM, Takashi Yano wrote:
> SetClipboard/Data() and GetClipboardData() occasionally fail with
> ERROR_CLIPBOARD_NOT_OPEN, even though OpenClipboard() succeeded if
> NULL HWND is used. Retry until GetClipboardData() does not return
> ERROR_CLIPBOARD_NOT_OPEN.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2026-February/259438.html
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Mark Geisert <mark@maxrnd.com>

Sorry, I didn't read ^^^ as a request to review, and then forgot to ask 
about it...

> ---
>   winsup/cygwin/fhandler/clipboard.cc | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
> index 12691c7c1..db33d839f 100644
> --- a/winsup/cygwin/fhandler/clipboard.cc
> +++ b/winsup/cygwin/fhandler/clipboard.cc
> @@ -25,11 +25,21 @@ details. */
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
> +	  /* SetClipboard/Data() and GetClipboardData() occasionally
> +	     fail with ERROR_CLIPBOARD_NOT_OPEN, even though
> +	     OpenClipboard() succeeded if NULL HWND is used.
> +	     Retry until GetClipboardData() does not return
> +	     ERROR_CLIPBOARD_NOT_OPEN. */
> +	  if (GetClipboardData (CF_UNICODETEXT)
> +	      || GetLastError () != ERROR_CLIPBOARD_NOT_OPEN)
> +	    return true;

I don't think this 'if' is quite right.  If GetClipboardData(...) 
succeeds, return true.  Otherwise, if GetLastError() returns 
ERROR_CLIPBOARD_NOT_OPEN, continue the loop.  Otherwise either break the 
loop or return false right there.

Do you agree with my reasoning?  I'm open to corrections.
Regards,

..mark
