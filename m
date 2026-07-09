Return-Path: <SRS0=y6DA=FD=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id 7FECE4BA5435
	for <cygwin-patches@cygwin.com>; Thu,  9 Jul 2026 08:06:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7FECE4BA5435
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7FECE4BA5435
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1783584408; cv=none;
	b=PSMPm6zV+LLfoR9uVEd2fIBfgy6vtFc4O3msVk5pdWYllHWYcXRR1K/ZzOMDdwzRK9IiYaR+X5wjYi9fCgwAM1b3w1OCKektvTGgGJsvoEJw9+hhEFAMP9InoCXSdnk6hgSGk5nLIWscJRhsWBeuS+zngFrNeTCe0XbIWmLJ99o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1783584408; c=relaxed/simple;
	bh=1asuPhcHgJ39rHnRPo8yIKtyu2dsLe9LI4i19O1Y3IU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=puZI7pobSoMnYSW08AgXItMeOQz57vFNbM6AxJJfTgKE7Cs/3GY6Dlu/kv5AbLEx6UqWD1tBFCQLiRtg4kTx7r3tRrTnXVJ0/VtviGlyrvwXBhtn2JOjs2jmRF23EQZVHSFDKjJFRCStNxJ1+P/LDecm8hLMZpB+f8m0AwjydDg=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jWdRklw4
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7FECE4BA5435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=jWdRklw4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783584401; x=1784189201;
	i=johannes.schindelin@gmx.de;
	bh=zhz6J/5xAkjuMGEW7p/eq4pN7f7VlNAdhEQTQEW7OwA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jWdRklw4qkcLPYk05abum461s3lM6ycz1HE5czmvkQ2kld/p5y1TuIHcUlLgJMCd
	 jbVENJazyrV6PSUFZU6hNfaD8zeNAMqNsJdku8HmVW8QogsRlsK+QyZHHBYmzbiBz
	 2ccGHxBKqZtSoe170yAx/yHaQEEZsNAKvV+sNli4I7nigizP7kY1mSHIgSobJGHmy
	 fdQsReJUNoOGUTJH6GrlQLlqfeBhaSiJ8mG85J3Pe8gAtIF+b7VT/z8o8gIUHUIrZ
	 ZaR5WTWm6aUils/gc5W1iI+e36+S2WP8H38XOChLbXWDEXPn4AL0Llr69PushjH3z
	 a1FLjEkBqMnYv74LYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1xUHwn14m8-00lWdw; Thu, 09
 Jul 2026 10:06:41 +0200
Date: Thu, 9 Jul 2026 10:06:41 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Cygwin: console: Correct previous NOFLSH fix
In-Reply-To: <20260709020416.d1bb5e52622ac5336ab98b6f@nifty.ne.jp>
Message-ID: <4750bfcf-2b91-bd32-dedd-804e2d1a54d7@gmx.de>
References: <20260708040323.905-1-takashi.yano@nifty.ne.jp> <6ac18250-e205-89ff-3913-92c4f8f86606@gmx.de> <20260709020416.d1bb5e52622ac5336ab98b6f@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:lqlcxG8fKeBxGNoZyoD0i1G//c519hHT9aCo7hjlhOdZGUEFUzu
 v193U0QLzFt/tr7NmokIyk5nazm8aKGpirdXeYbss8w1oeR3SUtd0NxwirJAgNDoWM1Zykf
 2RwEO5YmYWSMiHcHxsfALphHYI8rR8l+lNorNE/2LoVO5rkXXkWY0ddHkb7RMuh8p6QuMVG
 p4DJ7vyNk/yFUu7P8UFTg==
UI-OutboundReport: notjunk:1;M01:P0:aQQaAFrX+Hw=;9+zxy8eS1uFasPIPA/EuihTj6Al
 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
 8Ymr0zRo6/T6dpSMtE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_W,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Thu, 9 Jul 2026, Takashi Yano wrote:

> On Wed, 8 Jul 2026 16:58:57 +0200 (CEST)
> Johannes Schindelin wrote:
> >=20
> > Thank you for v3. Both concerns from v2 are addressed, and the "stty i=
ntr
> > ^x; cat | non-cygwin-app" case now behaves as expected.
> >=20
> > I have two non-blocking observations further below, and a question: Ou=
t of
> > curiosity, not a blocker: how does the `with_debugger_nat` branch actu=
ally
> > get reached in practice? gdb normally reads the console only at its ow=
n
> > prompt, i.e. when the inferior is stopped and thus not foreground, so =
the
> > pre-conditions do not obviously line up.
>=20
> In console, this never happen. In pty, process_sigs() is called from
> pty master, so this is reached when non-cygwin inferior is foreground
> in gdb.

Thank you for the clarification!

>=20
> >   Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>=20
> Thanks!
>=20
> > > diff --git a/winsup/cygwin/fhandler/console.cc b/winsup/cygwin/fhand=
ler/console.cc
> > > index 730bb0b45..cc4591c14 100644
> > > --- a/winsup/cygwin/fhandler/console.cc
> > > +++ b/winsup/cygwin/fhandler/console.cc
> > > @@ -1718,6 +1718,7 @@ fhandler_console::process_input_message (size_=
t len)
> > >  	  continue;
> > >  	}
> > > =20
> > > +      num_input_events_processed =3D i + 1;
> >=20
> > The new counter member is missing from the constructor's init list. It=
 is
> > safe in practice because `cnew()` zero-fills, but adding it explicitly
> > would match the surrounding style.
>=20
> Initializer added to constructor.
>=20
> > > @@ -525,11 +532,12 @@ fhandler_termios::line_edit (const char *rptr,=
 size_t nread, termios& ti,
> > >        switch (process_sigs (c, get_ttyp (), this))
> > >  	{
> > >  	case signalled:
> > > -	case not_signalled_but_done:
> > >  	case done_with_debugger:
> > >  	  sawsig =3D true;
> > >  	  get_ttyp ()->output_stopped &=3D ~BY_VSTOP;
> > >  	  continue;
> > > +	case not_signalled_but_done:
> > > +	  break;
> >=20
> > Dropping `not_signalled_but_done` from the shared switch case also dro=
ps
> > the clearing of `BY_VSTOP` on this path. Probably fine, since no cygwi=
n
> > signal is delivered here, but a sentence in the commit message would s=
ave
> > future git-blame archaeology.
>=20
> Your expectation is correct. I'll add the explanation to the commit mess=
age.
> In addition, the naming of return value 'not_signalled_but_done' means
> not_signalled && the processing for the key has been done. However, with
> this patch, the processing for the key is continued in the code below.
>=20
> So, I'd change here a bit:
> @@ -525,10 +532,11 @@ fhandler_termios::line_edit (const char *rptr, siz=
e_t nrea
> d, termios& ti,
>        switch (process_sigs (c, get_ttyp (), this))
>         {
>         case signalled:
> -       case not_signalled_but_done:
>         case done_with_debugger:
>           sawsig =3D true;
>           get_ttyp ()->output_stopped &=3D ~BY_VSTOP;
> +         fallthrough;
> +       case not_signalled_but_done:
>           continue;
>         case not_signalled_with_nat_reader:
>           disable_eof_key =3D true;
>=20
> and also change here:
> @@ -466,7 +473,7 @@ not_a_sig:
>           fh->discard_input ();
>         }
>        ti.c_lflag &=3D ~FLUSHO;
> -      return not_signalled_but_done;
> +      return need_send_sig ? not_signalled : not_signalled_but_done;
>      }
>    bool to_nat =3D !cyg_reader && pg_with_nat;
>    return to_nat ? not_signalled_with_nat_reader : not_signalled;
>=20
> I think this is more appropriate.
>=20
> With the minor fixes above, I'd push this patch to master and
> cygwin-3_6-branch.

Excellent!

Thank you,
Johannes
