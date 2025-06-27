Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id F24A6385700E; Fri, 27 Jun 2025 12:37:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org F24A6385700E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1751027876;
	bh=R3uJN0UZNcNcY0JOx1KcU0OOMNoJbTC3eLmgaGM9Gvs=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=DpWtsR221y0tPJuYj+KCNUodX9m/URxrZhF+0LhzG82yac296I37JJ4WQBnFUWcQ8
	 Ko7NN5q4P3D+i6/kA9NQFIH4QsRqmGjAy1xQxoz+JYieeFNc9+LF7h6WkTaWMdLFKt
	 f66XWNq6gmIkVHNcocNntCV/f+Hinn0ikei0Nypk=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D878DA806FF; Fri, 27 Jun 2025 14:37:54 +0200 (CEST)
Date: Fri, 27 Jun 2025 14:37:54 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 1/5] Cygwin: allow redirecting stderr in ch_spawn
Message-ID: <aF6Qoq0yXMg4z3Jo@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <cb938c47-80dd-78c6-876f-7a36112960af@jdrake.com>
 <aF59GwzNozRYeAp4@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aF59GwzNozRYeAp4@calimero.vinschen.de>
List-Id: <cygwin-patches.cygwin.com>

On Jun 27 13:14, Corinna Vinschen wrote:
> On Jun 26 16:55, Jeremy Drake via Cygwin-patches wrote:
> > stdin and stdout were alreadly allowed for popen, but implementing
> > posix_spawn in terms of spawn would require stderr as well.
> > 
> > Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> > ---
> >  winsup/cygwin/dcrt0.cc                    | 2 ++
> >  winsup/cygwin/local_includes/child_info.h | 6 +++---
> >  winsup/cygwin/spawn.cc                    | 5 +++--
> >  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> LGTM.  A sentence on why we can actually use the filler bytes now
> wouldn't hurt in the commit message.

...or rather...

> int worker (const char *, const char *const *, const char *const [],
> -                    int, int = -1, int = -1);
> +                    int, int = -1, int = -1, int = -1);

...maybe this should actually get an array of three descriptors,
rather than getting one additional argument per descriptor, i.e.

  int worker (const char *, const char *const *, const char *const [],
  -                    int, int = -1, int = -1);
  +                    int, int[3]);

There's no good reason for these default args anyway.


Thanks,
Corinna
