Return-Path: <mark@maxrnd.com>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
 by sourceware.org (Postfix) with ESMTPS id AD6E23858D28
 for <cygwin-patches@cygwin.com>; Wed,  8 Dec 2021 09:43:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org AD6E23858D28
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=maxrnd.com
Received: (from daemon@localhost)
 by m0.truegem.net (8.12.11/8.12.11) id 1B89hp8X099588
 for <cygwin-patches@cygwin.com>; Wed, 8 Dec 2021 01:43:51 -0800 (PST)
 (envelope-from mark@maxrnd.com)
Received: from 162-235-43-67.lightspeed.irvnca.sbcglobal.net(162.235.43.67),
 claiming to be "[192.168.1.100]"
 via SMTP by m0.truegem.net, id smtpd1eJOnO; Wed Dec  8 01:43:45 2021
Subject: Re: [PATCH v2] Cygwin: clipboard: Fix a bug in read().
To: cygwin-patches@cygwin.com
References: <20211207140006.912-1-takashi.yano@nifty.ne.jp>
 <Ya9uU1JP8stQOB/l@calimero.vinschen.de>
 <c69ec6dd-fbbb-829c-9856-7f34cf0a792e@towo.net>
 <bc0170d9-1fcc-1659-beab-d11b01c37e5f@SystematicSw.ab.ca>
 <549e1dea-5545-50c5-fc1f-79c2c4982e8c@maxrnd.com>
 <20211208171929.68490866d4a07aac4b1ca0d7@nifty.ne.jp>
From: Mark Geisert <mark@maxrnd.com>
Message-ID: <3e5ea337-8748-7c1c-813d-29196b6ef68a@maxrnd.com>
Date: Wed, 8 Dec 2021 01:43:45 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Firefox/52.0 SeaMonkey/2.49.4
MIME-Version: 1.0
In-Reply-To: <20211208171929.68490866d4a07aac4b1ca0d7@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, SPF_HELO_NONE,
 SPF_NONE, TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 08 Dec 2021 09:43:56 -0000

Takashi Yano wrote:
[...]
> I think the following patch makes the intent clearer.
> What do you think?
> 
> 
>  From d0aee9af225384a24ac6301f987ce2e94f262500 Mon Sep 17 00:00:00 2001
> From: Takashi Yano <takashi.yano@nifty.ne.jp>
> Date: Wed, 8 Dec 2021 17:06:03 +0900
> Subject: [PATCH] Cygwin: clipboard: Make intent of the code clearer.
> 
> ---
>   winsup/cygwin/fhandler_clipboard.cc   | 4 ++--
>   winsup/cygwin/include/sys/clipboard.h | 1 +
>   2 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler_clipboard.cc b/winsup/cygwin/fhandler_clipboard.cc
> index 05f54ffb3..65a3cad97 100644
> --- a/winsup/cygwin/fhandler_clipboard.cc
> +++ b/winsup/cygwin/fhandler_clipboard.cc
> @@ -76,7 +76,7 @@ fhandler_dev_clipboard::set_clipboard (const void *buf, size_t len)
>         clipbuf->cb_sec  = clipbuf->ts.tv_sec;
>   #endif
>         clipbuf->cb_size = len;
> -      memcpy (&clipbuf[1], buf, len); // append user-supplied data
> +      memcpy (clipbuf->data, buf, len); // append user-supplied data
>   
>         GlobalUnlock (hmem);
>         EmptyClipboard ();
> @@ -229,7 +229,7 @@ fhandler_dev_clipboard::read (void *ptr, size_t& len)
>         if (pos < (off_t) clipbuf->cb_size)
>   	{
>   	  ret = (len > (clipbuf->cb_size - pos)) ? clipbuf->cb_size - pos : len;
> -	  memcpy (ptr, (char *) (clipbuf + 1) + pos, ret);
> +	  memcpy (ptr, clipbuf->data + pos, ret);
>   	  pos += ret;
>   	}
>       }
> diff --git a/winsup/cygwin/include/sys/clipboard.h b/winsup/cygwin/include/sys/clipboard.h
> index 4c00c8ea1..b2544be85 100644
> --- a/winsup/cygwin/include/sys/clipboard.h
> +++ b/winsup/cygwin/include/sys/clipboard.h
> @@ -44,6 +44,7 @@ typedef struct
>       };
>     };
>     uint64_t      cb_size; // 8 bytes everywhere
> +  char          data[];
>   } cygcb_t;
>   
>   #endif

Sigh.  I guess it's not possible to keep rid of a data item like I'd hoped.  At 
least "data[]" is cleaner than the historical "data[1]" here.  If you call the 
item cb_data I can live with it.
Thanks all for the discussion.

..mark
