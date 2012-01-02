Return-Path: <cygwin-patches-return-7582-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28188 invoked by alias); 2 Jan 2012 12:56:42 -0000
Received: (qmail 28177 invoked by uid 22791); 2 Jan 2012 12:56:41 -0000
X-SWARE-Spam-Status: No, hits=-7.5 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 02 Jan 2012 12:56:28 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q02CuSso022424	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Mon, 2 Jan 2012 07:56:28 -0500
Received: from [10.3.113.16] ([10.3.113.16])	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id q02CuRT3009798	for <cygwin-patches@cygwin.com>; Mon, 2 Jan 2012 07:56:27 -0500
Message-ID: <4F01A97A.7060503@redhat.com>
Date: Mon, 02 Jan 2012 12:56:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:9.0) Gecko/20111222 Thunderbird/9.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add get_current_dir_name(3)
References: <1325385907.4064.7.camel@YAAKOV04>	 <20120101064630.GB3446@ednor.casa.cgf.cx> <1325402005.2376.5.camel@YAAKOV04>
In-Reply-To: <1325402005.2376.5.camel@YAAKOV04>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig292E020FF9E7D8FAE7C1D726"
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
X-SW-Source: 2012-q1/txt/msg00005.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig292E020FF9E7D8FAE7C1D726
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 837

On 01/01/2012 12:13 AM, Yaakov (Cygwin/X) wrote:
>> > You have to check st_dev here too don't you?
> Of course.  Revised patch for winsup/cygwin attached.
>=20

> +extern "C" char *
> +get_current_dir_name (void)
> +{
> +  char *pwd =3D getenv ("PWD");
> +  char *cwd =3D getcwd (NULL, 0);
> +
> +  if (pwd)
> +    {
> +      struct __stat64 pwdbuf, cwdbuf;
> +      stat64 (pwd, &pwdbuf);
> +      stat64 (cwd, &cwdbuf);
> +      if ((pwdbuf.st_dev =3D=3D cwdbuf.st_dev) && (pwdbuf.st_ino =3D=3D =
cwdbuf.st_ino))
> +        {
> +          cwd =3D (char *) malloc (strlen (pwd) + 1);

Memory leak.  You need to free(cwd) before reassigning it.  And why are
you using malloc(strlen())/strcpy(), when you could just use strdup()?

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig292E020FF9E7D8FAE7C1D726
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 620

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJPAal7AAoJEKeha0olJ0NqMg8IAK+tFPljkYwXfNK7HOK/EG3T
jJ+k81Eqfs7N3nzk/+1jRjU/pUgkdXtJbeCvHSlM2L91S45h1kKkD4TuxipZxKdL
lw9TeqkMoyG5GqyhjRvuJsHasOSJrv44AJuOKQXMre5QnKG5OAUJBiIhCnkBg1uX
514fQqvfqgBrHgRhgLVPSBxkqKg6gcqYAg0K51hfXbxsD09qdmKq26gPcJT2Qv1w
0tA1altRJyY3QykPQIBywYZr0TQKXoPZBNSrRt5/shgjGsRFjjPur6fuphmgrBBm
/6Cq4GAAhAKvwxHTP6R5UpEWrvV3zbJwFHiBd6iF6kde/pLaft+82tHJ2aMfmNs=
=8eUq
-----END PGP SIGNATURE-----

--------------enig292E020FF9E7D8FAE7C1D726--
