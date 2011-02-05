Return-Path: <cygwin-patches-return-7164-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2721 invoked by alias); 5 Feb 2011 20:45:53 -0000
Received: (qmail 2711 invoked by uid 22791); 5 Feb 2011 20:45:53 -0000
X-SWARE-Spam-Status: No, hits=-6.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Sat, 05 Feb 2011 20:45:46 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p15Kjj9C019248	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Sat, 5 Feb 2011 15:45:45 -0500
Received: from [10.3.113.43] (ovpn-113-43.phx2.redhat.com [10.3.113.43])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p15Kjitl011712	for <cygwin-patches@cygwin.com>; Sat, 5 Feb 2011 15:45:45 -0500
Message-ID: <4D4DB682.3070601@redhat.com>
Date: Sat, 05 Feb 2011 20:45:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx>
In-Reply-To: <20110205202806.GA11118@ednor.casa.cgf.cx>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigB4F79D99B7C32450B1934EBC"
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
X-SW-Source: 2011-q1/txt/msg00019.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB4F79D99B7C32450B1934EBC
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1087

On 02/05/2011 01:28 PM, Christopher Faylor wrote:
> On Sat, Feb 05, 2011 at 01:04:16PM -0700, Eric Blake wrote:
>> Our strerror_r is lousy (it doesn't even match glibc's behavior); see my
>> request to the newlib list.
>=20
> We really should just implement strerror_r in errno.cc.  It doesn't make
> sense to have two different implementations

You mean, implement the POSIX interface for strerror_r in errno.cc, and
ditch glibc compatibility?  But, backwards compatibility demands that we
have two interfaces - the glibc one that returns char* for satisfying
the link demands of existing applications, and the POSIX one that
returns int, so we really are stuck with providing two forms of
strerror_r if we intend to comply with POSIX.

We already provide our own strerror() (it provides a better experience
for out-of-range values that the newlib interface), but we're currently
using the newlib strerror_r() (in spite of its truncation flaw).

How should I rework this patch?

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigB4F79D99B7C32450B1934EBC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNTbb4AAoJEKeha0olJ0NqwX0H/RhdIF4oP2uhC2uln6KQE76Q
Y3H130O6zjX3ZiQebblUhQoB7dPhx06H1eEc6XpvZbipRAzZl5e3H+sbTS/UP/KJ
6j3XuBfVpMrDrOK1u/nbLpV3yU+t7Bezy8Tk8mLaW8rOFq1Tf0dpqMiZNnjcRmYB
OimQhvyTvb1ieL+sO/VDuQUZzUQKZl+DMLepu7KItiITkQGJ3uAJkX2lTeehN+Dy
jBJcFCjD9h+Z509lfbWus3ed2dHST+8rDyxSxK4TMO3Owpw7ZEykCgLC2DGXWCX8
3ncydm2gJz/OK/wpeRDMlyX+Sm4dhhV7ovOhzhQcQM54nCW8oEz1jBbKGsEuMPI=
=Evbe
-----END PGP SIGNATURE-----

--------------enigB4F79D99B7C32450B1934EBC--
