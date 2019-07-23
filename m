Return-Path: <cygwin-patches-return-9513-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 26109 invoked by alias); 23 Jul 2019 17:05:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 26099 invoked by uid 89); 23 Jul 2019 17:05:39 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 23 Jul 2019 17:05:38 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MG9To-1hdo5F20Dc-00GcO4; Tue, 23 Jul 2019 19:05:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CE43CA80872; Tue, 23 Jul 2019 19:05:28 +0200 (CEST)
Date: Tue, 23 Jul 2019 17:05:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Ken Brown <kbrown@cornell.edu>,	Jon TURNEY <jon.turney@dronecode.org.uk>
Cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 1/1] Cygwin: don't allow getpgrp() to fail
Message-ID: <20190723170528.GO21169@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Ken Brown <kbrown@cornell.edu>,	Jon TURNEY <jon.turney@dronecode.org.uk>,	"cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <20190723161100.1045-1-kbrown@cornell.edu> <20190723161100.1045-2-kbrown@cornell.edu> <20190723165458.GM21169@calimero.vinschen.de> <20190723165921.GN21169@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="yK/6QRnH3Zanb0EF"
Content-Disposition: inline
In-Reply-To: <20190723165921.GN21169@calimero.vinschen.de>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00033.txt.bz2


--yK/6QRnH3Zanb0EF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1337

On Jul 23 18:59, Corinna Vinschen wrote:
> On Jul 23 18:54, Corinna Vinschen wrote:
> > Hi Ken,
> >=20
> > On Jul 23 16:12, Ken Brown wrote:
> > > According to POSIX, "The getpgrp() function shall always be successful
> > > and no return value is reserved to indicate an error."  Cygwin's
> > > getpgrp() is defined in terms of getpgid(), which is allowed to fail.
> >=20
> > But it shouldn't fail for the current process.  Why should pinfo::init
> > fail for myself if it begins like this?
> >=20
> >   if (myself && n =3D=3D myself->pid)
> >     {
> >       procinfo =3D myself;
> >       destroy =3D 0;
> >       return;
> >     }
> >=20
> > I fear this patch would only cover up the problem still persisting
> > under the hood.
> >=20
> > > Change getpgrp() so that it doesn't fail even if getpgid() fails.
> >=20
> > Instead of calling getpgid(0), we could just as well return
> > myself->pgid.  This never fails for sure.
>=20
> Just a hunch: The only reason for pinfo::init failing in GDB I can think
> of is if the call is too early in the lifetime of the process.  Myself
> might not be set up yet.

No, wrong.  myself is set to &myself_initial at process startup so
it's never NULL.  The pid is probably incorrect at this time, as long
as pinfo::thisproc hasn't been called.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--yK/6QRnH3Zanb0EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl03PlgACgkQ9TYGna5E
T6CDYQ/9H8en7tYQAvOjjJDSrTv9hi6j7LOVMZeaXX/v83jf1sNJh6EfN7eOGzJQ
No4365TmScVGefB8B1igGbX6DGJ6bh+ZbkXIywyrQFKJg4KmAor7hYyLsjL+JZxR
wN7X4DRtm7Oit3Bc/tNcdbgsobGb8fGIkyJSxKTZqTiVWpImxH/fh1m+L8K2S1cL
q43AuJh4rEVEZMPRCwdhMVyi0F4oxIK9m2tFKrW6LqVzjSghX3RgVI8GBH5ilm0Z
rGuefkvxmc47AEyGItvHb6bC/z1ktyBqbQ3Rl4rKgEAM31YEPy0w7vgBJMLIRYAt
EXcXDnNznI0J27R/eMTYGnsIG0zVamXo3BpEJJLx05oZk1pIYpLvLM4Nje6yfvWn
y3AJN86QBTA+H8rxjfC4aAs/QzJcnegblDpaBglkdrEwR5xF48AA73DB+w5s7KRb
lP+raL/kxpel+R0we7ItHk14aXNWikj3YNRXkih7PHVgmYTwietyAdNecH54zBVY
yuTTp9KrLN9R9h1nZGWmvUSzdNgUz3HkObSZigJWeIf6PocYVEr89uyvnNqEaTFO
eWDepNLePcMDieV7UZG1AZyGfsWoENd6BDNP1pBdJ0VyDesadWKIiAu7MZccI+Sf
3XVALyUKHYAr6taC4ynUd2FoE8IFQqGA1j3QqStCnX74kv/cHeI=
=SGvE
-----END PGP SIGNATURE-----

--yK/6QRnH3Zanb0EF--
