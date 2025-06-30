Return-Path: <SRS0=wRab=ZN=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 4BC3B385481D
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 10:17:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4BC3B385481D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4BC3B385481D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751278620; cv=none;
	b=xc2eGwjU+YGDlJXPf/RfsHPfvZGiL14Uv05rG1+G9GMgzVa7EmsVDrWkP733Z7y/V3XyYTLszGckdtNzgjlLmtYqBd7fVPozjZyr0FMW8+q3vfkvxpYWEzqH2wjDoD8lMxssenQ0euVeQfKfF1Pc7sj1VCf/0sMEfqTGyDq3r7o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751278620; c=relaxed/simple;
	bh=Ro4CtW9096vJqGgbxZGb9FRPb79w8SkQGGEwSt/Cclk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ees+OQ+RxVVQu/3pvAGPuTkz7OkT4Lsb/gT4S40/XUwF0JNgTg/D8FzA4OEP52/LP0mxD7O97YsEnQ7/fzYR+VEm0/GUUOhRv/rQ4aVh7rl8q7w45S4MwWoOMb2RPE5OmX0MGEXkrk7c5+afUnC7jQKnRSxGxnzMPq5aMC19dRc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4BC3B385481D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=WqGCPNUA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751278619; x=1751883419;
	i=johannes.schindelin@gmx.de;
	bh=5rRTc+KMdwcD/AkZaWHsbT5wwasrUrdtrq3RS/FxCMY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=WqGCPNUAcribsOdcHyjo72wPaBgSBK4+C3Rd1/b1Tz0fT1Lzett/VGHsX8nIwnRN
	 wyDnY2SpHSFLDmW+AdROem8JFaj5+J7eyDD+sxvIYUGwCJ+NQWfX4bq61dUSO+orK
	 49Cvetez9umTIEHB2wumrSHDI+E6JQDeHbkHG5a0LAV2IHFLT3RafhWPtx+vzPRUy
	 Oxtc71hlrya56yWDPCeaTma+feK5ibZ328Cc/ICxDI3driz5B7EULiSfWYGOB6p1j
	 zfxrV6UcG/ZvbZFHFaFTGgBsKA5FvpEZ8Rc78PHrsQymCSH+he5QdfRfqhXiAxD4/
	 AGjSgFApSgzVmQ5cMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.85]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXp5a-1uDPCY3J5I-00WkKM; Mon, 30
 Jun 2025 12:16:58 +0200
Date: Mon, 30 Jun 2025 12:16:56 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/3] Cygwin: pipe: Make pipe_data_available() return
 PDA_UNKNOWN
In-Reply-To: <20250627114103.30364-3-takashi.yano@nifty.ne.jp>
Message-ID: <b2879485-5fca-0c40-9a92-2cfa383d2ce8@gmx.de>
References: <20250627114103.30364-1-takashi.yano@nifty.ne.jp> <20250627114103.30364-3-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:l6kUTcc2AxZNduoQuDpvx36jobS6BD4gBij7YCsKasaqCJEG4Fn
 VOpCLlVRwtUNyLKuopTwwgiQGrQCvHmwUdjB6ZQI1zPCITycFVIZQaWF1SebCXqMJGWjtnb
 14dzv57FjCPpSRNsBXOvy/OqQtuwFyntF7BYdDazWgXe6FcUchiJmslAV+3YQ1C+VKFUCeu
 ZluJQInSdpvEIXX1qJPCA==
UI-OutboundReport: notjunk:1;M01:P0:7GDq75vEaU8=;WiZjFmrs4EJUM/kyB8jZN9+uFjn
 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
 sw==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 27 Jun 2025, Takashi Yano wrote:

> ... rather than 1 when the pipe space estimation fails, so that
> select() and raw_wrie() can perform appropriate fallback handling.
> In select(), even if pipe space is unknown, return writable to avoid
> deadlock.  Even with select() returns writable, write() can blocked
> anyway, if data is larger than pipe space. In raw_write(), if the
> pipe is real non-blocking mode, attempting to write larger data than
> pipe space is safe. Otherwise, return error.

I am okay with this patch as-is.

The only minor thing is that neither the commit message nor the diff make
it clear that all six callsites of `pipe_data_available()` are handled
(the first two callsites in `peek_pipe()` are both handled by the 4th hunk
of the `select.cc` diff).

Thank you for fixing this!
Johannes

>=20
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc        |  7 ++++---
>  winsup/cygwin/local_includes/select.h |  3 +++
>  winsup/cygwin/select.cc               | 18 +++++++++---------
>  3 files changed, 16 insertions(+), 12 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index 22addbb18..7e2c1861b 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -663,12 +663,13 @@ fhandler_pipe_fifo::raw_write (const void *ptr, si=
ze_t len)
>  	     in a very implementation-defined way we can't emulate, but it
>  	     resembles it closely enough to get useful results. */
>  	  avail =3D pipe_data_available (-1, this, get_handle (), PDA_WRITE);
> -	  if (avail < 1)	/* error or pipe closed */
> +	  if (avail =3D=3D PDA_UNKNOWN && real_non_blocking_mode)
> +	    avail =3D len1;
> +	  else if (avail =3D=3D 0 || !PDA_NOERROR (avail))
> +	    /* error or pipe closed */
>  	    break;
>  	  if (avail > len1)	/* somebody read from the pipe */
>  	    avail =3D len1;
> -	  if (avail =3D=3D 1)	/* 1 byte left or non-Cygwin pipe */
> -	    len1 >>=3D 1;
>  	  else if (avail >=3D PIPE_BUF)
>  	    len1 =3D avail & ~(PIPE_BUF - 1);
>  	  else
> diff --git a/winsup/cygwin/local_includes/select.h b/winsup/cygwin/local=
_includes/select.h
> index 43ceb1d7e..afc05e186 100644
> --- a/winsup/cygwin/local_includes/select.h
> +++ b/winsup/cygwin/local_includes/select.h
> @@ -143,5 +143,8 @@ ssize_t pipe_data_available (int, fhandler_base *, H=
ANDLE, int);
> =20
>  #define PDA_READ	0x00
>  #define PDA_WRITE	0x01
> +#define PDA_ERROR	-1
> +#define PDA_UNKNOWN	-2
> +#define PDA_NOERROR(x)	(x >=3D 0)
> =20
>  #endif /* _SELECT_H_ */
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 701f4d9a6..050221a9f 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -601,7 +601,7 @@ pipe_data_available (int fd, fhandler_base *fh, HAND=
LE h, int mode)
>        if (mode =3D=3D PDA_READ
>  	  && PeekNamedPipe (h, NULL, 0, NULL, &nbytes_in_pipe, NULL))
>  	return nbytes_in_pipe;
> -      return -1;
> +      return PDA_ERROR;
>      }
> =20
>    IO_STATUS_BLOCK iosb =3D {{0}, 0};
> @@ -618,7 +618,7 @@ pipe_data_available (int fd, fhandler_base *fh, HAND=
LE h, int mode)
>  	 access on the write end.  */
>        select_printf ("fd %d, %s, NtQueryInformationFile failed, status =
%y",
>  		     fd, fh->get_name (), status);
> -      return (mode =3D=3D PDA_WRITE) ? 1 : -1;
> +      return (mode =3D=3D PDA_WRITE) ? PDA_UNKNOWN : PDA_ERROR;
>      }
>    if (mode =3D=3D PDA_WRITE)
>      {
> @@ -660,7 +660,7 @@ pipe_data_available (int fd, fhandler_base *fh, HAND=
LE h, int mode)
>  	    return fpli.WriteQuotaAvailable; /* Not empty */
>  	  else if (!NT_SUCCESS (status))
>  	    /* We cannot know actual write pipe space. */
> -	    return 1;
> +	    return PDA_UNKNOWN;
>  	  /* Restore pipe mode to blocking mode */
>  	  ((fhandler_pipe *) fh)->set_pipe_non_blocking (false);
>  	  /* Empty */
> @@ -684,7 +684,7 @@ pipe_data_available (int fd, fhandler_base *fh, HAND=
LE h, int mode)
>        return fpli.ReadDataAvailable;
>      }
>    if (fpli.NamedPipeState & FILE_PIPE_CLOSING_STATE)
> -    return -1;
> +    return PDA_ERROR;
>    return 0;
>  }
> =20
> @@ -734,7 +734,7 @@ peek_pipe (select_record *s, bool from_select)
>        if (n =3D=3D 0 && fh->get_echo_handle ())
>  	n =3D pipe_data_available (s->fd, fh, fh->get_echo_handle (), PDA_READ=
);
> =20
> -      if (n < 0)
> +      if (n =3D=3D PDA_ERROR)
>  	{
>  	  select_printf ("read: %s, n %d", fh->get_name (), n);
>  	  if (s->except_selected)
> @@ -775,8 +775,8 @@ out:
>  	}
>        ssize_t n =3D pipe_data_available (s->fd, fh, h, PDA_WRITE);
>        select_printf ("write: %s, n %d", fh->get_name (), n);
> -      gotone +=3D s->write_ready =3D (n > 0);
> -      if (n < 0 && s->except_selected)
> +      gotone +=3D s->write_ready =3D (n > 0 || n =3D=3D PDA_UNKNOWN);
> +      if (n =3D=3D PDA_ERROR && s->except_selected)
>  	gotone +=3D s->except_ready =3D true;
>      }
>    return gotone;
> @@ -989,7 +989,7 @@ out:
>        ssize_t n =3D pipe_data_available (s->fd, fh, fh->get_handle (), =
PDA_WRITE);
>        select_printf ("write: %s, n %d", fh->get_name (), n);
>        gotone +=3D s->write_ready =3D (n > 0);
> -      if (n < 0 && s->except_selected)
> +      if (n =3D=3D PDA_ERROR && s->except_selected)
>  	gotone +=3D s->except_ready =3D true;
>      }
>    return gotone;
> @@ -1415,7 +1415,7 @@ out:
>        ssize_t n =3D pipe_data_available (s->fd, fh, h, PDA_WRITE);
>        select_printf ("write: %s, n %d", fh->get_name (), n);
>        gotone +=3D s->write_ready =3D (n > 0);
> -      if (n < 0 && s->except_selected)
> +      if (n =3D=3D PDA_ERROR && s->except_selected)
>  	gotone +=3D s->except_ready =3D true;
>      }
>    return gotone;
> --=20
> 2.45.1
>=20
>=20
