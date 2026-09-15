Return-Path: <SRS0=CxYQ=HH=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w10.mail.nifty.com (mta-snd-w10.mail.nifty.com [106.153.227.42])
	by sourceware.org (Postfix) with ESMTPS id 00F594BA540B
	for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 09:50:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 00F594BA540B
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 00F594BA540B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=106.153.227.42
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789465850; cv=none;
	b=El/3EEBo5Opr+dtgOWTj5vBtXraT9QNFOajoFxlOWu5IfLthCdzHEBNFWA2xON4Bpv9146uCEjqsa6sm8Ke20zf8LXq58yvK8omw3H4sFCG+oJ+udMMkb2XaMT25Yuad/qIiUyUNgap2BDFB/DnW2A46e26cb7NsnZVwJZb3wGE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789465850; c=relaxed/simple;
	bh=qd7vntRP7fXUX5yS8jMN0C+iO9Y+H1rH23B6XZuZjUU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=bAEc2+oDEzSG/dHW/YoPNa2uYC1SvhGf6sWchbpdJ7kzqkAsSzEaXYCMbM7k3LfApB6t974LXVGnTFu5RFmesQ2IDlJ1k/3Wk4NsDii4ewH0+DPSyvTO89ZDXrzf6J4U1dXiYjOKKWpfZLxRBFuf5YXL8eCnls/QIOczYdRjl/s=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KixNnCZX
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 00F594BA540B
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=KixNnCZX
Received: from HP-Z230 by mta-snd-w10.mail.nifty.com with ESMTP
          id <20260915095047877.NNXD.44671.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Tue, 15 Sep 2026 18:50:47 +0900
Date: Tue, 15 Sep 2026 18:50:48 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Improve the performance of
 peek_console
Message-Id: <20260915185048.75e40c3a32cc85e5b5e32268@nifty.ne.jp>
In-Reply-To: <20260915174641.3fd65fe1123ee24969956753@nifty.ne.jp>
References: <20260903234859.344934-1-takashi.yano@nifty.ne.jp>
	<cbb2e74c-ae66-7c47-808a-a9b68d954655@gmx.de>
	<20260914204639.e0e82ff87a6794781416865f@nifty.ne.jp>
	<7a8728b4-39d3-8f8c-5620-030a9e6501b2@gmx.de>
	<20260915174641.3fd65fe1123ee24969956753@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1789465847;
 bh=FJ/wXc1GiCrhRT+opkQYaW3bsB9ol8FEnOd5m9/wfZk=;
 h=Date:From:To:Subject:In-Reply-To;
 b=KixNnCZXo9Q/30M4Ao4tgLGeXeylLPL5wCNXLBcuqZz/hfH1WmejTOpMb0eiiChH8Yr5iC9X
 Pt/Reg45ojDy3gaM6CQ2bapRF80XETjUKZEDsmhpxTUfmfHLrdPNZ+KyhxmvigTSAnffI21EaW
 ZyRB9/hE76yjY3OmlIsOHJSyyV+jPZWbr1EGdKGsoszng4iRfibg5Aa4xyt+eAoy8QQOjutbR9
 ezCYPnorDiZeOzDMqxnNsZLOPLl/DZFDU3vOToI+vgblmM7p8RLjW39S1N0TtW/orEB9JtODU1
 3U+kK8KcAdGIp1lLJwE+d0oTdm5Y6L8Oc/hQ+DnSC1oeqyJw==
X-Spam-Status: No, score=-10.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Tue, 15 Sep 2026 17:46:41 +0900
Takashi Yano wrote:
> Hi Johannes,
> 
> On Tue, 15 Sep 2026 09:32:26 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Mon, 14 Sep 2026, Takashi Yano wrote:
> > 
> > > On Sun, 13 Sep 2026 13:56:38 +0200 (CEST)
> > > Johannes Schindelin wrote:
> > > > 
> > > > On Fri, 4 Sep 2026, Takashi Yano wrote:
> > > > 
> > > > > Previously, peek_console() used PeekConsoleInput() to confirm
> > > > > whether the console input buffer has some input records. However,
> > > > > this need attaching to the console if the process does not attach to
> > > > > the console. To reduce that overhead, this patch uses
> > > > > WaitForSingleObject() with console input handle instead.
> > > > > WaitForSingleObject() works without attaching to the console, so
> > > > > this simplifies the peek_console() code.
> > > > 
> > > > Great! I like when Cygwin's code is taught to avoid expensive operations.
> > > > 
> > > > One issue, though:
> > > > 
> > > > > 
> > > > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > > > > Reviewed-by:
> > > > > ---
> > > > >  winsup/cygwin/select.cc | 9 +--------
> > > > >  1 file changed, 1 insertion(+), 8 deletions(-)
> > > > > 
> > > > > diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> > > > > index 592f6d14d..d565f4d5b 100644
> > > > > --- a/winsup/cygwin/select.cc
> > > > > +++ b/winsup/cygwin/select.cc
> > > > > @@ -1149,8 +1149,6 @@ peek_console (select_record *me, bool)
> > > > >        return 1;
> > > > >      }
> > > > >  
> > > > > -  INPUT_RECORD irec;
> > > > > -  DWORD events_read;
> > > > >    HANDLE h;
> > > > >    set_handle_or_return_if_not_open (h, me);
> > > > >  
> > > > > @@ -1161,12 +1159,7 @@ peek_console (select_record *me, bool)
> > > > >        else
> > > > >  	{
> > > > >  	  fh->acquire_input_mutex (mutex_timeout);
> > > > > -	  acquire_attach_mutex (mutex_timeout);
> > > > > -	  DWORD resume_pid = fh->attach_console (fh->get_owner ());
> > > > > -	  BOOL r = PeekConsoleInputW (h, &irec, 1, &events_read);
> > > > > -	  fh->detach_console (resume_pid, fh->get_owner ());
> > > > > -	  release_attach_mutex ();
> > > > > -	  if (!r || !events_read)
> > > > > +	  if (WaitForSingleObject (h, 0) != WAIT_OBJECT_0)
> > > > 
> > > > With this change, a host can report readiness without leaving any records
> > > > to process. Here is a concrete source counterexample in released
> > > > OpenConsole `v1.24.11911.0`:
> > > > 
> > > > 1. `SetConsoleActiveScreenBufferImpl()`
> > > >    (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/getset.cpp#L474-L498)
> > > >    calls `SetActiveScreenBuffer()`
> > > >    (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/output.cpp#L446-L476),
> > > >    which invokes `FlushAllButKeys()`.
> > > 
> > > I wonder why
> > >     if (_storage.empty())
> > >     {
> > >         ServiceLocator::LocateGlobals().hInputEvent.ResetEvent();
> > >     }
> > > is missing from:
> > > https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp#L347-L353
> > > while flush()
> > > https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp#L333-L337
> > > and read()
> > > https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp#L466-L469
> > > reset the event.
> > 
> > This seems to be a genuine omission. I did research discussions, issues
> > and PRs in microsoft/terminal, but it does not seem to be discussed
> > directly. The closest I (or more precisely, GPT-6) found is:
> > https://github.com/microsoft/terminal/pull/14745#discussion_r1107879996
> > which is followed by an explanation that the `resetWaitEvent` mechanism
> > was replaced with `_storage.empty()`. So from my point of view, you're
> > right, `FlushAllButKeys()` should probably also reset the event if
> > `_storage` is empty. But take that with a big rock of salt, as I am
> > _definitely_ out of my depth when talking about `microsoft/terminal` code.
> > 
> > > > 2. If the queue contained only non-key records, it becomes empty while the
> > > >    input-available event remains signaled.
> > > > 3. An empty subsequent peek returns before the event-reset code
> > > >    (https://github.com/microsoft/terminal/blob/v1.24.11911.0/src/host/inputBuffer.cpp#L460-L470).
> > > >    With no other input activity repairing that state, Cygwin's new loop
> > > >    can repeatedly see "signaled handle" followed by "zero records."
> > > > 
> > > > In other words: changing active screen buffers can discard the remaining
> > > > non-key records without resetting the input-available event. The queue is
> > > > then empty but the handle remains signaled; an empty peek does not repair
> > > > the event. The new preliminary wait consequently succeeds repeatedly,
> > > > while `process_input_message(0)` finds zero records and returns
> > > > `input_processing` without changing readiness. `peek_console()` loops
> > > > without progress, so even a zero-timeout `select()` can hang. The old
> > > > preliminary peek explicitly broke out when its record count was zero.
> > > > 
> > > > This is not merely the normal distinction between a keypress and a
> > > > complete line. It is a stale host notification paired with an actually
> > > > empty queue. The source counterexample keeps Cygwin's worker paused
> > > > through Win32 input mode, with no new input or other reader repairing the
> > > > state.
> > > > 
> > > > I think we can keep the cheap `WaitForSingleObject()` check, but could we
> > > > let `process_input_message()` report an empty queue separately from
> > > > `input_processing`? If its `PeekConsoleInputW()` call finds no records,
> > > > `peek_console()` needs to stop retrying rather than spin on a handle that
> > > > stays signaled. Simply breaking on `input_processing` would also stop when
> > > > we consumed input but hadn't yet completed a canonical line, so we need to
> > > > keep those cases separate. Please handle input errors explicitly, too.
> > > 
> > > What about calling read() with AmountToRead == 0
> > > https://github.com/microsoft/terminal/blob/main/src/host/inputBuffer.cpp#L372-L475
> > > ?
> > 
> > Unfortunately, there's an early return in that function if `OutEvents` is
> > empty, _before_ the event is reset:
> > https://github.com/microsoft/terminal/blob/dcfbcdd8639813994734ced60abec37474cb3ec7/src/host/inputBuffer.cpp#L462-L469
> 
> Sadly enough. So we cannot remove PeekConsoleInputW() call.
> I'll check v2 patch is still worth.

No! Your idea can be still worth. I'll try it.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
