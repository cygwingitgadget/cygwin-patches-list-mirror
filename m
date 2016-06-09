Return-Path: <cygwin-patches-return-8576-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 127409 invoked by alias); 9 Jun 2016 14:16:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 127315 invoked by uid 89); 9 Jun 2016 14:16:06 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-3.3 required=5.0 tests=BAYES_00,RP_MATCHES_RCVD,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1192, HTo:U*cygwin-patches, our
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with (AES256-GCM-SHA384 encrypted) ESMTPS; Thu, 09 Jun 2016 14:15:55 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id BDFB681F07	for <cygwin-patches@cygwin.com>; Thu,  9 Jun 2016 14:15:54 +0000 (UTC)
Received: from [10.3.116.88] (ovpn-116-88.phx2.redhat.com [10.3.116.88])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u59EFsOL016567	for <cygwin-patches@cygwin.com>; Thu, 9 Jun 2016 10:15:54 -0400
Subject: Re: Declaration of crypt
To: cygwin-patches@cygwin.com
References: <b1986513-81eb-39a0-959f-ba9f98521e03@cornell.edu> <20160609090004.GK30368@calimero.vinschen.de> <0479db42-e977-24ae-fc35-407c5067d256@cornell.edu> <20160609123245.GL30368@calimero.vinschen.de> <4a4c8f09-9488-bb0c-7d7b-d2cb21435c2f@cornell.edu>
From: Eric Blake <eblake@redhat.com>
Openpgp: url=http://people.redhat.com/eblake/eblake.gpg
Message-ID: <57597A1A.6060508@redhat.com>
Date: Thu, 09 Jun 2016 14:16:00 -0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <4a4c8f09-9488-bb0c-7d7b-d2cb21435c2f@cornell.edu>
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="2f83nVKhQGChGincD0DV4eCAHUUuW81OB"
X-IsSubscribed: yes
X-SW-Source: 2016-q2/txt/msg00051.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2f83nVKhQGChGincD0DV4eCAHUUuW81OB
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1197

On 06/09/2016 08:07 AM, Ken Brown wrote:
> On 6/9/2016 8:32 AM, Corinna Vinschen wrote:
>> Can you please define crypt, encrypt and setkey explicitely in unistd.h
>> per POSIX, rather than including crypt.h?  This would not only be target
>> independent, it would also be more correct.  As a side effect I will
>> have to come up with a new version of the crypt package, because our
>> crypt.h is using a wrong prototypes for setkey (const is missing).
>=20
> setkey is supposed to be in stdlib.h rather than unistd.h, so I've done
> that.
>=20
> One minor question about encrypt: The Posix prototype has 'char
> block[64]' as the first argument, but Cygwin's crypt.h simply has 'char
> *block'.  FreeBSD and glibc also use 'char *block', so I did the same.

The two are identical, according to C rules.  Using [64] rather than *
gives a bit more indication about the size of the array that must be
passed, but doesn't change the compiler behavior.

> Or would you rather follow Posix here?
>=20
>> Thanks a lot and sorry again,
>=20
> No problem.  Revised patch attached.
>=20
> Ken
>=20

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--2f83nVKhQGChGincD0DV4eCAHUUuW81OB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 604

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJXWXoaAAoJEKeha0olJ0Nq8S8H/ifqxCrXpOhrP65siSPMIBCc
0wKcxtPUvgYWshorHNdWwQ1uxR369KGX3VVRfzuSqevzcS4OkUUoWLoPuhHr1HHJ
W2G/GYqbqLEYmz8KLHHDYb+LEwNeqKtEw/2O9jReEWOum+demSGIbMfkPyYRRTLz
d6KRdHwcmYBhQejRozHK+WYUF/qV5C6QhLZ7ZBygr1ndFtGrylBWt/ybIBJhzBW+
feEycCI/m9acd7t6iKOCtOksupM9TqTf/B/0CGeMZ2fVlL1uNsn3ehEd1lz8EXHg
qy/Wek2huiuxG1YsvtwODxySODqZUiOFZbEnyGhm7HKiJyI0yCVwUtTDwL2br50=
=YEO2
-----END PGP SIGNATURE-----

--2f83nVKhQGChGincD0DV4eCAHUUuW81OB--
