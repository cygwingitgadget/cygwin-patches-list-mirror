Return-Path: <SRS0=ibs7=A4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w03.mail.nifty.com (mta-snd-w03.mail.nifty.com [106.153.227.35])
	by sourceware.org (Postfix) with ESMTPS id 5D95C4B9DB64
	for <cygwin-patches@cygwin.com>; Tue, 24 Feb 2026 00:46:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5D95C4B9DB64
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5D95C4B9DB64
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771893967; cv=none;
	b=gtCwNaHvOfHNnSsVKYIqsBpEFrwNVEvIz4mcwwS0w37a7TCfTLpTlrpKLk3lDgl8RFCS9G2xhEOuPYZ1qbz4cSXu7ilTqGDJVt17eVmW+8HOPyNjUGhCuIiZWJM9LXNCiDoQU/iU4qkT1cYBDuq/TkZ7icP+gAVvL4SN10PkGjc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771893967; c=relaxed/simple;
	bh=g29uQhyTLHBGCleMSnMM449J04A9SX9oNUAaGI52azA=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ilRb6HSpykdzLK67qb1SxK2HnyMlUDnBOWyY9NTa3SjJdEOjuNOpwOqoKV53oXmIbfL+alSiPgFi+V2FcArJRPSHAmGjqhgpPEaC063BDUUu8UmA1ah/vFhbrjgMhflcvXyr0Ha8WxZAOwqdpKLwckqz4lQaWMVo3lhrZjV4jRE=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5D95C4B9DB64
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mAzIT6TN
Received: from HP-Z230 by mta-snd-w03.mail.nifty.com with ESMTP
          id <20260224004601562.IREY.130342.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 24 Feb 2026 09:46:01 +0900
Date: Tue, 24 Feb 2026 09:46:00 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Discard remnants of win32-input-mode
Message-Id: <20260224094600.b274e016835a27277950fd41@nifty.ne.jp>
In-Reply-To: <20260223080031.320-1-takashi.yano@nifty.ne.jp>
References: <20260223080031.320-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1771893961;
 bh=+xiDpM6l02xEpjVomju07NPjj5ZhriRDCTvTfLVGJpg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mAzIT6TN/uurugvthPhulD6Le2AMOrq6Ugx7i1N1UVMFvY/PABZ71NkunEjN22HhhiFOW45q
 aG+BRuokF4wFKD0PdyUbgb8N3MkpglKIHNCQzDlzIQzgTjNEa6YsZ0f+bJjzMqiQYp/HfoEJNC
 YnsZpbw7TjWYMEVaFhsmvNapvYetapV0Rbeo1Pydq/TMuJ9D0rKY8lLH+q88Y9V3849a3nswJV
 1lGa/RMlSeAyFmnJnGDUFKWf9fsCksxwnO0glwgcOE45JEYLdmodaO3Cm9f3skY05MbKqxCges
 gIt//jDOFNUonAqi/ZRP4dqEL/2qkuEU6cz5XQMD894Hc7Dw==
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Mon, 23 Feb 2026 17:00:19 +0900
Takashi Yano wrote:
> In Windoes 11, some remnants sequences of win32-input-mode used by
> pseudo console occasionally sent to shell which start non-cygwin
> apps. With this patch, the remnants sequneces just after closing
> pseudo console will be discarded.
> 
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc      | 11 +++++++++++
>  winsup/cygwin/local_includes/tty.h |  1 +
>  winsup/cygwin/tty.cc               |  1 +
>  3 files changed, 13 insertions(+)
> 
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> index b30cb0128..b90b2b609 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2504,6 +2504,16 @@ fhandler_pty_master::write (const void *ptr, size_t len)
>        return len;
>      }
>  
> +  /* Remnants of win32-input-mode sequence in pcon_activated mode */
> +  bool is_remnants_to_nat =
> +    GetTickCount64 () - get_ttyp ()->pcon_close_time < 32

32msec deos not seem enough for some application.
I tested for several non-cygwin apps and observed 140sec max.

So ~200msec might be more appropriate.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
