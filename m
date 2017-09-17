Return-Path: <cygwin-patches-return-8853-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 79776 invoked by alias); 13 Sep 2017 21:55:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 79760 invoked by uid 89); 13 Sep 2017 21:55:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.0 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*M:cygwin, HAuthentication-Results:cygwin.com, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 13 Sep 2017 21:55:23 +0000
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id 56D0FC058EA1	for <cygwin-patches@cygwin.com>; Wed, 13 Sep 2017 21:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mx1.redhat.com 56D0FC058EA1
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: ext-mx08.extmail.prod.ext.phx2.redhat.com; spf=none smtp.mailfrom=yselkowitz@cygwin.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.redhat.com 56D0FC058EA1
Received: from [10.10.120.87] (ovpn-120-87.rdu2.redhat.com [10.10.120.87])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DC915D744	for <cygwin-patches@cygwin.com>; Wed, 13 Sep 2017 21:55:21 +0000 (UTC)
Subject: Re: [PATCH] Fix possible segmentation fault in strnstr() on 64-bit systems
To: cygwin-patches@cygwin.com
References: <54549d65d520d71e1d3038f2e8a1c2f8c0f1f70a.1505317436.git.johannes.schindelin@gmx.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <79298da3-0c76-d60b-d385-5c30fe938826@cygwin.com>
Date: Sun, 17 Sep 2017 02:04:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <54549d65d520d71e1d3038f2e8a1c2f8c0f1f70a.1505317436.git.johannes.schindelin@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="VpBoDP5aVIL1tWVQMLOcspIF4liwDefWa"
X-IsSubscribed: yes
X-SW-Source: 2017-q3/txt/msg00055.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VpBoDP5aVIL1tWVQMLOcspIF4liwDefWa
Content-Type: multipart/mixed; boundary="BUKIGBqdUGkHAXHIhC01Nupdqsk3aXp9K";
 protected-headers="v1"
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Message-ID: <79298da3-0c76-d60b-d385-5c30fe938826@cygwin.com>
Subject: Re: [PATCH] Fix possible segmentation fault in strnstr() on 64-bit
 systems
References: <54549d65d520d71e1d3038f2e8a1c2f8c0f1f70a.1505317436.git.johannes.schindelin@gmx.de>
In-Reply-To: <54549d65d520d71e1d3038f2e8a1c2f8c0f1f70a.1505317436.git.johannes.schindelin@gmx.de>


--BUKIGBqdUGkHAXHIhC01Nupdqsk3aXp9K
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
Content-length: 965

On 2017-09-13 10:44, Johannes Schindelin wrote:
> As of f22054c94d (Modify strnstr.c., 2017-08-30), the strnstr()
> implementation was replaced by a version that segfaults (at least
> sometimes) on 64-bit systems.
>=20
> The reason: the new implementation uses memmem(), and the prototype of
> memmem() is missing because the _GNU_SOURCE constant is not defined
> before including <string.h>. As a consequence its return type defaults
> to int (and GCC spits out a warning).
>=20
> On 64-bit systems, the int data type is too small, though, to hold a
> full char *, hence the upper 32-bit are cut off and bad things happen
> due to a bogus pointer being used to access memory.
>=20
> Reported as https://github.com/Alexpux/MINGW-packages/issues/2879 in
> the MSYS2 project.

As this is part of newlib, the proper place for this is on the newlib
list.  Others have already proposed similar patches, so please feel free
to follow the discussion there.

--=20
Yaakov


--BUKIGBqdUGkHAXHIhC01Nupdqsk3aXp9K--

--VpBoDP5aVIL1tWVQMLOcspIF4liwDefWa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 228

-----BEGIN PGP SIGNATURE-----

iHQEARECADQWIQRFYAu5jKh4qpenARn/IK+aZu4flAUCWbmpSBYceXNlbGtvd2l0
ekBjeWd3aW4uY29tAAoJEP8gr5pm7h+UZtoAn0i4jSiR0tqeEwtYdgzCB3tQgVnB
AJ0W+rnJ5x3YAeVJJlbBH2ImJWoAuA==
=n8ZW
-----END PGP SIGNATURE-----

--VpBoDP5aVIL1tWVQMLOcspIF4liwDefWa--
