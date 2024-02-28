Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 54A973858C98; Wed, 28 Feb 2024 09:01:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 54A973858C98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1709110884;
	bh=UTRcC9eWaUfHJeVRROvnu7t5pkPD7ch0YeIyC7rCofQ=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ZP3L3m2sFOZYBsPLA/mRYB1uNgV6EuY6TaOMBZLy2P25EPgnrdf4A6VgSRF22RY8U
	 mZjEMgy4leLkPIjZGwBx9pAokXAB1UXSDIy11fKBaLThD99uAoIUMfuCqLvTkBI2pa
	 /KASDYHTdgJKV7zJZN3rn2/3lD2NhE++BVcOZGkg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 76DF7A80CFF; Wed, 28 Feb 2024 10:01:22 +0100 (CET)
Date: Wed, 28 Feb 2024 10:01:22 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 2/2] Cygwin: remove ENOSHARE and ECASECLASH from
 _sys_errlist[]
Message-ID: <Zd72Yl8-5UTI9ULE@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f0c37daf-4086-d5b9-9812-8b15916ad987@t-online.de>
 <ede12d4d-3401-5d68-cfd1-f3aafa6a3394@t-online.de>
 <Zd3457LfikTibhEm@calimero.vinschen.de>
 <584bf6ac-4954-7075-8712-801d4bbda41d@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <584bf6ac-4954-7075-8712-801d4bbda41d@t-online.de>
List-Id: <cygwin-patches.cygwin.com>

On Feb 27 17:26, Christian Franke wrote:
> Hi Corinna,
> 
> Corinna Vinschen wrote:
> > On Feb 27 13:18, Christian Franke wrote:
> > > ...
> > > 
> > > diff --git a/winsup/cygwin/errno.cc b/winsup/cygwin/errno.cc
> > > index 7d58e62ec..d8c057e51 100644
> > > --- a/winsup/cygwin/errno.cc
> > > +++ b/winsup/cygwin/errno.cc
> > > @@ -167,8 +167,8 @@ const char *_sys_errlist[] =
> > >   /* ESTALE 133 */	  "Stale NFS file handle",
> > >   /* ENOTSUP 134 */	  "Not supported",
> > >   /* ENOMEDIUM 135 */	  "No medium found",
> > > -/* ENOSHARE 136 */	  "No such host or network path",
> > > -/* ECASECLASH 137 */	  "Filename exists with different case",
> > > +			  NULL, /* Was ENOSHARE 136, no longer used. */
> > > +			  NULL, /* Was ECASECLASH 137, no longer used. */
> > In terms of politenness, wouldn't it be better to define them as
> > empty strings?  This may be one crash less in already existing
> > binaries...
> 
> Indeed, I missed that case. Patch attached.
> 
> Christian
> 

> From 151da4ef76f84cd0343e6f49aa23de398ca73d1c Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Tue, 27 Feb 2024 17:21:45 +0100
> Subject: [PATCH 2/2] Cygwin: set ENOSHARE and ECASECLASH _sys_errlist[]
>  entries to empty
> 
> These errno values are no longer used by Cygwin.  Change the entries
> to empty strings instead of NULL to avoid crashes in existing
> binaries directly accessing the table.  Enhance strerror_worker()
> such that empty strings also result in "Unknown error ..." messages.
> Also add a static_assert check for the _sys_errlist[] size.
> 
> Signed-off-by: Christian Franke <christian.franke@t-online.de>
> ---
>  winsup/cygwin/errno.cc | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Pushed.

Thanks,
Corinna

