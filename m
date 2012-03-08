Return-Path: <cygwin-patches-return-7618-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25234 invoked by alias); 8 Mar 2012 15:29:48 -0000
Received: (qmail 25222 invoked by uid 22791); 8 Mar 2012 15:29:47 -0000
X-SWARE-Spam-Status: No, hits=-6.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,TW_CP,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Mar 2012 15:29:30 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q28FTU7I029223	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Thu, 8 Mar 2012 10:29:30 -0500
Received: from [10.3.113.123] (ovpn-113-123.phx2.redhat.com [10.3.113.123])	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q28FTTq3028497	for <cygwin-patches@cygwin.com>; Thu, 8 Mar 2012 10:29:30 -0500
Message-ID: <4F58D059.1090608@redhat.com>
Date: Thu, 08 Mar 2012 15:29:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: avoid calling strlen() twice in readlink()
References: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com>
In-Reply-To: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigC83F17D499444C7F1F30D8E9"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00041.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC83F17D499444C7F1F30D8E9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 543

On 03/08/2012 06:37 AM, V=E1clav Zeman wrote:
> Hi.
>=20
> Here is a tiny patch to avoid calling strlen() twice in readlink().
>=20

>=20=20
> -  ssize_t len =3D min (buflen, strlen (pathbuf.get_win32 ()));
> +  size_t pathbuf_len =3D strlen (pathbuf.get_win32 ());
> +  size_t len =3D MIN (buflen, pathbuf_len);
>    memcpy (buf, pathbuf.get_win32 (), len);

For that matter, is calling pathbuf.get_win32() twice worth factoring out?

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enigC83F17D499444C7F1F30D8E9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 620

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJPWNBZAAoJEKeha0olJ0Nqq9AIAIrjcwHOJ/GHVBCi8uvLI88Q
vZ1d5hqj53adPzxN4WUy0lu1GDL9rLOIRGqpmUWaIWalXiNomCrbEIEM6VkyBVAp
yC6HDOeU6Z1ExU65phtJz+OwKiv+D0HbJOBNY6yMdLt5mFFTulKHZTZBRuO2DJHm
8kD39ofjeFelMtQABvvad4aqX9MTmW/7JfaNBRXRUE7b9lGUF++nAI1Lx5AVhw/o
cg+5ijz9InZn6ky39Y3MJ/QR4+rOkkO3cnECNZleeELG55SSLbYGXlRr8t3Nf+b8
dnpKWqy3TO/B7ad9ONSXS95vBeqeQnkwkVx7GvnCtB/T4xf8pfTDy/tqgoAF1KQ=
=Dk2D
-----END PGP SIGNATURE-----

--------------enigC83F17D499444C7F1F30D8E9--
