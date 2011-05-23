Return-Path: <cygwin-patches-return-7390-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5338 invoked by alias); 23 May 2011 20:46:04 -0000
Received: (qmail 5316 invoked by uid 22791); 23 May 2011 20:46:03 -0000
X-SWARE-Spam-Status: No, hits=-6.7 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,SPF_HELO_PASS,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 23 May 2011 20:45:44 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p4NKjivd023783	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 16:45:44 -0400
Received: from [10.3.113.142] (ovpn-113-142.phx2.redhat.com [10.3.113.142])	by int-mx12.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p4NKjhSS001867	for <cygwin-patches@cygwin.com>; Mon, 23 May 2011 16:45:44 -0400
Message-ID: <4DDAC777.5030205@redhat.com>
Date: Mon, 23 May 2011 20:46:00 -0000
From: Eric Blake <eblake@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc14 Lightning/1.0b3pre Mnenhy/0.8.3 Thunderbird/3.1.10
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: __xpg_strerror_r should not clobber strerror buffer
References: <4DD8664D.2000407@redhat.com> <20110522013514.GA16516@ednor.casa.cgf.cx>
In-Reply-To: <20110522013514.GA16516@ednor.casa.cgf.cx>
OpenPGP: url=http://people.redhat.com/eblake/eblake.gpg
Content-Type: multipart/signed; micalg=pgp-sha256; protocol="application/pgp-signature"; boundary="------------enigA7F75D2389BBD739B6AEA0D5"
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
X-SW-Source: 2011-q2/txt/msg00156.txt.bz2

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA7F75D2389BBD739B6AEA0D5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-length: 1992

On 05/21/2011 07:35 PM, Christopher Faylor wrote:
> On Sat, May 21, 2011 at 07:26:37PM -0600, Eric Blake wrote:
>> POSIX says that no other function in the standard should clobber the
>> strerror buffer.  Our strerror_r is a GNU extension, so it can get away
>> with clobbering the buffer (but if we wanted to fix it, we would have to
>> separate _my_tls.locals.strerror_buf into two different buffers).
>> perror() is still broken, but that needs to be fixed in newlib.  But
>> __xpg_strerror_r, which is our POSIX strerror_r variant, has to be fixed
>> in cygwin.
>>
>> Meanwhile, glibc just patched strerror this week to print negative
>> errnum as a negative 32-bit int, rather than as a positive unsigned
>> long; cygwin should do likewise.
>>
>> 2011-05-21  Eric Blake  <eblake@redhat.com>
>>
>> 	* errno.cc (strerror): Print unknown errno as int.
>> 	(__xpg_strerror_r): Likewise, and don't clobber strerror buffer.
>=20
> Looks good.  Please check in.

Pushed.

Just for the record, I'm having a problem self-building cygwin right
now, from what looks like mingw issues:

/home/eblake/src/winsup/utils/mingw gcc-4 -B./ -shared
-Wl,--image-base,0x6FBC0000 -Wl,--entry,_DllMainCRTStartup@12 mthr.o
mthr_init.o mingwthrd.def -Lmingwex -o mingwm10.dll
mingwex/libmingwex.a(strtodnrp.o): In function `strtod':
/home/eblake/src/build/i686-pc-cygwin/winsup/mingw/mingwex/../../../../../w=
insup/mingw/include/stdlib.h:315:
multiple definition of `_strtod'
...
/usr/lib/gcc/i686-pc-cygwin/4.3.4/../../../../i686-pc-cygwin/bin/ld:
warning: cannot find entry symbol _DllMainCRTStartup@12; defaulting to
6fbc1000
ertr000001.o:(.rdata+0x0): undefined reference to
`__pei386_runtime_relocator'
collect2: ld returned 1 exit status
make[3]: *** [mingwm10.dll] Error 1
make[3]: Leaving directory
`/home/eblake/src/build/i686-pc-cygwin/winsup/mingw'

How do we go about getting that resolved?

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enigA7F75D2389BBD739B6AEA0D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 619

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJN2sd3AAoJEKeha0olJ0NqcWgIAILGLUo0PMWH4L4bK2iVWeLR
WEL97NDjSSVwX9tiS5rPWsQUVorP3V7nTf/S3JxlkkR/MXH8EoaSpTVbaIj5Esqx
5ler0gWJ0z+86K1MrmyZX6D3Tt7Vrgh5kD2hRITW7hI0MAs/5VAJI0FPxLBqZSfx
H2K+FOW4NmHVs8eGhtkH2cEQZh3MlLNvgpNNjCPt/um5GEVcdrNWHT50abQxhSZo
SxluZy9poAyYr7SCe32QM+fImkEqhER0e5FakJ7tDBdE24et/veioRKCMc12bwc4
uaO+AGrjfzMaPe2odGw9meRCpFlM3ocBVBKjWe3eEpRFi0fxH29goLmr1DCfbZI=
=DAlu
-----END PGP SIGNATURE-----

--------------enigA7F75D2389BBD739B6AEA0D5--
