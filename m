Return-Path: <cygwin-patches-return-9013-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32305 invoked by alias); 19 Jan 2018 19:26:58 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 32294 invoked by uid 89); 19 Jan 2018 19:26:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-0.9 required=5.0 tests=BAYES_00,KAM_LAZY_DOMAIN_SECURITY,SPF_HELO_PASS autolearn=no version=3.3.2 spammy=HTo:U*cygwin-patches
X-HELO: mx1.redhat.com
Received: from mx1.redhat.com (HELO mx1.redhat.com) (209.132.183.28) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 19 Jan 2018 19:26:56 +0000
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))	(No client certificate requested)	by mx1.redhat.com (Postfix) with ESMTPS id E6B34780E9	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 19:26:54 +0000 (UTC)
Received: from [10.10.120.72] (ovpn-120-72.rdu2.redhat.com [10.10.120.72])	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9ED1F64443	for <cygwin-patches@cygwin.com>; Fri, 19 Jan 2018 19:26:54 +0000 (UTC)
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
To: cygwin-patches@cygwin.com
References: <20180119055837.13016-1-yselkowi@redhat.com> <20180119190449.GM18814@calimero.vinschen.de>
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
Message-ID: <e4c12b5b-64bc-678a-5c97-f56208422986@cygwin.com>
Date: Fri, 19 Jan 2018 19:26:00 -0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180119190449.GM18814@calimero.vinschen.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="TUbYMlI4IWJulnzEcv9nR8joauyRrIkHX"
X-IsSubscribed: yes
X-SW-Source: 2018-q1/txt/msg00021.txt.bz2

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TUbYMlI4IWJulnzEcv9nR8joauyRrIkHX
Content-Type: multipart/mixed; boundary="2qf9InUX2Q0XALOtnmYBWx9B032PYrTjp";
 protected-headers="v1"
From: Yaakov Selkowitz <yselkowitz@cygwin.com>
To: cygwin-patches@cygwin.com
Message-ID: <e4c12b5b-64bc-678a-5c97-f56208422986@cygwin.com>
Subject: Re: [PATCH v2 0/3] catgets APIs, gencat tool
References: <20180119055837.13016-1-yselkowi@redhat.com>
 <20180119190449.GM18814@calimero.vinschen.de>
In-Reply-To: <20180119190449.GM18814@calimero.vinschen.de>


--2qf9InUX2Q0XALOtnmYBWx9B032PYrTjp
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: quoted-printable
Content-length: 243

On 2018-01-19 13:04, Corinna Vinschen wrote:
> Patch is fine, but I'd prefer if the whitespace problems are fixed
> first, even if they are from upstream:

Fixed.

> Are you going to provide a catgets deprecation package?

Yes.

--=20
Yaakov


--2qf9InUX2Q0XALOtnmYBWx9B032PYrTjp--

--TUbYMlI4IWJulnzEcv9nR8joauyRrIkHX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-length: 228

-----BEGIN PGP SIGNATURE-----

iHQEARECADQWIQRFYAu5jKh4qpenARn/IK+aZu4flAUCWmJGexYceXNlbGtvd2l0
ekBjeWd3aW4uY29tAAoJEP8gr5pm7h+UuZwAn0wQpp+nDK0qRQvR2yQqlBJh3ZUi
AJ0XCB/Nn7vorNVo9WJzZY53caju5g==
=xMRn
-----END PGP SIGNATURE-----

--TUbYMlI4IWJulnzEcv9nR8joauyRrIkHX--
