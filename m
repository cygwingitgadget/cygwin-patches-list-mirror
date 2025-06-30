Return-Path: <SRS0=wRab=ZN=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by sourceware.org (Postfix) with ESMTPS id CC264385481D
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 10:10:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CC264385481D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CC264385481D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751278221; cv=none;
	b=AmSHH+5JEEtSxXVAs8o6jxuanwCzanu3NlaBICX1imBzNTEeyiIgggQDmxwmcGw96q/TC03QLgKFhx57nOkN6a0ogO/a6eIhTvkq13vQHes3P7QLrpLn/Y3j5YMPTlteIc2cupbBvWmQ5RxqMrMDp+6YJVd08uejuHe8ibrq1nY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751278221; c=relaxed/simple;
	bh=sW6I2RAdrZWZ24zk0pySoBRHEbM8XaY0duGz+ZhgqYQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=nJXD8CciLzmOe5y6QzbKs24NAuS6eUv9INr+HY5u/8wE9PSi1wGGh5uUX654Zy4pzvWdT/BGcl1gMjp/CoC91exXDnAVPApzEefqYB3YdoZNQIuctQ9nMz+kLH/p+ihWWoo2eKh3hhse1Mf/HhcaJeXdEeUaosdNvOopYzWIby0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CC264385481D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=PR01NwLe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751278219; x=1751883019;
	i=johannes.schindelin@gmx.de;
	bh=raSdLMuMEIkncupLw7js13/rK9++yamM70OR/HP4Vbg=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=PR01NwLeWxOP1+WrCFSHucyLn9aePEpZWmdUhqTk4nWdx3jMPcexaDcwx7rI0Jer
	 P/9EhQ372KX/cPMnEc4AH4SJcFtlziHfLQUOcwyUzNFmtjmFWA8Bir3ut9h8Xs57T
	 WuJCoCjeVjmTFhl7w/n+E2sp5//BXcDX9WSNE2F3qNHB7Pcfawqa+lU3+fo5SX09X
	 pGuGXpZ4zsrcUbT4tLQM9+MwV4Paw1ZdWYI1S40fxHH2uQ9+mVFPDzsNRC6x+tq/T
	 2Ee2lykeKqiRUA6x8M0LASWtLj/pG8DNMDZcXqBISfBmolHRj2QRZPsNkkb2uWNOy
	 FE+D1rzCQ1TrmGnCWg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.53]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MmULx-1uwxdy1Hcn-00aZxy; Mon, 30
 Jun 2025 12:10:19 +0200
Date: Mon, 30 Jun 2025 12:10:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 2/3] Cygwin: pipe; Update source comment align with
 previous commit
In-Reply-To: <20250627114103.30364-2-takashi.yano@nifty.ne.jp>
Message-ID: <290543e9-28f5-bc51-766c-8d6cd3d73686@gmx.de>
References: <20250627114103.30364-1-takashi.yano@nifty.ne.jp> <20250627114103.30364-2-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p4fSgebbar0Z6kp5/sIFMT50Pnn0Z0PabD4OhjJmZW2EJV73B/T
 YdI2ku2idJdT3E54MrrCqoF3njlsvFvVPCDMxOPPlkolUsKlSS6qHUNaeMsXCydwADwbUs5
 OgdwstiRqyrNtBxREVqT8m491XklIovOvbOTUb4orn7/RfDOB20lEzPcf4lw087OUkot1lb
 1vHs4KktPzT4MhUV2mhuw==
UI-OutboundReport: notjunk:1;M01:P0:HoL+d/xvCMs=;sfDBNagVrh2s57+K+eW2T3u86C5
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

while I usually would like code comments to be in sync with the code (and
therefore have it be changed in the same commit), in this instance I
totally agree that it made sense to refactor them out into their own patch
because they are quite extensive and would otherwise have drowned out the
functional changes.

Thank you,
Johannes

On Fri, 27 Jun 2025, Takashi Yano wrote:

> The commit "Cygwin: pipe: Fix SSH hang with non-cygwin pipe reader"
> modifies how the amount of writable data is evaluated. This patch
> updates the source comments to align with that change.
>=20
> Reviewed-by:
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc |  8 ++---
>  winsup/cygwin/select.cc        | 54 ++++++++++++++++++----------------
>  2 files changed, 31 insertions(+), 31 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index bda0a9b25..22addbb18 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -497,8 +497,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
>  	    { /* Refer to the comment in select.cc: pipe_data_available(). */
>  	      /* NtSetInformationFile() in set_pipe_non_blocking(true) seems
>  		 to fail with STATUS_PIPE_BUSY if the pipe is not empty.
> -		 In this case, the pipe is really full if WriteQuotaAvailable
> -		 is zero. Otherwise, the pipe is empty. */
> +		 In this case, WriteQuotaAvailable indicates real pipe space.
> +		 Otherwise, the pipe is empty. */
>  	      status =3D fh->set_pipe_non_blocking (true);
>  	      if (NT_SUCCESS (status))
>  		/* Pipe should be empty because reader is waiting for data. */
> @@ -655,9 +655,7 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
>  	  if (io.Information > 0 || len <=3D PIPE_BUF || short_write_once)
>  	    break;
>  	  /* Independent of being blocking or non-blocking, if we're here,
> -	     the pipe has less space than requested.  If the pipe is a
> -	     non-Cygwin pipe, just try the old strategy of trying a half
> -	     write.  If the pipe has at
> +	     the pipe has less space than requested.  If the pipe has at
>  	     least PIPE_BUF bytes available, try to write all matching
>  	     PIPE_BUF sized blocks.  If it's less than PIPE_BUF,  try
>  	     the next less power of 2 bytes.  This is not really the Linux
> diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
> index 0b9afb359..701f4d9a6 100644
> --- a/winsup/cygwin/select.cc
> +++ b/winsup/cygwin/select.cc
> @@ -623,32 +623,34 @@ pipe_data_available (int fd, fhandler_base *fh, HA=
NDLE h, int mode)
>    if (mode =3D=3D PDA_WRITE)
>      {
>        /* If there is anything available in the pipe buffer then signal
> -        that.  This means that a pipe could still block since you could
> -        be trying to write more to the pipe than is available in the
> -        buffer but that is the hazard of select().
> -
> -        Note that WriteQuotaAvailable is unreliable.
> -
> -        Usually WriteQuotaAvailable on the write side reflects the spac=
e
> -        available in the inbound buffer on the read side.  However, if =
a
> -        pipe read is currently pending, WriteQuotaAvailable on the writ=
e side
> -        is decremented by the number of bytes the read side is requesti=
ng.
> -        So it's possible (even likely) that WriteQuotaAvailable is 0, e=
ven
> -        if the inbound buffer on the read side is not full.  This can l=
ead to
> -        a deadlock situation: The reader is waiting for data, but selec=
t
> -        on the writer side assumes that no space is available in the re=
ad
> -        side inbound buffer.
> -
> -	Consequentially, there are two possibilities when WriteQuotaAvailable
> -	is 0. One is that the buffer is really full. The other is that the
> -	reader is currently trying to read the pipe and it is pending.
> -	In the latter case, the fact that the reader cannot read the data
> -	immediately means that the pipe is empty. In the former case,
> -	NtSetInformationFile() in set_pipe_non_blocking(true) will fail
> -	with STATUS_PIPE_BUSY, while it succeeds in the latter case.
> -	Therefore, we can distinguish these cases by calling set_pipe_non_
> -	blocking(true). If it returns success, the pipe is empty, so we
> -	return the pipe buffer size. Otherwise, we return 0. */
> +	 that.  This means that a pipe could still block since you could
> +	 be trying to write more to the pipe than is available in the
> +	 buffer but that is the hazard of select().
> +
> +	 Note that WriteQuotaAvailable is unreliable.
> +
> +	 Usually WriteQuotaAvailable on the write side reflects the space
> +	 available in the inbound buffer on the read side.  However, if a
> +	 pipe read is currently pending, WriteQuotaAvailable on the write side
> +	 is decremented by the number of bytes the read side is requesting.
> +	 So it's possible (even likely) that WriteQuotaAvailable is less than
> +	 actual space available in the pipe, even if the inbound buffer is
> +	 empty. This can lead to a deadlock situation: The reader is waiting
> +	 for data, but select on the writer side assumes that no space is
> +	 available in the read side inbound buffer.
> +
> +	 Consequentially, there are two possibilities when WriteQuotaAvailable
> +	 is less than pipe size. One is that the buffer is really not empty.
> +	 The other is that the reader is currently trying to read the pipe
> +	 and it is pending.
> +	 In the latter case, the fact that the reader cannot read the data
> +	 immediately means that the pipe is empty. In the former case,
> +	 NtSetInformationFile() in set_pipe_non_blocking(true) will fail
> +	 with STATUS_PIPE_BUSY, while it succeeds in the latter case.
> +	 Therefore, we can distinguish these cases by calling set_pipe_non_
> +	 blocking(true). If it returns success, the pipe is empty, so we
> +	 return the pipe buffer size. Otherwise, we return the value of
> +	 WriteQuotaAvailable as is. */
>        if (fh->get_device () =3D=3D FH_PIPEW
>  	  && fpli.WriteQuotaAvailable < fpli.InboundQuota)
>  	{
> --=20
> 2.45.1
>=20
>=20
