Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 978163858C53; Wed, 12 Feb 2025 12:33:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 978163858C53
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1739363585;
	bh=fsKz0TG0WOD+yROgI9dMKqKdKkNt+ruHuvMUbaJm5Z8=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=X8Ky1fwHsFGYuA4q1L3NiR9Snp6QLLehtJhrFPn1pfRlu63lwGIj6IW3rabFw4vRB
	 mkk9zXQ/kuFV3ZAzvTvh/BzmWiuYyFdS3tDHjh2WtaCQ1G2vy7tmX2/m3vVZLC5Vv5
	 z9rn+yKExPnmTtwmE4hFAaJOaxCrP2XZmmOsKcJk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 696AAA8066E; Wed, 12 Feb 2025 13:33:03 +0100 (CET)
Date: Wed, 12 Feb 2025 13:33:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Cygwin: make list of mounts for a volume in
 dos_drive_mappings
Message-ID: <Z6yU__7mYxK7htjw@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <827294fb-0391-197f-6b53-52ea0f5e11e7@jdrake.com>
 <Z6soHzMvH9hcJMRY@calimero.vinschen.de>
 <b724a9a2-3882-298c-f0f0-58563cc5c863@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b724a9a2-3882-298c-f0f0-58563cc5c863@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Feb 11 16:13, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 11 Feb 2025, Corinna Vinschen wrote:
> 
> > On Feb 10 17:13, Jeremy Drake via Cygwin-patches wrote:
> > > make mappings linked list in order rather than reverse order.
> >
> > Why?  I'm not asking for myself, but for the commit message.
> > It may profit a lot from explaining what the change is supposed
> > to accomplish. :)
> 
> That's two good points: 1) I didn't write a proper commit message, I'll
> do that for v3.  but 2), why does the order of the list matter?

It doesn't.  Or rather, it shouldn't.  The drive letters were in order
in /cygdrive just because of the algorithm evaluating available_drives.
That's nice, but not essential.

> On my
> system, the order returned by the functions matches my "expected" order
> (my C: comes before my D:), but I don't think there's any guarantee that
> that will always be the case.  I don't think it matters other than for
> aesthetics though,

The order in /proc/self/mounts on Linux is the order in which the
drives got mounted.  You don't get them sorted unless you pipe it
through sort.  That's ok with me.

> but I don't know the motivation behind returning the
> explicit mount entries in native_sorted order.  Is there any reason why I
> might need to sort the cygdrive mount entries?  I could see that getting
> complicated.

No sorting necessary.  I'm actually really only talking about the commit
message.  It should explain what you're doing and, especially, why.

Btw.:

-               m->dospath = wcsdup (mounts);
+               if ((m->dos.path = (wchar_t *) malloc (len * sizeof (WCHAR))))  
+                 memcpy (m->dos.path, mounts, len * sizeof (WCHAR));

A short comment preceding the above change along the lines of "store
mount point list and split into dospath entries" wouldn t hurt.


Corinna
