Return-Path: <cygwin-patches-return-7404-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23486 invoked by alias); 25 May 2011 18:47:50 -0000
Received: (qmail 23475 invoked by uid 22791); 25 May 2011 18:47:50 -0000
X-SWARE-Spam-Status: No, hits=-6.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 25 May 2011 18:47:35 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4PIlZ2U010186	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Wed, 25 May 2011 14:47:35 -0400
Received: from [10.3.113.108] (ovpn-113-108.phx2.redhat.com [10.3.113.108])	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id p4PIlYeT009939	for <cygwin-patches@cygwin.com>; Wed, 25 May 2011 14:47:34 -0400
Message-ID: <4DDD4EC6.2000401@redhat.com>
Date: Wed, 25 May 2011 18:47:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fix perror POSIX compliance
References: <4DDAEDA4.9030005@redhat.com> <20110524100916.GA5509@calimero.vinschen.de>
In-Reply-To: <20110524100916.GA5509@calimero.vinschen.de>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig3105E9C59319E5D79CBB50AA"
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
X-SW-Source: 2011-q2/txt/msg00170.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3105E9C59319E5D79CBB50AA
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 643

On 05/24/2011 04:09 AM, Corinna Vinschen wrote:
> On May 23 17:28, Eric Blake wrote:
>> This depends on the newlib patch:
>> http://sourceware.org/ml/newlib/2011/msg00215.html
>>
>> In fact, if that patch goes in, then this one is required to avoid a
>> link failure; this one can probably go in first but makes no difference
>> to perror without the newlib patch.
>=20
> You can apply this together with the newlib patch.  But please
> make sure that you also tested the newlib-only implementation.

Yep, tested both, and now pushed.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig3105E9C59319E5D79CBB50AA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJN3U7GAAoJEKeha0olJ0NqGyIH/R7fzmOItxrkH8yZ6Yv67xU4
lFaQeAZ6MfXrM35gDg2qBKAuhfC1TD8vkSOXvNLqMiOcxUATjf7QvVSVAbjBcfdQ
9UtiN19RKHJd8wKdD4pwodLRTap0h74lS4YLL1KpjSWT5SwLmah0IvoWYqaAAqFu
lR8/e2y3gECp7pk1fRzjrm1KYueSoFC6jPevti1si0g3cKunIND7Ion2OxJ1CMS+
Fx9NJM51xC5xggGeqMjgQnPGn6jPGbKkOpFszaw69NhvAxMNIQ5n635HtXizvnrA
lsR+1IiymLL7RwtF/i5nn1Kngt7M7J8CZp5FJjO/TOk0R3rbc8G9ldbyFKhywI8=
=Locs
-----END PGP SIGNATURE-----

--------------enig3105E9C59319E5D79CBB50AA--
