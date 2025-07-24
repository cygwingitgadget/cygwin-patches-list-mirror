Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 37EC03857B94; Thu, 24 Jul 2025 13:20:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 37EC03857B94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1753363221;
	bh=FvzsbQMHvwZECZeW97QGH0TQKhp6iQRyKSMGJKUlQEA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=KLoJ3c1k6t/0CxyGzDkMy7VnXZd8q4Nf2CMed+jsjvvacf2ZXAZiqOPKG4tfAkdSN
	 xe8rQtyHKWMyDjYpjVa2P+oxZVwKLV9odS1DW07xxSAgvELcKB+d0Qoy0FwvN9uhf3
	 C58hDOCi2It08hqDYaGQdix1ZZW82ZRlecCdq5VI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 828EAA80DCD; Thu, 24 Jul 2025 15:20:19 +0200 (CEST)
Date: Thu, 24 Jul 2025 15:20:19 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix handling of archetype fhandler in
 process_fd
Message-ID: <aIIzE9Q3HPTV7_oo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250724115713.1669-1-takashi.yano@nifty.ne.jp>
 <aIIv1EH-BccejUqa@calimero.vinschen.de>
 <aIIxfYssj6zseSPi@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aIIxfYssj6zseSPi@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 24 15:13, Corinna Vinschen wrote:
> On Jul 24 15:06, Corinna Vinschen wrote:
> > On Jul 24 20:57, Takashi Yano wrote:
> > > Previously, process_fd failed to correctly handle fhandlers using an
> > > archetype. This was due to the missing PATH_OPEN flag in path_conv,
> > > which caused build_fh_pc() to skip archetype initialization. The
> > > root cause was a bug where open() did not set the PATH_OPEN flag
> > > for fhandlers using an archetype.
> > > 
> > > This patch introduces a new method, path_conv::set_isopen(), to
> > > explicitly set the PATH_OPEN flag in path_flags in fhandler_base::
> > > open_with_arch().
> > 
> > Wouldn't this patch fix the problem as well?
> > 
> > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc
> > index 887e2ef722bf..2801c806edd5 100644
> > --- a/winsup/cygwin/fhandler/console.cc
> > +++ b/winsup/cygwin/fhandler/console.cc
> > @@ -4311,7 +4311,7 @@ fhandler_console::init (HANDLE h, DWORD a, mode_t bin, int64_t dummy)
> >  {
> >    // this->fhandler_termios::init (h, mode, bin);
> >    /* Ensure both input and output console handles are open */
> > -  int flags = 0;
> > +  int flags = PC_OPEN;
> >  
> >    a &= GENERIC_READ | GENERIC_WRITE;
> >    if (a == GENERIC_READ)
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 77a363eb0e3b..10785e240091 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -1015,7 +1015,7 @@ fhandler_pty_slave::close (int flag)
> >  int
> >  fhandler_pty_slave::init (HANDLE h, DWORD a, mode_t, int64_t dummy)
> >  {
> > -  int flags = 0;
> > +  int flags = PC_OPEN;
> >  
> >    a &= GENERIC_READ | GENERIC_WRITE;
> >    if (a == GENERIC_READ)
> > 
> > 
> > Corinna
> 
> No, it wouldn't.  flags are not or'ed in the followup code.  Sigh.
> 
> diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhandler/console.cc

And no, this one wouldn't either. I'm not thinking straight ATM, sorry.

Your patch is GTG.


Thanks,
Corinna
