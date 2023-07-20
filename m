Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 60D1C3858CDB; Thu, 20 Jul 2023 15:17:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 60D1C3858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689866274;
	bh=ttqtAri8ffGAhvkpyOBbeR4YPBi0f8C6j8xMkCGeq94=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=uCRyobab2pVs8xz+sB+9QSExwkjluB9/lz9DOooklRxfvtXgDTMPcz7PuKO4b4cGE
	 4YWjclN0P79lKe3gKhlYD0ZQPbXHbLXRM15tdgF3u3+YULaWsNDJ5qiVK8EbRzrJfO
	 cBpPSDlMBLGVqggbOl267hocYaZLEjtyYi/57Xyg=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 0B1A3A81B2B; Thu, 20 Jul 2023 17:17:52 +0200 (CEST)
Date: Thu, 20 Jul 2023 17:17:51 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Testsuite adjustment and relevant fix
Message-ID: <ZLlQH47+AXD+YcMU@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
 <ZLgCVymLYi9ZB0uZ@calimero.vinschen.de>
 <0a200d0b-877e-48d5-7f20-c602b8d92de6@dronecode.org.uk>
 <ZLlPVSe3UyZ1tjXT@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZLlPVSe3UyZ1tjXT@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul 20 17:14, Corinna Vinschen wrote:
> On Jul 20 13:55, Jon Turney wrote:
> > On 19/07/2023 16:33, Corinna Vinschen wrote:
> > > On Jul 19 13:41, Jon Turney wrote:
> > > > [1/2] has the side effect of flipping test stat06 from working to failing.
> > > > [2/2] fixes that
> > > > 
> > > > When run with TDIRECTORY set, libltp just uses that directory and assumes
> > > > something else will clean it up.
> > > > 
> > > > When TDIRECTORY is not set, libltp creates a subdirectory under /tmp, and when
> > > > the test is completed, removes the expected files and verifies that the
> > > > directory is empty.
> > > > 
> > > > stat06 fails that check, because it creates the a file named "file" there, and
> > > > tries stat("file", -1), testing that it returns the expected value EFAULT.
> > > > 
> > > > "file" is removed, but lingers in the STATUS_DELETE_PENDING state until the
> > > > Windows handle which stat_worker() leaks when an exception occurs is closed
> > > > (when the processes exits).
> > > 
> > > Great find. Please push.
> > 
> > So, it seems this doesn't work in an optimized build, as fh is always NULL
> > when we get around to deleting it after a fault.
> > 
> > I'm thinking that I've written this wrong somehow (horses), rather than it
> > being some complex problem with how the optimizer interacts with all the
> > memory and register barriers the exception handling uses (zebras)
> 
> What if you turn around the order instead?
> 
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index 73343ecc1f07..32ace4d38943 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -1967,12 +1967,13 @@ stat_worker (path_conv &pc, struct stat *buf)
>  	{
>  	  fhandler_base *fh;
>  
> -	  if (!(fh = build_fh_pc (pc)))
> -	    __leave;
> -
>  	  debug_printf ("(%S, %p, %p), file_attributes %d",
>  			pc.get_nt_native_path (), buf, fh, (DWORD) *fh);
>  	  memset (buf, 0, sizeof (*buf));

Maybe adding a MemoryBarrier() call here if all else fails...

> +
> +	  if (!(fh = build_fh_pc (pc)))
> +	    __leave;
> +
>  	  res = fh->fstat (buf);
>  	  if (!res)
>  	    fh->stat_fixup (buf);
