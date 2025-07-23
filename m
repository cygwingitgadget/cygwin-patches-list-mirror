Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 5F7A63858C62; Wed, 23 Jul 2025 12:53:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5F7A63858C62
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753275215;
	bh=XXB8To3uTwqC3Wv/YINinqLZnoofM0sHCVC7gh5etjY=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=eQkQBuO0zYzUBX5VG5920lKnkJIXPQjhllzlSiLWLlLAiU+ffSdwz5gZVpEulnh/W
	 aFJvwpaLvqogfm4khi+wFXb9PgyhaehLxviq4eHkAIEnzdD3tTl1wOC2udXvriVl/n
	 4mzjZAE9cIsvdTppNsucOCpMvDkg/9YunZjiKCT0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 73505A80CF9; Wed, 23 Jul 2025 14:53:33 +0200 (CEST)
Date: Wed, 23 Jul 2025 14:53:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: process_fd: Fix handling of archetype fhandler
Message-ID: <aIDbTUeOEM6kSDUh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250722123240.349-1-takashi.yano@nifty.ne.jp>
 <aIClgpTaJ_6khEmq@calimero.vinschen.de>
 <20250723195536.5783866c1683727f0ca49fb1@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250723195536.5783866c1683727f0ca49fb1@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 23 19:55, Takashi Yano wrote:
> On Wed, 23 Jul 2025 11:04:02 +0200
> Corinna Vinschen wrote:
> > On Jul 22 21:32, Takashi Yano wrote:
> > > Previously, process_fd did not handle fhandler using archetype
> > > correctly. Due to lack of PC_OPEN flag for path_conv, build_fh_pc()
> > > could not initialize archetype. Because of this bug, accessing pty
> > > or console via process_fd fails.
> > > 
> > > With this patch, use build_fh_name() with PC_OPEN flag instead of
> > > build_fh_pc() to set PC_OPEN flag to path_conv.
> > 
> > Your patch fixes the issue, ok, but I don't understand why this occurs.
> > 
> > If the process opens /proc/PID/fd/N with PID != MYPID, it uses the
> > PICOM_FILE_PATHCONV commune request.  It copies the path_conv member
> > of the fd from the target process and this pc is used in the
> > build_fh_pc() call.
> > 
> > And here's what I don't get: If the pc has been fetched from a valid,
> > open file descriptor in the target process, why is the PATH_OPEN
> > flag not set?
> 
> Thanks for reviewing.
> 
> I looked into open process, and noticed that this is because fh_alloc()
> called from build_fh_name() does not copy argument pc.path_flags to
> fh->pc.path_flags.

No, wait.  build_fh_name() creates a path_conv instance and that in turn
is used to call build_fh_pc().  build_fh_pc() calls fh_alloc() and then
calls fh->set_name (pc) in allmost all scenarios.  This in turn should
copy pc.path_flags, because the underlying path_conv::<< operator is
basically a memcpy().

So this looks like PATH_OPEN hasn't been set when creating descriptor
FD in process PID.

I don't see that PATH_OPEN gets removed at one point, it's set once and
then just checked for in the path_conv::isopen() method.  And the flags
should be inherited from parent to child via cygheap copy.

So, afaics, the descriptor has originally been opened without PC_OPEN,
i.e., not via open(2).

Given we're talking about ptys here, openpty(3) comes to mind, but that
uses open(2) as well.

It could also be inherited from a non-Cygwin parent.  That would
create the fhandler via dtable::init_std_file_from_handle().  This
does actually not call open or set PATH_OPEN.

Am I missing something?  I'd really like to understand why the PATH_OPEN
flag isn't set, and if that's correct as is.  Adding a missing PC_OPEN
or PATH_OPEN to some place or other could just as well be the right
thing to do here.


Thanks,
Corinna
