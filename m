Return-Path: <SRS0=/csx=B4=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w05.mail.nifty.com (mta-snd-w05.mail.nifty.com [IPv6:2001:268:fa30:831:6a:99:e3:25])
	by sourceware.org (Postfix) with ESMTPS id 6A2054BA23D1
	for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 10:28:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6A2054BA23D1
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6A2054BA23D1
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa30:831:6a:99:e3:25
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1774693701; cv=none;
	b=jZi3L8TZHRDXk8EbC1+sMSB45nndISSnndCUth+V4ygwTkyuTiviS7sIjZLW84QvXNCPVZpdWf2V9gsOQLwzBiOVvx3/Gyi6NYU87M8PTndKvx1BMVAr3QZ7+KS5kZQWH3RBkc51SuvyE4R6lRVoxnOc0Q6hpXF/0ayYjkDSUPc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1774693701; c=relaxed/simple;
	bh=eGnv0tmWzpossSbaHVAeuGuLk1k0Fi4zFlGGgFMaePg=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=XREdZ6VD+Nm+6XWU9yopWcBELZjY3BMai1h1XyaG52xJoJvL6dN2HcBGud3rEX6CA7Di1VwE8vqLKmgIkBewh0P/okougMpVB4l1NsUUir2f4PUAxFP58nCiKuwbl/lafBHj79oJeQ/KEYKaBBb1V1tIqysFmSVUV5VrDRqGvYM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6A2054BA23D1
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=JVEiESep
Received: from HP-Z230 by mta-snd-w05.mail.nifty.com with ESMTP
          id <20260328102818102.LNKN.127398.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 28 Mar 2026 19:28:18 +0900
Date: Sat, 28 Mar 2026 19:28:15 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v7 3/7] Cygwin: console: Use input_mutex in the parent
 PTY in master thread
Message-Id: <20260328192815.985688185995437eb94a9576@nifty.ne.jp>
In-Reply-To: <28029d3e-e1fc-c57c-20a7-94fcc95a9112@gmx.de>
References: <20260321113613.9443-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-1-takashi.yano@nifty.ne.jp>
	<20260325130453.62246-4-takashi.yano@nifty.ne.jp>
	<28029d3e-e1fc-c57c-20a7-94fcc95a9112@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1774693698;
 bh=9/s7TBBxbjEfCT53BDkAN4BlKapw3dxJ7sL2jtuXLzw=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=JVEiESepCISc/dQaD0NMYxKGmZOIgXcqC7Fv1phpdiwpaumsA24PIXsk1K7ZmP/CZzudVQ8h
 p6+lQzPBgBWvodR9lmxHtwQ4ZoUwAuJn2PvlCtkEHmOJlbjenk7KysiA2cNgmnsAARpMk9KJb8
 isxGeeALxEvatbACe16957/WCSxwikTOWmG9yfnXWFlqSlO2fNZPjUf+ZcbynfW3fBWc+sa9qm
 rP3e7MzDE4e63ZfTnk4IFUZqk0WThMD1G6YhuA3Oh3Vk3oW8D5OMMMa3ygkGH+ce93nXWoQd94
 aMU67iTCxld5YXDXOcKoVxd/14fBkkUeRqi1+8wyNUdwMAJQ==
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

On Fri, 27 Mar 2026 15:20:42 +0100 (CET)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 25 Mar 2026, Takashi Yano wrote:
> 
> > If the console is originating from pseudo console, the input into
> > console is comming from PTY master. Therefore, input_mutex in PTY
> > can be used to avoid conflicts between fhandler_pty_master::write()
> > and cons_master_thread().
> 
> Nit: "comming" -> "coming".
> 
> More substantially, I think the commit message would benefit from
> explaining _why_ `cons_master_thread()` and `fhandler_pty_master::write()`
> can conflict. As I understand it, the mechanism is this:
> 
> When the pseudo console is active, `cons_master_thread()` runs inside
> the Cygwin process that inherited the pseudo console from its parent
> PTY. It reads all `INPUT_RECORD`s from the console input buffer via
> `ReadConsoleInputW()`, processes signal-generating events (e.g. Ctrl+C),
> and writes the remaining records back via `WriteConsoleInputW()`.
> Meanwhile, the PTY master process (e.g. mintty) calls
> `fhandler_pty_master::write()`, which writes keystrokes to `to_slave_nat`
> (one end of the nat pipe). Conhost reads from the other end of that pipe,
> parses the byte stream through its VT input path, and inserts the
> resulting `INPUT_RECORD`s into the console input buffer.
> 
> If `cons_master_thread()` reads the buffer and removes a signal record
> while conhost is simultaneously inserting new records from the PTY
> master's write, the verify step (`inrec_eq()`) finds records in the
> buffer that were not part of the original read, reports a mismatch, and
> enters the fixup path. That fixup path itself can disturb the record
> order, turning what was merely an interference into an actual problem.
> Acquiring the PTY's `input_mutex` in `cons_master_thread()` prevents
> `fhandler_pty_master::write()` from feeding new bytes into the pipe
> while the read-process-writeback-verify cycle is in progress.
> 
> That reasoning is what makes this patch convincing, and I think it should
> be in the commit message so that future readers do not have to
> reconstruct it.
> 
> Note that the serialization is not fully airtight: even when
> `cons_master_thread()` holds `input_mutex` and blocks
> `fhandler_pty_master::write()` from feeding more bytes into the pipe,
> conhost might still be processing bytes that are already buffered in the
> pipe from a previous write. The mutex does not block conhost itself, only
> the master's write end. So it reduces the window for interleaving rather
> than eliminating it entirely. Is there a reason this is sufficient, or is
> the remaining window small enough in practice that it does not matter?

You are right regarding the mutex that does not eliminate the conflict
entirely. This is acceptable because the fixup code in cons_master_thread
can fix it.

Originally, this fixup code was written for pure console input, and since
the console provides no way to block the user’s keystrokes, it was designed
so that the fixup code resolves the conflicts between keystrokes and master
thread. Therefore, the mutex added by this patch is actually not essential.
However, reducing fix-up is better than nothing, I think.


-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
