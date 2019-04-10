Return-Path: <cygwin-patches-return-9321-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 34001 invoked by alias); 10 Apr 2019 14:20:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 33983 invoked by uid 89); 10 Apr 2019 14:20:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-114.4 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=H*F:D*cygwin.com
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 10 Apr 2019 14:20:54 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1N9MlI-1gqsER0pbo-015Ew6 for <cygwin-patches@cygwin.com>; Wed, 10 Apr 2019 16:20:51 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 7122BA806B0; Wed, 10 Apr 2019 16:20:50 +0200 (CEST)
Date: Wed, 10 Apr 2019 14:20:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [rebase PATCH] Introduce --with-posix-shell configure flag.
Message-ID: <20190410142050.GH4248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <65e46d68-33be-bfea-dfd2-756812ac3472@ssi-schaefer.com> <20190410090237.GF4248@calimero.vinschen.de> <d4cfd98d-c9a2-3185-d2f2-c8c3c68a9345@ssi-schaefer.com> <5d84eeb0-2818-d8c9-7fbe-be6329270372@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="1sNVjLsmu1MXqwQ/"
Content-Disposition: inline
In-Reply-To: <5d84eeb0-2818-d8c9-7fbe-be6329270372@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q2/txt/msg00028.txt.bz2


--1sNVjLsmu1MXqwQ/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1276

On Apr 10 14:34, Michael Haubenwallner wrote:
> On 4/10/19 2:32 PM, Michael Haubenwallner wrote:
> > On 4/10/19 11:02 AM, Corinna Vinschen wrote:
> >> On Apr  9 11:23, Michael Haubenwallner wrote:
> >>> Some distros prefer a POSIX shell other than /bin/ash and /bin/dash.
> >>
> >> I think this is pretty old stuff nobody really looked at for a while.
> >> ash and dash are the same binary anyway, both are dash.
> >=20
> > Patch updated.
>=20
> and attached now.
>=20
> >=20
> >>
> >> I'd prefer to drop the distinction between ash and dash, so dash
> >> is default and --with-dash becomes a no-op.
> >>
> >> Also, why not just SHELL?
> >=20
> > The variable SHELL does have meanings to the system() call,
> > and may not necessarily denote a POSIX compatible shell.
> >=20
> > Thanks!
> > /haubi/
> >=20
>=20

> >From 052be19f0ff522a8b8fc57df933f4b5e39602ea0 Mon Sep 17 00:00:00 2001
> From: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
> Date: Fri, 5 Apr 2019 15:37:04 +0200
> Subject: [PATCH] Introduce --with-posix-shell configure flag.
>=20
> Some distros prefer a POSIX shell other than /bin/dash, which is the
> default.  Remove --with-dash configure flag, is POSIX shell default.

Pushed.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--1sNVjLsmu1MXqwQ/
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlyt+8IACgkQ9TYGna5E
T6CGPg//YJ5xG2LO7Zax/NbDrh6+6YZ9sUk04dwksk3okbgDOr6IaQoEF8VHyjbd
tainiOw7RcCAcWfpRjlQciVqVEGQ6sWiyM0zr2jdHaKSzvreUfS9bdVDvE0BObP/
8QxgSzLgXA2lwnN0a+455mzior4bmDtyLYHWyJXILY4XqJRIrwiZFLTsjFu72m32
43kVR699vH4lfQTyZfMHVOww08/PDpSxhY0R7P+lMyCmb9NvlDKMSVT/W+chXeGK
P29hEakM0hJr8eRNc6YvKpmMMp6tPZRCKvvz7BRi4cjhnJzcslwkFU20Anv+/tKv
vYNAnHiGBw6x1Y4awhZBz1aMsHmhvTb2n6a9eViKxibF50OmcBYCCbmKzX2IRHLH
nijpbzwaBilH8KRgLQgeUwLy+nqWD8gqaeAhx1OwvzJ6zM8HJ3c/V0DAQbH4J0Kf
Q2Sa2cmLnU/ZK0+8JyHgQHWB+VTRmoKG3gzrI8AnlCmd4bTkkeQ1OezUPtD8r2Ut
KRMFFViu4hdg2vhCooH9pGZcTx5UvsGHF37zXb/TtMLm525xEEY2cPTbXp4nIbGW
lfahQYfDysf6dao7LSi5olWcBnby/uyCQkKPZyr4zvRqZiOvxzHkuawD00xnH61O
TDeLhz6c7Co7eNdxVpmEF/QbNu5GocpsPQe+4udYZfnEGLtCmus=
=2AH1
-----END PGP SIGNATURE-----

--1sNVjLsmu1MXqwQ/--
