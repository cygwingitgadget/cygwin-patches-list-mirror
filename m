Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id 582C1385B50F; Wed, 23 Oct 2024 09:00:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 582C1385B50F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1729674035;
	bh=chGmCwzbLyLm7ncripZENi4nOY8XHK+FfEKc8BH+4cw=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=dNKto+9XvVpdNigBspmkjvh1cR3COQowkYeUbgfgUDTvi0u+S5NfVHpIKsnVaBYBb
	 RtE7AVk//qk3+65J6KKwErUj3vGvXszPQTJRj13ATIe0rNZ9xnp0KleLRP/h+sdj0m
	 BxHj5utB9myiLddGzY0oU1R20NV4yeZKPa2Ox5bc=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 15AC4A80D05; Wed, 23 Oct 2024 11:00:33 +0200 (CEST)
Date: Wed, 23 Oct 2024 11:00:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v8] Cygwin: pipe: Switch pipe mode to blocking mode by
 default
Message-ID: <Zxi7MaoxQlVrIdPl@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240921211508.1196-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

first of all, this is quite a piece of work, thanks for pulling
this through!

Just a few points:

On Sep 22 06:15, Takashi Yano wrote:
> @@ -370,35 +415,15 @@ fhandler_pipe::raw_read (void *ptr, size_t& len)
>  	      break;
>  	    case STATUS_PIPE_LISTENING:
>  	    case STATUS_PIPE_EMPTY:
> +	      /* Only for real_non_blocking_mode */
> +	      if (!is_nonblocking ())
> +		/* Should not reach here */
> +		continue;

Can you explain why this is necessary at all?

> @@ -439,24 +452,100 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>    if (!len)
>      return 0;

This new implementation of raw_write() skips the mechanism added in
commit 170e6badb621 ("Cygwin: pipe: improve writing when pipe buffer is
almost full") for non-blocking pipes, if the pipe has less space than
is requested by user-space.

Rather than trying to write multiple of 4K chunks or smaller multiple of
2 chunks if < 4K, it just writes as much as possible in one go, i.e.

Before:

  $ ./x 40000
  pipe capacity: 65536
  write: writable 1, 40000 25536
  write: writable 1, 24576 960
  write: writable 0, 512 448
  write: writable 0, 256 192
  write: writable 0, 128 64
  write: writable 0, 64 0
  write: writable 0, -1 / Resource temporarily unavailable

After:

  $ ./x 40000
  pipe capacity: 65536
  write: writable 1, 40000 25536
  write: writable 1, 25536 0
  write: writable 0, -1 / Resource temporarily unavailable

This way, we get into the EAGAIN case much faster again, which was
one reason for 170e6badb621.

Does this make more sense, and if so, why?  If this is really the
way to go, the comment starting at line 634 (after applying your patch)
will have to be changed as well.

> +               /* Pipe should be empty because reader is waiting the data. */
                                                                    ^^^
                                                                    for

> @@ -925,7 +952,7 @@ fhandler_pipe::create (fhandler_pipe *fhs[2], unsigned psize, int mode)
>    HANDLE r, w;
>    SECURITY_ATTRIBUTES *sa = sec_none_cloexec (mode);
>    int res = -1;
> -  int64_t unique_id;
> +  int64_t unique_id = 0;

unique_id will be set by the following nt_create() anyway.
Is there a case where it's not set?  I don't see this.

Other than that, this looks great!


Thanks,
Corinna
