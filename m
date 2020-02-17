Return-Path: <cygwin-patches-return-10070-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 77532 invoked by alias); 17 Feb 2020 09:28:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 77520 invoked by uid 89); 17 Feb 2020 09:28:25 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.9 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*r:mreue108
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.13) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 17 Feb 2020 09:28:23 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MqJyX-1jpu0E0bsB-00nMnR for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2020 10:28:21 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 03785A80773; Mon, 17 Feb 2020 10:28:19 +0100 (CET)
Date: Mon, 17 Feb 2020 09:28:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Change timing of set/unset xterm compatible mode.
Message-ID: <20200217092819.GC4092@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200216081322.1183-1-takashi.yano@nifty.ne.jp> <20200217090015.GB4092@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <20200217090015.GB4092@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00176.txt


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1581

On Feb 17 10:00, Corinna Vinschen wrote:
> Hi Takashi,
>=20
> On Feb 16 17:13, Takashi Yano wrote:
> > - If two cygwin programs are executed simultaneousley with pipes
> >   in cmd.exe, xterm compatible mode is accidentally disabled by
> >   the process which ends first. After that, escape sequences are
> >   not handled correctly in the other app. This is the problem 2
> >   reported in https://cygwin.com/ml/cygwin/2020-02/msg00116.html.
> >   This patch fixes the issue. This patch also fixes the problem 3.
> >   For these issues, the timing of setting and unsetting xterm
> >   compatible mode is changed. For read, xterm compatible mode is
> >   enabled only within read() or select() functions. For write, it
> >   is enabled every time write() is called, and restored on close().
>=20
> Oh well, I was just going to release 3.1.3 :}
>=20
> In terms of this patch, rather than to change the mode on every
> invocation of read/write/select/close, wouldn't it make more sense to
> count the number of mode switches in a shared per-console variable, i.e.
>=20
> LONG shared_console_info::xterms_mode =3D 0;
>=20
> on open:
>=20
>   if (InterlockedIncrement (&xterm_mode) =3D=3D 1)
>     switch to xterm mode;
>=20
> on close:
>=20
>   if (InterlockedDecrement (&xterm_mode)) =3D=3D 0)
>     switch back to compat mode;
>=20
> ?

On second thought, also consider that switching the mode and
reading/writing is not atomic.  You'd either have to add locking, or you
may suffer the same problem on unfortunate task switching.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5KXLMACgkQ9TYGna5E
T6DxtRAAmQJdMK/S1kLImJpXFDEFFgLRjJoVeMl7eFyS/2nu6t9hH1e5BkExr0Od
SuRmgCrfLxHcGhphJ9mQz4zyEHoo5EHVkIFBJZzgIctYemHOv6UJsNDhl2Ek5pLq
UAlfd3t2jP/yXIO6xwaz4HZcJbvlNwkFNW5hTA0q/LISg9GoyC171ZANMd1Iz489
RVclu/LiZYo8FxZ9mWg1gBG6LSUrEgYo1diJt3gZNuMTTZG76CV8zPNMMbdXZdL5
IDxTTB2yIBJDvYOofpqoRgZb4BUw3aibyYxL6QrR1TkjIRAjpKN7Pvn3bDBLRRIK
GXp36vQRRLq/EO1EtzvS7Fj7LCrflNAf8415TXd91jkwoeQGR8Z16yG5ArOZPViz
d/B3jFsfjaZMgOSu8jGafv4XSUUfsGDSRqfFUMmiNorJNxYtywktmsz1kWbbJQME
8OGmGpUJKbUMECJiTYbbZb2rJQy3r8ZF6Xh3HrQ11qWXK0j92DNmmgnCEFBL55oM
4glWZUsfpbe+ID3LLiVt3SGSUJ4Qhh7mEmTZbcecykIk09w9BBcVLo06x93uhho5
uLp4i5Kbl9DTcbJXtGsrx/PNnveDtU4w5FYUItU9YM8PJn7NH+rf6bE3JclyGKp7
51VXSo/9tj0yhPe3+s/8Z7a72y7YfVZ6O9DMGbMpGSl0aUdPWjw=
=N9r/
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
