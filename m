Return-Path: <SRS0=dH/q=BI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 3A2694BA23D1
	for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2026 11:24:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3A2694BA23D1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3A2694BA23D1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772969040; cv=none;
	b=GuAdnypHwpuYXhy0aJB3AYls4bw3cooKroVVIk4zvSMk3on5OqPo8DK0A4U7/oBxWY73PidoUkqhCq+/ZgjnykikMsArzrxmwGPWTxDq962TOA6kfDO327rSMLJZLzsYC1skcL6Mou5yvEo9XUxFkrTUk+OSk8Q2QPO1QOJ7V70=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772969040; c=relaxed/simple;
	bh=TiwtE3NcwofQGL/1Xg6Guafm3qHCG4beLAu9eMMu+AI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=JtTnoxeJPTgY8FDRklxVSKt4/s/FVaBUSrOGsrdBLlXZ2wPNwmwMF0hz6Ou1molRiP5z2BbXb9DeOsnqpPspPnTLX3fpvZEEzloADUNUWCt9XaVQZ4BAeEw3oUL2z3Jlq/hRN3SdveIOlckrnxagP+dRTtUg2Q4mtfUPKa48OPw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3A2694BA23D1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=mWKDg7qf
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260308112357187.QVHR.14880.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 8 Mar 2026 20:23:57 +0900
Date: Sun, 8 Mar 2026 20:23:54 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Restore nat handles in all PTY-slave
 instances in GDB
Message-Id: <20260308202354.44288a095a97b5f08f0511bd@nifty.ne.jp>
In-Reply-To: <20260308111932.1380-1-takashi.yano@nifty.ne.jp>
References: <20260308111932.1380-1-takashi.yano@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772969037;
 bh=WsGvto5DwR0f6uL6f8mdA2cO120cOyeWVoYpCvq/rWA=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=mWKDg7qfVXSdtSK/FOhZNa8oK33Cn6SLEcTvHt4+btrnbh0tlc3HhbgpzJAbO/hewEy89Y4T
 vxM3Y/jxqI61ylAP7bemhEi+PhKk5RJaJWdpFepnCOvMZSWJrZsiu7Bo5dq39gb5a83f4h9rIc
 C3nIemcIiCM1orz9yKPQqfExmQe9qhai+G1YDGWlND8YbeTTWbcGx76daqBPSDhBlW9BsbsEQF
 6ZHDn7vVGmaxIzL4310dTMyuxo04tNLvVGnBskgrpN0dnRxJBbLR4/lH59qFIks7M8gpPMajsz
 nYVUH1fwZBFg3nRteXUaM6sop5WiVaVrG9xrH0VUJfTFQWpQ==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sun,  8 Mar 2026 20:19:21 +0900
Takashi Yano wrote:
> If non-cygwin app is started in GDB and terminating it normally,
> re-running the non-cygwin app might fail in setup_pseudoconsole().
> 
> The error is something like:
> 
> $ gdb ./winsleep
> GNU gdb (GDB) (Cygwin 15.2-1) 15.2
> Copyright (C) 2024 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.
> Type "show copying" and "show warranty" for details.
> This GDB was configured as "x86_64-pc-cygwin".
> Type "show configuration" for configuration details.
> For bug reporting instructions, please see:
> <https://www.gnu.org/software/gdb/bugs/>.
> Find the GDB manual and other documentation resources online at:
>     <http://www.gnu.org/software/gdb/documentation/>.
> 
> For help, type "help".
> Type "apropos word" to search for commands related to "word"...
> Reading symbols from ./winsleep...
> (gdb) run
> Starting program: /home/yano/winsleep
> [New Thread 49324.0x14178]
> [Thread 49324.0x14178 exited with code 0]
> [Inferior 1 (process 49324) exited normally]
> (gdb) run
> Starting program: /home/yano/winsleep
>       0 [] gdb 294 fhandler_pty_slave::setup_pseudoconsole: CreatePseudoConsole() failed. 00000057 80070057
>                            [New Thread 86480.0xfd4]
> [Thread 86480.0xfd4 exited with code 0]
> [Inferior 1 (process 86480) exited normally]
> (gdb)
> 
> The essential problem is lack of restoring nat handles for *ALL* the
> PTY-slave instances after closing pseudo console in GDB.
> 
> Restoring handles from pseudo console handles to simple pipe handles
> is not necessary in normal non-cygwin apps because pseudo console is
> setup in the stub process for the non-cygwin app and the stub process
> exits after the app is terminated.
> 
> However, for GDB, pseudo console is setup in GDB process in hooked
> CreateProcess() because GDB does not use exec() to run an inferior
> (debuggee). Therefore, after the inferior exits, nat handle must be
> restored to simple pipe handles.
> 
> The current code restores only handles in the PTY-slave instance
> that has called fhandler_pty_slave::reset_switch_to_nat_pipe(). If
> this instance is different from the instance that will setup pseudo
> console, the nat handles are not restored correctly, then call to
> CreatePseudoConsole() causes error.
> 
> To solves this issue, restore nat handles in all the PTY-slave
> instances to simple pipe handles when the inferior exits with this
> patch.
> 
> Fixes: 8aeb3f3e5037 ("Cygwin: pty: Make apps using console APIs be able to debug with gdb.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:

This is the replacement for:
"Cygwin: pty: Use consistently first pty slave found in cygheap_fdenum"
https://cygwin.com/pipermail/cygwin-patches/2026q1/014674.html

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
