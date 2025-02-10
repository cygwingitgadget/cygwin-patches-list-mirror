Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F1A653858D26; Mon, 10 Feb 2025 11:34:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F1A653858D26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739187274;
	bh=eEz5lnJWH3wGwPJjd44Az8ebuCwfQmYcWG3sTAuqVxs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=h7sY717QVQdvfdTbDaGUrmTryyfrsOycoZoovNKa9EfRcmg/tO3ySGDMZkza3Jy9S
	 2qNvL8xcvVy6Y5LuWGOFPOq4DhQmiVc4awkgACJcIwMt9jhRgXIj+SzXZg+QzBXHqq
	 +TjjGOX2rkgG+xdVRJCP47kpYq9vzmBegO55S8GU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 5AB30A80D2E; Mon, 10 Feb 2025 12:34:33 +0100 (CET)
Date: Mon, 10 Feb 2025 12:34:33 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: expose all windows volume mount points.
Message-ID: <Z6nkSf7l7MOuQdBb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <be64d541-a24d-b5ff-5a50-9aae577a48ae@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <be64d541-a24d-b5ff-5a50-9aae577a48ae@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb  7 20:38, Jeremy Drake via Cygwin-patches wrote:
> They are exposed via the getmntent API and proc filesystem entries
> dealing with mounts.  This allows things like `df` to show volumes
> that are only mounted on directories, not on drive letters.
> 
> Addresses: https://cygwin.com/pipermail/cygwin/2025-February/257251.html
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> Rather amazingly, this seemed to work as I expected.  Kind of gross due to
> keeping state in the _mytls.locals struct, but it seems to do the job.
> Does this approach make sense, or is there something I'm missing?

The approach makes sense, but...

On Feb  8 10:27, Jeremy Drake via Cygwin wrote:
> On Sat, 8 Feb 2025, Corinna Vinschen via Cygwin wrote:
> > Go for it.  There's already matching logic in fhandler/proc.cc,
> > function format_proc_partitions() for the "win-mounts" column
> > of /proc/partitions.  Probably this can be reused.
> 
> Actually closer to the dos_drive_mappings at the end of mount.cc, except
> that only looks at the first mount point.  But, reusing anything might be
> difficult due to having to save state and resume iteration on subsequent
> calls.  Open to suggestions on
> https://cygwin.com/pipermail/cygwin-patches/2025q1/013353.html.

Yes, dos_drive_mappings() is what I really meant, thanks for pointing
it out.

So I wonder why not include your additional requirements into the
dos_drive_mappings class and just use it to iterate over the mount
points.  AFAICS there are only two things missing in dos_drive_mappings:

- looking for all mount points, not just the first one, and
- bookkeeping over getmntent calls

If you add a state pointer (pointing to the current mapping) to
dos_drive_mappings, you only need a single slot in the TLS, holding a
pointer to your dos_drive_mappings instance.

[...time passes...]

Hang on, there might be a bug here...

[...time passes...]

Why do we keep the cygdrive state in cygtls anyway?  From history I see
that this has been the case since at least 2003.

Per definition, getmntent isn't thread-safe at all, and getmntent_r is
only thread-safe in that it keeps the data in a buffer provided by the
caller.
However, the state information is process-wide: if you call getmntent
alternating in two different threads, they don't see the same set of
drives, but only every second drive.

At least this is the case on Linux.  Don't we subvert expectations
by handling getmentent thread-local?

If I'm thinking to much outside the box, feel free to kick me.


Thanks,
Corinna
