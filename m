Return-Path: <cygwin-patches-return-9022-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32118 invoked by alias); 2 Feb 2018 22:10:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32106 invoked by uid 89); 2 Feb 2018 22:10:24 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=H*Ad:U*yselkowitz, HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 02 Feb 2018 22:10:24 +0000
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id EF053356CB	for <cygwin-patches@cygwin.com>; Fri,  2 Feb 2018 22:10:22 +0000 (UTC)
Received: from [10.10.120.142] (ovpn-120-142.rdu2.redhat.com [10.10.120.142])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9885B5C25F	for <cygwin-patches@cygwin.com>; Fri,  2 Feb 2018 22:10:22 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
To: cygwin-patches@cygwin.com
References: <20180119055837.13016-1-yselkowi@redhat.com> <20180119190449.GM18814@calimero.vinschen.de> <e4c12b5b-64bc-678a-5c97-f56208422986@cygwin.com>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <acea1de8-1006-eb85-e2ae-972f7e09ce22@cygwin.com>
Date: Fri, 02 Feb 2018 22:10:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <e4c12b5b-64bc-678a-5c97-f56208422986@cygwin.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="bNfOL3IL6EpoRpS2F0hefPokcoMO7TalX"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00030.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bNfOL3IL6EpoRpS2F0hefPokcoMO7TalX
Content-Type: multipart/mixed; boundary="aujOKHD0wNzLFXJUeCrrP537IV6c1zm6C";
 protected-headers="v1"
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Message-ID: <acea1de8-1006-eb85-e2ae-972f7e09ce22@cygwin.com>
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
References: <20180119055837.13016-1-yselkowi@redhat.com>
 <20180119190449.GM18814@calimero.vinschen.de>
 <e4c12b5b-64bc-678a-5c97-f56208422986@cygwin.com>
In-Reply-To: <e4c12b5b-64bc-678a-5c97-f56208422986@cygwin.com>


--aujOKHD0wNzLFXJUeCrrP537IV6c1zm6C
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
Content-length: 185

On 2018-01-19 13:26, Yaakov Selkowitz wrote:
> On 2018-01-19 13:04, Corinna Vinschen wrote:
>> Are you going to provide a catgets deprecation package?
>=20
> Yes.
 Done.

--=20
Yaakov


--aujOKHD0wNzLFXJUeCrrP537IV6c1zm6C--

--bNfOL3IL6EpoRpS2F0hefPokcoMO7TalX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 228

-----BEGIN PGP SIGNATURE-----

iHQEARECADQWIQRFYAu5jKh4qpenARn/IK+aZu4flAUCWnThzRYceXNlbGtvd2l0
ekBjeWd3aW4uY29tAAoJEP8gr5pm7h+UTjIAniMf5Zisq6iyKkEIAJQ9meCXgNfZ
AJ9MpK1fpcs9vDwZKFYCv8XiswzChg==
=eGzV
-----END PGP SIGNATURE-----

--bNfOL3IL6EpoRpS2F0hefPokcoMO7TalX--
