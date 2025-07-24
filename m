Return-Path: <SRS0=Pspn=2F=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e08.mail.nifty.com (mta-snd-e08.mail.nifty.com [106.153.226.40])
	by sourceware.org (Postfix) with ESMTPS id 05F323858D32
	for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 00:10:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 05F323858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 05F323858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.40
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753315821; cv=none;
	b=uwtxi79YF/l7yDeQD6yVutAWWssmDo7UdGSRIYrzPnos0890+XB4N8ztfcgzaPGh7HOf/09My3NMnH6LrKY8s+qtniDNziwidnLgJgSsHSgCX8FM+mbyN7BdnukAoPBfwD9XRn0+gDfVkCd1oWFTrvZ4viVuLSg7TUQjlFRN3Ck=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753315821; c=relaxed/simple;
	bh=EclMQlcmBA3IvU01ER93g1jNWM8oJYyTpxFU07X2EN4=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=CF4blNWk4CyMnNv4p3ET3MCKrdJO2TRoCSY8/ZAXCgVtl70s3wlDv2klx9gzoi2euDjAp7lJ9GFCrNPe1Z6Un9viNqDHAZAM2pTiBLcgqil1VMaM/BrIEsC+pW2GY63iKjEBA6x+4PsonYJuu+x9oykDsVRNUL5PbMoxUjviUTo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 05F323858D32
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=ITG/D7FY
Received: from HP-Z230 by mta-snd-e08.mail.nifty.com with ESMTP
          id <20250724001017786.IYER.106098.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Thu, 24 Jul 2025 09:10:17 +0900
Date: Thu, 24 Jul 2025 09:10:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Message-Id: <20250724091016.f04b1709e164619f58b21032@nifty.ne.jp>
In-Reply-To: <aIDbTUeOEM6kSDUh@calimero.vinschen.de>
References: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
	<aIClgpTaJ_6khEmq@calimero.vinschen.de>
	<20250723195536.5783866c1683727f0ca49fb1@nifty.ne.jp>
	<aIDbTUeOEM6kSDUh@calimero.vinschen.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1753315817;
 bh=UY+ynf4BvArMHUJtgI7jkFn9NW/Fl27511+o9fu54bc=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=ITG/D7FYjV3W8ZYkuiVhS+UR270EY2oP0XbH6kTCLK3ajwd8ofDcvDusHdfyo/CoHwlf0Z4h
 JsfYDzJm5En4Wt96ahY3U2Lb6NIe0lFpScRjRXe5t+/K2yTI59AN7toZ7zfvGkY+htsjIcjbhh
 U6tFUayvmLzxbCGcJwyd3n9etHjl8/mQMWgS9hOKi+L17wSHxmEXiwYuzy7nQUFCaxl6Vm9eA7
 kK2nYSVAqIR7mpHH11TpjXy5y0IZFXbfjzgJ+7wYB8LudThbiAJJWjTtBrvOxJiP2vEvShdKPE
 VjKmBkxU0SKTwaw99eeBy+8f/Ptiws8/u0fMkM4AP2Z0aXbw==
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 23 Jul 2025 14:53:33 +0200
Corinna Vinschen wrote:
> On Jul 23 19:55, Takashi Yano wrote:
> > On Wed, 23 Jul 2025 11:04:02 +0200
> > Corinna Vinschen wrote:
> > > On Jul 22 21:32, Takashi Yano wrote:
> > > > Previously, process_fd did not handle fhandler using archetype
> > > > correctly. Due to lack of PC_OPEN flag for path_conv, build_fh_pc()
> > > > could not initialize archetype. Because of this bug, accessing pty
> > > > or console via process_fd fails.
> > > > 
> > > > With this patch, use build_fh_name() with PC_OPEN flag instead of
> > > > build_fh_pc() to set PC_OPEN flag to path_conv.
> > > 
> > > Your patch fixes the issue, ok, but I don't understand why this occurs.
> > > 
> > > If the process opens /proc/PID/fd/N with PID != MYPID, it uses the
> > > PICOM_FILE_PATHCONV commune request.  It copies the path_conv member
> > > of the fd from the target process and this pc is used in the
> > > build_fh_pc() call.
> > > 
> > > And here's what I don't get: If the pc has been fetched from a valid,
> > > open file descriptor in the target process, why is the PATH_OPEN
> > > flag not set?
> > 
> > Thanks for reviewing.
> > 
> > I looked into open process, and noticed that this is because fh_alloc()
> > called from build_fh_name() does not copy argument pc.path_flags to
> > fh->pc.path_flags.
> 
> No, wait.  build_fh_name() creates a path_conv instance and that in turn
> is used to call build_fh_pc().  build_fh_pc() calls fh_alloc() and then
> calls fh->set_name (pc) in allmost all scenarios.  This in turn should
> copy pc.path_flags, because the underlying path_conv::<< operator is
> basically a memcpy().

In the case use_archetype() is true, fh->set_name(pc) does not seem
to be called.
https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/cygwin/dtable.cc;h=f1832a1693d45d5fd1e27acb830d5a12a6a34238;hb=HEAD#l683

> 
> So this looks like PATH_OPEN hasn't been set when creating descriptor
> FD in process PID.
> 
> I don't see that PATH_OPEN gets removed at one point, it's set once and
> then just checked for in the path_conv::isopen() method.  And the flags
> should be inherited from parent to child via cygheap copy.
> 
> So, afaics, the descriptor has originally been opened without PC_OPEN,
> i.e., not via open(2).
> 
> Given we're talking about ptys here, openpty(3) comes to mind, but that
> uses open(2) as well.
> 
> It could also be inherited from a non-Cygwin parent.  That would
> create the fhandler via dtable::init_std_file_from_handle().  This
> does actually not call open or set PATH_OPEN.
> 
> Am I missing something?  I'd really like to understand why the PATH_OPEN
> flag isn't set, and if that's correct as is.  Adding a missing PC_OPEN
> or PATH_OPEN to some place or other could just as well be the right
> thing to do here.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
