Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 4F6843857359; Thu, 24 Jul 2025 15:39:07 +0000 (GMT)
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id A58D2A80CDB; Thu, 24 Jul 2025 17:39:05 +0200 (CEST)
Date: Thu, 24 Jul 2025 17:39:05 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: Fix handling of archetype fhandler in
 process_fd
Message-ID: <aIJTmW9pfkyJNH46@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20250724115713.1669-1-takashi.yano@nifty.ne.jp>
 <aIIv1EH-BccejUqa@calimero.vinschen.de>
 <aIIxfYssj6zseSPi@calimero.vinschen.de>
 <aIIzE9Q3HPTV7_oo@calimero.vinschen.de>
 <20250725002646.64f8a7b84be3939a9dcf8e14@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250725002646.64f8a7b84be3939a9dcf8e14@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Jul 25 00:26, Takashi Yano wrote:
> On Thu, 24 Jul 2025 15:20:19 +0200
> Corinna Vinschen wrote:
> > On Jul 24 15:13, Corinna Vinschen wrote:
> > > On Jul 24 15:06, Corinna Vinschen wrote:
> > > > On Jul 24 20:57, Takashi Yano wrote:
> > > > > Previously, process_fd failed to correctly handle fhandlers using an
> > > > > archetype. This was due to the missing PATH_OPEN flag in path_conv,
> > > > > which caused build_fh_pc() to skip archetype initialization. The
> > > > > root cause was a bug where open() did not set the PATH_OPEN flag
> > > > > for fhandlers using an archetype.
> > > > > 
> > > > > This patch introduces a new method, path_conv::set_isopen(), to
> > > > > explicitly set the PATH_OPEN flag in path_flags in fhandler_base::
> > > > > open_with_arch().
> > > > Wouldn't this patch fix the problem as well?
> > > > [...]
> > > No, it wouldn't.  flags are not or'ed in the followup code.  Sigh.
> > > [...]
> > And no, this one wouldn't either. I'm not thinking straight ATM, sorry.
> 
> Thanks. The following patch also fixes the issue, however, the intent of
> the code is more unclear than v2 patch, I think.
> The root cause is the same for pty and console, but fixes are different.

Yeah, v2 is it.


Thanks,
Corinna
