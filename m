Return-Path: <cygwin-patches-return-10077-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 104546 invoked by alias); 17 Feb 2020 12:55:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 104536 invoked by uid 89); 17 Feb 2020 12:55:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.73) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Feb 2020 12:55:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1Mk1BG-1jjMUC0N1E-00kQNC for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2020 13:55:52 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 103B5A80666; Mon, 17 Feb 2020 13:55:50 +0100 (CET)
Date: Mon, 17 Feb 2020 12:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Message-ID: <20200217125550.GE4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200216081322.1183-1-takashi.yano@nifty.ne.jp> <20200217090015.GB4092@calimero.vinschen.de> <20200217184545.43be636858734d029f2f5a11@nifty.ne.jp> <20200217101650.GD4092@calimero.vinschen.de> <20200217213759.7e373930ae752aa918b2a426@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NklN7DEeGtkPCoo3"
Content-Disposition: inline
In-Reply-To: <20200217213759.7e373930ae752aa918b2a426@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00183.txt


--NklN7DEeGtkPCoo3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2834

On Feb 17 21:37, Takashi Yano wrote:
> On Mon, 17 Feb 2020 11:16:50 +0100
> Corinna Vinschen wrote:
> > On Feb 17 18:45, Takashi Yano wrote:
> > > On Mon, 17 Feb 2020 10:00:15 +0100
> > > Corinna Vinschen wrote:
> > > > On Feb 16 17:13, Takashi Yano wrote:
> > > > > - If two cygwin programs are executed simultaneousley with pipes
> > > > >   in cmd.exe, xterm compatible mode is accidentally disabled by
> > > > >   the process which ends first. After that, escape sequences are
> > > > >   not handled correctly in the other app. This is the problem 2
> > > > >   reported in https://cygwin.com/ml/cygwin/2020-02/msg00116.html.
> > > > >   This patch fixes the issue. This patch also fixes the problem 3.
> > > > >   For these issues, the timing of setting and unsetting xterm
> > > > >   compatible mode is changed. For read, xterm compatible mode is
> > > > >   enabled only within read() or select() functions. For write, it
> > > > >   is enabled every time write() is called, and restored on close(=
).
> > > >=20
> > > > Oh well, I was just going to release 3.1.3 :}
> > > >=20
> > > > In terms of this patch, rather than to change the mode on every
> > > > invocation of read/write/select/close, wouldn't it make more sense =
to
> > > > count the number of mode switches in a shared per-console variable,=
 i.e.
> > > >=20
> > > > LONG shared_console_info::xterms_mode =3D 0;
> > > >=20
> > > > on open:
> > > >=20
> > > >   if (InterlockedIncrement (&xterm_mode) =3D=3D 1)
> > > >     switch to xterm mode;
> > > >=20
> > > > on close:
> > > >=20
> > > >   if (InterlockedDecrement (&xterm_mode)) =3D=3D 0)
> > > >     switch back to compat mode;
> > > >=20
> > > > ?
> > >=20
> > > Thanks for the advice. However this unfortunately does not work
> > > in bash->cmd->bash case.
> > > For cmd.exe, xterm mode should be disabled, however, the second
> > > bash need xterm mode enabled.
> > >=20
> > > On Mon, 17 Feb 2020 10:28:19 +0100
> > > Corinna Vinschen wrote:
> > > > On second thought, also consider that switching the mode and
> > > > reading/writing is not atomic.  You'd either have to add locking, o=
r you
> > > > may suffer the same problem on unfortunate task switching.
> > >=20
> > > Hmm, it may be. Let me consider. It may need time, so please
> > > go ahead for 3.1.3.
> >=20
> > Ok.  I just wonder if I should merge your patch into 3.1.3 as is for the
> > time being.  It's better than the old state, right?
>=20
> I am very sorry but I found one more mistake. Is it possible to
> add a patch for 3.1.3?

Actually, it's kind of too late for 3.1.3.  I already pushed the 3.1.3
tag to the sourceware repo and the git scripts on sourceware disallow to
drop an already pushed tag.

We could skip 3.1.3 and make this a 3.1.4 release when you send the patch.


Corinna


--=20
Corinna Vinschen
Cygwin Maintainer

--NklN7DEeGtkPCoo3
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5KjVUACgkQ9TYGna5E
T6AUwA/+PIQgY4V3xICRM00YaYcm5+1VANXT4vsI9K7fMThK1JP6f6DAC6+qTaX1
ouTyyVrJL7TcFe9OxGF7CnDJDQA4KBg7AW0EvqYhCiTL6obozP2IEsujIvohhNTk
Hc3GuP25+kiF2Vwx5cTkg1h5RBMYbDCsYywh992o+mRxdhxY/4lw4uLtxz8X8W1g
EzjB33c7XLVPrTTzbfgXD7CoenbpH69rqOnTyu+TADCmcxIcv2Qd6Lt61qwWvon9
+UhjKCyZUjqNYVOn7kpWGNE9UKmC8iCJJ+r+BbNTsbZFFAJYCi1SJpJXLoVha87m
oJdmrCbSvHgsA13lmlR7bGbfJ4UV/jzTQjg/Jk0T6JSyinm75K3CCBGbHMQe5j+q
N+0o1l7rt7VFTpgRUioAwTgW1k923rVh9vajcwdgETSNeQk39J6vpXNNpHK9vFn+
TEDGbseUeDudnBTrT5mGLbWEr3Qm7g1rXjlUqsTfIPsRo4A/8j51uV03LnXbqbuV
suJBnwbseW0kiKBtuPgGFuUuSpvAx+bOnRXZAnXzdttwp+dqrGVSg/Le6AFfRkpZ
ZyUFUe3OnKuenZf2P6CH+KD4tHT3PZreNCN4S+IoHuvM753mTj0CBQL2RjKUqSYt
1nTAQvpmBwtuBRW2esdIAK3uPLVLeWrtxPm1wdXkVuSxCGEtQwU=
=D6Fp
-----END PGP SIGNATURE-----

--NklN7DEeGtkPCoo3--
