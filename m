Return-Path: <vapier@gentoo.org>
Received: from smtp.gentoo.org (dev.gentoo.org
 [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
 by sourceware.org (Postfix) with ESMTPS id B2C093858406
 for <cygwin-patches@cygwin.com>; Wed,  2 Mar 2022 01:42:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org B2C093858406
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gentoo.org
Received: by smtp.gentoo.org (Postfix, from userid 559)
 id 872673432C9; Wed,  2 Mar 2022 01:42:48 +0000 (UTC)
Date: Tue, 1 Mar 2022 20:42:52 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Jon Turney <jon.turney@dronecode.org.uk>
Cc: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] winsup: enable maintainer mode support
Message-ID: <Yh7LnG73RODD1D4/@vapier>
References: <20220301005439.23139-1-vapier@gentoo.org>
 <9a4b4c3c-f35f-920f-5937-bf119f63983e@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="I8OineRqUL4X3ENT"
Content-Disposition: inline
In-Reply-To: <9a4b4c3c-f35f-920f-5937-bf119f63983e@dronecode.org.uk>
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 KAM_DMARC_STATUS, SPF_HELO_PASS, SPF_PASS, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Wed, 02 Mar 2022 01:42:53 -0000


--I8OineRqUL4X3ENT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01 Mar 2022 14:26, Jon Turney wrote:
> On 01/03/2022 00:54, Mike Frysinger wrote:
> > We do this in newlib & libgloss, so enable in winsup too for consistenc=
y.
> > ---
> >   winsup/configure.ac | 1 +
> >   1 file changed, 1 insertion(+)
> >=20
> > diff --git a/winsup/configure.ac b/winsup/configure.ac
> > index b8d2100dbe90..6c6e1cb0893a 100644
> > --- a/winsup/configure.ac
> > +++ b/winsup/configure.ac
> > @@ -13,6 +13,7 @@ AC_INIT([Cygwin],[0],[cygwin@cygwin.com],[cygwin],[ht=
tps://cygwin.com])
> >   AC_CONFIG_AUX_DIR(..)
> >   AC_CANONICAL_TARGET
> >   AM_INIT_AUTOMAKE([dejagnu foreign no-define no-dist subdir-objects -W=
all -Wno-portability -Wno-extra-portability])
> > +AM_MAINTAINER_MODE
>=20
> I'm not sure having maintainer-mode disabled by default for cygwin makes=
=20
> a lot of sense.
>=20
> We don't check in the autotools generated files, so for the handful of=20
> people in the world who build cygwin from source from the git repo, they=
=20
> should have autotools already installed and this just requires them to=20
> know and remember to use '--enable-maintainer-mode'.
>=20
> I take the point about consistency, but I'm not sure what the arguments=
=20
> are against using 'AM_MAINTAINER_MODE([enabled])' everywhere.

tbh, it makes no diff to me -- merge or skip it, i'm fine either way.
just something i noticed while digging through things.

> (There are no meaningful source archive releases of cygwin.)

yeah, it's a shame because it makes building a cygwin toolchain a pita :p
-mike

--I8OineRqUL4X3ENT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAmIey5sACgkQQWM7n+g3
9YGacQ//SW0WmpQ4xhWh1A0V5sX/ugbwOCdMdyJXV7iw+FAF//0n52NaS1D4+vnD
sOBFxVIqvEPPG4TesCUZ0ZT9bfPoOuHi0E3dOHRLOmvfQdAW1qWZwjbGtIMBLONF
sKTAPuUgWGpgIadvhSpiKSgXAKZLAo4r1M8aDIpb2+R+CeGwU+qTXVtkS83K9qKt
uOCuFCb2pxAFalA/LhV8GUgmyOZlHHFrUImp/TJlOgnO9OEKMbbUUetLurjVGUJ4
dOiTqOkd158o03pUNh1yLj1VEJqv7h0ztxeBsmJ3rU2cSR/XlVlaetNImuuVAULd
SkyHkrgQD/+HqFCCuFtzBFf6aVKze9k7XqGWUcmwndDi43mKHudf2Seu2HYpmx2I
bmppMb/dwBwe2EPeLk1xLOOcKge5ObZuX9YCS2yeAQcr6/mXQSw5GGhHHTBeL2kR
ay7fzt28fhx4spyrZy9lr/b1SP5gcCk8drX/46IzBEBJEnY7P6Z0yWQ9uyGh7s0x
MDpPtFuUtpd+2eWqQW//CCifiB42n8Opl7DQmmycE7h8J//OG+89PjNxw1U+IYU6
+TMuQVvkGKeKNZueEG9ybp+Sb2IaIM2JE+s+v170IEkhBkOVyHD6V+H0k8V0tm1j
pcoPkpVYulYZ2J9CLrWuuSqloq/p+OF0GmyzMFyOQqkXx/iUVns=
=eQd6
-----END PGP SIGNATURE-----

--I8OineRqUL4X3ENT--
