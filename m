Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	by sourceware.org (Postfix) with ESMTPS id CD35B38923E2
	for <cygwin-patches@cygwin.com>; Fri,  9 Dec 2022 09:59:30 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N5W4y-1osIYd0rXe-016weF for <cygwin-patches@cygwin.com>; Fri, 09 Dec 2022
 10:59:29 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 354E8A8079F; Fri,  9 Dec 2022 10:59:28 +0100 (CET)
Date: Fri, 9 Dec 2022 10:59:28 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Fix performance degradation for non-cygwin
 pipe.
Message-ID: <Y5MHAA1uwGwnHWZc@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20221209004927.614-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221209004927.614-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:voFocmkc9uMkicyG79nOS9bUA2nBjjBHpyN6uY+bH3h0BmrQcnh
 QjU7Tzvxe8uzkhlV+oOyeVzRxctMfS6vXQKQ1hMkEO00slJtLFVZpLg8yR2DRMwm90TP23L
 CyFuhF8c4m95T6oH5ql2RMnUCOmCEFcjEn3n9n9LfBVkzYuakfsHamJMYSxdzXkEq13LFZL
 D+VXVAXcq1t1uIRFBWZwQ==
UI-OutboundReport: notjunk:1;M01:P0:biWsKKOF8BI=;C0FrumzHkiSSZpxfFf0ExQHqelR
 Yw3/dk7tqAzTQKrJsxShS7dL+nEgRJ6VsfzK5oZmvWD7s/GAr/TpfupEzP0sdO83Xd526GP4B
 i5nWEYTV8Guie6GdJPm6Xiap5r9LGV+NFmmQ+9Kl5oU5872nXOBJv4Kk2w6X7qf5cEXBbH6l7
 C0xA5IYLebh/26QPs8db7QNF4CnpISga7kW5lWDoQHe3/zohH3bcfV8qELGw6U1CwCFKZUzGE
 TrtmmppSS6kD7nvv5W6t2QCK0O/4/c8yppkwe/F9ZOHl11XDLWR0McKq4x/7bgxJLjjg20tIR
 UVyDXsBwyGYGsVgb9qR2+YwZJYVPtgjPxFhFuAEe62ZsfhuUj+5oPubt5lH70uZx88tQr3Zmi
 JYgcIdacHtqpyIl9pWGue9+aeYchp/zYTAknJE6sCreRXVqHzIejV6wCOaIZuxDTSv83s7vHc
 JvCPG2HPgzittMvWYqLHnH15iAvt5oyQsQD/utpFYbOh05YAzaoOBEVUDgw91TwQLXVFNFijQ
 TBmJQMm35ILnm0d7cTR754QVWK/Lfy+vY3Cd+2dZ0z6McR/LjshOeiSqOAOZWmKaQEJgz8w9Q
 wxrc6g27Fs72g1gnmvNt5QIntddkWQpcnjwpfXEGQDfSmIXv//6ISzEeVinHRuFnjk2xinj2Q
 dXGNT/L6IULDbS4O8/nO1rcieVbbsi8G16DH9BuxWA==
X-Spam-Status: No, score=-101.4 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

both patches LGTM, feel free to push.  Your commit message looks great!


Thanks,
Corinna


On Dec  9 09:49, Takashi Yano wrote:
> https://cygwin.com/pipermail/cygwin/2022-December/252628.html
> 
> After the commit 9e4d308cd592, the performance of read from non-cygwin
> pipe has been degraded. This is because select_sem mechanism does not
> work for non-cygwin pipe. This patch fixes the issue.
> 
> Fixes: 9e4d308cd592 ("Cygwin: pipe: Adopt FILE_SYNCHRONOUS_IO_NONALERT
> flag for read pipe.")
> Reported-by: tryandbuy <tryandbuy@proton.me>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc | 16 +++++++++++++++-
>  winsup/cygwin/release/3.4.1    |  3 +++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.cc
> index 720e4efd3..e23131668 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -281,6 +281,8 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>    size_t nbytes = 0;
>    NTSTATUS status = STATUS_SUCCESS;
>    IO_STATUS_BLOCK io;
> +  ULONGLONG t0 = GetTickCount64 (); /* Init timer */
> +  const ULONGLONG t0_threshold = 20;
>  
>    if (!len)
>      return;
> @@ -312,6 +314,7 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>      {
>        ULONG_PTR nbytes_now = 0;
>        ULONG len1 = (ULONG) (len - nbytes);
> +      DWORD select_sem_timeout = 0;
>  
>        FILE_PIPE_LOCAL_INFORMATION fpli;
>        status = NtQueryInformationFile (get_handle (), &io,
> @@ -358,7 +361,18 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>  		  nbytes = (size_t) -1;
>  		  break;
>  		}
> -	      waitret = cygwait (select_sem, 1);
> +	      /* If the pipe is a non-cygwin pipe, select_sem trick
> +		 does not work. As a result, the following cygwait()
> +		 will return only after timeout occurs. This causes
> +		 performance degradation. However, setting timeout
> +		 to zero causes high CPU load. So, set timeout to
> +		 non-zero only when select_sem is valid or pipe is
> +		 not ready to read for more than t0_threshold.
> +		 This prevents both the performance degradation and
> +		 the high CPU load. */
> +	      if (select_sem || GetTickCount64 () - t0 > t0_threshold)
> +		select_sem_timeout = 1;
> +	      waitret = cygwait (select_sem, select_sem_timeout);
>  	      if (waitret == WAIT_CANCELED)
>  		pthread::static_cancel_self ();
>  	      else if (waitret == WAIT_SIGNALED)
> diff --git a/winsup/cygwin/release/3.4.1 b/winsup/cygwin/release/3.4.1
> index 432113a55..afe7e86f9 100644
> --- a/winsup/cygwin/release/3.4.1
> +++ b/winsup/cygwin/release/3.4.1
> @@ -8,3 +8,6 @@ Bug Fixes
>  - Fix a backward incompatibility problem in the definition of the
>    base type of the stdio type FILE.
>    Addresses: https://savannah.gnu.org/bugs/index.php?63480
> +
> +- Fix performance degradation of non-cygwin pipe.
> +  Addresses: https://cygwin.com/pipermail/cygwin/2022-December/252628.html
> -- 
> 2.38.1
