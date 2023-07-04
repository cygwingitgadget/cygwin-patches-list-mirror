Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 7B1D73858D32; Tue,  4 Jul 2023 18:38:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7B1D73858D32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1688495907;
	bh=zai+yb2hd1L2lZUS5AIj68ljLMVGAzlQjKPt7rfl89E=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=qEk5HVuz3g1a7139X5zaqsO4gx8WZjpK32qFwG1/e+VLgnF+ZTu5kp2Q6oo93kmlm
	 IilnN8UdwpxWiSxS8Azct2n1qT6s25C+xBxRVFMKANfWt9EIgFIXEE1gZTQh/gZchq
	 7pwgQTfCx5pP3XTM+GVom5VGmbsJC251XGx1Dq24=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id B6BFDA80F77; Tue,  4 Jul 2023 20:38:25 +0200 (CEST)
Date: Tue, 4 Jul 2023 20:38:25 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fchmodat/fstatat: fix regression with empty `pathname`
Message-ID: <ZKRnIfNCwKhAGi1d@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <c985ab15b28da4fe6f28da4e20236bc0feb484bd.1687898935.git.johannes.schindelin@gmx.de>
 <ZKKo8Ez3nIf7klxz@calimero.vinschen.de>
 <d983003d-b8e6-e312-2197-499cc7f29306@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d983003d-b8e6-e312-2197-499cc7f29306@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Jul  4 17:45, Johannes Schindelin wrote:
> Hi Corinna,
> 
> On Mon, 3 Jul 2023, Corinna Vinschen wrote:
> 
> > Hi Johannes,
> >
> > On Jun 27 22:51, Johannes Schindelin wrote:
> > > In 4b8222983f (Cygwin: fix errno values set by readlinkat, 2023-04-18)
> > > the code of `readlinkat()` was adjusted to align the `errno` with Linux'
> > > behavior.
> > >
> > > To accommodate for that, the `gen_full_path_at()` function was modified,
> > > and the caller was adjusted to expect either `ENOENT` or `ENOTDIR` in
> > > the case of an empty `pathname`, not just `ENOENT`.
> > >
> > > However, `readlinkat()` is not the only caller of that helper function.
> > >
> > > And while most other callers simply propagate the `errno` produced by
> > > `gen_full_path_at()`, two other callers also want to special-case empty
> > > `pathnames` much like `readlinkat()`: `fchmodat()` and `fstatat()`.
> > >
> > > Therefore, these two callers need to be changed to expect `ENOTDIR` in
> > > case of an empty `pathname`, too.
> > >
> > > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > Looks like a good catch. Can you please also add a "Fixes:" tag line
> > and move the tar error description up into the commit message?
> 
> Done.
> 
> BTW a colleague and I were wondering whether we really want to set
> `errno=ENOTDIR` in `gen_full_path_at()` for empty paths when
> `AT_EMPTY_PATH` is _not_ specified. As far as we can tell, Linux sets
> `errno=ENOENT` in that instance.

I wonder if that's really what you mean.  gen_full_path_at() generates
ENOTDIR in two scenarios:

- At line 4443, if Cygwin can't resolve dirfd into a valid directory.

- At line 4450 if ... actually... never.  Given that p is always
  set to the end of the directory string copied into path_ret, it
  can never be NULL. Looks like this check for !p is a remnant from
  the past.  We should remove it.

The actual check for an empty path is done in line 4457, and this
results in ENOENT, as desired.

So, by any chance, do you mean the situation handled in line 4443,
that is, returning ENOTDIR if dirfd doesn't resolve to a directory?

Yeah, it slightly complicates the caller, but it's not exactly
wrong, given your patch.

OTOH, this entire thing doesn't look overly well thought out.  We try
to generate a full path in gen_full_path_at() and if it fails in
a certain way and AT_EMPTY_PATH is given, we basically repeat
trying to create a full path in the caller.  Maybe some
streamlining would be in order...


Corinna
