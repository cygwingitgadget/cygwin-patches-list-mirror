Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1FF8D3858D20; Thu, 19 Dec 2024 17:24:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1FF8D3858D20
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1734629077;
	bh=77h3fQw42cRfQUkLXnkXfAmL4PwSz/VGyt/io+3RGmc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=x99X0wMnAmJVEMfTtUmVmgZ3GusQCcnSBx9hBXcKBOFKUT2kEnEvOzfkWdGepJmv3
	 ROAQTVdby05zBSkmu/aGWv+FT62bXV69XEl3UBSyW9Myq4/7LLTE7ennZKmTQPjkV7
	 MhdBT1IpucvRS1LOLZt4Qw5i31M2a5GcLgh0VnKI=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D64F9A8096C; Thu, 19 Dec 2024 18:24:34 +0100 (CET)
Date: Thu, 19 Dec 2024 18:24:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: mmap fixes
Message-ID: <Z2RW0qTATkXLb_0x@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3c4f732a-52de-42d3-a6d3-7fea99a343ff@cornell.edu>
 <Z2PyzRoS2QeOrNem@calimero.vinschen.de>
 <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c2b2c0ee-e848-4b1d-b41d-7568671b77e4@cornell.edu>
List-Id: <cygwin-patches.cygwin.com>

On Dec 19 09:59, Ken Brown wrote:
> Hi Corinna,
> 
> On 12/19/2024 5:17 AM, Corinna Vinschen wrote:
> > Fixes: c68de3a262fe5 ("* mmap.cc (class mmap_record): Declare new map_pages method with address parameter.")
> 
> Again thanks.  Some time you'll have to tell me how to find those commits.

I'm using `git blame <filename>' and check relevant commit IDs backwards
in time until it fits.  When I find a commit 123456789 which changes the
lines but is not actually the one introducing the problem, next I use

  git blame <filename> 123456789^  <--Note the caret

For files changing their name, you have to change the filename on
the commandline, too.  For instance

  git blame mm/mmap.cc

but

  git blame mmap.cc 123456789^

if the commit is before the filename change.

> > > +	  if (u_addr > (caddr_t) addr || u_len < len
> > >   	      || !rec->compatible_flags (flags))
> > 
> > While this is strictly correct, I wonder if this shouldn't be
> > 
> >    if (u_addr > (caddr_t) addr || u_addr + u_len < (caddr_t) addr + len ...
> > 
> > for plain readability.  The problem is, you can't see what match()
> > really returns, an intersection or the entire free region.  That's
> > what I stumbled over in the cygwin ML.
> > 
> > This way, the code immediately tells the reader that we want to make
> > sure that [addr,addr+len] is a region completely inside the region
> > [u_addr,u_addr+u_len], without needing to know what exactly match()
> > returns.  And it would still be correct, even if we redefine match().
> > 
> > What do you think?
> I agree.  I'll make that change and push.  At some point it might be helpful
> to add a reference parameter "contains" to match(), so that match() can
> return the information about whether the mmap_record region contains
> [addr,addr+len].  That way the relevant tests can be done right where the
> reader can see what's going on.  But I'm not going to try to do that
> immediately.

Sounds like a good extension.  It would be great if we could handle
partial page intersections at one point, too.


Corinna
