Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id A7A1E3858D21; Wed, 23 Oct 2024 11:29:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A7A1E3858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729682968;
	bh=eaSqQy3KwTlbiN6jBUfubrRQj9NDEddlI4silCPKTDA=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=Zk2+T8ovTx+n4zXFP1Uh/y0+zg1vPcpV+XlLPKb4kRRmVNbDIZzispgrePVxF3Gcm
	 18tMCmBrTteqtEqTOuyY5hYhfYmNf5d4xHD3Os9qghDlDG0gatxds4Xf1lWTWN79LK
	 X1iLJVmOVbeK1DcJEyJM7ZRym5sIlOCJkpjd6Tn0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9CCC8A80D05; Wed, 23 Oct 2024 13:29:26 +0200 (CEST)
Date: Wed, 23 Oct 2024 13:29:26 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cygwin: timer_delete: Fix return value
Message-ID: <ZxjeFjj8IxosdLoZ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <fb690e19-367f-0741-fffe-90c30df16351@t-online.de>
 <Zxe_Zfp0BZL_bngZ@calimero.vinschen.de>
 <5216f1fa-c489-ae20-6f68-be7c924d8691@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5216f1fa-c489-ae20-6f68-be7c924d8691@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Oct 23 12:43, Christian Franke wrote:
> Corinna Vinschen wrote:
> > Hi Christian,
> > 
> > On Oct 12 18:58, Christian Franke wrote:
> > > Nobody checks the return value of functions which only free resources:
> > > close(), ..., timer_delete(), ... :-)
> > Sigh.  Apparently I broke it in 2019, see commit 229ea3f23c015.
> > 
> > >  From 2d0c5b53bba2ded8d85ed725774498cffbb4f1de Mon Sep 17 00:00:00 2001
> > > From: Christian Franke<christian.franke@t-online.de>
> > > Date: Sat, 12 Oct 2024 18:47:00 +0200
> > > Subject: [PATCH] cygwin: timer_delete: Fix return value
> > > 
> > > timer_delete() always returned failure.  This issue has been
> > > detected by 'stress-ng --hrtimers 1'.
> > > 
> > Please add
> > 
> >    Fixes: 229ea3f23c015 ("Cygwin: posix timers: reimplement using OS timer")
> > 
> > > Signed-off-by: Christian Franke<christian.franke@t-online.de>
> > > ---
> > >   winsup/cygwin/posix_timer.cc | 1 +
> > >   1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/winsup/cygwin/posix_timer.cc b/winsup/cygwin/posix_timer.cc
> > > index 9d832f201..a336b2bc2 100644
> > > --- a/winsup/cygwin/posix_timer.cc
> > > +++ b/winsup/cygwin/posix_timer.cc
> > > @@ -530,6 +530,7 @@ timer_delete (timer_t timerid)
> > >   	  __leave;
> > >   	}
> > >         delete in_tt;
> > > +      ret = 0;
> > >       }
> > >     __except (EFAULT) {}
> > >     __endtry
> > > -- 
> > > 2.45.1
> > > 
> > Also add an entry for the release/3.5.5 file, please.
> 
> Attached.
> 

Pushed.

Thanks,
Corinna
