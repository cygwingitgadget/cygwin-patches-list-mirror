Return-Path: <cygwin-patches-return-10158-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 85414 invoked by alias); 2 Mar 2020 17:03:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 85399 invoked by uid 89); 2 Mar 2020 17:03:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.17.24) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 17:03:40 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M4aA4-1j8GFQ0zji-001iOB for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2020 18:03:38 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 917C5A8276B; Mon,  2 Mar 2020 18:03:37 +0100 (CET)
Date: Mon, 02 Mar 2020 17:03:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-ID: <20200302170337.GU4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de> <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de> <ea1bcf99-d945-d06e-9be6-8a17d8fb166f@t-online.de> <20200301153849.4fcaaaf2a6ae8fe723339174@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="qKojvbh47KHQqxue"
Content-Disposition: inline
In-Reply-To: <20200301153849.4fcaaaf2a6ae8fe723339174@nifty.ne.jp>
X-SW-Source: 2020-q1/txt/msg00264.txt


--qKojvbh47KHQqxue
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1129

On Mar  1 15:38, Takashi Yano wrote:
> Hi Hans,
>=20
> On Sat, 29 Feb 2020 19:10:02 +0100
> Hans-Bernhard Br=C3=B6ker wrote:
> > One more important note: the current implementation has a potential=20
> > buffer overrun issue, because it writes first, and only then checks=20
> > whether that may have overrun the buffer.  And the check itself is off=
=20
> > by one, too:
> >=20
> > >    wpbuf[wpixput++] =3D x; \
> > >    if (wpixput > WPBUF_LEN) \
> > >     wpixput--; \
> >=20
> > That's why my latest code snippet does it differently:
> >=20
> >  >      if (ixput < WPBUF_LEN)
> >  >        {
> >  >          buf[ixput++] =3D x;
> >  >        }
>=20
> Indeed. You are right. Thanks for pointing out that.
> Another similar problem exists in console code of escape
> sequence handling, so I will submit a patch for that.
>=20
> As for wpbuf, please continue to fix.

Yeah, a patch in `git format-patch' format would be most welcome.

For a first-time contribution (and then never again) we also need
a 2-clause BSD license waiver per https://cygwin.com/contrib.html


Thanks,
Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--qKojvbh47KHQqxue
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5dPGkACgkQ9TYGna5E
T6C5Yw//cwltj1hZ5z6Ndq7IUUYkMU2fOlyL0XkK02NhvQClFP5RDq3xNfC+SIQd
Xx79r7jCzLHa6GPnmLTwH0Cz6mLdV8EEFKTGNbfeBqi/+Zq645biu8h6Ps5wBq9O
nmiDmwIYvRJLkX+nnhOJnLbcLQ2dQYGwtBsWAUQe2RhHUM7Ft0Qq+9PaW2s38iyN
B3HCbdmYVLJ7KSvPTHsV3rCzPs2+m+lGc5O25Rx1hE4cyJTs0RRWyAGbsHhoyItn
k2ZLlYCiByOHttP/ZlrN9AC6rApzD8MUt/lmNOamGZ8EkkUDF33bnsf2cJrwIF2R
hbdMurSMPS2GrS9ICbTx9XdotmNx41K+sltarz+O9fDORtMvTycowvVa2z9JAypo
55P/4qSzWMNJpvsa/D+GBYr3dVi50tdnpqjx6fpz9KEK2kE/LPY/XfkvdR98h9PP
cMlawnnvOQnFYjLkPY1mrFMPrIfhf4vOSpEuDqboW+6jPRELhPhAAhDDKrXIf1ZG
FaC0LJzsw3PBqXa9wb+YNdLE8mpJzMLDZAM9RXa/Njq6FiXcpXgpQ+3i3IPMdcqB
ML35jUaPYn/HLIK+6BwPDRTML1gVfB9ApH0r7BVvLyRGIHh049Ne0lMirf8Nfrmz
iygNM8LTpT32GucVox05XGut4P4DX1q6SOJ7y0FVL+/zwRJYFkw=
=IiYC
-----END PGP SIGNATURE-----

--qKojvbh47KHQqxue--
