Return-Path: <cygwin-patches-return-7610-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3621 invoked by alias); 28 Feb 2012 15:01:07 -0000
Received: (qmail 3591 invoked by uid 22791); 28 Feb 2012 15:01:02 -0000
X-SWARE-Spam-Status: No, hits=-6.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 28 Feb 2012 15:00:48 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q1SF0lQo007043	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2012 10:00:48 -0500
Received: from [10.3.113.13] ([10.3.113.13])	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id q1SF0l0p005904	for <cygwin-patches@cygwin.com>; Tue, 28 Feb 2012 10:00:47 -0500
Message-ID: <4F4CEC1F.60302@redhat.com>
Date: Tue, 28 Feb 2012 15:01:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: fix tcgetsid return type
References: <4F4C10F0.3080306@redhat.com> <20120227235759.GA26689@ednor.casa.cgf.cx>
In-Reply-To: <20120227235759.GA26689@ednor.casa.cgf.cx>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigB5B5A70073954B439265E299"
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
X-SW-Source: 2012-q1/txt/msg00033.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB5B5A70073954B439265E299
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 668

On 02/27/2012 04:57 PM, Christopher Faylor wrote:
> On Mon, Feb 27, 2012 at 04:25:36PM -0700, Eric Blake wrote:
>> Detected by gnulib's unit tests.  POSIX requires tcgetsid to return
>> pid_t, not int.
>>
>> 2012-02-27  Eric Blake  <eblake@redhat.com>
>>
>> 	* include/sys/termios.h (tcgetsid): Fix return type.
>> 	* termios.cc (tcgetsid): Likewise.
>> 	* fhandler_termios.cc (fhandler_termios::tcgetsid): Likewise.
>> 	* fhandler.h (fhandler_base): Likewise.
>> 	* fhandler.cc (fhandler_base::tcgetsid): Likewise.
>=20
> Looks good.  Please check in.

Done.

--=20
Eric Blake   eblake@redhat.com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--------------enigB5B5A70073954B439265E299
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 620

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJPTOwfAAoJEKeha0olJ0NqED0H/iehrEyPwXloiwzLwzrJRcis
Hc9MWknV0ZKo+ZcIZ7ANsBoDzQOI0kGdPK0a6r86QB5W4L4OBXoaRqczf37bvGFY
2JvcU8/au0a+WXAmL908pi1gDIbQ6evgDUsL9xoSNOBoK1sVfONEb59MyhcMCol9
WXfHeNEHj284DgERyvxs/dDhy2TKOqmp/fmy1jSAEgMizVPa4lm4iqF8BlVUL1XY
wksLbdq95SrwQFS5fiNYHxDdS8X0ANfwiaHnPmiBqcKcmm5bqfHypq4baCzgfJW3
EOfpo76IsIdNJqOoLKOn90gj8uDnj4WsC4QcZvEOAYzUPn3V2tuXuN8sjKVDiUI=
=3YpJ
-----END PGP SIGNATURE-----

--------------enigB5B5A70073954B439265E299--
