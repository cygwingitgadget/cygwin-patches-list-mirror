Return-Path: <SRS0=9Zje=CO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [106.153.227.39])
	by sourceware.org (Postfix) with ESMTPS id 175934BA543C
	for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 10:31:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 175934BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 175934BA543C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776249063; cv=none;
	b=ez9siw/bmPF7J/mmcxBIcoV21q7xo0mJwIKfH7Zce01jDvqADSNinf51HDN8v/nyYxCeLPMZ1zDBjjjrhIad9+X2cUOgG3Lgwtxlv5aYeBkxIgMxuZSDBwxDy/vwoUvtaKB0vyc7gW7OsV1DNP3uGwmVNt9rUOkBrqChjAUKwB8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776249063; c=relaxed/simple;
	bh=3lepPldDjIDaZxAi8IkK1wWQMI34rLvH8A/2CTKjTqI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=w/6maXqpCdRVhw7TTc4o/Na6whUIKTcK6v0EMCR127AW13k305IEJuHu9kO1JaAiSIUibL8UKHZ41T9oR7RtbBs79FdUdbDruHX9swN4l5o+laDcVvDPX5awTkunmr7irLpTvK6dToE/x08OVjS00FtwRLFG+qTNkO07O3FZ+ck=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 175934BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dNnv3HIN
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260415103059861.ZQUG.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 19:30:59 +0900
Date: Wed, 15 Apr 2026 19:30:59 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-Id: <20260415193059.0b34ba1e1b4392322b4f8f33@nifty.ne.jp>
In-Reply-To: <20260415134228.ddece78c331752e380c5baf2@nifty.ne.jp>
References: <20260309070818.5952-1-takashi.yano@nifty.ne.jp>
	<ad4DAiKm8gzm7bAB@calimero.vinschen.de>
	<20260415134228.ddece78c331752e380c5baf2@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776249059;
 bh=SebIUMWIa56K9lIQFx0/zS0+5+sftILBKAaz3do8QBA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=dNnv3HINgHch8RFPirDmSrX5AqoMQLegNn6W8atMiVz4s+8EPTAwANB68772L/HbGHcrOVMO
 mr2KFj7alixD404IYUPmsyskxQY6npjNCX2YkkLN4Gt3h8YqbV65KN/BbRra79+2xecFXSHqAT
 vbRJxwNC0XflDiDzfk3Zz2sWC7MrbDw8ddjCFVpClbBAkZVlcUGsIHk+h/qdgIKWobzYLFBa4T
 gVc9KjEDtMJS/LE6vF58tUWa28/xSul7eFRMNRQRq+dGYlxg6SB1YLh8ZVw3DLbe8pO+swiBNK
 ZkQvAB7+/Hu5fWprkyalMsYE5nzGfyKvyU52xPiWFNIstz8w==
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 15 Apr 2026 13:42:28 +0900
Takashi Yano wrote:
> Hi Corinna,
> 
> Thanks for reviewing.
> 
> On Tue, 14 Apr 2026 11:04:02 +0200
> Corinna Vinschen wrote:
> > Hi Takashi,
> > 
> > two (minor) points:
> > 
> > - is_gdb_with_foreground_non_cygwin_inferior() is defined twice.
> >   It would probably make sense to move all these inline functions
> >   is_gdb_with_foreground_non_cygwin_inferior(),
> >   is_foreground_special_process() and
> >   is_non_cygwin_foreground_process() into a header.
> >   pinfo.h might be a good place.
> 
> Done.
> 
> > - The check in is_gdb_with_foreground_non_cygwin_inferior() looks
> >   a bit on the fragile side.  Wouldn't it make sense to check with
> >   CheckRemoteDebuggerPresent(), or at least, try to?
> 
> Actually, it is not esseitial whether the child process is
> being debugged. This function should check if the child process
> was executed by CreateProcess() rather than exec(). For exec'ed
> process, pseudo console is activated by stub process of the non-
> cygwin process, however, if a cygwin process executes the child
> non-cygwin process by CreateProcess(), the chance to activate
> pseudo console is missing. So, pty code hooks CreateProcess()
> and activates pseudo console if necessary.
> 
> Usually, this happens in GDB and strace, however, other app
> may do the same.
> 
> But, checking dwProcessId == exec_dwProcessId is not rbust,
> so I revised the patch to v3.
> 
> In v3 patch, _pinfo::h_debuggee_maybe is introduced and
> is set in hooked CreateProcess(). Then,
>   cygwin_pid (GetProcessId (h_debuggee_maybe))

This was wrong. h_debuggee_maybe only valid in GDB.
So the PTY master process fails to GetProcessId().
Please review v4 patch.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
