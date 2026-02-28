Return-Path: <SRS0=y73r=BA=nifty.ne.jp=takashi.yano@sourceware.org>
Received: from mta-snd-e05.mail.nifty.com (mta-snd-e05.mail.nifty.com [106.153.226.37])
	by sourceware.org (Postfix) with ESMTPS id 14A264BA23C2
	for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 09:00:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 14A264BA23C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=nifty.ne.jp
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 14A264BA23C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=106.153.226.37
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772269241; cv=none;
	b=GS/QaMI5ZP0n+Tw7kd0abnDZvw44wU2u7zdsIfaNrDztZDOT4pxluBBe3Oi1Ekh65tFGLyBy06j/f3KNRpQLQPpEUbzUQiIDk5uV+nBE0ieKlrLRPeeLv9rq/UCfDQeGSrrRxiCMpKhTC7mTOIe6zQXhz2+tja4WwQtYW+A+uBI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772269241; c=relaxed/simple;
	bh=Hh3IOxAiKAPyM2krIzBxdzPBWmxUpV59er81XRE8WNU=;
	h=Date:From:To:Subject:Message-Id:Mime-Version:DKIM-Signature; b=B0Y3SNQDPX5g0j8Ox8c3AmICA2QrsjhRtJp9wRuIntKip0QvMLPpsA9FG1FNaHDIaJFjmIwnhNO3EvcxsjgM6g+sbEERZVas0E1I3QHjdsvQNTcXVvbEIIR8m7MEfrq4j23M6UG6ywRYggOzrvx8VHEaj8+/Kd0QBiOtXj/CLK4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 14A264BA23C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=nifty.ne.jp header.i=@nifty.ne.jp header.a=rsa-sha256 header.s=default-1th84yt82rvi header.b=hcIKMho3
Received: from HP-Z230 by mta-snd-e05.mail.nifty.com with ESMTP
          id <20260228090039256.RUXG.36235.HP-Z230@nifty.com>
          for <cygwin-patches@cygwin.com>; Sat, 28 Feb 2026 18:00:39 +0900
Date: Sat, 28 Feb 2026 18:00:37 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Improve CSI6n handling in pcon_start state
Message-Id: <20260228180037.e9a86823c18aade8c3ca8e8f@nifty.ne.jp>
In-Reply-To: <00548c9e-dd25-40e9-737a-4113910d4c8f@gmx.de>
References: <20260223080106.330-1-takashi.yano@nifty.ne.jp>
	<00548c9e-dd25-40e9-737a-4113910d4c8f@gmx.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp; s=default-1th84yt82rvi; t=1772269239;
 bh=/C7VkX7t7D7LNbU0B6BKcyAecE0Uzgf8bAy3kXfAW6E=;
 h=Date:From:To:Subject:In-Reply-To:References;
 b=hcIKMho3usGuap6aI3IAfpvReSpnvYR4QBArRcrbkLOMmBuUfdvLEgPmtiPCuQACvXiilE/q
 SAOEgIxS5T/qfc0zVTHqtB6o8+SU1LSrEtEuEUWH4vtAPXPPKarVfbKFFnjpON6GHhWy1HWMSm
 APrRE5V7ueQwQ1PoEoGPSujtO47YBkK6vY+usfioq6lLSEqgIVEPxgnEyPpaFyetc1RhIzEism
 Lr+TjeELkCsF2sg54fvVS/FslzDXPkVNDJy2qxtLU2fk9Z1gMiDyrPBxVKWMtbtYFJwU9ajcAp
 kAa6rKTGw0py2EN5ZUMulrl4CKfr52icOHaelXufzR/9tnlQ==
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Johannes,

Thanks for reviewing!

On Fri, 27 Feb 2026 18:58:26 +0100 (CET)
Johannes Schindelin wrote:
> On Mon, 23 Feb 2026, Takashi Yano wrote:
> 
> > Previsouly, CSI6n was not handled correctly if the some sequences
> > are appended after the responce for CSI6n. Especially, if the
> > appended sequence is a ESC sequence, which is longer than the
> > expected maximum length of the CSI6n responce, the sequence will
> > not be written atomically. With this patch, pcon_start state
> > is cleared at the end of CSI6n responce, and appended sequence
> > will be written outside of the CSI&n handling block.
> 
> The idea of breaking out of the CSI 6n loop at `R` and falling through to
> the normal write paths is sound, but I think the `towrite` accounting has
> a bug, and the commit message could use some work.
> 
> > 
> > Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> > Reviewed-by:
> > ---
> >  winsup/cygwin/fhandler/pty.cc | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> > 
> > diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.cc
> > index 838be4a2b..c1e03db41 100644
> > --- a/winsup/cygwin/fhandler/pty.cc
> > +++ b/winsup/cygwin/fhandler/pty.cc
> > @@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
> >  ssize_t
> >  fhandler_pty_master::write (const void *ptr, size_t len)
> >  {
> > +  size_t towrite = len;
> > +
> >    ssize_t ret;
> >    char *p = (char *) ptr;
> >    termios &ti = tc ()->ti;
> > @@ -2171,6 +2173,8 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  	    }
> >  	  if (state == 1)
> >  	    {
> > +	      towrite--;
> > +	      ptr = p + i + 1;
> 
> The per-byte `towrite--` only fires inside `state == 1`, so bytes before
> the ESC (which go through the `else` / `line_edit` branch) are never
> subtracted. If there happen to be N bytes before the ESC in the same
> write, `towrite` ends up N too large, and the `nat` pipe fast path reads
> past the end of the buffer.
> 
> This can be fixed in a simpler way by not tracking `towrite` in the loop
> at all, and instead computing it once at the break, see below...
> 
> >  	      if (ixput < wpbuf_len)
> >  		wpbuf[ixput++] = p[i];
> >  	      else
> > @@ -2184,7 +2188,10 @@ fhandler_pty_master::write (const void *ptr, size_t len)
> >  	  else
> >  	    line_edit (p + i, 1, ti, &ret);
> >  	  if (state == 1 && p[i] == 'R')
> > -	    state = 2;
> > +	    {
> > +	      state = 2;
> > +	      break;
> > +	    }
> 
> 
> If you initialize `towrite = 0` and make this hunk look like this instead:
> 
> 	  if (state == 1 && p[i] == 'R')
> -	    state = 2;
> +	    {
> +	      state = 2;
> +	      towrite = len - i - 1;
> +	      ptr = p + i + 1;
> +	      break;
> +	    }
> 
> then no per-byte bookkeeping is needed, making the entire logic a lot more
> robust, not to mention: easier on the reader's brain.

I'll adopt your idea and submit v2 patch.

> Regarding the commit message: beyond the typos ("Previsouly" =>
> "Previously", "responce" => "response" x3, "CSI&n" => "CSI 6n"), the body
> describes the bug as "the sequence will not be written atomically", but
> isn't the actual problem that bytes after the `R` terminator go through
> per-byte `line_edit` inside the CSI 6n loop and then hit `return len`
> without ever reaching the `nat` pipe fast path? In that case, it would be
> a routing problem, not an atomicity problem, and something like:
> 
>     Cygwin: pty: Fix data after CSI 6n response bypassing normal write paths
> 
>     When the terminal's CSI 6n response and subsequent data (e.g.
>     keystrokes) arrive in the same write buffer, `master::write()`
>     processes all of it inside the pcon_start loop and returns early.
>     Bytes after the 'R' terminator go through per-byte `line_edit()` in
>     that loop instead of falling through to the `nat` pipe fast path or
>     the normal bulk `line_edit()` call.
> 
>     Fix this by breaking out of the loop when 'R' is found and letting the
>     remaining data fall through to the normal write paths, which are now
>     reachable because `pcon_start` has been cleared.
> 
> would be potentially more accurate in describing what is going on.
> 
> I am still quite fuzzy on the exact goings-on in the pty code, essentially
> cobbling it all together "on the side" because I unfortunately cannot
> afford to spend much focus on the Cygwin/MSYS2 runtime. Hopefully what I
> said above makes some sense?

Actually, sending the data which is sent to nat pipe to line_edit()
is not so wrong. The data buffered in the readahead buffer will be
routed to nat pipe if necessary in `accept_input()`.

However, in this case, the code page conversion is not apply to the
data. Therefore, "letting the remaining data fall through to the normal
write paths" is more appropriate than using line_edit().

Anyway, could you please review the v2 patch? Thanks in advance.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
