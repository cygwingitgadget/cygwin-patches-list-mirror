Return-Path: <SRS0=9Zje=CO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 28D764BA2E0A
	for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 17:47:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 28D764BA2E0A
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 28D764BA2E0A
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776275263; cv=none;
	b=Nul5p+G1TqmOaijXhQjiW4PgRR7RwWkd5FLzulQimBRSEenU9E2L7Gn5EuOoNG5EUsyBdvplkhgV+R2aTwflSrsNJ596KLY+9YuRqtiZqnHS2KZXqMzz6dSQsg3RjpMuYplPAs4ujZgySnZprjppie5bJ0kdxqnVIuWizWAr2Kc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776275263; c=relaxed/simple;
	bh=PxC61PYxOTK6tw26vNo2HHbHtpPeKE0ofywnBp96ltc=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=LrI46FgjDln6quYO1KJhg0RJ3leUoi9eFeOnf1/PKS8W1BautkRaD3ehdhNlRgFb0pbtVXtOlb+bBmDG2jVmveJriKj+CiToumZQ1BkATy+mAEe9549BdVY2AswbxHwhPIG7HTz62mvgN9NNbmaajMXGkZcOuguEJzz5QjULLQs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 28D764BA2E0A
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rBk4vPPA
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260415174739489.DQNC.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 16 Apr 2026 02:47:39 +0900
Date: Thu, 16 Apr 2026 02:47:38 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-Id: <20260416024738.1a525470ff3658b19dfd8249@nifty.ne.jp>
In-Reply-To: <20260415111123.5952-1-takashi.yano@nifty.ne.jp>
References: <20260415111123.5952-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776275259;
 bh=HTVm311cox059O0LveZY7dNQehqgqMl+lwP1NLpwAB4=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=rBk4vPPAVphqueOSe6tQq+tyCo59/WoCtZ17NUaQn3LBCbDcUTVLfZjh3fNrdj4m7i8tLVzT
 2tTIDhiPyO+iWCPVomVRJSUrsfPcKzor04pYMWQw6riLUJxAi1vt/Bvcg6xx+7A7CYp3k85giW
 uFBc/Uwt0LF1LoukeLOpCinLyDvUJzqbPKlLncY1+mySf9oVrCxMCYVP/i5+myK36EdusKXTEZ
 cisi4WhlCn9aJFRhQa2/kx71KljYraF+uYZdJXvBWNuTcLt8o52uJnzhxE+3KJyoRLuQEbYDjd
 92nqe9rVFg8bgdBbntQuYcIbJwL4UxhMCQhC3eF8P7BUBURg==
X-Spam-Status: No, score=-12.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 15 Apr 2026 20:11:11 +0900
Takashi Yano <takashi.yano@nifty.ne.jp> wrote:

> At some point in the past, GDB sets terminal pgid to inferior pid
> when the inferior is running. Moreover, the inferior is non-cygwin
> process, GDB sets the terminal pgid to windows pid of the inferior.
> Due to this behaviour, Ctrl-C does not work if the inferior is a
> non-cygwin app. This is because, the current code sends Ctrl-C to
> GDB only when GDB's pgid equeals to terminal pgid. This patch omit
> checking pgid when recognizing GDB process whose inferior is non-
> cygwin app.
> 
> In addition, to improve the readabiliby of the code, this patch
> introduces inline functions such as:
> is_foreground_special_process (),
> is_gdb_with_foreground_non_cygwin_inferior (), etc.,
> instead of complicated conditions in 'if' clauses.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
> ---
>  winsup/cygwin/fhandler/pty.cc        |  7 +++---
>  winsup/cygwin/fhandler/termios.cc    | 27 +++++++---------------
>  winsup/cygwin/local_includes/pinfo.h | 34 +++++++++++++++++++++++++---
>  winsup/cygwin/tty.cc                 |  7 +++---
>  4 files changed, 46 insertions(+), 29 deletions(-)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index cdfb363c9..64a25691f 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -384,6 +384,7 @@ atexit_func (void)
>  	    break;
>  	  }
>        CloseHandle (h_gdb_inferior);
> +      myself->wpid_debuggee_maybe = 0;
>      }
>  }
>  
> @@ -420,6 +421,7 @@ CreateProcessA_Hooked
>    DuplicateHandle (GetCurrentProcess (), h_gdb_inferior,
>  		   GetCurrentProcess (), &h_gdb_inferior,
>  		   0, 0, DUPLICATE_SAME_ACCESS);
> +  myself->wpid_debuggee_maybe = GetProcessId (h_gdb_inferior);

myself->wpid_debuggee_maybe = p.dwProcessId;


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
