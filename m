Return-Path: <SRS0=9Zje=CO=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:25])
	by sourceware.org (Postfix) with ESMTPS id 1D9C94BA543C
	for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 04:42:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1D9C94BA543C
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1D9C94BA543C
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776228151; cv=none;
	b=ppomOXnNTNUZBKV9hmEPRq4U0LpEkgjd2S5CCgEAxvI1V1nXXiiF6QAjdtvlSZ1hPJh6nrQKa5cKwdYtcmuhbkhJfNOaEeoSkydr86QLRTqJ461Rpax6w/MKRZZw+xbmltfkCy1IawcPVV9t4hKfENRMCipnhGX84HwrcKwfoLs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776228151; c=relaxed/simple;
	bh=k/L41Tdgn0d2BZF1jEIshIEujIbPCiu20HZG4SgEL/4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=H1c4/uA1HWQ2eErXW+wZqguVvaBKkFjVd0ZpmPChpZPEM3qJYfpa098J0+gfuKtrICwzRqrqJy8JSBrgEwwCGie/S+9UM1ZGlc1x76IypnCZNYyZZ/t4qyAl2Taqzc2IOWerBBni+vHXW3hO47+zzKsjYRirtm4O7HmB/h2pLdM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1D9C94BA543C
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=dCRAIkWc
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260415044228227.IDUJ.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 15 Apr 2026 13:42:28 +0900
Date: Wed, 15 Apr 2026 13:42:28 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Make Ctrl-C work for non-cygwin app in
 GDB
Message-Id: <20260415134228.ddece78c331752e380c5baf2@nifty.ne.jp>
In-Reply-To: <ad4DAiKm8gzm7bAB@calimero.vinschen.de>
References: <20260309070818.5952-1-takashi.yano@nifty.ne.jp>
	<ad4DAiKm8gzm7bAB@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776228148;
 bh=NJRt3IU543CICXfnTMX2iWHM0/xb7n2YVBe7lWxeMp0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=dCRAIkWcoyl5t/cosp5NSE0NxbgJRlgzzikhclh/NboHUyI7vMCm4ag+v09RmAteqWeV4F17
 c/9EaE32RQO62MxVv9IsvzxyCWogrAlJXA6x8WePAoCLw8B2yV6nWawmHJjg2dzkWalzs/h1au
 3DSpPVdiRwhQJeovG1ihbcVSlhVCIF7xtDkG6wK717U2sIsAyQdew3qSqPq3/Tl8OTZ+DLNRQX
 KidJJbFMWsoaP99ZRCRbCnSe1t2DnKjQpTa1j+dzi43ytHnQEM64CoMVQn128AHV8mPcoIZacA
 E0fQkjNxH45wpqIgGrfx9axHjBNn7gmn1knfmRznb+RWIZxQ==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

Thanks for reviewing.

On Tue, 14 Apr 2026 11:04:02 +0200
Corinna Vinschen wrote:
> Hi Takashi,
> 
> two (minor) points:
> 
> - is_gdb_with_foreground_non_cygwin_inferior() is defined twice.
>   It would probably make sense to move all these inline functions
>   is_gdb_with_foreground_non_cygwin_inferior(),
>   is_foreground_special_process() and
>   is_non_cygwin_foreground_process() into a header.
>   pinfo.h might be a good place.

Done.

> - The check in is_gdb_with_foreground_non_cygwin_inferior() looks
>   a bit on the fragile side.  Wouldn't it make sense to check with
>   CheckRemoteDebuggerPresent(), or at least, try to?

Actually, it is not esseitial whether the child process is
being debugged. This function should check if the child process
was executed by CreateProcess() rather than exec(). For exec'ed
process, pseudo console is activated by stub process of the non-
cygwin process, however, if a cygwin process executes the child
non-cygwin process by CreateProcess(), the chance to activate
pseudo console is missing. So, pty code hooks CreateProcess()
and activates pseudo console if necessary.

Usually, this happens in GDB and strace, however, other app
may do the same.

But, checking dwProcessId == exec_dwProcessId is not rbust,
so I revised the patch to v3.

In v3 patch, _pinfo::h_debuggee_maybe is introduced and
is set in hooked CreateProcess(). Then,
  cygwin_pid (GetProcessId (h_debuggee_maybe))
is checked to determine whether the process is a cygwin process.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
