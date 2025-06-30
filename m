Return-Path: <SRS0=wRab=ZN=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id B92B2385481D
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 10:18:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B92B2385481D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B92B2385481D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751278712; cv=none;
	b=S7GdUc8A8ZJsnEdahOQwaaapEydYrvEx0TnUjy4aeyCmoKte2SmFIsq0211UN9iJHJoUcyhoz53T91kmklSj+twcn6nywchotzC8VBWyGBIqRqmXohIy7fbgOzgLe8yk7A3y91MAJjIUItPnAf39R/z5RPDQkTgjKB/bC3MnrSM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751278712; c=relaxed/simple;
	bh=OFBHTxNiz6JKLzCsduQiTosuQrK5h7CTxVWml+xhYts=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=Qs0d5QoTBFtdpkK3bzmIpc6O+60SqV5beemHaVe+A5HoM/2p6e72PC4go20zq2tEeIriPXF/T1FEYBHWsIV8Lvace6mExNwj6TX6VMGhW7UfSnbhHfNUQ1U4PeEfjN57jYObhS85sqtmjVVrSuXRzTCRMZaeGen2Jc//3PvKy24=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B92B2385481D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=ob4kBxOO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1751278710; x=1751883510;
	i=johannes.schindelin@gmx.de;
	bh=Vg49J1udGOY/d0LwGq9VVm9V1rEsic0K/xu4gdiDszo=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ob4kBxOO/bNOpnkAZAvpvTedK6uj421myLjWd7G5N28cCcIs88RGf4ezAV7hYvXK
	 MHJtA0Bh1tHi56V/wIYEG3BVWaMPrFBMCJFTjZ0Dv16s2Ey+NNQfXdaOdvVbYTueG
	 Fi/cuVKD6U6pMfhwPK+LLMl/R41qdE7zCFjilHG5hq+Kz3F6iBbsnUBK7+CMZpROP
	 KgQtd/GHCCnRee4tKbSrhQ1B2Gcg5DBg2mGo62AVWubLJMq4OCgJxwAGLGAqrL76J
	 SfeiAWJZFx2P54GyrDJxSbMtCYEZmtarJ/0zC9k7GbiK8EvUgjSJQutTaIBoz8uIa
	 F/G+4sEIVy2ERbUTYA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([167.220.208.85]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MsYqv-1upn4v127P-00rHCD; Mon, 30
 Jun 2025 12:18:30 +0200
Date: Mon, 30 Jun 2025 12:18:27 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pipe: Simplify raw_write() a bit (Drop using
 chunk)
In-Reply-To: <20250627100835.442-1-takashi.yano@nifty.ne.jp>
Message-ID: <59dc1841-3dc1-2e16-e794-908eb594de87@gmx.de>
References: <20250627100835.442-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:UePMyMHVccS9GYXutztW+x/UYxGKawgoNGZyGyySHRKychzYnuV
 +GEmAhG9eCI08wLbzTNAPp1/Q/MRy2Dgl5aDaUKRO3WDbxDmVEzDuNJFNUeHoe+W3yxfuFS
 qp1xIiHTlprfZ61WR1DsrkZXQ9cAyVfuZHV7AdSMPapNQDt+UAs4/KPJUbpLIYmHwOML9w6
 5PYjwC2rt7VGd69vLG/Og==
UI-OutboundReport: notjunk:1;M01:P0:AUh3Wp3JCXg=;J6lJUZ4lEEl6E8EyHYnbCNFsYdy
 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
 Ug==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 27 Jun 2025, Takashi Yano wrote:

> There are tree variables for similar purpose in raw_write(), avail,
> chunk, and len1. avail is the amount of writable space in the pipe.
> len1 is the data length to attempt to NtWriteFile(). And chunk is
> intermediate value to calculate len1 from avail which holds
> min(avail, len). Here, chunk has no clear role among them. In fact,
> it appears to obscure the intent of the code for the reader.
>=20
> This patch removes the use of chunk and obtains len1 directly from
> avail.

Now that this diff no longer conflicts with the SSH hang fix (because you
dug deeper and identified a different part of the code as needing to be
fixed), I'd be very happy if you fast-tracked this patch.

Thank you,
Johannes

>=20
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>  winsup/cygwin/fhandler/pipe.cc | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pip=
e.cc
> index 3a0f8bfe9..1a8c39c5b 100644
> --- a/winsup/cygwin/fhandler/pipe.cc
> +++ b/winsup/cygwin/fhandler/pipe.cc
> @@ -442,7 +442,6 @@ ssize_t
>  fhandler_pipe_fifo::raw_write (const void *ptr, size_t len)
>  {
>    size_t nbytes =3D 0;
> -  ULONG chunk;
>    NTSTATUS status =3D STATUS_SUCCESS;
>    IO_STATUS_BLOCK io;
>    HANDLE evt;
> @@ -543,11 +542,6 @@ fhandler_pipe_fifo::raw_write (const void *ptr, siz=
e_t len)
>  	}
>      }
> =20
> -  if (len <=3D (size_t) avail)
> -    chunk =3D len;
> -  else
> -    chunk =3D avail;
> -
>    if (!(evt =3D CreateEvent (NULL, false, false, NULL)))
>      {
>        __seterrno ();
> @@ -564,8 +558,8 @@ fhandler_pipe_fifo::raw_write (const void *ptr, size=
_t len)
>        ULONG len1;
>        DWORD waitret =3D WAIT_OBJECT_0;
> =20
> -      if (left > chunk && !is_nonblocking ())
> -	len1 =3D chunk;
> +      if (left > (size_t) avail && !is_nonblocking ())
> +	len1 =3D (ULONG) avail;
>        else
>  	len1 =3D (ULONG) left;
> =20
> --=20
> 2.45.1
>=20
>=20
