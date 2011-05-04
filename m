Return-Path: <cygwin-patches-return-7301-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13265 invoked by alias); 4 May 2011 20:16:18 -0000
Received: (qmail 13248 invoked by uid 22791); 4 May 2011 20:16:16 -0000
X-SWARE-Spam-Status: No, hits=-6.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 04 May 2011 20:15:57 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p44KFvVx022037	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Wed, 4 May 2011 16:15:57 -0400
Received: from [10.3.113.2] ([10.3.113.2])	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p44KFupe020225	for <cygwin-patches@cygwin.com>; Wed, 4 May 2011 16:15:57 -0400
Message-ID: <4DC1B3FC.3010209@redhat.com>
Date: Wed, 04 May 2011 20:16:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] False positive from access("/proc/registry/...", F_OK)
References: <4DC1B292.70201@t-online.de>
In-Reply-To: <4DC1B292.70201@t-online.de>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigE785CF1079FC930BE6548EC8"
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
X-SW-Source: 2011-q2/txt/msg00067.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE785CF1079FC930BE6548EC8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 354

On 05/04/2011 02:09 PM, Christian Franke wrote:
> Done, tested and attached.
>=20
> Christian
>=20

>  	{
> +	  /* Key does not exist or open failed with EACCESS,
> +	     enumerate subkey and value names of parent key.  */

EACCES, not EACCESS.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigE785CF1079FC930BE6548EC8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNwbP8AAoJEKeha0olJ0NqM9oH/i8OtJSMbUwVU9iNZaUh+6NX
zGiR+mlffb71pGBAMQ6vbmH2MS9ox4ZRwmJeQ8VgtxZdKxviuaQbUfydh/aYdt7M
qit1gSBNEmD3nangJHXzLewR9CvEo64b8NGSW6pDkTCb28Igy0pSrR65T7x5npXn
JIek1AarQTUEWo0gAnSN2sG6EV5hFpc3uV1yVYdbahOBggX7RZvNgmKAA3trP6Md
yixfGbLfJKAq+rx4iZEu1Tt31oHjySL+EhqMJErelC4x3OQ87NIioQrLpX1Pz1xY
gmEexmUfmeh9W2YIvNBJ0XDA/k4Deg/FDx2Y6gFVRNWrKsMxHmhVJqx4HSPO2a4=
=V870
-----END PGP SIGNATURE-----

--------------enigE785CF1079FC930BE6548EC8--
