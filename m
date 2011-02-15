Return-Path: <cygwin-patches-return-7197-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20480 invoked by alias); 15 Feb 2011 15:48:00 -0000
Received: (qmail 20232 invoked by uid 22791); 15 Feb 2011 15:47:59 -0000
X-SWARE-Spam-Status: No, hits=-6.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 15 Feb 2011 15:47:54 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1FFlrTd009259	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Tue, 15 Feb 2011 10:47:53 -0500
Received: from [10.3.113.118] (ovpn-113-118.phx2.redhat.com [10.3.113.118])	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p1FFlq5g017396	for <cygwin-patches@cygwin.com>; Tue, 15 Feb 2011 10:47:53 -0500
Message-ID: <4D5AA028.8050304@redhat.com>
Date: Tue, 15 Feb 2011 15:48:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: src/winsup/doc ChangeLog new-features.sgml
References: <20110215153220.24348.qmail@sourceware.org>
In-Reply-To: <20110215153220.24348.qmail@sourceware.org>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig41B940D5CB6676B2C8840FAA"
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
X-SW-Source: 2011-q1/txt/msg00052.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig41B940D5CB6676B2C8840FAA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 654

On 02/15/2011 08:32 AM, corinna wrote:
> 	* new-features.sgml (ov-new1.7.8): Document /proc/sys.
>=20
> Patches:
> http://sourceware.org/cgi-bin/cvsweb.cgi/src/winsup/doc/ChangeLog.diff?cv=
sroot=3Dsrc&r1=3D1.328&r2=3D1.329
> http://sourceware.org/cgi-bin/cvsweb.cgi/src/winsup/doc/new-features.sgml=
.diff?cvsroot=3Dsrc&r1=3D1.64&r2=3D1.65

>  File system access via block devices works.  For instance
> +(note the trailing backslash!)
> +<screen>
> +bash$ cd /proc/sys/Device/HarddiskVolumeShadowCopy1/

That's a trailing slash, not backslash.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig41B940D5CB6676B2C8840FAA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNWqAoAAoJEKeha0olJ0NqyWUH/3wockLqWMFV91m3/HH3E/t+
03TD2C6a/r3JhXjdzTo72oVgfcBlu0OvqNQ0bi/SefxZB8awD2R3DULRWAji7Aej
aT/Ogz/5Lkjs5jGQgl7r1lwWwlpDMy9dN5uBdctJ0rVfsMZ1skk3gtvDr5eWMzDh
xxgu/yrtCwAt5flGvoeLWNVChzZinOOI4DyW62EoQ4fXn+a8u0BGW+Oqgc4fU+tl
EZ8jtSNdTPJAkktwLInOTwKwodbQZmId8hYVWIrdtJFBS9kAK6GFRHXS6FrVQZ6H
O+I/+0ov5NVJwzW//fppuITr/uvf9zX6Eb03rMKAETnzCKOR5OpILssSWZMOXLk=
=Smj7
-----END PGP SIGNATURE-----

--------------enig41B940D5CB6676B2C8840FAA--
