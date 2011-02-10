Return-Path: <cygwin-patches-return-7195-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13067 invoked by alias); 10 Feb 2011 20:23:08 -0000
Received: (qmail 13056 invoked by uid 22791); 10 Feb 2011 20:23:07 -0000
X-SWARE-Spam-Status: No, hits=-6.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 10 Feb 2011 20:23:03 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1AKN2RW024609	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 15:23:02 -0500
Received: from [10.3.113.122] (ovpn-113-122.phx2.redhat.com [10.3.113.122])	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p1AKN1J9024616	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 15:23:01 -0500
Message-ID: <4D544925.9000001@redhat.com>
Date: Thu, 10 Feb 2011 20:23:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx> <4D4DB682.3070601@redhat.com> <20110206095423.GA19356@calimero.vinschen.de> <4D532F6B.5080104@redhat.com> <20110210021547.GA26395@ednor.casa.cgf.cx> <20110210095054.GA2305@calimero.vinschen.de> <20110210095530.GC2305@calimero.vinschen.de> <4D542269.3030604@redhat.com> <20110210195852.GA32475@ednor.casa.cgf.cx>
In-Reply-To: <20110210195852.GA32475@ednor.casa.cgf.cx>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig27F8B8B393A88BCDF0AA295C"
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
X-SW-Source: 2011-q1/txt/msg00050.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig27F8B8B393A88BCDF0AA295C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1190

On 02/10/2011 12:58 PM, Christopher Faylor wrote:
> On Thu, Feb 10, 2011 at 10:37:45AM -0700, Eric Blake wrote:
>> Pushed, and squashed into minor version 236.  I've also updated
>> new-features.sgml.
>=20
> Thanks Eric.

Shoot - I pushed too early; I'm pushing this follow-up patch to fix the
temporary build breakage that I introduced (now that strerror_r defaults
to the POSIX signature, errno.cc has to take efforts to ensure that it
doesn't conflict when implementing the GNU signature).

diff --git a/winsup/cygwin/errno.cc b/winsup/cygwin/errno.cc
index 33a1038..8ee2a75 100644
--- a/winsup/cygwin/errno.cc
+++ b/winsup/cygwin/errno.cc
@@ -12,12 +12,14 @@ details. */
 #define _sys_nerr FOO_sys_nerr
 #define sys_nerr FOOsys_nerr
 #define _sys_errlist FOO_sys_errlist
+#define strerror_r FOO_strerror_r
 #include "winsup.h"
 #include "cygtls.h"
 #include "ntdll.h"
 #undef _sys_nerr
 #undef sys_nerr
 #undef _sys_errlist
+#undef strerror_r

 /* Table to map Windows error codes to Errno values.  */
 /* FIXME: Doing things this way is a little slow.  It's trivial to change


--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig27F8B8B393A88BCDF0AA295C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNVEklAAoJEKeha0olJ0Nq7sUH/101kNWk9F+S0DREy1/DP2Ks
p0CBtqUCEwiYb61djd1bzwAoqaVwJ8zvAwC4cDu8SSZH6F8dzBvC7upwYYvFoHzj
Z1bnM6+TuC0ZaBo1QbhWB2i0/f4j+xgriGq7YdP3FSqQB7dckhCacwd3FmjgxxbF
Gqem1XKb6A/Xemmr0w8YkSoSNWlgybp+RmvrBviD81Pm6bOJT6MrFG+YJcC1VBWv
UODip13Bnw0+3azOusyXcQwrpolui5mDwaaeFdexX3MHtNQGLgSUAF8Gg2aJctpe
a7a8h0cP1U1Q5zu5vVqMpCwxyaJwlZ/8uQMSzGrdhX92/J/N055wNiuafTQ09RE=
=fBAT
-----END PGP SIGNATURE-----

--------------enig27F8B8B393A88BCDF0AA295C--
