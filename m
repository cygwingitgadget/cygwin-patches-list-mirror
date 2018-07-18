Return-Path: <cygwin-patches-return-9128-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 90541 invoked by alias); 18 Jul 2018 11:25:26 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 89996 invoked by uid 89); 18 Jul 2018 11:24:55 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Hx-languages-length:1062, professional
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 18 Jul 2018 11:24:53 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue003 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LwmRY-1g8Xun18vI-016QyK for <cygwin-patches@cygwin.com>; Wed, 18 Jul 2018 13:24:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id AC418A80579; Wed, 18 Jul 2018 13:24:44 +0200 (CEST)
Date: Wed, 18 Jul 2018 11:25:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 1/3] POSIX Asynchronous I/O support: aio files
Message-ID: <20180718112444.GG27673@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180715082025.4920-1-mark@maxrnd.com> <20180715082025.4920-2-mark@maxrnd.com> <20180716142128.GZ27673@calimero.vinschen.de> <2f78f69e-079d-36d5-15f0-61f1bfc8a9b7@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="Vo2ArcSjcOqS/fzO"
Content-Disposition: inline
In-Reply-To: <2f78f69e-079d-36d5-15f0-61f1bfc8a9b7@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q3/txt/msg00023.txt.bz2


--Vo2ArcSjcOqS/fzO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1080

On Jul 17 22:26, Mark Geisert wrote:
> Corinna Vinschen wrote:
> > I like the name, but what's the background for naming a thread like thi=
s?
> > Just curious.  A bit of comment might help to keep it in mind, too :)
>=20
> I've now added commentary above the pthread_create() call.  It reads:
>   /* A "vaquita" thread is a temporary pthread created to deliver a signa=
l to
>    * the application.  We don't wait around for the thread to return from=
 the
>    * app.  There's some symbolism here of sending a little creature off t=
o tell
>    * the app something important.  If all the vaquitas end up wiped out i=
n the
>    * wild, a distinct near-term possibility, at least this code remembers=
 them.
>    */
>=20
> If all this vaquita stuff is deemed too precious for industrial-grade
> software I can recast this code in more professional terms and wouldn't m=
ind
> doing it.

Nope, keep it.  It's nice.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--Vo2ArcSjcOqS/fzO
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAltPI3wACgkQ9TYGna5E
T6BcFA//ZLIWmVDkvYQvEZDJlu1U686I/7QrDQ3Sj30iMyd38ab5Hbfbm2/Cg81J
YQy+uUB40spaUnOup/hNSqVW/EjYFUGZB4gcBdjGzu+7oMsjkm2/qri+/AM0XvdB
Cihucj+vMsruMS60gvK8o5mF1HaC1pt8YpE3db9YPzvz6d5qhx1DsfscYzVdKoEN
peAgHKYNcKUOWOA5I43UcokBvSyyCIvA4tKrDDwFmhLRq1UKdh6NT+kXNk4tetAc
CiSt16KYR0kurTp4IbZfjqT4DsIvvqRQEU7jDjETcBGC5RRPPSnAtHmY6oevfCZw
COthX34Xt1kGwqTNJER4t4DMjcjR2mMOXm1TuG12wvd+Zre3IXsw1lFVbdzmq0I4
xbC/baRXBPYd/A0ATdR18JyyTYsFfxUfyhQSanOSjB7u3hAx+ZP7a3bteRoJtGlC
F6dNQd4fxmAo7j90bmU8KreLCzKPfoDq2HYtdOPN1aMNS/vIQ4kH2aN2oLcSrNnq
a8ocYX+DbJvXkAbJ4OGl0xLAbDOPC5mTBzbC+X4yzBg+ORcTm8eT63IZMfwd53+t
RnXQNpH4ZI8JNNc23os8dZ7u8wlo3gP0py/iqC0PF2utG6ki/RzlWuLteJtSzKp/
EIwO1srUyVvyKADwmaoaB/IZN8LTVBJJJ3cz46TYR1lkNEXwPqg=
=xMMe
-----END PGP SIGNATURE-----

--Vo2ArcSjcOqS/fzO--
