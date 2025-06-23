Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id C672A388223B; Mon, 23 Jun 2025 08:24:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C672A388223B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1750667090;
	bh=dMomMIBy37M40K7MMMbdaktNkAwFEu0+k27ONOucuZo=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=kBI7KO/6Hm2G9oQQvZZe8El1xLPKO+ZePQgePZlSLK4bdHxPC0YdOzyBafS84w5sD
	 jP1L/NFJb8sFN+efODZaprTBc6+PKFpNRc6D6AnemTeLItAGRN28smI/63qb6bQi4F
	 mtvRR2oY3DtBmGkBM1E2BGdMSDXtlJVTjx/xISXw=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 602D9A80667; Mon, 23 Jun 2025 10:24:48 +0200 (CEST)
Date: Mon, 23 Jun 2025 10:24:48 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Subject: Re: symlink_native() bug with case-sensitive file-systems Re:
 [PATCH] symlink_native: allow linking to `..`
Message-ID: <aFkPUI22HlYnYhZh@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com, cygwin@cygwin.com
References: <6058889e2ae8c9c827a8d6678f09b3b1741e2fcf.1750413578.git.johannes.schindelin@gmx.de>
 <CAHnbEGLjsy4MZD+oqjGbd=JrX+q8an3mhT38xndEgjmTpWyOnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHnbEGLjsy4MZD+oqjGbd=JrX+q8an3mhT38xndEgjmTpWyOnw@mail.gmail.com>
List-Id: <cygwin-patches.cygwin.com>

On Jun 20 13:33, Sebastian Feld wrote:
> On Fri, Jun 20, 2025 at 12:03 PM Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> >  winsup/cygwin/path.cc | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
> > index 42919a7cf5..ed08398930 100644
> > --- a/winsup/cygwin/path.cc
> > +++ b/winsup/cygwin/path.cc
> > @@ -1855,9 +1855,18 @@ symlink_native (const char *oldpath, path_conv &win32_newpath)
> >        while (towupper (*++c_old) == towupper (*++c_new))
> 
> 1 unrelated issue:
> I think this towupper() code is WRONG if the filesystem (e.g. WSL) is
> case-sensitive!

The preceding comment tries to explain why we always compare case
insensitive.  There's a high probability that the symlink will be used
by native (non-Cygwin) processes which are insensitive.

> How can code in cygwin.dll test whether the current path is on a
> case-sensitive volume, or not?

There's a twist here.  NTFS or ReFS or other filesystems (but not FAT)
are usually case sensitive.  It's the OS which makes them case insensitve
by using a specific flag at open time, combined with a kernel registry
key.  So apart from FAT, the creator of a file decides if it's created
sensitive or insensitive, and the one searching for and opening a file
is deciding if the search/open is sensitive or insensitive.

Also, we're creating the symlink via CreateSymbolicLinkW, which is
probably acting case insensitive anyway...

What if the perr-dir case-sensitive
> feature is ON, should that be probed and handled too?

...unless the symlink is created in a case sensitive dir, I assume.

Right now we don't handle case sensitive dirs in the path_conv code.  We
only check for the kernel registry key and the FILE_CASE_SENSITIVE_SEARCH
filesystem flag.

To add the sensitive dirs to the picture, path_conv() would have to
check every directory on NTFS for
NtQueryInformationFile(FileCaseSensitiveInformation). It would then
set the path_conv::caseinsensitive flag accordingly.


Corinna
