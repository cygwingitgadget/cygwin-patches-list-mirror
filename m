Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 1F5DF4BA2E2A; Thu, 18 Dec 2025 10:17:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1F5DF4BA2E2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1766053060;
	bh=Dj0wp8nrkQa8pv/r0A7Qr4QcAci5XII7JYangwBhprc=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=pFGuojO+bM+wZXdKnbxhKLdxB/JJZcS5oYragGu5zS9+CR2DqJ4YT5SzpeWd3eidS
	 YMBlvqZxTGJaFyZS47GvQwwu6u3EcbWQeS3ojutaI19OUYTg+AFy97vfxNhodyR9zd
	 v107LU/SAgqFF2F0VkPheLgKbzRBbwNWo+U4lofc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 43101A80797; Thu, 18 Dec 2025 11:17:38 +0100 (CET)
Date: Thu, 18 Dec 2025 11:17:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 2/2] Cygwin: termios: Handle app execution alias in
 is_console_app()
Message-ID: <aUPUwmpEQRlhONO0@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20251217093003.375-1-takashi.yano@nifty.ne.jp>
 <20251217093003.375-3-takashi.yano@nifty.ne.jp>
 <a4777af3-0f55-1b29-9fa7-cc38c47a3291@gmx.de>
 <20251218020426.2d726257fd3cce4d2405d67e@nifty.ne.jp>
 <adf3c29b-5c94-9612-5de7-2f19141b723d@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adf3c29b-5c94-9612-5de7-2f19141b723d@gmx.de>
List-Id: <cygwin-patches.cygwin.com>

On Dec 18 09:08, Johannes Schindelin wrote:
>  As I have
> debugged Cygwin bugs quite often in the past, I can tell you that it is
> quite frustrating to end up finding commits that leave everything unclear,
> whose diffs are too large to find any obvious bugs.

You'll come across them especially back in CVS times.  CVS didn't
support patchsets along the lines of "one patch per problem" and the
blessed way of CVS ChangeLog entries didn't support the notion of
explaining at great length why a patch was necessary but rather only
what a patch is doing where.  Whoever had the idea how a CVS ChangeLog
entry is supposed to look like, got it wrong, and thousands of
developers followed suit, including me.  Example:

  2015-04-22  Corinna Vinschen  <corinna@vinschen.de>

      * fhandler_tty.cc (fhandler_pty_slave::fch_close_handles): Don't close
      handles not opened via fhandler_pty_slave::fch_open_handles.

I have no idea why this was necessary at the time and we have the entire
20 years of history since 1995 documented this way.

And, we have a couple of years using git, in which we had to wrap our
heads around the new-fangled way to document patches in git commit
messages.  And even if some of our commit messages might still be
lacking, they are much better than some other git entries in projects,
which don't seem to have learned how useful git commit messages can
be, if they try to describe the problem they are solving and the way
how to solve it.  Example from FreeBSD in 2025:

  cxgbe: Stop using bus_space_tag/handle directly

  Reviewed by:    np, imp
  Sponsored by:   [...]
  Differential Revision:  https://reviews.freebsd.org/D53030

That's it.  They are getting better, there are actually some git commit
messages explaining the problem they are trying to solve and how, but
it's not standard throughout.

What I'm trying to say is this:

It doesn't make sense to reflect on the past.

We can do better, but for that, let's please stay professional and just
review the patch.  Tell the patch contributor what you think is wrong
and wait for v2. Rinse and repeat with v3, v4, ... until you're
satisfied.

Johannes, I think we all understood what you're trying to say, but this
is *not* how to say it.  Review the patch, criticize the patch (including
it's commit message) and stick to the patch.

If you have good arguments or can point out bugs or problems, I and, I'm
sure, Takashi and others as well, will change their patch accordingly,
or even drop the patch if it's incorrect.  But: don't tell people *how*
to spend their *voluntary* time.  Stick to the patch, it's what counts.

As a side-note, I lost track of the pty patches which were already GTG
and the patches which are not.  Takashi, can you please push what's
already not in question and make a clean restart with a new thread on
this list?  I'm really confused, and maybe I'm not alone...


Thanks,
Corinna
