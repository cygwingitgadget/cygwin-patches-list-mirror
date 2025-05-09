Return-Path: <SRS0=zJ3/=XZ=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-w04.mail.nifty.com (mta-snd-w04.mail.nifty.com [106.153.227.36])
	by sourceware.org (Postfix) with ESMTPS id CCB3B385828E
	for <cygwin-patches@cygwin.com>; Fri,  9 May 2025 13:13:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CCB3B385828E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CCB3B385828E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.227.36
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746796385; cv=none;
	b=JqtOoABwbblqEXomav5R8Ro9yzbyLY2lrWeRvr59SKCWvJwjHS96OF4FYaWDud6v83v99cfkqH6K+BytoFZjLdcp9KZF7/cO9nkdlrBnmK/e6Oh/mGdqNh4SJYXL+iqbjV4esaVheAwJ6WCLJYHoryEj4n4a7kT9TfXJcDCRl44=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746796385; c=relaxed/simple;
	bh=gCG60fCh+jqeCwAGJlDmX5kjoKKKPGFAF0NNihpOV8E=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=ekVrvq7aeZ6xghpL/gFI4mV/55ot4SuU88ROUZIL6heunAT+Jj7ptC0usO+IgX5nMkHebA0dXtutsrbYm1lsmXXl4DsMrjI7DVYf7w0yG9YJL2oXrXHdyIRtBVzRKhkJmEQ1Z7Kf/9hGQGPy3oJ2b39Twzn0AI1geuglN//ar4I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CCB3B385828E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=rIx9e8ql
Received: from HP-Z230 by mta-snd-w04.mail.nifty.com with ESMTP
          id <20250509131303066.XIRV.37487.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Fri, 9 May 2025 22:13:03 +0900
Date: Fri, 9 May 2025 22:13:03 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Store console mode only when console
 is opened
Message-Id: <20250509221303.2d2c32a042bfcc35e3a5c9c6@nifty.ne.jp>
In-Reply-To: <20250509220757.86a926ae1717e70affe42ffd@nifty.ne.jp>
References: <20250507073114.12640-1-takashi.yano@nifty.ne.jp>
	<a7787513-177a-05e5-401d-3710e975de55@gmx.de>
	<20250509220757.86a926ae1717e70affe42ffd@nifty.ne.jp>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1746796383;
 bh=gL3DAv0LTDRVhNCvJFe3dS4f1ttC5KrAFDIMAF62MSk=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=rIx9e8qlkqpUrUlfs9KC8bzJTeZevi2x+IzOEq2u6YVpq+4jlDuuN9udDTCqdztVZWKQonK8
 bbn40OrdkC0K3bP9ytNsWUQVJR4Avlq2s5iVHsuBmX3zIcpHxxyh/KSiPtQaPvuii3Uk9i8KAi
 P3px4+q5cJ/DPiFJj8JGHl120vLFfTlMOMBJJ3sOSBiAv6xxFLSEJn1cUHDdAYZ0PzfVI0baPn
 AsRLkr2+caojwhN4DGDdNyvUHEaYT7rurKJLCofkv87Hdc7UTtcGSlx/5RL+nUHxpy1DUljJid
 ijLf8fkD3VUr88IRauwwn1QfjUgIbjo7B87mfmZOlFWwBI3A==
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Fri, 9 May 2025 22:07:57 +0900
Takashi Yano wrote:
> On Thu, 8 May 2025 09:19:47 +0200 (CEST)
> Johannes Schindelin wrote:
> > Hi Takashi,
> > 
> > On Wed, 7 May 2025, Takashi Yano wrote:
> > 
> > > ... and restore it when app exits. The commit 0bfd91d57863 has a bug
> > > that the console mode is stored into the shared memory when both:
> > >   (1) cygwin process is started from non-cygwin process.
> > >   (2) cygwin process started from non-cygwin process exits.
> > > (1) is intended, but (2) is not. Due to (2), the stored console mode
> > > is unexpectedly broken when the cygwin process exits. Then the mode
> > > restored will be not as expected. This causes undesired console mode
> > > in the use case that cygwin and non-cygwin apps are mixed.
> > > 
> > > With this patch, the console mode will stored only in the case (1).
> > > This is done by putting the code, which stores the console mode, into
> > > fhandler_console::open() rather than fhandler_console::set_input_mode()
> > > and fhandler_console::set_output_mode().
> > > 
> > > Fixes: 0bfd91d57863 ("Cygwin: console: tty::restore really restores the previous mode")
> > > Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > 
> > Thank you! I can confirm that this re-fixes the problem fixed in
> > 3312f2d21f (Cygwin: console: Redesign mode set strategy on close().,
> > 2025-03-03), which was in response to a report I received in
> > https://github.com/microsoft/git/issues/730.
> > 
> > I also asked the reporter of the bug you fixed in 114cbda779 (Cygwin:
> > console: tty::restore really restores the previous mode, 2025-03-21)
> > (which was the cause for the regression I reported) to verify that _their_
> > bug did not reappear, see
> > https://github.com/msys2/msys2-runtime/issues/268#issuecomment-2858071841
> > 
> > Finally, I spent quite a few hours to write an automated test that
> > imitates my reproducer, and integrated it into Git for Windows' CI builds:
> > https://github.com/git-for-windows/msys2-runtime/pull/95/commits/7acbb031654404c9fd711eee9974c88475de98fd
> 
> Thanks for testing.
> 
> > However, I still have concerns about the patch. It still lets the Cygwin
> > runtime operate under the assumption that it can control the console, even
> > though other process can interact with the same console in _overlapping_
> > lifecycles.
> > 
> > Keep in mind that the bug I reported twice involves a Cygwin process that
> > spawns a non-Cygwin process which writes to the console _after_ the Cygwin
> > process exited (and restored the console mode).
> > 
> > It looks plausible to me that this storing, setting, then re-setting of
> > the console mode by the Cygwin runtime will never cease to be fragile and
> > will always be prone to surface bugs that are similar, bug not identical
> > to the two bugs referenced above.
> > 
> > Therefore I fail to convince myself that the current design is okay, and
> > expect that, in the long run, the Cygwin runtime will stop to toggle the
> > console modes as if the console were not serving other, non-Cygwin
> > processes, too.
> > 
> > I do see that you changed some code so that it is only run when Cygwin is
> > the console owner. That triggers the following questions, answers to which
> > I could not find in the commit message (and neither in the diff):
> > 
> > - Now that the mode is left alone when the console is owned by a
> >   non-Cygwin process, which code is broken? There must have been a reason
> >   to change the console mode in the first place, after all.
> 
> What situation do you assume? I think I designed so that the console mode
> is restored to tty::cygwin when non-cygwin process exits.
                                  ^^^^^^^^^^^^^^^^^^^^^^^^^
I meant "when the last non-cygwin process exits"

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
