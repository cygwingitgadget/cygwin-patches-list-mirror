Return-Path: <cygwin-patches-return-9108-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 123284 invoked by alias); 4 Jul 2018 12:20:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 123272 invoked by uid 89); 4 Jul 2018 12:20:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.131) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Jul 2018 12:20:45 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue004 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LroR0-1gFpJ71kDO-013gYB for <cygwin-patches@cygwin.com>; Wed, 04 Jul 2018 14:20:43 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C1C3FA818EF; Wed,  4 Jul 2018 14:20:42 +0200 (CEST)
Date: Wed, 04 Jul 2018 12:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: perror() changes the orientation of stderr to byte-oriented mode if stderr is not oriented yet.
Message-ID: <20180704122042.GQ3111@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180627200116.ddd80f78597f8fd3f09d5d4b@nifty.ne.jp> <20180627125503.GV28757@calimero.vinschen.de> <20180628201421.8f395c712f2fe5b3504d63f1@nifty.ne.jp> <20180628183157.GC32575@calimero.vinschen.de> <20180629213458.a39b9d4114bdf778deed8f49@nifty.ne.jp> <20180702102838.GB3111@calimero.vinschen.de> <20180703191818.5ee7b9c7338deb479d4a774c@nifty.ne.jp> <20180703134053.GL3111@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="b/Q3JWIUAuLE0ZFy"
Content-Disposition: inline
In-Reply-To: <20180703134053.GL3111@calimero.vinschen.de>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00003.txt.bz2


--b/Q3JWIUAuLE0ZFy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 832

On Jul  3 15:40, Corinna Vinschen wrote:
> On Jul  3 19:18, Takashi Yano wrote:
> > Hi Corinna,
> >=20
> > On Mon, 2 Jul 2018 12:28:38 +0200
> > Corinna Vinschen wrote:
> > > > By the way, I have noticed that psignal() and psiginfo() also have =
the
> > > > same problem. psignal() belongs to newlib, so the same strategy can
> > > > be applied. However, what can we do for psiginfo()? Only the FreeBSD
> > > > route may be the answer...
> > >=20
> > > I guess the simplest solution is to use the FreeBSD/OpenBSD method
> > > all the time.
> >=20
> > This is for fixing psiginfo().
>=20
> Thanks, LGTM.  I'll push this depending on the discussion on newlib.

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--b/Q3JWIUAuLE0ZFy
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAls8u5oACgkQ9TYGna5E
T6BTFhAAlBgjt1ANQr8suUQzGJLIg6vYiZhJJl2r2OWFcybttfPJ63fP6VnB5EcP
+3i2zk3J6ACCWj2q0cwibF8NLe7tHgw03cWj62M3yaFGZbK0jMCuMEsV1OZ9bfaz
6JGyOo26rGWBdrL4mz3XicyTpPM4+PGhcEiG1Ej6LxsXpv6D4rhMLztt1ua7UWj6
M18s6IWMAIHJ01TY2QiX6xk7mNBCef19JKtkmCBbqEwc7YGr9eukxAWv+BdkR7XN
DhDNxYaMoOEUB0bniFzz/bX/VzxKnFjWYxVtUkZg0+Npzdn3ho5KUC51C7KK7vAc
r1W31+ZYPaTZi6I/ZHDGhQ2SX05rNzcl420zCcXoNKcA/gRuI4wZFhmz4/lbG0wi
mM4IrDDo78Rj4d9EP2lnhtUaObAulX7g564PAF24cFPcVTAo4Dyq25ApENWQPxRg
cO4qASDEU5pYo7gh9eNjD62ywlF/OeAdXC5fSC3bTfBo2Gc1/FeDvozVzfumAwv/
v2WGcFYe3sr853yJ63WlC8QcJtD1RVo6Ir2g77JLtMgrL5xpK/mqD/yKA/ivVeYa
fPse+bALM8DpiZ1oLxt+/dzltlxDCc3ai6vsonjbY6tYj3TxxOcwvIkGzcoJpEeM
MnSxmkxAQ7KW4cWI6AvVvbVYoTPdlRL0pADjCk8HO1XnXgbV15w=
=GGS+
-----END PGP SIGNATURE-----

--b/Q3JWIUAuLE0ZFy--
