Return-Path: <SRS0=4rNz=BS=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [106.153.227.37])
	by sourceware.org (Postfix) with ESMTPS id 8E8114BB5907
	for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 05:33:06 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8E8114BB5907
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8E8114BB5907
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1773811987; cv=none;
	b=dphWnQ5f/3DHi41BK7g9XkgozI67D6ypSC3ElNjvQ8RABBrCUCLYSnXsSAMaMXCNiL6tbt5HvRKW0mxWLTPGelcvSOWUuDHaeQWEtzQfbF9wNihCfgXluqfitVGCmI63i0+uUVGfVFhySq/CdXEBEvNOd3YkTGkKqCC7NcgquoM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1773811987; c=relaxed/simple;
	bh=xjZ3sPFJiMR8AZZfOuDTdHU/vohNfLP/VOcbuShReYI=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ZY/xBG0FOOCk4z6mtUu8rdeq4rfNiv1JKFQDq9IXfPYFiiox8m+zU+DnLgbzFygijTllrgEU8Bjis1qADprLMud5VxFTOe1WzKJH62hFvd6ehVfFjH2PEz5c/WAfBIlE+URJsuKWniyT5kSHeMAQgub1QtujvFOA7vvB/odViss=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8E8114BB5907
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=IHTpREVk
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260318053304488.MRSH.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Wed, 18 Mar 2026 14:33:04 +0900
Date: Wed, 18 Mar 2026 14:33:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/4] Fix out-of-order keystrokes
Message-Id: <20260318143303.58cc77455258152b46c50f06@nifty.ne.jp>
In-Reply-To: <d6fd357c-c1eb-487c-df77-81614354d5ed@gmx.de>
References: <pull.6.cygwin.1772461480.gitgitgadget@gmail.com>
	<20260303212405.25a2db7d786ac2db324e8f7a@nifty.ne.jp>
	<22f45be0-3a22-f9c6-6d91-a7c2484621ef@gmx.de>
	<20260310175652.a7c404ae59c02560956cfb59@nifty.ne.jp>
	<20260317212208.cb8ac446f8da721cd82d3e51@nifty.ne.jp>
	<d6fd357c-c1eb-487c-df77-81614354d5ed@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1773811984;
 bh=jKQIbh6PtG7t2QZQjjqGCZP3K4uxmpL06WNAGvvoPPk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=IHTpREVkCYkfYZVwiwVVatogfHiRvM4QgaMuZH6TmADZXzS9jK9xLx9A2twzBgKrH6/K6/AC
 9ghZu7RX2QvFW9kBe1FO53a5xykSnO1H21h1L729Hxrvg2DF0MThIp7XS5GXgqv6bEmXMclYZA
 1E2TAQwcKS0ZRCC00gSF5pWDW3IxmWfA6l41OQTmbLka5XkM4+50hS44YOS1aZh/sG6elxJ43P
 yPWRNV8qj2Rn2WzPW1lAfxEI+LOl/SsvI13egUIIBMEKUqd6oAH1RydCblvZV5OVTLiVhj2lAG
 MEikjFPZdstyJcQ4QKbis3/gP5XaMquVCBo+gliYmVr8AAjw==
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,POISEN_SPAM_PILL,POISEN_SPAM_PILL_1,POISEN_SPAM_PILL_3,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Tue, 17 Mar 2026 14:57:05 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Tue, 17 Mar 2026, Takashi Yano wrote:
> 
> > On Tue, 10 Mar 2026 17:56:52 +0900
> > Takashi Yano wrote:
> > > 
> > > On Fri, 6 Mar 2026 08:46:40 +0100 (CET)
> > > Johannes Schindelin wrote:
> > > > 
> > > > Hi Takashi,
> > > > 
> > > > On Tue, 3 Mar 2026, Takashi Yano wrote:
> > > > 
> > > > > On Mon, 02 Mar 2026 14:24:36 +0000
> > > > > "Johannes Schindelin wrote:
> > > > > > A Git for Windows user reported that typing in a Bash session while a native
> > > > > > Windows program is running (or has just exited) can produce scrambled input
> > > > > > -- e.g. typing "git log" yields "igt olg":
> > > > > > https://github.com/git-for-windows/git/issues/5632
> > > > > > 
> > > > > > [...]
> > > > > 
> > > > > Is the issue reproducible in pcon_activated case?
> > > > > Or disable_pcon case?
> > > > > 
> > > > > If you can reproduce the issue in cygwin, could you kindly please
> > > > > let me know how to reproduce it?
> > > > 
> > > > It is admittedly difficult to reproduce. It took me a good 4 days to get
> > > > to a reliable reproducer. And I failed to do this in manual mode, I had to
> > > > employ the help of AutoHotKey to do it. The result can be seen here:
> > > > https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui-tests/keystroke-order.ahk
> > > > 
> > > > Unfortunately, it is not quite stand-alone, it requires `powershell.exe`
> > > > in the `PATH`, and
> > > > https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui-tests/ui-test-library.ahk
> > > > and
> > > > https://github.com/dscho/msys2-runtime/blob/fix-jumbled-character-order/ui-tests/cpu-stress.ps1
> > > > in the same directory. I just verified that it reproduces even with vanilla
> > > > Cygwin, using the latest AutoHotKey version from
> > > > https://github.com/AutoHotkey/AutoHotkey/releases/tag/v2.0.21. I ensured
> > > > that Cygwin's `bin` directory is first in the `PATH` and then ran, from a
> > > > PowerShell session:
> > > > 
> > > >   & "<path-to>\AutoHotkey64.exe" /force keystroke-order.ahk "$PWD\log.txt"
> > > > 
> > > > What this test does: It runs a small PowerShell script designed to add a
> > > > bit of CPU load and then spawns a Cygwin process (`sleep 1`). While these
> > > > are running, it then types _very_ rapidly four characters, then two
> > > > backspaces, then repeats that quite a few times ("ABXY" then deleting
> > > > "XY", then "CDXY", deleting "XY", etc). The number of characters was
> > > > chosen high enough that this reproducer basically reproduces the issue on
> > > > the first try. The "log.txt" file contains a detailed log including the
> > > > verdict. In my latest test, for example, it shows:
> > > > 
> > > >   Iteration 1 of 20
> > > >   MISMATCH in iteration 1!
> > > >   Expected: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
> > > >   Got:      ABCDEFGHIJKLMNOPQRXSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
> > > > 
> > > > You will spot the "X" between "R" and "S", meaning that the backspace was
> > > > not able to remove the "X" because it was routed to the wrong pipe, or
> > > > after the "X" was already consumed.
> > > 
> > > Thanks for the reproducer. I finally could reproduce the issue!
> > > Please let me take a look.
> > 
> > I finally have a patch series that fixes all the issue triggered by
> > this reproducer.
> 
> Seeing as you did not reuse any part of my patches, not even the carefully
> crafted commit messages, I wonder why you find them so horrible that you
> don't even review them, let alone consider using them.
> 
> > I'll submit the patch series to cygwin-patches mailing list.
> > Could you please test?
> 
> Yes, I tested. There is already a problem in the `cmd.exe` test I
> introduced in response to your feedback. What it does is to launch
> `cmd.exe`, wait a few milliseconds, and then start typing `echo
> <long-string>`.
> 
> As you can see from the output here, that does not work. The first two
> characters never make it to `cmd.exe`, and besides, `cmd.exe` is then
> stuck:
> 
> -- snip --
> $ cmd.exe
> eMicrosoft Windows [Version 10.0.26200.7984]c
> (c) Microsoft Corporation. All rights reserved.
> 
> D:\git-sdk-64\usr\src\MSYS2-packages\msys2-runtime\src\wip\ui-tests\msys2>ho ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
> -- snap --

This seems to be a deadlock caused by PATCH 6/6.

I've revised the PATCH 6/6 v2 so that to_be_read_from_nat_pipe() returns
false if pcon_start is asserted while trying to acuqire pipe_sw_mutex.
This is because if the slave is in setup_pseudoconsole(), the slave has
pipe_sw_mutex acquired and asserts pcon_start. In pcon_start state,
other input than response to CSI6n should go to cyg-pipe.

> In my investigations (supported by Claude Opus, because I still have a
> hard time with the current shape of the code and its lack of documenting
> ideas clearly), I stumbled across something that I _think_ is the actual
> cause of the many problems: When a native program is started, there is
> this time window during which the console owner is the current process (in
> my case, Bash), _not_ the native process (because it does not exist yet or
> the parent process does not yet know its process ID). When any kind of
> transfer happens during that time (and it does!), we're heading straight
> into trouble. I get the impression that we need to address this, to close
> that time window, not by narrowing it further, but by eliminating it
> entirely: while a native process is starting up that will become the
> console's owner, no transfer should happen.
> 
> Now, I really would like to collaborate with you on that. But I have to
> admit that I'm struggling a bit when you don't even comment on the
> contents of the commit message or patch to help me improve them, or when
> you just ignore those patches and instead write completely different ones.
> 
> Can we work on this together, please?

With pleasure!

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
