Return-Path: <cygwin-patches-return-7193-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25108 invoked by alias); 10 Feb 2011 17:37:55 -0000
Received: (qmail 24999 invoked by uid 22791); 10 Feb 2011 17:37:54 -0000
X-SWARE-Spam-Status: No, hits=-6.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 10 Feb 2011 17:37:47 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p1AHbj1W030772	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 12:37:46 -0500
Received: from [10.3.113.122] (ovpn-113-122.phx2.redhat.com [10.3.113.122])	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p1AHbj2M008614	for <cygwin-patches@cygwin.com>; Thu, 10 Feb 2011 12:37:45 -0500
Message-ID: <4D542269.3030604@redhat.com>
Date: Thu, 10 Feb 2011 17:37:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.7
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: provide __xpg_strerror_r
References: <4D4DAD40.3060904@redhat.com> <20110205202806.GA11118@ednor.casa.cgf.cx> <4D4DB682.3070601@redhat.com> <20110206095423.GA19356@calimero.vinschen.de> <4D532F6B.5080104@redhat.com> <20110210021547.GA26395@ednor.casa.cgf.cx> <20110210095054.GA2305@calimero.vinschen.de> <20110210095530.GC2305@calimero.vinschen.de>
In-Reply-To: <20110210095530.GC2305@calimero.vinschen.de>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enig3328394C76E73FFDA7B4C854"
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
X-SW-Source: 2011-q1/txt/msg00048.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3328394C76E73FFDA7B4C854
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 1014

On 02/10/2011 02:55 AM, Corinna Vinschen wrote:
> On Feb 10 10:50, Corinna Vinschen wrote:
>> On Feb  9 21:15, Christopher Faylor wrote:
>>> On Wed, Feb 09, 2011 at 05:20:59PM -0700, Eric Blake wrote:
>>>> +/* Newlib's <string.h> provides declarations for two strerror_r
>>>> +   variants, according to preprocessor feature macros.  It does the
>>>> +   right thing for GNU strerror_r, but its __xpg_strerror_r mishandles
>>>> +   a case of EINVAL when coupled with our strerror() override.*/
>>>> #if 0
>>>
>>> Can't we get rid of this now?
>>
>> I agree.  We should simply implement strerror_r by ourselves, even if
>> it's identical to newlib's strerror_r.  In the long run it's less
>> puzzeling to have all the strerror variants in one place.
>=20
> Oh, and: http://cygwin.com/ml/cygwin-patches/2011-q1/msg00031.html

Pushed, and squashed into minor version 236.  I've also updated
new-features.sgml.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig3328394C76E73FFDA7B4C854
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNVCJpAAoJEKeha0olJ0NqSdgH/1p5vuApG/DpHHDdsTylVa6Y
eTE9nIlObYczTzB11AYxC2HjsHgdiFdSBP/Ge6byVvzEnRVzRCByr/lwL6h1hbIM
RakHpTbETwYHj6rBbu8LgUTeUGRqf51Z6/eHqWPR7TEfgi46GYqpnWJvdathXTZs
vtXO/rnbyqO42sergiSZDYiZCThVXX6WmXHzbDzvf/wQZ7ixLAEfSZj0/XEQwh72
DhDZ0oYk67ybvLjjNvioRGM32XQVwUefB8Ebv5M+C3lJXUyGlBuZOCQT3lFOu0+g
jJXNZqBFaCYu5+FNWjeBMl7wFwz4zbngtiCpCgyx5Vbao+BfsDLHXvA+YnExaJU=
=YUwp
-----END PGP SIGNATURE-----

--------------enig3328394C76E73FFDA7B4C854--
