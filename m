Return-Path: <SRS0=Wk1n=CQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id CE6124CD2032
	for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2026 17:27:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CE6124CD2032
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CE6124CD2032
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776446861; cv=none;
	b=ZLnKyN5mv0jDGkXyP4TXJyy4dYd37sF+XqMsx67Y40oggzfwkRO33t5cnT6pb1bFtBIKBGDdGky49y1WXREYZJHYcw3WQ1C4BbptJdP2b97MyG0nfZJ9ZoFiZ4eD5rdTAhpMY4fOsOqXKSaKUaAhdMZVLKXsgYRdCNuSNJfdT1k=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776446861; c=relaxed/simple;
	bh=E+lAEHNoS7QybLZqrMR7HusAReMlCCyoI0NCavNfbdY=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=VORd/n71l+rXGuiBzVUSay8GN4YUeALJ9uwssKQ1nF46bgOE9IjgUmIkpGf0+91pKDTMRb43t9TH0ZH912JqwOXnUuMLmFEkBDRJif7p+XdppGBQJkdLTlTY41Qb02yRCfw6beUnEo02WPI0m6lBRtAhEpqF8H/SWSvihGXm0hI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CE6124CD2032
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dimBpLrU
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260417172737669.HSUM.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 02:27:37 +0900
Date: Sat, 18 Apr 2026 02:27:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-Id: <20260418022737.578e70457e1ef08af1ce47c0@nifty.ne.jp>
In-Reply-To: <aeIhYHuCfXlCwSom@calimero.vinschen.de>
References: <20260417104847.10575-1-takashi.yano@nifty.ne.jp>
	<aeIhYHuCfXlCwSom@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776446857;
 bh=jNf0UASLs3PYgPXstUvy31fJ1+Mz8D3GO/IMEkftNKg=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=dimBpLrUrlNvhxoQfpAanjMrTGDbLLAdW1uHOH6ffpme0uhHY3TpztMXN107q29nytEo1nHq
 gqcDj+p4wNKV1g2E/2rZQQjTA407vITkxMYD5cCM4YYs0B+pN6e2SFnymMLCJfBQUGWKUHWRSb
 5JfUoXl6QzXKIlJJJpQJ4JK5XYBOO5CC5cKJ0F5g2MpMBJijlQ6j0557LPJtwMZa6KmeAz1nbP
 3bOfmpX/o+4at3bmHAogQbuAO/y2bLn+05J4C3FKlTXMXpNCI+6jarOsv+9UmDSgfH7SxGnyLE
 9MMkIV5yCN3WT9yJP/52AGYvR4SfgVhx+moVDAXge9eD5flQ==
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 17 Apr 2026 14:02:40 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> yes, please go ahead.

Thanks for reviewing again!

> Btw., for v2, v3, etc it would be helpful for reviewers to see
> a short note what has changed in the comment section following the 
> three dashes.  E.g.
> 
>   v1: add foo
>   [...]
>   v4: replace foo with bar

Thanks for the advice. Like this?

From d0978ce7454beb2e239936ade256dce447aa0c0a Mon Sep 17 00:00:00 2001
From: Takashi Yano <takashi.yano@nifty.ne.jp>
Date: Sat, 28 Feb 2026 15:48:51 +0900
Subject: [PATCH v5] Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB

At some point in the past, GDB sets terminal pgid to inferior pid
when the inferior is running. Moreover, the inferior is non-cygwin
process, GDB sets the terminal pgid to windows pid of the inferior.
Due to this behaviour, Ctrl-C does not work if the inferior is a
non-cygwin app. This is because, the current code sends Ctrl-C to
GDB only when GDB's pgid equeals to terminal pgid. This patch omit
checking pgid when recognizing GDB process whose inferior is non-
cygwin app. This patch also fixes the issue that the cygwin debuggee
under strace cannot be terminated by Ctrl-C.

In addition, to improve the readabiliby of the code, this patch
introduces inline functions such as:
is_foreground_special_process (),
is_gdb_with_foreground_non_cygwin_inferior (), etc.,
instead of complicated conditions in 'if' clauses.

Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Reviewed-by: Corinna Vinschen <corinna@vinschen.de>
---
 winsup/cygwin/exceptions.cc          |  4 +--
 winsup/cygwin/fhandler/pty.cc        |  7 ++--
 winsup/cygwin/fhandler/termios.cc    | 54 +++++++++++-----------------
 winsup/cygwin/local_includes/pinfo.h | 42 ++++++++++++++++++++--
 winsup/cygwin/tty.cc                 |  7 ++--
 5 files changed, 69 insertions(+), 45 deletions(-)

v2: Introduce inline functions such as is_foreground_special_process ()
    to clarify the code intent.
v3: Move the inline functions into pinfo.h. In addition, drop the
    marker: _pinfo::dwProcessId == _pinfo::exec_dwProcessId that
    means the process is a non-cygwin debuggee, and introduce
    h_debuggee_maybe which holds process handler of the debuggee
    instead.
v4: Use wpid_debuggee_maybe instead of h_debuggee_maybe, because
    the process handle is valid only in the process that opens it.
v5: Use pi->dwProcessId instead of GetProcessId (h_gdb_inferior).
    Introduce is_cygwin_inferior_being_debugged (). Refactor the
    'if' clauses in process_sigs(). In addition, fix the similar
    issue that the cygwin debuggee under strace cannot be terminated
    by Ctrl-C (change in exceptions.cc and line_edit()).

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
