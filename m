Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 581274BA5439; Wed, 15 Apr 2026 10:23:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 581274BA5439
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1776248599;
	bh=1fa24v7+W3LYmRbp5am8PRml080/UN/Op/Be2sILTpw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=fen683X0t9fxJQcrSEo0BtOD4la3SuL3gSV3KF56kXvnIK73SpzSpJSOHTxFXSj6S
	 ZPbfbTWxRohpNuneaCpkUMgvR5NUhuepoZ3LGxhlJ6wnJitXGGqQhHfslRTrYjknaB
	 yDjy2S768OQdMgFW2WkBMlGRQ7CmSePfD5nmOfQw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 75502A80D5A; Wed, 15 Apr 2026 12:23:17 +0200 (CEST)
Date: Wed, 15 Apr 2026 12:23:17 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-ID: <ad9nFVfkt4Qstgbv@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260415041339.1837-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260415041339.1837-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Apr 15 13:13, Takashi Yano wrote:
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
>  winsup/cygwin/fhandler/pty.cc        | 32 +++++++++------------
>  winsup/cygwin/fhandler/termios.cc    | 27 ++++++-----------
>  winsup/cygwin/local_includes/pinfo.h | 43 ++++++++++++++++++++++++++--
>  winsup/cygwin/tty.cc                 |  7 ++---
>  4 files changed, 65 insertions(+), 44 deletions(-)

Yeah, that looks good, especially the patch is now a bit
more concise in the actual code.  LGTM.


Thanks,
Corinna
