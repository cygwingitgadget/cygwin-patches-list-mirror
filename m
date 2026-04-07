Return-Path: <SRS0=Vzu2=CG=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w07.mail.nifty.com (mta-snd-w07.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:27])
	by sourceware.org (Postfix) with ESMTPS id 9746D4BA2E06
	for <cygwin-patches@cygwin.com>; Tue,  7 Apr 2026 10:46:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9746D4BA2E06
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9746D4BA2E06
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:27
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1775558791; cv=none;
	b=uYEjtfv0AkhNeKxy111nYJr1iLgSEQYv6QCoOfQxjyG6f+UMmRLK0HK4ck+RuEGUAFgAlV6jJznkGNQz7FZAVpo5yXSrUTCLRJlvHhPByDNtHeH72dix4meJrWrMGPCEe1XLgi+FgiwK/EvRD1zf/LEusrIqI+TNp5siJmKPhVY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1775558791; c=relaxed/simple;
	bh=wRNl/jXLPMOX68YdtVxXJNOzhgDfY6qgnUddydIYasQ=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=O3aCZWqU6FO70u7shnMADADmcGWLRH44mezGnwgeOYwAiltzI9v8MFS8z4NC3DcFlKxqlvy6l6UY1NEhTVw9v2eMa2HLI9juXZbe0FuOYcYV2otYrMO07IAqVM2GEQ0pQx3g8CLQbUmDIgjD525zFqqYO536+NKJNSBtTX9xJp4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 9746D4BA2E06
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=Eg0timOE
Received: from HP-Z230 by mta-snd-w07.mail.nifty.com with ESMTP
          id <20260407104628211.GBXD.19957.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 7 Apr 2026 19:46:28 +0900
Date: Tue, 7 Apr 2026 19:46:26 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Status of pty and console pathces
Message-Id: <20260407194626.d18f4222db9d74b0f14cd970@nifty.ne.jp>
In-Reply-To: <aco2wLRJMJO3_06T@calimero.vinschen.de>
References: <20260325224343.5d92b9ee72ec70e0a09b133a@nifty.ne.jp>
	<20260329095346.aece4ca9b5b9144dd87b45b8@nifty.ne.jp>
	<aco2wLRJMJO3_06T@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1775558788;
 bh=+VZSh/AycLBEncpsl5OezHVSgvW47gH640En9eZ9S4U=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=Eg0timOEstHpDeY7rZYXiDXGbMCyhjdR17ueLaMcu6UPaFR7qsHmZRvlbBQ1xInPPLqGGgGm
 5BGnS40NdmgIgQuOqgvv+jguzWI5Zi0K7KS+goDdO8Z+xsisszVtUmxzb6tOl5Vz+s/R54IA0Z
 2ndLxa3/quFQUrpUlLcAqo9EdDI7tVDWzA0jdrpbl9SJ0Or9ncxoSBqrQeKUnFm9fMrTqFqhRw
 e123b9KXfCA6WkTdixl7wKZLffk9oRYauJiuZbrTGvb1Jp0o9RnM6gru48TcikMr3boNrK5LmK
 8I+MUYeUIi/0ou/U26G3uE6qBZWf0am8wSDUn1O+8V1kk3dA==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_ASCII_DIVIDERS,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

[New feature]
===== OpenConsole [v6] ====
Cygwin: console: Fix master thread for OpenConsole.exe (*)
===========================

[Bug Fixes]
Cygwin: pty: Add missing DeleteProcThreadAttributeList() call
Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB  [v2] (*)

(*) meas the patch is under review

Many thanks to Johannes for reviewing so many patches.

On Mon, 30 Mar 2026 10:39:28 +0200
Corinna Vinschen <corinna-cygwin@cygwin.com> wrote:
> Johannes,
> 
> any chance you could review these patches as well?
> 
> 
> Thanks,
> Corinna
> 
> 
> On Mar 29 09:53, Takashi Yano wrote:
> > [New feature]
> > ===== OpenConsole [v6] ====
> > Cygwin: console: Fix master thread for OpenConsole.exe
> > Cygwin: pty: Handle CSIc in pcon_start phase (*)
> > Cygwin: pty: Use OpenConsole.exe if available (*)
> > ===========================
> > 
> > [Bug fixes]
> > Cygwin: pty: Make pcon_start handling more multi thread durable
> > Cygwin: pty: Fix write data handling in pcon_start phase
> > 
> > Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB  [v2] (*)
> > Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB [v2]
> > 
> > (*) means the patch reviewed once and revised.
> > 
> > 
> > On Wed, 25 Mar 2026 22:43:43 +0900
> > Takashi Yano wrote:
> > > I currently am proposing the following patches that is waiting for review.
> > > 
> > > Many of bugs are uncovered by Johannes's reproducer:
> > > https://cygwin.com/pipermail/cygwin-patches/2026q1/014714.html
> > > I really appreciate for providing such a reproducer.
> > > 
> > > 
> > > [New feature]
> > > ===== OpenConsole (v6) ====
> > > Cygwin: console: Fix master thread for OpenConsole.exe
> > > Cygwin: pty: Handle CSIc in pcon_start phase (*)
> > > Cygwin: pty: Use OpenConsole.exe if available (*)
> > > ===========================
> > > 
> > > 
> > > [Bug fixes]
> > > Cygwin: pty: Make pcon_start handling more multi thread durable
> > > Cygwin: pty: Fix write data handling in pcon_start phase
> > > 
> > > Cygwin: pty: Clear discard_input flag on master write()
> > > Cygwin: console: Release pipe_sw_mutex in pcon_hand_over_proc()
> > > 
> > > ====== out-of-order patch (v7) ====
> > > Cygwin: pty: Drop nat_fg() check from to_be_read_from_nat_pipe()
> > > Cygwin: pty: Guard to_be_read_from_nat_pipe() by pipe_sw_mutex
> > > Cygwin: pty: Guard get_winpid_to_hand_over() with attach_mutex
> > > Cygwin: pty: Apply line_edit() for transferred input to to_cyg
> > > Cygwin: console: Use input_mutex in the parent PTY in master thread
> > > Cygwin: pty: Add workaround for handling of backspace when pcon enabled (*)
> > > Cygwin: console: Fix master thread
> > > ===================================
> > > 
> > > Cygwin: pty: Omit CSI?1004h/l from pseudo console output
> > > Cygwin: pty: Fix input transfer when multiple non-cygwin apps exist
> > > 
> > > Cygwin: pty: Make Ctrl-C work for non-cygwin app in GDB (*)
> > > Cygwin: pty: Restore nat handles in all PTY-slave instances in GDB
> > > 
> > > 
> > > (*) means the patch reviewed once and revised.
> > > 
> > > -- 
> > > Takashi Yano <takashi.yano@nifty.ne.jp>
> > 
> > 
> > -- 
> > Takashi Yano <takashi.yano@nifty.ne.jp>


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
