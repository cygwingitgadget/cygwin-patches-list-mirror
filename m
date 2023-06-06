Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C70583858D33; Tue,  6 Jun 2023 13:28:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C70583858D33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1686058135;
	bh=ohCaUFhq5xLkeGXFF8wlLw3LtfR0x9oO8QWfG0LHg4g=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Y+FOW0hA85mBsaUEs12ci1xwvgqL4b7NFp5AJgrJCznRtv4bEHmzkX64iVH+3dNXO
	 KDdm7krY2da94p7foEuhg5TmunB6pBnQgXXswCKGgLY4wuat3xOhaDs+0nSrd0RiO3
	 j57BjkgF883RN2NMgqEtg9us2Jyqo34ZUPsQjoGY=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 290E7A80B78; Tue,  6 Jun 2023 15:28:54 +0200 (CEST)
Date: Tue, 6 Jun 2023 15:28:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Philippe Cerfon <philcerf@gmail.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] include/cygwin/limits.h: add XATTR_{NAME,SIZE,LIST}_MAX
Message-ID: <ZH80lgpsfWwCZp+R@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Philippe Cerfon <philcerf@gmail.com>,
	cygwin-patches@cygwin.com
References: <CAN+za=MhQdD2mzYxqVAm9ZwBUBKsyPiH+9T5xfGXtgxq1X1LAA@mail.gmail.com>
 <f4106af5-ed7a-0df5-a870-b87bb729f862@Shaw.ca>
 <ZH4yDkPXLU9cYsrn@calimero.vinschen.de>
 <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN+za=MTBHNWV+-4rMoBb_zefPO7OG2grySUFdV-Eoa2aQg_uw@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

Hi Philippe,

On Jun  6 03:14, Philippe Cerfon wrote:
> Hey Corinna, et al.
> 
> On Mon, Jun 5, 2023 at 9:05 PM Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> > - Whatever that's good for, we actually allow bigger values right
> >   now.  For compat reasons we only allow attributes starting with
> >   the "user." prefix, and the *trailing* part after "user." is
> >   allowed to be 255 bytes long, because we don't store the "user."
> >   prefix in the EA name on disk.  So in fact, XATTR_NAME_MAX should
> >   be 255 + strlen("user.") == 260.
> 
> I haven't given to much though into that right now (just about to go
> for 2 weeks on vacation), but if "we" (Cygwin) allow now names up to
> 260 bytes, because we don't store the "user." .. doesn't that mean
> users could set XATTRs, that in the end couldn't be read by e.g. Linux
> (should there be, or ever be in the future, support for reading
> FAT/NTFS' EAs as XATTRs.... e.g. from the Linux FAT/NTFS fs drivers)?

No, that's no problem.  The names on disk are actually just 255 chars
long, so the Linux kernel will handle them just fine.  It's only Cygwin
which should expose 260 chars to user space to emulate the "user."
prefix.

> > - If we actually define these values in limits.h, it would also be a
> >   good idea to use them in ntea.cc and to throw away the MAX_EA_*_LEN
> >   macros.
> 
> Done so in a 2nd commit.
> But that commit, right now, really just replaces the name!
> MAX_EA_NAME_LEN was set 256, so presumably with the null terminator...
> while now it would be set to 260, which seems wrong.

Yes, it is wrong, because the value of MAX_EA_NAME_LEN / XATTR_NAME_MAX
is used for array size definitions as well as comparisons.

> Please just adapt if necessary,... or at least I won't likely be able
> to update the patch until in about 2 weeks or so.

No worries, we're in no hurry.


Thanks,
Corinna
