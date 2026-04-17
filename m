Return-Path: <SRS0=Wk1n=CQ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:27])
	by sourceware.org (Postfix) with ESMTPS id B43284C900D8
	for <cygwin-patches@cygwin.com>; Fri, 17 Apr 2026 17:57:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B43284C900D8
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B43284C900D8
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776448661; cv=none;
	b=xT1++iDM9hlk2XM7LDmRH9hyyybn7IXDJTenPs8xERZFY4PmOaIAv0T1bF+9LIUuc494825IOOpOgJEyed+CJWFZ74BKyrhtTn98mh1iIYjozyDaIv300pKerFze9/Y7Axm0SkUTGW2FyMzb1mkTdPahRrB8VL8sxKxjt2vREno=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776448661; c=relaxed/simple;
	bh=i4EaP/JL4Ah6Y8iNnBo9Z5Y5lvfL6Dpw8gtFaVKvNqo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=pTo1VdyGuewL22fzLNgm/ao7r+XrXU6kulIa4hQWbAkt7OAdIDmVAHP8zgjHP3J+HxD4sTwMkcXWQYiIe/3mz4JSUwL4LvVp2VN6PvhjjBVsh4kYj9KJMp80nwAz0TSFuEjBHLAWBbSgSQ2u+iF7PUiIBuTsGewkq//D+1BLw4Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B43284C900D8
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=jh7jzODK
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20260417175737804.WDL.14880.HP-Z230@nifty.com>;
          Sat, 18 Apr 2026 02:57:37 +0900
Date: Sat, 18 Apr 2026 02:57:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Status of pty and console pathces
Message-Id: <20260418025737.2e9e75d46535f54bb17900a2@nifty.ne.jp>
In-Reply-To: <20260407194626.d18f4222db9d74b0f14cd970@nifty.ne.jp>
References: <20260325224343.5d92b9ee72ec70e0a09b133a@nifty.ne.jp>
	<20260329095346.aece4ca9b5b9144dd87b45b8@nifty.ne.jp>
	<aco2wLRJMJO3_06T@calimero.vinschen.de>
	<20260407194626.d18f4222db9d74b0f14cd970@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1776448657;
 bh=61w/rZsM4s0zJTU5r2kHnVyyQs0Z2tdlZkJbeP9PkC4=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References;
 b=jh7jzODKq7iSimK2PqBfQk6tD/ZTImpoxoKs1YrME6+sVRnc5uNanRgdk1Q3vvosOL4eWDBi
 JTcQl+RP6g48n5wdwT/xT7TIP3EZ9kuwOcJ07e1a6RySoRxfCp7Dh3FPJC/irUNr9oS7Hvx9ng
 lO89r3Ym6i51QsfktVpYpG56tDSkNT1YZdbe0yDDZGh3r3abPYp7B+GVU7H0cq+uswMmBAmBQL
 bSevnN7t1wWgYCEOKEjUjaa9LBtQyHEMKX9y8veUf2qb25Nbt4ZF0AUnKa5oP+oZ6m8qSVtNwy
 aQ/FjPIBp/Wwh8GtNpprBE2vCa/IDkMPZ+Kkt27rJ24W1DJg==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_ASCII_DIVIDERS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing so many patches.
Now, only the one patch under review is as follows.

[New feature]
===== OpenConsole [v6] ====
Cygwin: console: Fix master thread for OpenConsole.exe (*)
===========================

If you have time, could you take a look?


On Tue, 7 Apr 2026 19:46:26 +0900
Takashi Yano wrote:
> [New feature]
> ===== OpenConsole [v6] ====
> Cygwin: console: Fix master thread for OpenConsole.exe (*)
> ===========================
> 
> [Bug Fixes]
> Cygwin: pty: Add missing DeleteProcThreadAttributeList() call
> Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB  [v2] (*)
> 
> (*) meas the patch is under review
> 
> Many thanks to Johannes for reviewing so many patches.
> 
> On Mon, 30 Mar 2026 10:39:28 +0200
> Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> > Johannes,
> > 
> > any chance you could review these patches as well?
> > 
> > 
> > Thanks,
> > Corinna
> > 
> > 
> > On Mar 29 09:53, Takashi Yano wrote:
> > > [New feature]
> > > ===== OpenConsole [v6] ====
> > > Cygwin: console: Fix master thread for OpenConsole.exe
> > > Cygwin: pty: Handle CSIc in pcon_start phase (*)
> > > Cygwin: pty: Use OpenConsole.exe if available (*)
> > > ===========================
> > > 
> > > [Bug fixes]
> > > Cygwin: pty: Make pcon_start handling more multi thread durable
> > > Cygwin: pty: Fix write data handling in pcon_start phase
> > > 
> > > Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB  [v2] (*)
> > > Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB [v2]
> > > 
> > > (*) means the patch reviewed once and revised.
> > > 
> > > 
> > > On Wed, 25 Mar 2026 22:43:43 +0900
> > > Takashi Yano wrote:
> > > > I currently am proposing the following patches that is waiting for review.
> > > > 
> > > > Many of bugs are uncovered by Johannes's reproducer:
> > > > https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> > > > I really appreciate for providing such a reproducer.
> > > > 
> > > > 
> > > > [New feature]
> > > > ===== OpenConsole (v6) ====
> > > > Cygwin: console: Fix master thread for OpenConsole.exe
> > > > Cygwin: pty: Handle CSIc in pcon_start phase (*)
> > > > Cygwin: pty: Use OpenConsole.exe if available (*)
> > > > ===========================
> > > > 
> > > > 
> > > > [Bug fixes]
> > > > Cygwin: pty: Make pcon_start handling more multi thread durable
> > > > Cygwin: pty: Fix write data handling in pcon_start phase
> > > > 
> > > > Cygwin: pty: Clear discard_input flag on master write()
> > > > Cygwin: console: Release pipe_sw_mutex in pcon_hand_over_proc()
> > > > 
> > > > ====== out-of-order patch (v7) ====
> > > > Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()
> > > > Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
> > > > Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
> > > > Cygwin: pty: Apply line_edit() for transferred input to to_cyg
> > > > Cygwin: console: Use input_mutex in the parent PTY in master thread
> > > > Cygwin: pty: Add workaround for handling of backspace when pcon enabled (*)
> > > > Cygwin: console: Fix master thread
> > > > ===================================
> > > > 
> > > > Cygwin: pty: Omit CSI?1004h/l from pseudo console output
> > > > Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist
> > > > 
> > > > Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB (*)
> > > > Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB
> > > > 
> > > > 
> > > > (*) means the patch reviewed once and revised.
> > > > 
> > > > -- 
> > > > Takashi Yano <takashi.yano@nifty.ne.jp>
> > > 
> > > 
> > > -- 
> > > Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> 
> -- 
> Takashi Yano <takashi.yano@nifty.ne.jp>


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
