Return-Path: <SRS0=XFaT=S6=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e07.mail.nifty.com (mta-snd-e07.mail.nifty.com [106.153.226.39])
	by sourceware.org (Postfix) with ESMTPS id 98DF83858C52
	for <cygwin-patches@cygwin.com>; Thu,  5 Dec 2024 13:40:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 98DF83858C52
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 98DF83858C52
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.39
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733406038; cv=none;
	b=SnSz44u8dnj5/DcqEl2KKGA1Dtfm2jm9D4MWf46TqHx0K+OOAtUFb75KoHi4LLxI0MoePwjiluaGC8Ni2DSggNo148YfkYqwVbzrFpWAwueWpiHoCxjfPjHFzpvobafCfEiu5fAvDoX2WLFxbNv0qL+2xxtG5l1XCz38QLgUlRI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733406038; c=relaxed/simple;
	bh=pPz3cD1Id5bOfSCZ8iMdNa4OhCR8pwrkWmk3D0ipuzE=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=P77zlkvAljr7Z2hgIStGoCgQsQyXGDvgUo3uZ7G9FA5O+va/2pe/9zERub12yKrXAfOWcHdGS+KSPxSuTugpTFGtGkzFQHrxgtJoAkxLCUosu1vtAh860j0attdPPtr3tRCGsu+u+4WJ39cMAOhitYRdZsj1VeLeLTucNSstMrU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 98DF83858C52
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=e8FSNnyF
Received: from HP-Z230 by mta-snd-e07.mail.nifty.com with ESMTP
          id <20241205134034516.EBUS.76216.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 5 Dec 2024 22:40:34 +0900
Date: Thu, 5 Dec 2024 22:40:33 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: setjmp/longjmp: decrement incyg after signal
 handling
Message-Id: <20241205224033.a3dd8d46eba2d38083e43623@nifty.ne.jp>
In-Reply-To: <Z1GFpWUYpJHKah23@calimero.vinschen.de>
References: <20241204125447.316279-1-corinna-cygwin@cygwin.com>
	<20241205101422.ef6a17a0e3b8f313c1f76638@nifty.ne.jp>
	<Z1GFpWUYpJHKah23@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1733406034;
 bh=7aJDbGRSrebsxngT4HBBFvQbcOM/ZW1YnepHxo3scY0=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=e8FSNnyFnltvfhu0mPweIO1v0NQoLf50UAptzH5G4zqfp6c/oFXhd+LNQJxRdLVv2wFd5PdT
 rWtXp6HSq1jEQVzoUVClPMBh5llnkiHtoIJ7X8Yj2yO+5k95jDhSgNkGO0Y6W/XMnHZy75G5Uo
 zxJHzl8dMsgzbDYEkoUZlBRhXBdTj3o1uTm2Ui93p8y3OSls835UICUIfqb8iOJw+EFtNAaI+1
 JxuzItCbimJBG5R7k3663ESSIJYRspiKqvov1G/s/sTpFbIn3doiyO9NbCYPMgjI+kaPRLxViw
 iCA53E6LfYmQXpNnFlSo6Zm0koCHIVCmPmcqzElntr87xTFA==
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Thu, 5 Dec 2024 11:51:17 +0100
Corinna Vinschen wrote:
> Hi Takashi,
> 
> On Dec  5 10:14, Takashi Yano wrote:
> > Hi Corinna,
> > 
> > On Wed,  4 Dec 2024 13:54:47 +0100
> > Corinna Vinschen wrote:
> > > From: Corinna Vinschen <corinna@vinschen.de>
> > > 
> > > Commit 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert
> > > to checking for "spinning" when choosing to defer signal.") introduced
> > > a bug in the loop inside the stabilize_sig_stack subroutine:
> > > 
> > > First, stabilize_sig_stack grabs the stacklock. The _cygtls::incyg
> > > flag is then incremented before checking if a signal has to be handled
> > > for the current thread.
> > > 
> > > If no signal waits, the code simply jumps out, decrements _cygtls::incyg
> > > and returns to the caller, which eventually releases the stacklock.
> > > 
> > > However, if a signal is waiting, stabilize_sig_stack releases the
> > > stacklock, calls _cygtls::call_signal_handler(), and returns to
> > > the start of the subroutine, trying to grab the lock.
> > > 
> > > After grabbing the lock, it increments _cygtls::incyg... wait...
> > > again?
> > > 
> > > The loop does not decrement _cygtls::incyg after
> > > _cygtls::call_signal_handler(), which returns with _cygtls::incyg
> > > set to 1.  So it increments incyg to 2.  If no other signal is
> > > waiting, stabilize_sig_stack jumps out and decrements _cygtls::incyg
> > > to 1.  Eventually, setjmp or longjmp both will return to user
> > > code with _cygtls::incyg set to 1.  This *may* be fixed at some later
> > > point when signals arrive, but there will be a time when the application
> > > runs in user code with broken signal handling.
> > > 
> > > Fixes: 0b6fbd396ca2f ("* exceptions.cc (_cygtls::interrupt_now): Revert to checking for "spinning" when choosing to defer signal.")
> > > Signed-off-by: Corinna Vinschen <corinna@vinschen.de>
> > > ---
> > >  winsup/cygwin/scripts/gendef | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/winsup/cygwin/scripts/gendef b/winsup/cygwin/scripts/gendef
> > > index 7e14f69cf71c..377ceb59b2c8 100755
> > > --- a/winsup/cygwin/scripts/gendef
> > > +++ b/winsup/cygwin/scripts/gendef
> > > @@ -344,6 +344,7 @@ stabilize_sig_stack:
> > >  	movq	\$_cygtls.start_offset,%rcx	# point to beginning
> > >  	addq	%r12,%rcx			#  of tls block
> > >  	call	_ZN7_cygtls19call_signal_handlerEv
> > > +	decl	_cygtls.incyg(%r12)
> > >  	jmp	1b
> > >  3:	decl	_cygtls.incyg(%r12)
> > >  	addq	\$0x20,%rsp
> > > -- 
> > > 2.47.0
> > > 
> > 
> > I tested this patch with Christian's longjmp test case, but
> > the problem does not seem to be fixed.
> 
> That was not the intention.  It was just something I found while looking
> into the assembler code.  This looks like a long-standing bug, which,
> if my description above is right, might result in threads missing
> signals, too.  Or at least, signals being defered, because user-space
> is running partially with the "iscyg" flag being set.
> 
> It would be nice if you could check this, too, to be sure I'm not
> totally wrong here.

It looks almost good to me and your commit message sounds reasonable.
One question.
There are three incyg <- 0 lines in gendef that are outside of stacklock.
Is that safe?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
