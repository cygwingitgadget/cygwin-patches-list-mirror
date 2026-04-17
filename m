Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id E0C864BA2E3B; Fri, 17 Apr 2026 12:02:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E0C864BA2E3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1776427362;
	bh=mvTz+cfvTh/BkyAvKDplOvJqu/BAKV0vvT8jplN76pQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=SLep02LvKzzcTGXCAjNw9Kxd+oZUNUGSaMYzBEgbb2eDSq8syBBvm2ix+3oKSQk4y
	 59+ZFr3jBHmUuohAcCy8loKNcZ350VEtp5l+OBMeT2HJDy44LJhL8gk/yPsB9A5IiF
	 g6nsKT+164kacrBooGu7AfYTpmGgM0RPkYodg1/0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id E498CA80C19; Fri, 17 Apr 2026 14:02:40 +0200 (CEST)
Date: Fri, 17 Apr 2026 14:02:40 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-ID: <aeIhYHuCfXlCwSom@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260417104847.10575-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260417104847.10575-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

yes, please go ahead.

Btw., for v2, v3, etc it would be helpful for reviewers to see
a short note what has changed in the comment section following the 
three dashes.  E.g.

  v1: add foo
  [...]
  v4: replace foo with bar


Thanks,
Corinna


On Apr 17 19:48, Takashi Yano wrote:
> At some point in the past, GDB sets terminal pgid to inferior pid
> when the inferior is running. Moreover, the inferior is non-cygwin
> process, GDB sets the terminal pgid to windows pid of the inferior.
> Due to this behaviour, Ctrl-C does not work if the inferior is a
> non-cygwin app. This is because, the current code sends Ctrl-C to
> GDB only when GDB's pgid equeals to terminal pgid. This patch omit
> checking pgid when recognizing GDB process whose inferior is non-
> cygwin app. This patch also fixes the issue that the cygwin debuggee
> under strace cannot be terminated by Ctrl-C.
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
>  winsup/cygwin/exceptions.cc          |  4 +--
>  winsup/cygwin/fhandler/pty.cc        |  7 ++--
>  winsup/cygwin/fhandler/termios.cc    | 54 +++++++++++-----------------
>  winsup/cygwin/local_includes/pinfo.h | 42 ++++++++++++++++++++--
>  winsup/cygwin/tty.cc                 |  7 ++--
>  5 files changed, 69 insertions(+), 45 deletions(-)
