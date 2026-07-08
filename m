Return-Path: <SRS0=LZdQ=FC=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id 4860C4BA2E04
	for <cygwin-patches@cygwin.com>; Wed,  8 Jul 2026 15:01:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4860C4BA2E04
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4860C4BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.15.18
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783522908; cv=none;
	b=YFyX7o03BZAm1ThE+LOdIpqWlQrFLK2m4vsYeOc4AeQskF1ByQWyoGlEZSKDoWpXfcnolr4zd81P8OqS6zA5MBaALnBYyc9nfpf8hbe4PlVNePNWD6I5cnLenEtp4SfV9rO2rg2t0IPkaoRr9w6m+YPoOrypSNEUjzVJbNOBX3g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783522908; c=relaxed/simple;
	bh=Cpoolnhv5rvYUM7Q5AGGMaepJ0twobS5yWAMiQs2WF8=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=TC3KVQ0P7rksaS6qbzLhEDVx1mq65dLqsaHSZSq5rIOPUZnpOqoCwzvrDNEG7NBbL6vAKI74ZARsrG5i2tbwnGDTrgzA2kTnQ1A7QIgPqFXwH4Mr51NUOWOUGUqxKVOs0SDmocO9V6mY6fIscHJrevMCwrVvCglzkrW7Lej+LhM=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=AjXnyhHg
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4860C4BA2E04
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=AjXnyhHg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783522907; x=1784127707;
	i=johannes.schindelin@gmx.de;
	bh=JWDUgEXP+XfJuwRPNvcc6mLBQmJhTmF9codq042Uqv4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AjXnyhHgv0oALu19Uub82f7HZBPqN2nkoaOP1W7Lc+681l2VC/1eNqQ1egvmaP7Z
	 HzSv0vhgcK4JyyvkLpHIUdiAgcvj4IHqwN7finCQZ2LPIvtqzhQ3dlVmVB9Q9C2nW
	 3Y2zJ5W1QH/eTY9oM5v0bnY13Hz2M7hgg+mOMZush4z2csFgyVR9zxqmCqYSkZFOt
	 inoK6bhU1vZEaCJ+Nk4s9/QaBYeeGGBECj9sfLsWG3qw9U8C/ahV0IDOKMthJdA36
	 z35KrvnmlFkamr4JsB5Jmu11MHbJK23Lk5+XVG2zGu4jnbfbb6qzhRobyqI8m0ifN
	 AdIptg2p/ovdE44PWA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1wuNx2038t-003PTR; Wed, 08
 Jul 2026 17:01:47 +0200
Date: Wed, 8 Jul 2026 17:01:47 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v4] Cygwin: pty: Do not transfer input to nat-pipe while
 masked
In-Reply-To: <20260708045412.945-1-takashi.yano@nifty.ne.jp>
Message-ID: <b55b9478-261d-a63f-de53-c2618295c5b7@gmx.de>
References: <20260708045412.945-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:gWJdbr9XlAEdfpHG+gQPajPQtBaR2vnAg2PEfY8ia7VcJt49bDL
 6ruBqYZU/KF19AZBarRG+R0BjOv4N8TDgARIhH7Dt+W/AyO+T5EXuPEPQbQTQ/Bw/qskxqu
 VUemjDIP2NivVrfBWC807Ak7K5ZPPRfvjBW9QEvvFJ+o9sCOPcpOfkGkGTIcfyNQkNi9isf
 1/iqJzC4qBUHc6kjUAVGA==
UI-OutboundReport: notjunk:1;M01:P0:lfzl6mlPg5E=;yC3xMEsACuSZrcnNsGU9rPNV54O
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Wed, 8 Jul 2026, Takashi Yano wrote:

> On the command "cat | non-cygwin-app", `cat` sometimes fails to read
> key input. This happens when `cat` starts to read input before `non-
> cygwin-app` configures pseudo console. This is because pipe state is
> switched to nat-pipe when pseudo console is configured.
>=20
> This patch prevent the pipe state from changing to nat-pipe state if
> some cygwin process is reading input from the cyg-pipe.
>=20
> Fixes: f20641789427 ("Cygwin: pty: Reduce unecessary input transfer.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
> v2: Release all masks owned by myself on cleanup()
> v3: Reverts the change that made num_reader and slave_reading shared
> v4: Correct what mutex shoud be acquired in mask_switch_to_nat_pipe()

v4 is the right shape. Taking `input_mutex` at the top matches the
ordering used elsewhere in the file, and because it is a named mutex the
race is closed across processes attaching to the same tty, not just across
threads.

One non-blocking suggestion: As far as I can tell, the new guard is
correct only because every caller holds `input_mutex`. That is a non-local
invariant, and a short comment above the guard would help future refactors
preserve it.

  Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

Ciao,
Johannes

>  winsup/cygwin/fhandler/pty.cc | 27 ++++++++++++++++++++++-----
>  1 file changed, 22 insertions(+), 5 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler/pty.cc b/winsup/cygwin/fhandler/pty.=
cc
> index ca85ae679..1b453a499 100644
> --- a/winsup/cygwin/fhandler/pty.cc
> +++ b/winsup/cygwin/fhandler/pty.cc
> @@ -1282,6 +1282,10 @@ fhandler_pty_slave::open_setup (int flags)
>  void
>  fhandler_pty_slave::cleanup ()
>  {
> +  fhandler_pty_slave *arch =3D (fhandler_pty_slave *) archetype ? : thi=
s;
> +  while (arch->num_reader)
> +    mask_switch_to_nat_pipe (false, false);
> +
>    if (get_ttyp ()->pcon_activated && get_ttyp ()->getpgid () =3D=3D mys=
elf->pgid)
>      req_fixup_pcon_state ();
> =20
> @@ -1543,19 +1547,20 @@ fhandler_pty_slave::write (const void *ptr, size=
_t len)
>  void
>  fhandler_pty_slave::mask_switch_to_nat_pipe (bool mask, bool xfer)
>  {
> +  WaitForSingleObject (input_mutex, mutex_timeout);
>    char name[MAX_PATH];
>    shared_name (name, TTY_SLAVE_READING, get_minor ());
>    HANDLE masked =3D OpenEvent (READ_CONTROL, FALSE, name);
>    CloseHandle (masked);
> =20
> -  WaitForSingleObject (input_mutex, mutex_timeout);
> +  fhandler_pty_slave *arch =3D (fhandler_pty_slave *) archetype ? : thi=
s;
>    if (mask)
>      {
> -      if (InterlockedIncrement (&num_reader) =3D=3D 1)
> -	slave_reading =3D CreateEvent (&sec_none_nih, TRUE, FALSE, name);
> +      if (InterlockedIncrement (&arch->num_reader) =3D=3D 1)
> +	arch->slave_reading =3D CreateEvent (&sec_none_nih, TRUE, FALSE, name)=
;
>      }
> -  else if (InterlockedDecrement (&num_reader) =3D=3D 0)
> -    CloseHandle (slave_reading);
> +  else if (InterlockedDecrement (&arch->num_reader) =3D=3D 0)
> +    CloseHandle (arch->slave_reading);
> =20
>    if (!!masked !=3D mask && xfer && get_ttyp ()->switch_to_nat_pipe)
>      {
> @@ -4460,6 +4465,18 @@ fhandler_pty_slave::transfer_input (tty::xfer_dir=
 dir, HANDLE from, tty *ttyp,
>  				    HANDLE input_available_event,
>  				    HANDLE input_transferred_to_cyg)
>  {
> +  if (dir =3D=3D tty::to_nat)
> +    {
> +      char name[MAX_PATH];
> +      shared_name (name, TTY_SLAVE_READING, ttyp->get_minor ());
> +      HANDLE masked =3D OpenEvent (READ_CONTROL, FALSE, name);
> +      CloseHandle (masked);
> +      if (masked)
> +	/* Cygwin process is reading cyg-pipe.
> +	   Do not transfer input to nat-pipe. */
> +	return;
> +    }
> +
>    HANDLE to;
>    if (dir =3D=3D tty::to_nat)
>      to =3D ttyp->to_slave_nat ();
> --=20
> 2.51.0
>=20
>=20
