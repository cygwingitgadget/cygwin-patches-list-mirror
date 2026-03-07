Return-Path: <SRS0=qb86=BH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by sourceware.org (Postfix) with ESMTPS id B73E84BA2E0D
	for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2026 11:58:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B73E84BA2E0D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B73E84BA2E0D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772884684; cv=none;
	b=AliFWJgJWJtOD2ydzN7/R7iMnoaZdVddaxmi/1TaCG8yFndga6//0VanLcT7S7p8mZAZfDRc2tsyczwzXOzJoRXP0gCuInXkT0j9tIO/+3huOVXEYWjimNrOyLzqpg3XwF4fObS5Q20BVhQ3EFwdYXv/+TTmZqkEueuGM/yfLw8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772884684; c=relaxed/simple;
	bh=rhbJESMMjIqn4HbwYR97XKfXlq/We9MwC4vCzhDJEWg=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ezM5aPMQytlzGbFd+hcCB6kfmsQZglIcduWmalJ1KSvEptRG8t77AAZ9EvAUd5QnRGNokBCqc5A6aiyRnmSmRd8ELe6ajtNyz9AlndWiJZWzTWgBc7WgaowMWspe01VbR3973Zf4MWvtJZG5lc0ybRGzXsuv10QJExf1D6UJETo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B73E84BA2E0D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=EvMrybZS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772884682; x=1773489482;
	i=johannes.schindelin@gmx.de;
	bh=/9gTPfj6cIeUTrTYDWcTnL8IZBNp5dIMjVvOOCK/4XM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=EvMrybZS+6DMC+ZUoRA10TKaq7lj0ugTj12VY3OGojZFpW/CPq0WX0d6ejDcRs3q
	 nDqUEkBPj5G/9RG/iA/QnR4GRhcckMZpxttXWyX7dIdMDNDFBNxlD7NzZWWZma1Kb
	 E5dauj8HIMQhdm5dpU39jlrATl3hCy/G+nStrQaBLJUYBEetk8tCpaGywxvyHbRtp
	 SkoSVVXCpRDsc2VUtYf6+r1rWCx9NDnhK8IsYtvQRKk5aCMzPPPVWdgYvX4K0mfhF
	 XufON41r5bM91vGTKZiTx9c0RD30xQyptntj3kqRiB0qdwDFuXhrubQeB14bEGkKB
	 7zMN1ba7F0ob7zrV5w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1vGkFZ1gKl-00c40f; Sat, 07
 Mar 2026 12:58:02 +0100
Date: Sat, 7 Mar 2026 12:58:00 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pty: Fix handling of data after CSI6n
 response
In-Reply-To: <20260305233757.886-1-takashi.yano@nifty.ne.jp>
Message-ID: <f57571f3-e2d6-bfa6-875c-edaca6c24d64@gmx.de>
References: <20260305233757.886-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lL+8OGYWh8+4vXrfKO2DKHMSakN/+Tdx5ATPlKkOxawokKtUv/O
 UWN9ht1IUa90HRUUswCxMi7L8NSRVm+4XG0BLJp1/jNoFmpo2k3z2jPBIDZvyDq0F8ME8oF
 +/5L+5RqFGC8983VpP8SzE0aHk95d6txEuFbpL8taFnS8CYWggn8Xi3gFK40fs1QE4dXnqi
 bFO4WOTmrbU0ZSlAYIrZQ==
UI-OutboundReport: notjunk:1;M01:P0:95r6tctS98E=;kL/ZVg190M0XLOSc1IsAPbaJbkG
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 6 Mar 2026, Takashi Yano wrote:

> Previously, CSI6n was not handled correctly if the some sequences
> are appended after the response for CSI6n. Especially, if the
> appended sequence is a ESC sequence, which is longer than the
> expected maximum length of the CSI6n response, the sequence will
> not be written atomically.
>=20
> Moreover, when the terminal's CSI 6n response and subsequent data
> (e.g. keystrokes) arrive in the same write buffer, master::write()
> processes all of it inside the pcon_start loop and returns early.
> Bytes after the 'R' terminator go through per-byte line_edit() in
> that loop instead of falling through to the `nat` pipe fast path
> or the normal bulk `line_edit()` call. Due to this behaviour,
> the chance of code conversion to the terminal code page for the
> subsequent data in `to_be_read_from_nat_pipe()` case, will be lost.
>=20
> Fix this by breaking out of the loop when 'R' is found and letting
> the remaining data fall through to the normal write paths, which
> are now reachable because `pcon_start` has been cleared.
>=20
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Co-authored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Thank you! This version looks good to me!

Ciao,
Johannes

> ---
>  winsup/cygwin/fhandler/pty.cc | 42 ++++++++++++++++++++---------------
>  1 file changed, 24 insertions(+), 18 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index b59f54096..3717542e6 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -2137,6 +2137,8 @@ fhandler_pty_master::close (int flag)
>  ssize_t
>  fhandler_pty_master::write (const void *ptr, size_t len)
>  {
> +  size_t orig_len =3D len;
> +
>    ssize_t ret;
>    char *p =3D (char *) ptr;
>    termios &ti =3D tc ()->ti;
> @@ -2160,7 +2162,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
> =20
>        DWORD n;
>        WaitForSingleObject (input_mutex, mutex_timeout);
> -      for (size_t i =3D 0; i < len; i++)
> +      len =3D 0;
> +      for (size_t i =3D 0; i < orig_len; i++)
>  	{
>  	  if (p[i] =3D=3D '\033')
>  	    {
> @@ -2185,18 +2188,21 @@ fhandler_pty_master::write (const void *ptr, siz=
e_t len)
>  	    line_edit (p + i, 1, ti, &ret);
>  	  if (state =3D=3D 1 && p[i] =3D=3D 'R')
>  	    state =3D 2;
> -	}
> -      if (state =3D=3D 2)
> -	{
> -	  /* req_xfer_input is true if "ESC[6n" was sent just for
> -	     triggering transfer_input() in master. In this case,
> -	     the responce sequence should not be written. */
> -	  if (!get_ttyp ()->req_xfer_input)
> -	    WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> -	  ixput =3D 0;
> -	  state =3D 0;
> -	  get_ttyp ()->req_xfer_input =3D false;
> -	  get_ttyp ()->pcon_start =3D false;
> +	  if (state =3D=3D 2)
> +	    {
> +	      /* req_xfer_input is true if "ESC[6n" was sent just for
> +		 triggering transfer_input() in master. In this case,
> +		 the response sequence should not be written. */
> +	      if (!get_ttyp ()->req_xfer_input)
> +		WriteFile (to_slave_nat, wpbuf, ixput, &n, NULL);
> +	      len =3D orig_len - i - 1;
> +	      ptr =3D p + i + 1;
> +	      ixput =3D 0;
> +	      state =3D 0;
> +	      get_ttyp ()->req_xfer_input =3D false;
> +	      get_ttyp ()->pcon_start =3D false;
> +	      break;
> +	    }
>  	}
>        ReleaseMutex (input_mutex);
> =20
> @@ -2220,8 +2226,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	    }
>  	  get_ttyp ()->pcon_start_pid =3D 0;
>  	}
> -
> -      return len;
> +      if (len =3D=3D 0)
> +	return orig_len;
>      }
> =20
>    /* Write terminal input to to_slave_nat pipe instead of output_handle
> @@ -2261,7 +2267,7 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>  	WriteFile (to_slave_nat, buf, nlen, &n, NULL);
>        ReleaseMutex (input_mutex);
> =20
> -      return len;
> +      return orig_len;
>      }
> =20
>    /* The code path reaches here when pseudo console is not activated
> @@ -2283,8 +2289,8 @@ fhandler_pty_master::write (const void *ptr, size_=
t len)
>    ReleaseMutex (input_mutex);
> =20
>    if (status > line_edit_signalled && status !=3D line_edit_pipe_full)
> -    ret =3D -1;
> -  return ret;
> +    return -1;
> +  return orig_len - len + ret;
>  }
> =20
>  void
> --=20
> 2.51.0
>=20
>=20
