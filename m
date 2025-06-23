Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 2CAE43865466; Mon, 23 Jun 2025 19:46:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2CAE43865466
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750707993;
	bh=4O708Ko2OC6DxoJL6sUZDVohMx4N2OqwJvU9CmYYWH4=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=RgBd3751LI/bkBTNiOruAlySfPHoQNlKe0Zh5UfxQHFuzRMMBA34l1X+eM2O6HHyZ
	 bGsAt/JnO5Igns3WMR1t016r6Fcb6z+w7q4mNc0P1bkC7DjvwpstOV8TCQBDo6O+BV
	 C620sc0JOZjwMC8dlEs5w71bGwE46UuhBPdjfA64=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 16E9DA80D72; Mon, 23 Jun 2025 21:46:31 +0200 (CEST)
Date: Mon, 23 Jun 2025 21:46:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: symlink_native() bug with case-sensitive file-systems Re:
 [PATCH] symlink_native: allow linking to `..`
Message-ID: <aFmvF9cWsr8UCqQ6@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
References: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
 <CAHnbEGLjsy4MZD+oqjGbd=JrX+q8an3mhT38xndEgjmTpWyOnw@mail.gmail.com>
 <aFkPUI22HlYnYhZh@calimero.vinschen.de>
 <CAHnbEG+7T8K50WkDN4=xBA_ir8N3M32=ZGJnYvCFSpH7UquZ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHnbEG+7T8K50WkDN4=xBA_ir8N3M32=ZGJnYvCFSpH7UquZ=Q@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 23 20:22, Sebastian Feld wrote:
> On Mon, Jun 23, 2025 at 10:52 AM Corinna Vinschen
> <corinna-cygwin@cygwin.com> wrote:
> >
> > On Jun 20 13:33, Sebastian Feld wrote:
> > > On Fri, Jun 20, 2025 at 12:03 PM Johannes Schindelin
> > > <johannes.schindelin@gmx.de> wrote:
> > > >  winsup/cygwin/path.cc | 21 ++++++++++++++++-----
> > > >  1 file changed, 16 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > > > index 42919a7cf5..ed08398930 100644
> > > > --- a/winsup/cygwin/path.cc
> > > > +++ b/winsup/cygwin/path.cc
> > > > @@ -1855,9 +1855,18 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
> > > >        while (towupper (*++c_old) == towupper (*++c_new))
> > >
> > > 1 unrelated issue:
> > > I think this towupper() code is WRONG if the filesystem (e.g. WSL) is
> > > case-sensitive!
> >
> > The preceding comment tries to explain why we always compare case
> > insensitive.  There's a high probability that the symlink will be used
> > by native (non-Cygwin) processes which are insensitive.
> 
> OK, but this is at least bad for performance.
> 
> Some stats from a profiling tool I am working on:
> German language, multibyte locale, codepage 65001:
> Each towupper() traverses 11 functions, covering between 8002 and
> 11722 instructions, and between 260 and 469 branches, on 64bit.
> If the code could just use the per-volume case sensitive flag, then
> this could be reduced to 20-30 instructions just to do the indirect
> load (2 times) and compare.

Yes, but real life is working against you.  I would bet that most
users never touch case sensitivity settings and most scenarios
are touching case insensitive paths.

Worse, consider a case-sensitive dir:

  C:\foo\bar\baz\i_am_a_case_sensitive_dir

All path components preceeding the i_am_a_case_sensitive_dir have
to be compared case insensitive!  *Only* the i_am_a_case_sensitive_dir
and path components below that have to be compared case sensitive.

No fun.  No fun at all.

> > > How can code in cygwin.dll test whether the current path is on a
> > > case-sensitive volume, or not?
> >
> > There's a twist here.  NTFS or ReFS or other filesystems (but not FAT)
> > are usually case sensitive.  It's the OS which makes them case insensitve
> > by using a specific flag at open time, combined with a kernel registry
> > key.  So apart from FAT, the creator of a file decides if it's created
> > sensitive or insensitive, and the one searching for and opening a file
> > is deciding if the search/open is sensitive or insensitive.
> >
> > Also, we're creating the symlink via CreateSymbolicLinkW, which is
> > probably acting case insensitive anyway...
> >
> > What if the perr-dir case-sensitive
> > > feature is ON, should that be probed and handled too?
> >
> > ...unless the symlink is created in a case sensitive dir, I assume.
> >
> > Right now we don't handle case sensitive dirs in the path_conv code.  We
> > only check for the kernel registry key and the FILE_CASE_SENSITIVE_SEARCH
> > filesystem flag.
> >
> > To add the sensitive dirs to the picture, path_conv() would have to
> > check every directory on NTFS for
> > NtQueryInformationFile(FileCaseSensitiveInformation). It would then
> > set the path_conv::caseinsensitive flag accordingly.
> 
> Yikes. Does Windows cache this per-dir info somewhere?

I honestly don't know.


Corinna
