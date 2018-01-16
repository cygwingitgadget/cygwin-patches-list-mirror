Return-Path: <cygwin-patches-return-8996-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31972 invoked by alias); 16 Jan 2018 15:03:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 31951 invoked by uid 89); 16 Jan 2018 15:03:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-25.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jan 2018 15:03:45 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id D6AD9776C0	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 15:03:43 +0000 (UTC)
Received: from [10.10.120.72] (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 16CA35C3FA	for <cygwin-patches@cygwin.com>; Tue, 16 Jan 2018 15:03:41 +0000 (UTC)
Subject: Re: [PATCH] cygwin: add LFS_CFLAGS etc. to confstr/getconf
To: cygwin-patches@cygwin.com
References: <20180116031900.18732-1-yselkowi@redhat.com> <20180116092749.GB3009@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <9637bdd8-e68f-613b-8074-e711a62447ce@cygwin.com>
Date: Tue, 16 Jan 2018 15:03:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180116092749.GB3009@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="1pOFTBLWNOucTbMtmIzKr4EMHsVIyOSrf"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00004.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1pOFTBLWNOucTbMtmIzKr4EMHsVIyOSrf
Content-Type: multipart/mixed; boundary="pOkggriFoqBPvUKGMx3BCP8SanWTbOrW8";
 protected-headers="v1"
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Message-ID: <9637bdd8-e68f-613b-8074-e711a62447ce@cygwin.com>
Subject: Re: [PATCH] cygwin: add LFS_CFLAGS etc. to confstr/getconf
References: <20180116031900.18732-1-yselkowi@redhat.com>
 <20180116092749.GB3009@calimero.vinschen.de>
In-Reply-To: <20180116092749.GB3009@calimero.vinschen.de>


--pOkggriFoqBPvUKGMx3BCP8SanWTbOrW8
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
Content-length: 1252

On 2018-01-16 03:27, Corinna Vinschen wrote:
> On Jan 15 21:19, Yaakov Selkowitz wrote:
>> These are used, for instance, when cross-compiling the Linux kernel.
>>
>> Signed-off-by: Yaakov Selkowitz <yselkowi@redhat.com>
>> ---
>>  newlib/libc/include/sys/unistd.h | 4 ++++
>>  winsup/cygwin/sysconf.cc         | 6 +++++-
>>  winsup/utils/getconf.c           | 4 ++++
>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/newlib/libc/include/sys/unistd.h b/newlib/libc/include/sys/=
unistd.h
>> index f216fb95c..5386bd49d 100644
>> --- a/newlib/libc/include/sys/unistd.h
>> +++ b/newlib/libc/include/sys/unistd.h
>> @@ -582,6 +582,10 @@ int	unlinkat (int, const char *, int);
>>  #define _CS_POSIX_V7_THREADS_LDFLAGS          19
>>  #define _CS_V7_ENV                            20
>>  #define _CS_V6_ENV                            _CS_V7_ENV
>> +#define _CS_LFS_CFLAGS                        21
>> +#define _CS_LFS_LDFLAGS                       22
>> +#define _CS_LFS_LIBS                          23
>> +#define _CS_LFS_LINTFLAGS                     24
>=20
> Basically ok, but while at it, wouldn't it make sense to add the LFS64
> macros too?

No, because we do not provide off64_t or the *64 function declarations.

--=20
Yaakov


--pOkggriFoqBPvUKGMx3BCP8SanWTbOrW8--

--1pOFTBLWNOucTbMtmIzKr4EMHsVIyOSrf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 228

-----BEGIN PGP SIGNATURE-----

iHQEARECADQWIQRFYAu5jKh4qpenARn/IK+aZu4flAUCWl4USBYceXNlbGtvd2l0
ekBjeWd3aW4uY29tAAoJEP8gr5pm7h+U4LYAnjZySZ5n/6cSaNqL5OTKsQ1/c9QL
AJ43nDWp0coTf5GkTWSefMmLQAaGpg==
=ukyd
-----END PGP SIGNATURE-----

--1pOFTBLWNOucTbMtmIzKr4EMHsVIyOSrf--
