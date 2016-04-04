Return-Path: <cygwin-patches-return-8549-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 105811 invoked by alias); 4 Apr 2016 14:46:45 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 105798 invoked by uid 89); 4 Apr 2016 14:46:45 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:1566, crosscompilers, H*MI:sk:1459609, HTo:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 04 Apr 2016 14:46:44 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0157FA80604; Mon,  4 Apr 2016 16:46:42 +0200 (CEST)
Date: Mon, 04 Apr 2016 14:46:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Rename without-mingw-progs to with-cross-bootstrap
Message-ID: <20160404144641.GB13238@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1459609004-28850-1-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="2B/JsCI69OhZNC5r"
Content-Disposition: inline
In-Reply-To: <1459609004-28850-1-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q2/txt/msg00024.txt.bz2


--2B/JsCI69OhZNC5r
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1543

On Apr  2 10:56, Peter Foley wrote:
> Rename without-mingw-progs to with-cross-bootstrap, since it now
> disables additional checks that are problematic for cross-compilers.
>=20
> When cross-compiling a toolchain targeting cygwin, building cygwin1.dll
> requires libgcc.
> However, building libgcc requires the cygwin headers to be
> installed.
> Configuring cygwin requries the mingw-crt libraries, which require the
> cygwin headers to be installed.
> Work around this circular dependency by making the
> --with-cross-bootstrap configure option skip cygwin's configure checks
> for valid mingw-crt libraries. Cygwin will still properly link against
> these libraries if they exist, but this allows configure to succeed even
> if the libraries have not been built yet.
> Since the mingw-crt libraries only require the cygwin headers to be
> installed, this allows us to successfully configure cygwin so that we
> can only install the headers without trying to build any
> libraries.
>=20
> winsup/ChangeLog
> configure.ac: rename without-mingw-progs option to with-cross-bootstrap
> configure: regenerate
> winsup/cygserver/ChangeLog
> configure.ac: don't check AC_WINDOWS_LIBS when using with-cross-bootstrap
> configure: regenerate
> winsup/cygwin/ChangeLog
> configure.ac: don't check AC_WINDOWS_LIBS when using with-cross-bootstrap
> configure: regenerate

Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--2B/JsCI69OhZNC5r
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXAn5RAAoJEPU2Bp2uRE+gwwsP/RNpXxk9XKnBkbviAEh45j3y
sssagMVJK1kXkzIpe0Rc1FdjqtaI21QKJYTvi1fi4Pz3x7s5fZJ73b9ibl306mP5
7WYbSieC+CzDS8xdITdmDN5o8MpbvyvYKXwPA2DvtyZvzlV+1S4NsoaD3VLRr1zH
/wOC2UG9y+wsMHfnwyWpmYFv0149o559ZSbpWNlsy9jC8VxzrxTQqd0oFIB12cw8
dIYt+taVCLFbJ4f3ulJ4rMrgv8Hu/Wal0FXHQOYohMwNe7KmraFQZjmzRXwFxugS
nBYbcOB26HO00a7Puq8PZca/sirxM7fUFfL2dAm0tuBLmXdBC8EYkHASAdgjKX7p
0WtBZoLEeVAg4CdkgcrbP6w+xqQEE2Exr183p5jzkSqveACPxPOUPOJ/1X+xuAM0
AB1WmPImLXR6GQAgZ2DhdS7zH7QGabzW9Yu/AxAHyiuDihh9J4UdHJjA6XOZfV7a
jyPwhhH50W//j9p2O7BLaYqdm/v1wWcgHDD2q6nhkkuNoaPPmp2UiCpXHwMKJmFY
VtSRGL9+gJnZE+9ulMhXKwpGolcp3YhcrlBYMD+9NpL1DIYBFzQr+XBkZH9gvULO
XaoHm+tajek6jQdSG3YGfejZMhDD2QlAkhJ6c+SsDbx9DkzzNqLSXqdFVT8o83ji
JcgtufqT76eh7Pd6yqQR
=UEub
-----END PGP SIGNATURE-----

--2B/JsCI69OhZNC5r--
