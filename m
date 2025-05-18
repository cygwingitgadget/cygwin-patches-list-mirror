Return-Path: <SRS0=meub=YC=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e02.mail.nifty.com (mta-snd-e02.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:22])
	by sourceware.org (Postfix) with ESMTPS id 1642E3858D1E
	for <cygwin-patches@cygwin.com>; Sun, 18 May 2025 06:12:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1642E3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1642E3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1747548725; cv=none;
	b=SHVtz8kwWiJRSquW2jsNEIwlqxXo7j4pnLqjtrHQ6Sf8oGzd/6sQaA6R3vfF96iRf8YvNvk136ltNtcaURG03CZCsnfYJ8K3Bj9eWL8ObxlI66qh7IaUjnXLCLHMetdiHFvA4zSHcGl9R8ZXlWCrn/j7fr5drnuGxyu8YyWsNtQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1747548725; c=relaxed/simple;
	bh=vxZqV+eGYj3sM+qC8jlAfqVJ3bHEBDdkLc84PZoBA84=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=oFAI6ZMDK7jGDSoiHWumcodarcSSmYvjI+R5pmIFSAU41B9fpSrjpIeRETRpiBzx5exIbojjL2dQiAB1qkaPVbJicioQz+C54puku98yHv9iAHdfUdFpxoQhriXI9VI+T7i3c8uc7waejuj6vXZoA4VZpMhokBFZL62xGGKDfX8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1642E3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=XLr/GOzV
Received: from HP-Z230 by mta-snd-e02.mail.nifty.com with ESMTP
          id <20250518061201918.HXIM.45927.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 18 May 2025 15:12:01 +0900
Date: Sun, 18 May 2025 15:11:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Only return true from try_to_debug() if we
 launched a JIT debugger
Message-Id: <20250518151159.cb5a58b59f66bf90efa93826@nifty.ne.jp>
In-Reply-To: <20250517140054.1826-1-jon.turney@dronecode.org.uk>
References: <20250517140054.1826-1-jon.turney@dronecode.org.uk>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1747548721;
 bh=V9FHfcJYUYI4V50Aojk4eUrzNj/azhsg2DmWpsLkmyc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=XLr/GOzVABaXjj81u3JRKrjAvjiAkUml+zRAzd8NZWEQ/QbkwQk6QnXlhPSJd4580ok/Y52S
 aD8X7DSKks5AxgmHawD7GHW5cUZauV22mX9d6/s82ESyPyZVJFvpBkkfxB8LXuq/vwY9q195KX
 TLtF7y3xg0jphxufWoMoOTPU3Iyr0yU9Rpwk+vZvwQzfB8J+7LaxTzhyYgA5cNGa/8dx5OBfDt
 n1iAPWZI2lSJy7jiic/3lY76xsfhahA6FVS9tjgbueYA8nCYYWjAZn0D9uQRZ73ZIP7XM32wIK
 83WCsVJwp5wCIqhR2B+rHyroV2SKX3EZ4ddMmy+pHlxSJoBA==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 17 May 2025 15:00:53 +0100
Jon Turney wrote:

> This fixes constantly replaying the exception if we have a segfault
> while a debugger is already attached, e.g. stracing a segv, see:
> 
> https://cygwin.com/pipermail/cygwin/2025-May/258144.html
> 
> (I'm tempted to remove the 'debugging' static from exception::handle()
> and everything associated with it, since replaying the exception the
> next half a million times it's hit seems really weird)
> 
> (This would seem to make try_to_debug() less useful, as it then does
> nothing if you're just run under gdb, but it's what the code used to
> do...)

I don't understand what the sentences in ()s mean.

> Fixes: 91457377d6c9 ("Cygwin: Make 'ulimit -c' control writing a coredump")

Please add "Signed-off-by:". I also think it is better to add
"Reported-by:".

> ---
>  winsup/cygwin/exceptions.cc | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/winsup/cygwin/exceptions.cc b/winsup/cygwin/exceptions.cc
> index 9763a1b04..3a0315fd0 100644
> --- a/winsup/cygwin/exceptions.cc
> +++ b/winsup/cygwin/exceptions.cc
> @@ -591,13 +591,16 @@ int exec_prepared_command (PWCHAR command)
>  extern "C" int
>  try_to_debug ()
>  {
> +  if (!debugger_command)
> +    return 0;
> +
>    /* If already being debugged, break into the debugger (Note that this function
>       can be called from places other than an exception) */
>    if (being_debugged ())
>      {
>        extern void break_here ();
>        break_here ();
> -      return 1;
> +      return 0;
>      }
>  
>    /* Otherwise, invoke the JIT debugger, if set */
> @@ -812,6 +815,8 @@ exception::handle (EXCEPTION_RECORD *e, exception_list *frame, CONTEXT *in,
>    else if (try_to_debug ())
>      {
>        debugging = 1;
> +      /* If a JIT debugger just attached, replay the exception for the benefit
> +	 of that */
>        return ExceptionContinueExecution;
>      }
>  
> -- 
> 2.45.1

Otherwise, LGTM. Please push.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
