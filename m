Return-Path: <corinna@sourceware.org>
Received: by sourceware.org (Postfix, from userid 2155)
	id CDA4B4B9DB71; Wed, 25 Mar 2026 19:19:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CDA4B4B9DB71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cygwin.com;
	s=default; t=1774466359;
	bh=y7F0vWp/Csq/Z9jX61G4f6UId/crzHmlok9JwuDA1jI=;
	h=Date:From:To:Subject:Reply-To:References:In-Reply-To:From;
	b=ob/C3brNjIyjbT1y4AD6i6S0QUZlBtm6K2xUclfmAAlwN2YMYvaufX9kq+undr3zz
	 3Hnk5sk/tH0q1R+z5BuTvXhvSbc1ein+TVZ9O22mQh9RvkzkLCarXfzPiiM1mSx25B
	 8JQaaBznrkJfDYpvuK+ix9GNDeTx3B8hfLjNVvjs=
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id D8D04A805DF; Wed, 25 Mar 2026 20:19:17 +0100 (CET)
Date: Wed, 25 Mar 2026 20:19:17 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: pty: Fix handling of data after CSI6n response
Message-ID: <acQ1Nc1KjWidh8bq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20260303113918.25905-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260303113918.25905-1-takashi.yano@nifty.ne.jp>
List-Id: <cygwin-patches.cygwin.com>

On Mar  3 20:39, Takashi Yano wrote:
> Previously, CSI6n was not handled correctly if the some sequences
                                                 ^^^
                                           drop "the" here

> are appended after the response for CSI6n. Especially, if the
> appended sequence is a ESC sequence, which is longer than the
> expected maximum length of the CSI6n response, the sequence will
> not be written atomically.
> 
> Moreover, when the terminal's CSI 6n response and subsequent data
> (e.g. keystrokes) arrive in the same write buffer, master::write()
> processes all of it inside the pcon_start loop and returns early.
> Bytes after the 'R' terminator go through per-byte line_edit() in
> that loop instead of falling through to the `nat` pipe fast path
> or the normal bulk `line_edit()` call. Due to this behaviour,
> the chance of code conversion to the terminal code page for the
> subsequent data in `to_be_read_from_nat_pipe()` case, will be lost.
> 
> Fix this by breaking out of the loop when 'R' is found and letting
> the remaining data fall through to the normal write paths, which
> are now reachable because `pcon_start` has been cleared.
> 
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 40 ++++++++++++++++++++---------------
>  1 file changed, 23 insertions(+), 17 deletions(-)

With the followup len -> orig_len patch, looks ok to me.


Thanks,
Corinna
