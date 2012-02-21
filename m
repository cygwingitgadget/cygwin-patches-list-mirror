Return-Path: <cygwin-patches-return-7597-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30547 invoked by alias); 21 Feb 2012 23:04:30 -0000
Received: (qmail 30537 invoked by uid 22791); 21 Feb 2012 23:04:29 -0000
X-SWARE-Spam-Status: No, hits=-6.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 21 Feb 2012 23:03:55 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1LN3tcR004814	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Tue, 21 Feb 2012 18:03:55 -0500
Received: from [10.3.113.9] ([10.3.113.9])	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q1LN3sBX010047	for <cygwin-patches@cygwin.com>; Tue, 21 Feb 2012 18:03:55 -0500
Message-ID: <4F4422DA.6040306@redhat.com>
Date: Tue, 21 Feb 2012 23:04:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120209 Thunderbird/10.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add scandirat(3)
References: <1329864298.3540.2.camel@YAAKOV04>
In-Reply-To: <1329864298.3540.2.camel@YAAKOV04>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig129540D0E44DC56B5426BC29"
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
X-SW-Source: 2012-q1/txt/msg00020.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig129540D0E44DC56B5426BC29
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 573

On 02/21/2012 03:44 PM, Yaakov (Cygwin/X) wrote:
> scandirat(3) was added in glibc-2.15[1] and has supposedly been proposed
> for addition to POSIX.1[2].  Patch attached.

I haven't yet seen anyone propose it for POSIX, but it would indeed be a
welcome addition there.

Also it would be a welcome addition to have pathconfat(), although this
hasn't yet happened on the Linux side of things, let alone any POSIX
proposal.

At any rate, +1 for having this in cygwin.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enig129540D0E44DC56B5426BC29
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 620

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJPRCLaAAoJEKeha0olJ0NqD6oH/jtPFLA0S4Qyqn6EZJzZ4kKL
W2UrEuWd78R+S7hrPbLL6hnMz6FJI27hkbIZkWzzDKHx8KBVEShoPnx8YwonLFz3
Bf44WGRnFaCpbVxlGijNE4vqart57Vmw3R4ZHZ7Y62yQzXm9v97MBKBevACp5y/y
RtgTf58k9r80gGwjAdXME+amrecnED/oEtOAYWSzXSiPy5Vvwx8FqwLWoQlnBs8Z
pg3xMwjXvac5ucVTOaWMlYidnKUW2C8U8+DuA31RHzRx4gOGO/4A3k1Ddh1G7iwb
/tuyTPI0oUVKA3GMb3XUj60r/JhPu2POZ5bcKU+byUBPdOiCdCcXjRJFOcBsoUc=
=FYQ2
-----END PGP SIGNATURE-----

--------------enig129540D0E44DC56B5426BC29--
