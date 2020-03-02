Return-Path: <cygwin-patches-return-10160-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 82244 invoked by alias); 2 Mar 2020 19:54:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 82232 invoked by uid 89); 2 Mar 2020 19:54:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-106.2 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.1 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (217.72.192.75) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 02 Mar 2020 19:54:04 +0000
Received: from calimero.vinschen.de ([24.134.7.25]) by mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MBV2f-1jEbVW2Jvb-00D0xX for <cygwin-patches@cygwin.com>; Mon, 02 Mar 2020 20:54:01 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 0ED1DA80BB0; Mon,  2 Mar 2020 20:54:01 +0100 (CET)
Date: Mon, 02 Mar 2020 19:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/4] Cygwin: console: Add workaround for broken IL/DL in xterm mode.
Message-ID: <20200302195401.GW4045@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200226153302.584-1-takashi.yano@nifty.ne.jp> <20200226153302.584-2-takashi.yano@nifty.ne.jp> <05cca441-eb83-4600-90f3-bf82ec7a0190@dronecode.org.uk> <20200228111409.149929dcf710cabf99a879b3@nifty.ne.jp> <20200228133122.GG4045@calimero.vinschen.de> <cc657f02-e3a4-1880-34a2-dcf04d6e902a@t-online.de> <ea1bcf99-d945-d06e-9be6-8a17d8fb166f@t-online.de> <20200301153849.4fcaaaf2a6ae8fe723339174@nifty.ne.jp> <20200302170337.GU4045@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="656hIAUFSU7Oh46B"
Content-Disposition: inline
In-Reply-To: <20200302170337.GU4045@calimero.vinschen.de>
X-SW-Source: 2020-q1/txt/msg00266.txt


--656hIAUFSU7Oh46B
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1329

On Mar  2 18:03, Corinna Vinschen wrote:
> On Mar  1 15:38, Takashi Yano wrote:
> > Hi Hans,
> >=20
> > On Sat, 29 Feb 2020 19:10:02 +0100
> > Hans-Bernhard Br=C3=B6ker wrote:
> > > One more important note: the current implementation has a potential=20
> > > buffer overrun issue, because it writes first, and only then checks=20
> > > whether that may have overrun the buffer.  And the check itself is of=
f=20
> > > by one, too:
> > >=20
> > > >    wpbuf[wpixput++] =3D x; \
> > > >    if (wpixput > WPBUF_LEN) \
> > > >     wpixput--; \
> > >=20
> > > That's why my latest code snippet does it differently:
> > >=20
> > >  >      if (ixput < WPBUF_LEN)
> > >  >        {
> > >  >          buf[ixput++] =3D x;
> > >  >        }
> >=20
> > Indeed. You are right. Thanks for pointing out that.
> > Another similar problem exists in console code of escape
> > sequence handling, so I will submit a patch for that.
> >=20
> > As for wpbuf, please continue to fix.
>=20
> Yeah, a patch in `git format-patch' format would be most welcome.
>=20
> For a first-time contribution (and then never again) we also need
> a 2-clause BSD license waiver per https://cygwin.com/contrib.html

I pushed wpbuf_put as a simple inline function as a stop-gap
measure so Cygwin builds on gcc 9.2.0.


Corinna

--=20
Corinna Vinschen
Cygwin Maintainer

--656hIAUFSU7Oh46B
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAl5dZFgACgkQ9TYGna5E
T6D4TQ/+KnONIgNOTiMSLZO+Xw57NLNsKj80AUPN2c+lQFrYoExsah/BuRptb8Y7
QAF3tSoiJ+spAKG5raOUgzrIKDd5wPj8U0L5UfHPR0Vt6lJmOokRdq9QLClXaPJs
kEjoEiqfHxM2Pt6bvBOAzu906St0KJ9P8y/aipkpAnpONIyEvg5OmO7vXyXbt1jq
tnOUB0Cc3MULXo1RdgIqABS7O0F/Clqa+TCiX7ljD552OKhOD1BMyrcZWwrZGD+c
jzeABW4gVHGceq+sh5Iqvsp3HRbEL5ouLvpPhWn++oExImwzNrz+IfjjuQCJUnUt
Fm7pnXbUqU93GDxWabURg4dUcrzHKL3pI0dY2WRfG9/w6Npq6UdFm3iIcchc9Ara
J6ZNoJETd/LsNOOSql0NwMEDUujzodMlSsz3o5ZbDAiicf5aP+RvnQPFSB45xzVW
GwW7Orzzs4NUztT69qWdQRjAa0CcInPt7zJpm/caeQphmbvib9YlDhN4wBrFwi7c
TlFFV+3bat9MCs2jZpD67ZMjrF2cCihXd/J8h0hxgMeHstqBtEJWciNvpcrP0lmm
w2kv8vnhAmWl3W+biDoXbCIZSJBkWv7DHonj1hRbRO6suLeL3g4E/+iMw9NOgRE9
38eqlBDENJ9tGATkHretXqP5lV7iLy+o4lpsAgvSs23fluNTQ0g=
=4DoA
-----END PGP SIGNATURE-----

--656hIAUFSU7Oh46B--
