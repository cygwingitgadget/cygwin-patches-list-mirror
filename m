Return-Path: <SRS0=qb86=BH=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id A66AA4BA2E0D
	for <cygwin-patches@cygwin.com>; Sat,  7 Mar 2026 12:07:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A66AA4BA2E0D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A66AA4BA2E0D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772885225; cv=none;
	b=OIFa/vAbGCw2u9U/nNlK3+gizcDMwqvcbZDdTSfkAK6kc0oI9+T4XlE/gdWt+qUdCWK5ZVbR531npyhvKQkd51FF2UfUiFxXFTpFhCTEmrz3dDKxg0ASh5xrpFlA4FQ+wuG6rL3Y5GkTQW+NVy9B5U+bi/pZorM/cRNkVZl4EFM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772885225; c=relaxed/simple;
	bh=hUyaWqkneCWWbibPUs+crE5cnf7zaQUjatwb1K+SjdE=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=n060JMlozEbRbZZblu0CtKI0THYeYJK+9fhJ8jDKQTaVWtOVsVbsoCFcxyBzKt3ueqepYk73v7nOBg89tqccTc69LOdPQr54PmSGIgzqUXG6G1WQgsLY0dBzNg99cImHPrI+WxjdXCjFQ22o2Y+u28WrveD9UuTZvl3Uajbh9FU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A66AA4BA2E0D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=f7HqGCN/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1772885223; x=1773490023;
	i=johannes.schindelin@gmx.de;
	bh=/lNNLUngCig5RcB7uinNroLpVfXDMHHCuv15u8AmuVk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=f7HqGCN/8aIsc2+2EBrsalsrPIiJ8fNZD7nQQAmJm86/Hus26jESJZ3nU0AYng7O
	 jJCGxt/yAbzAeKcnE6CJhE6tOKKYqRyY7B4YqnaGn0VrPWOrB6zeg5rkn4CF3TmLJ
	 wkWbGCOt5XXNXYdGfqKdYBkiahJ6aVtJ7G5/bYlBAFbG9hcnctKnb9KL9qeBWjiG4
	 heGcHuT4Bfi3VYcnslo4BqcNQvSBJeiCiehRi0DJ9zg5a909PyI2QPQxcOyrCm/CB
	 dkp4MxISew5cD1ypnZkTz+IFngF6W1DYhtwESgiQSX6B09ekkTaugvlTjBrYR+Flr
	 f9BxkZ5n4BthVeh2aQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MtwZ4-1ve9il1B2i-010O4x; Sat, 07
 Mar 2026 13:07:03 +0100
Date: Sat, 7 Mar 2026 13:07:01 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: pty: Fix nat pipe hand-over when pcon is
 disabled
In-Reply-To: <20260306005037.1934-1-takashi.yano@nifty.ne.jp>
Message-ID: <5f24a7c4-ed7a-da39-2e95-8f9252576ed9@gmx.de>
References: <20260306005037.1934-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cjNWxM2AaC6ucuhbB1WIgMYZ3d/TX+AGPB6GYrDWGP9Taim95Cv
 3exrqA745GPWPpK62PvqhSde7FcA1NpxOMhgTb1AtZUo3/Dpw+jwEyIdILBYx9/OjtpTU91
 PIksJGJVZEakvH8dBIJVe1kz2Ns3B4bACNsJlkdoYsiX4oEiDI9nn/rGaoKpIv70HAhLayz
 VmM+FFu3L9eYuEhkKys4w==
UI-OutboundReport: notjunk:1;M01:P0:foZVuLSbrGo=;ygmokLedfaAdU8jskONvHs0BM2D
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Fri, 6 Mar 2026, Takashi Yano wrote:

> The nat pipe ownership hand-over mechanism relies on the console
> process list - the set of processes attached to a console, enumerable
> via `GetConsoleProcessList()`. For non-cygwin process in pcon_activated
> case, this list contains all processes attached to the pseudo console.
> Otherwise, it contains all processes attached to the invisible console.
>=20
> 04f386e9af (Cygwin: console: Inherit pcon hand over from parent pty,
> 2024-10-31) added a last-resort fallback in `get_winpid_to_hand_over()`
> that hands nat pipe ownership to any process in the console process
> list, including Cygwin processes. This fallback is needed when a
> Cygwin process on the pseudo console (that might be exec'ed from non-
> cygwin process) must take over management of an active pseudo console
> after the original owner exits.
>=20
> When the pseudo console is disabled, this fallback incorrectly finds a
> Cygwin process (such as the shell) and assigns it nat pipe ownership,
> because both the original nat pipe owner and the shell are assosiated
> with the same invisible console. Since there is no console for that
> process to manage, ownership never gets released, input stays stuck on
> the nat pipe.
>=20
> Only the third (last-resort) call in the cascade needs guarding: the
> first two calls filter for native (non-Cygwin) processes via the `nat`
> parameter, and handing ownership to another native process is fine
> regardless of pcon state. It is only the fallback to Cygwin processes
> that is dangerous without an active pseudo console.
>=20
> Guard the fallback with a `pcon_activated` check, since handing nat
> pipe ownership to a Cygwin process only makes sense when there is an
> active pseudo console for it to manage.

I recognize that commit message (and your edits) ;-)

Thank you for indulging me, this looks ready to go to me.

Ciao,
Johannes

>=20
> Fixes: 04f386e9af99 ("Cygwin: console: Inherit pcon hand over from paren=
t pty")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>  winsup/cygwin/fhandler/pty.cc | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index 2da46f8d9..06122def7 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -3593,7 +3593,7 @@ fhandler_pty_slave::get_winpid_to_hand_over (tty *=
ttyp,
>        if (!switch_to)
>  	switch_to =3D get_console_process_id (current_pid,
>  					    false, true, false, true);
> -      if (!switch_to)
> +      if (!switch_to && ttyp->pcon_activated)
>  	switch_to =3D get_console_process_id (current_pid,
>  					    false, false, false, false);
>      }
> --=20
> 2.51.0
>=20
>=20
