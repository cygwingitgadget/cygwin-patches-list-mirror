Return-Path: <SRS0=x2P2=HK=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id E046F4BA79AD
	for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 09:13:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E046F4BA79AD
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E046F4BA79AD
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789722797; cv=none;
	b=WBtHAO0APWKLOgR2PAt4XkngMoqWnOlsiiG/0n8WpIcymXeqDa9fpIeIHKM6/BnBK2TH/lv3F+lZHnhQM+JeWbPjr6se34SfG9fBYYWlnPCFlWpp6V0syqZvLtBrf5sUYxgtyiwAtVlKB7rxkVP1NxuzU2k73D84ALGRxEqsh+o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789722797; c=relaxed/simple;
	bh=sRknc8tEqJzzFiyW8IYDiZ+Q85Ud/NKYhrxh5EbEWYE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=PyVj32v7ZI9EzU6ve2Y4BrjyOr+qAIDkcJXoz+kn8SmNHP7LUjLcl6elXtC9iRwBM7KSbKQd8dNWlu5f+4BdMvuPtCwa8tF4pJQjXC0011KaqEltl/IFmOcMGFKhTIgvZvXlQyLnKWtKaU9laCa0hSwiYk4MINfOasZHZXwSe7M=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E046F4BA79AD
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 68I9R4BB016490
	for <cygwin-patches@cygwin.com>; Fri, 18 Sep 2026 02:27:04 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdFqS2ha; Fri Sep 18 02:26:59 2026
Message-ID: <222ce10a-2691-47b0-8fc3-ed915267b7fd@maxrnd.com>
Date: Fri, 18 Sep 2026 02:13:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: clipboard: Handle ERROR_SYS_KEY_NOT_FOUND and
 NO_ERROR
To: cygwin-patches@cygwin.com
References: <20260918013226.1205-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260918013226.1205-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 9/17/2026 6:32 PM, Takashi Yano wrote:
> Windows 10 seems to return ERROR_SYS_KEY_NOT_FOUND instead of
> ERROR_NOT_FOUND. In addition, it returns NO_ERROR even though
> GetClipboardData() returns NULL. This patch handles these cases.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2026-September/260058.html
> Fixes: 7fd670a36b9a ("Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN")
> Reported-by: Shun <shun1048576@gmail.com>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>   winsup/cygwin/fhandler/clipboard.cc | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/clipboard.cc b/winsup/cygwin/fhandler/clipboard.cc
> index 116feb599..391f21051 100644
> --- a/winsup/cygwin/fhandler/clipboard.cc
> +++ b/winsup/cygwin/fhandler/clipboard.cc
> @@ -41,7 +41,10 @@ open_clipboard ()
>   	  DWORD err = GetLastError ();
>   	  /* Here, ERROR_NOT_FOUND means the clipboard does not contains
>   	     valid CF_UNICODETEXT. OpenClipboard() must have succeeded. */
> -	  if (err == ERROR_NOT_FOUND)
> +	  /* In Windows 10, ERROR_SYS_KEY_NOT_FOUND or NO_ERROR seem
> +	     to be returned instead of ERROR_NOT_FOUND. */
> +	  if (err == ERROR_NOT_FOUND || err == ERROR_SXS_KEY_NOT_FOUND
> +	      || err == NO_ERROR)
>   	    return true;
>   	  CloseClipboard ();
>   	  if (err != ERROR_CLIPBOARD_NOT_OPEN)

The patch LGTM as long as you fix spelling of ERROR_SYS_KEY_NOT_FOUND.

It belatedly occurs to me it might be nice to report the error somewhere 
if it's not one of the ones we check for.  Use debug_printf() for that 
if you decide to do this.  I understand the OP is running an LTSC 
version of Windows 10 which will likely diverge from EOL'd Windows 10 as 
time goes on (since the latter may be getting updates).
Thanks & Regards,

..mark
