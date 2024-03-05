Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 3D8333858C41; Tue,  5 Mar 2024 10:14:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D8333858C41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709633688;
	bh=rfy1Q+njQ07NB5ECMoJ0z32pzSHDJaKKWQOp8Ao44Iw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Ky2okLOPQkKhgKzsTqQ1MJwL/rfAoyyMVFyubmcS3Qo9VQVH5VQ2lBnVl/ZkfkR7T
	 eLnecikXF50F5LxfEyrC+iNcJ2f9IFaHCbWwcuHLx+X5IzYTztItuiW2MAJ0TnVPdS
	 QkUps3JdUM34sGLQOqcmcn8xLwQEYJfOxt55rBtQ=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 496FEA809C6; Tue,  5 Mar 2024 11:14:46 +0100 (CET)
Date: Tue, 5 Mar 2024 11:14:46 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Give up to use query_hdl for non-cygwin
 apps.
Message-ID: <ZebwloVEzedGcBWj@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240303050915.2024-1-takashi.yano@nifty.ne.jp>
 <b0bd6b96-5bd8-7f4e-71ff-4552e5ac1cb5@gmx.de>
 <20240303192109.9fb4a3a4968bb11ca5d9636a@nifty.ne.jp>
 <87a5nfbnv7.fsf@Gerda.invalid>
 <20240303203641.09321b0a0713e8bdb90980b5@nifty.ne.jp>
 <ZeWjmEikjIUushtk@calimero.vinschen.de>
 <87edcqgfwc.fsf@>
 <ZeYG_11UfRTLzit1@calimero.vinschen.de>
 <20240305090648.6342d8f9cb8fd4ca64b47d38@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240305090648.6342d8f9cb8fd4ca64b47d38@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  5 09:06, Takashi Yano wrote:
> On Mon, 4 Mar 2024 18:38:07 +0100
> Corinna Vinschen wrote:
> > On Mar  4 16:45, ASSI wrote:
> > > Corinna Vinschen writes:
> > > > Right you are.  We always said that independent Cygwin installations
> > > > are supposed to *stay* independent.
> > > >
> > > > Keep in mind that they don't share the same shared objects in the native
> > > > NT namespace and they don't know of each other.  It's not only the
> > > > process table but also in-use FIFO stuff, pty info, etc.
> > > 
> > > What I was getting at is that a process not showing up in the process
> > > list in one Cygwin installation doesn't automatically mean it's a native
> > > Windows process, it could be a process started by an independent Cygwin
> > > installation.  So this way of checking for "native" Windows processes
> > > may or may not do what was originally intended.
> > 
> > But that was my point. A "foreign" Cygwin process from another
> > installation is not a Cygwin process.  Lots of interoperability
> > just won't work, so it's basically a native process.
> 
> Actually, I think query_hdl can be retrieved from the process
> from another installation of cygwin using NtQueryInformationProcess()
> with ProcessHandleInformation. However, I cannot imagne the case
> that the pipe is made by one cygwin installation but the reader
> process is from another installation of cygwin.
> 
> BTW, what about v2 patch itself?

It does the job with less code and less memory, which is good.
I would change the comment

  stop to try to get query_hdl for non-cygwin apps

to something like

  don't try to fetch query_hdl from non-cygwin apps

"stop trying" is a bit of a back-reference to the old code, which
is not necessary, I think.

This doesn't affect your patch, but while looking into this, what
strikes me as weird is that fhandler_pipe::temporary_query_hdl() calls
NtQueryObject() and assembles the pipe name via swscanf() every time it
is called.

Wouldn't it make sense to store the name in the fhandler's
path_conv::wide_path/uni_path at creation time instead?
The wide_path member is not used at all in pipes, ostensibly.


Thanks,
Corinna
