Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 31FF93858CDB; Thu, 20 Jul 2023 15:14:31 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 31FF93858CDB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1689866071;
	bh=hk7iQGjQCmrmbzUeSYVswKaJYLkRsLwB99GYryvwG7c=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=nh6YvQMEYmu6PIZA+D3Yvy8v3c7yeBxuLbuMxpongrc9lOS7F3v9R3g+0sLVsTYoN
	 09mEEiLGBePUOy+tELMZ1ftbxc/NLyNxhC1uKLayEbExbhnh1TPg5EfDVzbXIZC1CJ
	 Nt/wL6lQCWx4SIg1FjY46IjH7rXymF2qP4BQ/7q0=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 3AD43A81B2B; Thu, 20 Jul 2023 17:14:29 +0200 (CEST)
Date: Thu, 20 Jul 2023 17:14:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Testsuite adjustment and relevant fix
Message-ID: <ZLlPVSe3UyZ1tjXT@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20230719124142.10310-1-jon.turney@dronecode.org.uk>
 <ZLgCVymLYi9ZB0uZ@calimero.vinschen.de>
 <0a200d0b-877e-48d5-7f20-c602b8d92de6@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0a200d0b-877e-48d5-7f20-c602b8d92de6@dronecode.org.uk>
List-Id: <cygwin-patches.cygwin.com>

On Jul 20 13:55, Jon Turney wrote:
> On 19/07/2023 16:33, Corinna Vinschen wrote:
> > On Jul 19 13:41, Jon Turney wrote:
> > > [1/2] has the side effect of flipping test stat06 from working to failing.
> > > [2/2] fixes that
> > > 
> > > When run with TDIRECTORY set, libltp just uses that directory and assumes
> > > something else will clean it up.
> > > 
> > > When TDIRECTORY is not set, libltp creates a subdirectory under /tmp, and when
> > > the test is completed, removes the expected files and verifies that the
> > > directory is empty.
> > > 
> > > stat06 fails that check, because it creates the a file named "file" there, and
> > > tries stat("file", -1), testing that it returns the expected value EFAULT.
> > > 
> > > "file" is removed, but lingers in the STATUS_DELETE_PENDING state until the
> > > Windows handle which stat_worker() leaks when an exception occurs is closed
> > > (when the processes exits).
> > 
> > Great find. Please push.
> 
> So, it seems this doesn't work in an optimized build, as fh is always NULL
> when we get around to deleting it after a fault.
> 
> I'm thinking that I've written this wrong somehow (horses), rather than it
> being some complex problem with how the optimizer interacts with all the
> memory and register barriers the exception handling uses (zebras)

What if you turn around the order instead?

diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
index 73343ecc1f07..32ace4d38943 100644
--- a/winsup/cygwin/syscalls.cc
+++ b/winsup/cygwin/syscalls.cc
@@ -1967,12 +1967,13 @@ stat_worker (path_conv &pc, struct stat *buf)
 	{
 	  fhandler_base *fh;
 
-	  if (!(fh = build_fh_pc (pc)))
-	    __leave;
-
 	  debug_printf ("(%S, %p, %p), file_attributes %d",
 			pc.get_nt_native_path (), buf, fh, (DWORD) *fh);
 	  memset (buf, 0, sizeof (*buf));
+
+	  if (!(fh = build_fh_pc (pc)))
+	    __leave;
+
 	  res = fh->fstat (buf);
 	  if (!res)
 	    fh->stat_fixup (buf);


> If I had infinite time, maybe I'd review the source code to see if there are
> any other instances where we fail to properly dispose of objects created in
> a __try block...

I like the idea of infinite time...


Corinna
