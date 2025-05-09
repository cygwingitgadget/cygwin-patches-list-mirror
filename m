Return-Path: <SRS0=zJ3/=XZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e01.mail.nifty.com (mta-snd-e01.mail.nifty.com [IPv6:2001:268:fa04:731:6a:99:e2:21])
	by sourceware.org (Postfix) with ESMTPS id 09C04385828E
	for <cygwin-patches@cygwin.com>; Fri,  9 May 2025 13:07:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 09C04385828E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 09C04385828E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2001:268:fa04:731:6a:99:e2:21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746796080; cv=none;
	b=Ca8gLtlCu2wNvfYattn9X8fmHMpN9Lsj6Vh5YWb7stGUalREoakchS5KMOEiXKj7+F69et6Jbhiwq5mCtAgxGEabytP6yp/UkoELJKni16tmWw5VtRQak1Whp1R/1dMQVCvEHk5c1H9Qutc7T3WEDGNqr5sho0CYpxrknibvxNI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746796080; c=relaxed/simple;
	bh=lICiraXOusH+NmnDtpUPwa0MntL3km9zXoo6FsgYKxo=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=NDlTxTFwzX5TnPALXbHlMeMRSiY59j38CX4xrUgyEQByuz7ZprprzC+YjerPnIvnAtrXP6ZoN/l80shmg6vIKDfE2h6PMaIU9ukPUjuxBFKw4rV/mK2W20S5k8pXBBe2Yox5VHkAtXjy26br4PBQk7hv5wROXRliK+9o2zN9Ieg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 09C04385828E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=GkH9/pHJ
Received: from HP-Z230 by mta-snd-e01.mail.nifty.com with ESMTP
          id <20250509130757048.LMHJ.62593.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 9 May 2025 22:07:57 +0900
Date: Fri, 9 May 2025 22:07:57 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Store console mode only when console
 is opened
Message-Id: <20250509220757.86a926ae1717e70affe42ffd@nifty.ne.jp>
In-Reply-To: <a7787513-177a-05e5-401d-3710e975de55@gmx.de>
References: <20250507073114.12640-1-takashi.yano@nifty.ne.jp>
	<a7787513-177a-05e5-401d-3710e975de55@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746796077;
 bh=1FP/Y8nU06yHXlWXRmIIouZujppNOvBAu1h9FxYwCuU=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=GkH9/pHJji4SBW02eCNSs8QlpSHdfWnmqHY8wmcuUNp8XgYNGjELW9zUWDh5/2bfWqViiNti
 Xh1vb244SSESZlyjN9p2UeEbzksCd/ct9J1hFWOoRqYXqGLZM1T5/JZIkjF+XAM+cO+wAK7kb5
 8zH6bQiK5Em0J+sIrKmtHmsxioc/TUaNUWYrmRRPpp40ljZHljD73keSM6f8PqEXJ/GpzBvM2K
 hvuGL3XpYML5dK/FIIEULysbMn5UakANhifhkT5zZ21U06dZ0GJgjui3CEWkfqVF9Md5fbEuQr
 l506eLamiFput0+cuKt1AmBGBWWEw7uLcJiz3EUmXEztHj0Q==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Thu, 8 May 2025 09:19:47 +0200 (CEST)
Johannes Schindelin wrote:
> Hi Takashi,
> 
> On Wed, 7 May 2025, Takashi Yano wrote:
> 
> > ... and restore it when app exits. The commit 0bfd91d57863 has a bug
> > that the console mode is stored into the shared memory when both:
> >   (1) cygwin process is started from non-cygwin process.
> >   (2) cygwin process started from non-cygwin process exits.
> > (1) is intended, but (2) is not. Due to (2), the stored console mode
> > is unexpectedly broken when the cygwin process exits. Then the mode
> > restored will be not as expected. This causes undesired console mode
> > in the use case that cygwin and non-cygwin apps are mixed.
> > 
> > With this patch, the console mode will stored only in the case (1).
> > This is done by putting the code, which stores the console mode, into
> > fhandler_console::open() rather than fhandler_console::set_input_mode()
> > and fhandler_console::set_output_mode().
> > 
> > Fixes: 0bfd91d57863 ("Cygwin: console: tty::restore really restores the previous mode")
> > Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> 
> Thank you! I can confirm that this re-fixes the problem fixed in
> 3312f2d21f (Cygwin: console: Redesign mode set strategy on close().,
> 2025-03-03), which was in response to a report I received in
> https://github.com/microsoft/git/issues/730.
> 
> I also asked the reporter of the bug you fixed in 114cbda779 (Cygwin:
> console: tty::restore really restores the previous mode, 2025-03-21)
> (which was the cause for the regression I reported) to verify that _their_
> bug did not reappear, see
> https://github.com/msys2/msys2-runtime/issues/268#issuecomment-2858071841
> 
> Finally, I spent quite a few hours to write an automated test that
> imitates my reproducer, and integrated it into Git for Windows' CI builds:
> https://github.com/git-for-windows/msys2-runtime/pull/95/commits/7acbb031654404c9fd711eee9974c88475de98fd

Thanks for testing.

> However, I still have concerns about the patch. It still lets the Cygwin
> runtime operate under the assumption that it can control the console, even
> though other process can interact with the same console in _overlapping_
> lifecycles.
> 
> Keep in mind that the bug I reported twice involves a Cygwin process that
> spawns a non-Cygwin process which writes to the console _after_ the Cygwin
> process exited (and restored the console mode).
> 
> It looks plausible to me that this storing, setting, then re-setting of
> the console mode by the Cygwin runtime will never cease to be fragile and
> will always be prone to surface bugs that are similar, bug not identical
> to the two bugs referenced above.
> 
> Therefore I fail to convince myself that the current design is okay, and
> expect that, in the long run, the Cygwin runtime will stop to toggle the
> console modes as if the console were not serving other, non-Cygwin
> processes, too.
> 
> I do see that you changed some code so that it is only run when Cygwin is
> the console owner. That triggers the following questions, answers to which
> I could not find in the commit message (and neither in the diff):
> 
> - Now that the mode is left alone when the console is owned by a
>   non-Cygwin process, which code is broken? There must have been a reason
>   to change the console mode in the first place, after all.

What situation do you assume? I think I designed so that the console mode
is restored to tty::cygwin when non-cygwin process exits.

> - If it is okay to leave the console mode alone when Cygwin is _not_ the
>   console owner, why bother changing the mode at all?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
