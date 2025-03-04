Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id B00453858D21; Tue,  4 Mar 2025 11:34:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B00453858D21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1741088076;
	bh=H87ESmbEVb73aeD3o03wK1AFjunjRgjU+Dfr9dfsy5M=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=VBnNiFWPFlbGU/eWPBbwajljs5/0OVkjiL8820rZ7VBbN9kU4WxrT+I0Bt0CkIYMR
	 U+SfJAQ050Y6z+8UFq6OIxk/BQb66JVAbDawpYYrnlnOulY6op2TdbJW0NrTNjVfgg
	 sOrZQQtvxjbp6Hd39kqLVSUJnMBUFSi9kbUQK7OU=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 9A159A806B7; Tue, 04 Mar 2025 12:34:34 +0100 (CET)
Date: Tue, 4 Mar 2025 12:34:34 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Adjust CWD magic to accommodate for the latest
 Windows previews
Message-ID: <Z8blSgY5iSPALP3A@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
 <Z8WHsUDXsVhtOEzS@calimero.vinschen.de>
 <576cd7fb-a579-4eda-19bf-1735a7a55bf0@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <576cd7fb-a579-4eda-19bf-1735a7a55bf0@jdrake.com>
List-Id: <cygwin-patches.cygwin.com>

On Mar  3 13:19, Jeremy Drake via Cygwin-patches wrote:
> On Mon, 3 Mar 2025, Corinna Vinschen wrote:
> 
> > > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > > index 599809f941..49740ac465 100644
> > > --- a/winsup/cygwin/path.cc
> > > +++ b/winsup/cygwin/path.cc
> > > @@ -4539,6 +4539,18 @@ find_fast_cwd_pointer ()
> > >           %rcx for the subsequent RtlEnterCriticalSection call. */
> > >        lock = (const uint8_t *) memmem ((const char *) use_cwd, 80,
> > >                                         "\x48\x8d\x0d", 3);
> > > +      if (lock)
> > > +	{
> > > +	  /* A recent Windows 11 Preview calls `lea rel(rip),%rcx' then
> > > +	     a `mov` and a `movups` instruction, and only then
> > > +	     `callq RtlEnterCriticalSection'.
> > > +	     */
> > > +	  if (memmem (lock + 7, 8, "\x4c\x89\x78\x10\x0f\x11\x40\xc8", 8))
> >
> > Is it really necessary to check for each and every byte between lea and
> > callq?  I wonder if this can't be simpler by simply checking for the
> > '\x48\x8d\x0d` needle and then, instead of just assuming a fixed
> > call_rtl_offset, skip programatically to the next callq 0xe8 byte
> > within the next 16 bytes or so?
> 
> I think looking for only a single byte might have too high a probability
> of a false-positive match inside a multi-byte instruction.  As you said
> 
> > It needs a lot of knowledge of instructons and their respective length,
> > to skip the uninteresting parts.

Yeah, sure.  I'm a bit concerned that this expression, testing every
single byte for a fixed value, will only match this very preview build,
is all.  Shouldn't we give a little slack for different registers at
least?  Kind of like

  movq   <somereg>, <someoffset>(%rax)	0x4c 0x89 + 2 bytes
  movups xmm0, <someoffset>(%rax)	0x0f 0x11 + 2 bytes

?


Thanks,
Corinna
