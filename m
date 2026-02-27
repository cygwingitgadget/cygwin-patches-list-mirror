Return-Path: <SRS0=+cfa=A7=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id C1ED34BA2E0D
	for <cygwin-patches@cygwin.com>; Fri, 27 Feb 2026 17:58:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C1ED34BA2E0D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C1ED34BA2E0D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772215110; cv=none;
	b=dnSNaJD3PWsAc5qvkXQj3+9vaiEmcnWJBIUkvOGM2NwMdUeKx4URvNdEzs7337RqRknQre02f8xg3DLhj5fE92W4zPuzBrQBPEtrwO+7IEklKaWxosmbAHftNfjm0vPbnDUorAxf3Xs6mWL+qtHqyKb4Jj3kvtfUExDR9S1fBGA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772215110; c=relaxed/simple;
	bh=pGP9S0/oXzX/1/1uHNO6ndnbrWHVsLHGR3JpiFUPUPw=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=raTITibo2txZARw13lC2x1lCM429YJfGmLO6vUV7XZWdbiJBmUXyFJIy2b4lua2b2uA2eV5jixqadYpf5aGG67rIPJy/ky6DRNa8+tjkj1WNEZMqyTOrYOT2alD+2mM1OoEKRjlAT7FIJB4m8ufcBFSiCQbB76kkUccsEnvl8Lc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C1ED34BA2E0D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=UAgnhYCi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772215108; x=1772819908;
	i=johannes.schindelin@gmx.de;
	bh=oN7Ym7nLSzfmvM3jDrs6IWrLIg+dKtYJpusOq+p6Zl4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UAgnhYCilaJJAnSGW9ejUtI9KVNdw/nEBJ1H4wRk9zq/QzzmJgeiBqzCK+q3voUz
	 zZXxLHYhxMvHvl3XJjuhiLFisiFwrQxY1g2Z5rlmh0arML7fYCcBScjgYyilwE48S
	 Qw7DH8XVpZkbY6v7tEtY2ys0acEY6ACs4qr8tKXKecE3Quk62/iLaMSeYSQ0RJfLY
	 GGu4CdAvB9dUJ4BsprYvyFq/ub3ztGDR5UEhgD8HdtzQIEC9aacd+7InVVqv+MoQP
	 2mR6M6MVAKOa1cljM1sgYmF2gkaRJkJjBBHypX0um2YLELlg+qT50xem5Xa+wZ2MK
	 15HkGqdvhJuN2jQfrg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1vKEOb1PDt-00Zu2z; Fri, 27
 Feb 2026 18:58:28 +0100
Date: Fri, 27 Feb 2026 18:58:26 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Improve CSI6n handling in pcon_start
 state
In-Reply-To: <20260223080106.330-1-takashi.yano@nifty.ne.jp>
Message-ID: <00548c9e-dd25-40e9-737a-4113910d4c8f@gmx.de>
References: <20260223080106.330-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:YemUyu6ugtN8qHO02c/ohr+gwSx9jz+CWunoG59R4X6LQc1yimL
 0i3h9RV7fuCFi5GHaAboAdSqYAm69Dnn8uEHqk8RKC9vpMUifOMxU3rkNDcxDNtN2oi/j54
 ki3oWijKNvT+p/IkPBWVIHF//7ID/Zh+HEm2qgoAxWZrQMswN/6JZOHIRDENS0HsJ3+m37L
 SgmV8Tty+uDtu/XvpWI7w==
UI-OutboundReport: notjunk:1;M01:P0:/ZUTJxDhHaw=;da9ZAjMpqIybUbc2R55Sua2roKp
 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
 wZcBIMGKsMtiXte9wrRdXHbMRIZPD
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>


Hi Takashi,

On Mon, 23 Feb 2026, Takashi Yano wrote:

> Previsouly, CSI6n was not handled correctly if the some sequences
> are appended after the responce for CSI6n. Especially, if the
> appended sequence is a ESC sequence, which is longer than the
> expected maximum length of the CSI6n responce, the sequence will
> not be written atomically. With this patch, pcon_start state
> is cleared at the end of CSI6n responce, and appended sequence
> will be written outside of the CSI&n handling block.

The idea of breaking out of the CSI 6n loop at `R` and falling through to
the normal write paths is sound, but I think the `towrite` accounting has
a bug, and the commit message could use some work.

>=20
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:
> ---
>  winsup/cygwin/fhandler/pty.cc | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 838be4a2b..c1e03db41 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
>  ssize_t
>  fhandler_pty_master::write (const void *ptr, size_t len)
>  {
> +  size_t towrite =3D len;
> +
>    ssize_t ret;
>    char *p =3D (char *) ptr;
>    termios &ti =3D tc ()->ti;
> @@ -2171,6 +2173,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	    }
>  	  if (state =3D=3D 1)
>  	    {
> +	      towrite--;
> +	      ptr =3D p + i + 1;

The per-byte `towrite--` only fires inside `state =3D=3D 1`, so bytes befo=
re
the ESC (which go through the `else` / `line_edit` branch) are never
subtracted. If there happen to be N bytes before the ESC in the same
write, `towrite` ends up N too large, and the `nat` pipe fast path reads
past the end of the buffer.

This can be fixed in a simpler way by not tracking `towrite` in the loop
at all, and instead computing it once at the break, see below...

>  	      if (ixput < wpbuf_len)
>  		wpbuf[ixput++] =3D p[i];
>  	      else
> @@ -2184,7 +2188,10 @@ fhandler_pty_master::write (const void *ptr, size=
_t len)
>  	  else
>  	    line_edit (p + i, 1, ti, &ret);
>  	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
> -	    state =3D 2;
> +	    {
> +	      state =3D 2;
> +	      break;
> +	    }


If you initialize `towrite =3D 0` and make this hunk look like this instea=
d:

	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
-	    state =3D 2;
+	    {
+	      state =3D 2;
+	      towrite =3D len - i - 1;
+	      ptr =3D p + i + 1;
+	      break;
+	    }

then no per-byte bookkeeping is needed, making the entire logic a lot more
robust, not to mention: easier on the reader's brain.

Regarding the commit message: beyond the typos ("Previsouly" =3D>
"Previously", "responce" =3D> "response" x3, "CSI&n" =3D> "CSI 6n"), the b=
ody
describes the bug as "the sequence will not be written atomically", but
isn't the actual problem that bytes after the `R` terminator go through
per-byte `line_edit` inside the CSI 6n loop and then hit `return len`
without ever reaching the `nat` pipe fast path? In that case, it would be
a routing problem, not an atomicity problem, and something like:

    Cygwin: pty: Fix data after CSI 6n response bypassing normal write pat=
hs

    When the terminal's CSI 6n response and subsequent data (e.g.
    keystrokes) arrive in the same write buffer, `master::write()`
    processes all of it inside the pcon_start loop and returns early.
    Bytes after the 'R' terminator go through per-byte `line_edit()` in
    that loop instead of falling through to the `nat` pipe fast path or
    the normal bulk `line_edit()` call.

    Fix this by breaking out of the loop when 'R' is found and letting the
    remaining data fall through to the normal write paths, which are now
    reachable because `pcon_start` has been cleared.

would be potentially more accurate in describing what is going on.

I am still quite fuzzy on the exact goings-on in the pty code, essentially
cobbling it all together "on the side" because I unfortunately cannot
afford to spend much focus on the Cygwin/MSYS2 runtime. Hopefully what I
said above makes some sense?

Ciao,
Johannes

>  	}
>        if (state =3D=3D 2)
>  	{
> @@ -2220,8 +2227,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	    }
>  	  get_ttyp ()->pcon_start_pid =3D 0;
>  	}
> -
> -      return len;
> +      if (towrite =3D=3D 0)
> +	return len;
>      }
> =20
>    /* Write terminal input to to_slave_nat pipe instead of output_handle
> @@ -2233,15 +2240,14 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>  	 is activated. */
>        tmp_pathbuf tp;
>        char *buf =3D (char *) ptr;
> -      size_t nlen =3D len;
> +      size_t nlen =3D towrite;
>        if (get_ttyp ()->term_code_page !=3D CP_UTF8)
>  	{
>  	  static mbstate_t mbp;
>  	  buf =3D tp.c_get ();
>  	  nlen =3D NT_MAX_PATH;
> -	  convert_mb_str (CP_UTF8, buf, &nlen,
> -			  get_ttyp ()->term_code_page, (const char *) ptr, len,
> -			  &mbp);
> +	  convert_mb_str (CP_UTF8, buf, &nlen, get_ttyp ()->term_code_page,
> +			  (const char *) ptr, towrite, &mbp);
>  	}
> =20
>        for (size_t i =3D 0; i < nlen; i++)
> --=20
> 2.51.0
>=20
>=20
