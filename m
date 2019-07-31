Return-Path: <cygwin-patches-return-9540-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 36250 invoked by alias); 31 Jul 2019 16:59:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 36235 invoked by uid 89); 31 Jul 2019 16:59:19 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-104.7 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=UD:cygwin.com, cygwincom, cygwin.com, retry
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.135) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 31 Jul 2019 16:59:18 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MpUQm-1iiTVe1nfI-00ps6j; Wed, 31 Jul 2019 18:59:14 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EF00AA80673; Wed, 31 Jul 2019 18:59:13 +0200 (CEST)
Date: Wed, 31 Jul 2019 16:59:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>
Cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 0/2] silent fork retry with shm (broke emacs-X11)
Message-ID: <20190731165913.GB11632@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: Michael Haubenwallner <michael.haubenwallner@ssi-schaefer.com>,	cygwin-patches@cygwin.com
References: <20190730160754.GZ11632@calimero.vinschen.de> <20190731103531.559-1-michael.haubenwallner@ssi-schaefer.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="aZ/0/p6gSDXwzas7"
Content-Disposition: inline
In-Reply-To: <20190731103531.559-1-michael.haubenwallner@ssi-schaefer.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-SW-Source: 2019-q3/txt/msg00060.txt.bz2


--aZ/0/p6gSDXwzas7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1282

On Jul 31 12:35, Michael Haubenwallner wrote:
> Hi Corinna,
>=20
> On 7/30/19 6:07 PM, Corinna Vinschen wrote:
> > Hi Michael,
> >=20
> > On Jul 30 17:22, Michael Haubenwallner wrote:
> >> Hi,
> >>
> >> following up
> >> https://cygwin.com/ml/cygwin-patches/2019-q2/msg00155.html
> >>
> >> It turns out that fixup_shms_after_fork does require the child pinfo to
> >> be "remember"ed, while the fork retry to be silent on failure requires
> >> the child to not be "attach"ed yet.
> >>
> >> As current pinfo.remember performs both "remember" and "attach" at onc=
e,
> >> the first patch does introduce pinfo.remember_without_attach, to not
> >> change current behaviour of pinfo.remember and keep patches small.
> >>
> >> However, my first thought was to clean up pinfo API a little and have
> >> remember not do both "remember+attach" at once, but introduce some new
> >> remember_and_attach method instead.  But then, when 'bool detach' is
> >> true, the "_and_attach" does feel wrong.
> >=20
> > I'd prefer to drop the reattach call from remember, calling both of them
> > where appropriate.
> >=20
>=20
> Fine with me, even if that looks a little more complicated for spawn.

Pushed, with just a small formatting tweak.


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--aZ/0/p6gSDXwzas7
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl1ByOEACgkQ9TYGna5E
T6C0QA/7Bngnv4phUCFb35bvUmtLJ2jn7t0BVGHqeQRoiz6tDmkmd3V0wGCSAoXW
dmwCf1pXbo7jcj6e+5U50PuRp8pBHIRPJGEM3YISTWlG7niEYMKNgECnjoDDk6M5
xwBjqAp3PXd2LzexrgHD+0tG2Uh3OApgWYXh5rlCy8Duh+aawKtefdyklwndGvQe
XmjjQ4jUAKzZfM+CrvbYGC0mZ/tgnFvbm1f9RBa7+W05rRnUNzvfhGUk0CCQ3zaT
KWeU77UIVkWmOT6v9Z+qavPsXiEU0ApNN3KRXVeE7RJRSNHSAogO4B4SFCsZNo5P
SqWiwykL7nYMeUdUbTT6YyZLtftKs6EKhH6e14t8M2KcpbtnngHUIIt+cG6iJEi1
/ITcNW7hHOUsthfA2ywhwCtVt8yx/GPEp9EiaiZ1dni30+eXKOX2vaAUUPUTwN+J
kzQlCraoVecRGFhohJUJSthPeZ5Nu28t58RgJo8L1Xujck65cXPbTTQfilz7BPkN
Sq8ki/boZAcci6TBc6qSTOeM+GSa7UGaeQrlAhtNXP0Mc2CcBDtIZ4GEo7K61Zjo
eZVaPU/YyZ/3e3lPz3KJ2CiFhN9ygXroKdPu7Q8Wd0I1f6Sn97AWTrKW0zWd3wPf
ET+jphxWegzr8DrGn/JlHq5F4wmbE2UFLx7QWpCA2s2U5EXXmWI=
=HCyp
-----END PGP SIGNATURE-----

--aZ/0/p6gSDXwzas7--
