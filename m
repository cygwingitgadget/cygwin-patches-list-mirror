Return-Path: <SRS0=dH/q=BI=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w09.mail.nifty.com (mta-snd-w09.mail.nifty.com [106.153.227.41])
	by sourceware.org (Postfix) with ESMTPS id C36554BA2E14
	for <cygwin-patches@cygwin.com>; Sun,  8 Mar 2026 11:07:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C36554BA2E14
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C36554BA2E14
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.41
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772968069; cv=none;
	b=ABZp4Osl5SzqvaCl7KhhIn+oIkJpdkUZYXvuk/iGp5ZR7ZS42JvZ3GFrdkmDtSrO+zuddisrmhWTsy0tmelDCRvJP+Is56G2C5MoUEc4bGNAYO8j9hPWJ4y536nFpk3/1qfxRYdtGO9NyRIHS+X/Ywo75cIiBgYthbYhCMNqmdU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772968069; c=relaxed/simple;
	bh=x5UK8TVtZkuXyGImP282RAypRloSNqn9/HSJ9K+5ISI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=OZH8y1NiaUXSb+UR0xHXPyqW/V533U5gUW0Xm9RiGaFRxOnm4S8ySLtm8t0r5+lReWCKj/3rJCgW41qMwryFSGAkG+glRqYDy9o2CrZTE2tRC/Jh4TbEH4qjIeP/mEYReGX7fqDYD+j6r/AeRi7FxzyF5ZAAlEqh0RHgRpLMO+g=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C36554BA2E14
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=BQ++12Li
Received: from HP-Z230 by mta-snd-w09.mail.nifty.com with ESMTP
          id <20260308110745948.EUIH.116672.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sun, 8 Mar 2026 20:07:45 +0900
Date: Sun, 8 Mar 2026 20:07:43 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Use consistently first pty slave found in
 cygheap_fdenum
Message-Id: <20260308200743.20048750201eef19b9dc5ee7@nifty.ne.jp>
In-Reply-To: <fa6eed40-2966-26dc-e1e3-e7955cbbaa12@gmx.de>
References: <20260228090219.2551-1-takashi.yano@nifty.ne.jp>
	<fa6eed40-2966-26dc-e1e3-e7955cbbaa12@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772968066;
 bh=HfdXAz6DRjM/6kj2eWcHMLonbMFR/+s02npmpFzu0zI=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=BQ++12Lipcl6JiZlDtliydnjHvJ0TfHpA++x2Tm2i+Jw25ee1JxWCacL95a5vyc69ekiZK71
 5UlmbXCBwmYj2WuFMf3rXsnVmE0JGpBO5MKqay05Y8zEqeTXscmYLltTQCZkf6UTDSJ3BXotWf
 9YVtcX1OFpDKKWnW686wD/Ss5hd2Yd6+CUh5gryVTWwCJQG7eB91O2kfVOvuOhMYdGjHEoDGHS
 YbLkWnLn698ZzC0g4c0TkaJVqHQqCJb2IBUf7WTqSS7iRSfya/6sAc0OlgC9wzQWYGJVuE2Ivu
 01YnHz6Fai/bEuhAK8rrVCK4Iis6TWING7rFUSi14NvVVfHg==
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jonannes,

On Sat, 7 Mar 2026 09:27:17 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Sat, 28 Feb 2026, Takashi Yano wrote:
> 
> > If non-cygwin app is started in GDB and terminating it normally,
> > re-running the non-cygwin app might fail in setup_pseudoconsole().
> 
> Could you paste the exact symptom into the commit message? That might help
> readers like myself understand better what motivated/necessitated this
> patch.

It's somethingk like:

$ gdb ./winsleep
GNU gdb (GDB) (Cygwin 15.2-1) 15.2
Copyright (C) 2024 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
Type "show copying" and "show warranty" for details.
This GDB was configured as "x86_64-pc-cygwin".
Type "show configuration" for configuration details.
For bug reporting instructions, please see:
<https://www.gnu.org/software/gdb/bugs/>.
Find the GDB manual and other documentation resources online at:
    <http://www.gnu.org/software/gdb/documentation/>.

For help, type "help".
Type "apropos word" to search for commands related to "word"...
Reading symbols from ./winsleep...
(gdb) run
Starting program: /home/yano/winsleep
[New Thread 49324.0x14178]
[Thread 49324.0x14178 exited with code 0]
[Inferior 1 (process 49324) exited normally]
(gdb) run
Starting program: /home/yano/winsleep
      0 [] gdb 294 fhandler_pty_slave::setup_pseudoconsole: CreatePseudoConsole() failed. 00000057 80070057
                           [New Thread 86480.0xfd4]
[Thread 86480.0xfd4 exited with code 0]
[Inferior 1 (process 86480) exited normally]
(gdb)

> > This is because set_switch_to_nat_pipe() uses the last pty slave
> > instance found in cygheap_fdenum while the clearnup uses the first
> > pty salve.
> > 
> > With this patch, the first pty slave instance in cygheap_fdenum is
> > used for setup and cleanup consistently.
> 
> That explanation makes sense to me. What I struggle with is to connect
> this explanation with the change in the diff: an added `ptys == NULL`
> condition in `set_switch_to_nat_pipe()`, which does not look related to
> first vs last pty slave nor to setup/cleanup.
> 
> Maybe the commit message could be improved to help readers understand the
> connection?

Sorry, I was completely wrong.

The essential problem is lack of restoring nat handles for *ALL* the
PTY-slave instances after closing pseudo console in GDB.

Restoring handles from pseudo console handles to simple pipe handles
is not necessary in normal non-cygwin apps because pseudo console is
setup in the stub process for the non-cygwin app and the stub process
exits after the app is terminated.

However, for GDB, pseudo console is setup in GDB process in hooked
CreateProcess() because GDB does not use exec() to run an inferior
(debuggee). Therefore, after the inferior exits, nat handle must be
restored to simple pipe handles.

The current code restores only handles in the PTY-slave instance
that has called fhandler_pty_slave::reset_switch_to_nat_pipe(). If
this instance is different from the instance that will setup pseudo
console, the nat handles are not restored correctly, then call to
CreatePseudoConsole() causes error.

The patch:
"Cygwin: pty: Use consistently first pty slave found in cygheap_fdenum"
works because the instance which calls reset_switch_to_nat_pipe() is
the stdin PTY-slave instance in most cases, that will be found first
in cygheap_fdenum.

I'll submit new patch for this issue.
Could you please review it again?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
