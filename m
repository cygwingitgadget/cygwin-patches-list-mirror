Return-Path: <cygwin-patches-return-9011-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 119829 invoked by alias); 19 Jan 2018 17:11:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 119813 invoked by uid 89); 19 Jan 2018 17:11:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*Ad:U*yselkowitz, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 17:11:30 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 12BD72F7C43	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 17:11:29 +0000 (UTC)
Received: from [10.10.120.72] (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id BC4C35DC1E	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 17:11:28 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
To: cygwin-patches@cygwin.com
References: <20180119055837.13016-1-yselkowi@redhat.com> <20180119101959.GI18814@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <d27ca185-57bd-f717-de84-b1b1e4dd3264@cygwin.com>
Date: Fri, 19 Jan 2018 17:11:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180119101959.GI18814@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="ay4zbQ4fD4SfeVxhmdmOufYnGYwp4fLSE"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00019.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ay4zbQ4fD4SfeVxhmdmOufYnGYwp4fLSE
Content-Type: multipart/mixed; boundary="YYf5k92AWfDrcBdPApXJpbXcuSyxoMW4J";
 protected-headers="v1"
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Message-ID: <d27ca185-57bd-f717-de84-b1b1e4dd3264@cygwin.com>
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
References: <20180119055837.13016-1-yselkowi@redhat.com>
 <20180119101959.GI18814@calimero.vinschen.de>
In-Reply-To: <20180119101959.GI18814@calimero.vinschen.de>


--YYf5k92AWfDrcBdPApXJpbXcuSyxoMW4J
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
Content-length: 564

On 2018-01-19 04:19, Corinna Vinschen wrote:
> On Jan 18 23:58, Yaakov Selkowitz wrote:
>> This adds FreeBSD-derived implementations to replace the glibc-derived
>> standalone implementation shipped in the catgets package. An integrated
>> implementation avoids the need to remember to install libcatgets-devel a=
nd
>> modify the build to link with -lcatgets.
>=20
> Do you want this in 2.10?  Otherwise I'd wait with adding new features
> until after the release.

Yes, I would, and this is the last feature enhancement in my queue at
the moment.

--=20
Yaakov


--YYf5k92AWfDrcBdPApXJpbXcuSyxoMW4J--

--ay4zbQ4fD4SfeVxhmdmOufYnGYwp4fLSE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 228

-----BEGIN PGP SIGNATURE-----

iHQEARECADQWIQRFYAu5jKh4qpenARn/IK+aZu4flAUCWmImuhYceXNlbGtvd2l0
ekBjeWd3aW4uY29tAAoJEP8gr5pm7h+UfJMAnjHWKlwxkg0s7CXYZN6REOEKufRh
AJ9UL1oxSIRnRXiXrmyUr4DBsrqNvw==
=m7uz
-----END PGP SIGNATURE-----

--ay4zbQ4fD4SfeVxhmdmOufYnGYwp4fLSE--
