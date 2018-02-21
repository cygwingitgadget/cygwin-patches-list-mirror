Return-Path: <cygwin-patches-return-9027-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 102165 invoked by alias); 21 Feb 2018 21:37:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 101632 invoked by uid 89); 21 Feb 2018 21:37:20 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=para, claims, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 21 Feb 2018 21:37:18 +0000
Received: from perth.hirmke.de (aquarius.franken.de [193.175.24.89])	by mail-n.franken.de (Postfix) with ESMTP id 6D260721E281A	for <cygwin-patches@cygwin.com>; Wed, 21 Feb 2018 22:37:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])	by perth.hirmke.de (Postfix) with ESMTP id 410A3860934	for <cygwin-patches@cygwin.com>; Wed, 21 Feb 2018 22:37:15 +0100 (CET)
X-Spam-Score: -2.9
Received: from perth.hirmke.de ([127.0.0.1])	by localhost (perth.hirmke.de [127.0.0.1]) (amavisd-new, port 10024)	with LMTP id EIh1Da_Oz2pB for <cygwin-patches@cygwin.com>;	Wed, 21 Feb 2018 22:37:14 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by perth.hirmke.de (Postfix) with ESMTP id AEA01860905	for <cygwin-patches@cygwin.com>; Wed, 21 Feb 2018 22:37:14 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A1575A80678; Wed, 21 Feb 2018 22:37:14 +0100 (CET)
Date: Wed, 21 Feb 2018 21:37:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] doc/ntsec.xml: Fix typo
Message-ID: <20180221213714.GB7576@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <f1047ae4-4edf-6343-2929-c193e6cee77c@gmail.com> <20180221210534.GA7576@calimero.vinschen.de> <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <9501f8b9-f84a-ea43-93da-c0eeb8ca9d35@SystematicSw.ab.ca>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SW-Source: 2018-q1/txt/msg00035.txt.bz2


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1510

On Feb 21 14:20, Brian Inglis wrote:
> On 2018-02-21 14:05, Corinna Vinschen wrote:
> > Hi David,
> >=20
> > On Feb 21 18:09, David Macek wrote:
> >> ---
> >>  winsup/doc/ntsec.xml | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/winsup/doc/ntsec.xml b/winsup/doc/ntsec.xml
> >> index df1d54930..03293591b 100644
> >> --- a/winsup/doc/ntsec.xml
> >> +++ b/winsup/doc/ntsec.xml
> >> @@ -914,7 +914,7 @@ This is not valid:
> >>  </screen>
> >>  <para>
> >> -Apart from this restriction, the reminder of the line can have as
> >> +Apart from this restriction, the remainder of the line can have as
> >>  many spaces and TABs as you like.
> >>  </para>
> >> --=20
> >> 2.16.2.windows.1
> >=20
> > The patch is malformed.  It claims to contain 7 lines (6 lines context,
> > one line changed), but actually it has only 4 lines context.  Please
> > check your git settings.
>=20
> "It's an een-justice!" -- Calimero
> Check your mail client blank line squishing settings; I see:

I'm using mutt which is usually sticks to the original.  I checked again
and when looking into the message with vi I see this:

  </screen>
=3D20=3D20
  <para>
[...]
  </para>
=3D20=3D20

Why are the spaces decodes as =3D20 in these two lines?

In theory the decode-copy command should retain the empty lines
and it did so before.  Why not now?!?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlqN5ooACgkQ9TYGna5E
T6D/uw/+PapkHx2PNSCiilXdjy+/YWjxZarK8up+2zaVTlXx7EPvxpOOc80zJwDs
k7bWFmLmHAS3y9biogbCM0nBaOaqC/qrzHzqt60LkeGcgCQunwqNFxITttKk1bRi
Tn0XTW11W+mcJJdDgzHm9IlfDXvKOrI2Jr+OA7AZhuOODbP3kAWXFcfGGCndTmnl
D4D6exOFG50GDN0mahIIjB8EoJxYfXuLC2MauYAWiWy1t4UjnZY35ln0Rfutpy1G
qFziYZ/niAloMxxj5AotONv7kU8WRmAqggTkk7hhnDy5uPfXXYgDbAzFSh6j4rXm
7qtn2HbN2mcHeudZUmrc4iHqPjMmS4SyWiN1yqAmimLKlSjI4DjIgu/96weU7UxJ
nzl4t9xpGA5NueRkuoHsJWpCtsOBaDWaOj980j3nbUY9Mud979u3+Re10ILnZojX
M+Ii/7SH9L57flnFBaKYeLQC9/SVinv3ui40QtrLixw8Tptk8KCKkcOTmmHQdkTk
lhYYUOdCcjpCe/QVhoVNM7i3TF8tDUxhQ8iCKYdyMC7R4gfKic5wYQ4hzPfsdakQ
J/9LBkT4a43jjOUTce/exNn39UjbuBVY8FaKYnnhGdIDQ0pw8Q/g++jpxzjUguBP
2Y7TTnarjH8ppCPSqeOFsu2Eb4gCPvhq9Yx8P9pNYre/o0Kbd9E=
=rret
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
