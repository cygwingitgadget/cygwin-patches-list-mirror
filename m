Return-Path: <cygwin-patches-return-8464-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 46020 invoked by alias); 21 Mar 2016 19:48:02 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 45928 invoked by uid 89); 21 Mar 2016 19:48:01 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-6.6 required=5.0 tests=BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:546, H*R:D*cygwin.com, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 21 Mar 2016 19:48:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A987BA803F7; Mon, 21 Mar 2016 20:47:58 +0100 (CET)
Date: Mon, 21 Mar 2016 19:48:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/5] Add with-only-headers
Message-ID: <20160321194758.GH14892@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1458580546-14484-1-git-send-email-pefoley2@pefoley.com> <1458580546-14484-5-git-send-email-pefoley2@pefoley.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="vtJ+CqYNzKB4ukR4"
Content-Disposition: inline
In-Reply-To: <1458580546-14484-5-git-send-email-pefoley2@pefoley.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00170.txt.bz2


--vtJ+CqYNzKB4ukR4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 546

On Mar 21 13:15, Peter Foley wrote:
> When cross-compiling a toolchan targeting cygwin, building cygwin1.dll
> requires libstdc++v3 to be built.

Building cygwin1.dll doesn't require libstdc++-v3.  The Cygwin DLL is
never linked against it and never will be.  Only building the utils dir
requires libstdc++ and that would be fixed by not builing utils as in
your other patch, wouldn't it?


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--vtJ+CqYNzKB4ukR4
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW8E/uAAoJEPU2Bp2uRE+g9mYP/1aVVnnzZwB17H/ApD6a+9b0
7E313RHkz9lWjToTlOz7BsUHQFDr0mX42C5CnfzFhfkARs3X2Qxzht46nLrZCaKK
ccmDjdiSaJcnWUl5Nh0ws6a8G6jN9+LM5VZhwnEK7V5Kr3SZOwpyQSYhGWXnGOrQ
mqq6c7hEqG/o78KDMl3tCA6GS41EDv9+5za0oU7arliW1kzJZC9dAIG6GA8t2jB/
OkhlFpl0Z3aK70Q0VFz4HORevQClZl0+JFgD94/0PjP9e8F7ZriWW5TK68rWA05+
THu99PCrm/DXlBod7aEhjv3J68+P9RBgIytsACx8WinSqL4j4I1SMuM4zen+1lCb
iWGH7OymFRMLErR+NJYaVQRLTrCSyw8Mo6t1ruaZvKNoDjKH0RHM3zZ5znQqf/Y+
Wx0vMj0+fnrNk4l0HP5CaiRVsnBawQqcMLvk/qYGGfVM8Bt0sbm+bJ3/YxEZMwap
NhwfKBuJ3roblwp7bV/wnnhjzwUKce9/0WjhjO6lxGV10cL1I9AZAr1spd/uTUeg
KMHmhIw4yW7OzyYphTZEmf7V3Gcd0ewGFWxOz5uCLJHjGhmSfu780capA710TDn+
moUo/2Okdn3I5m7lmbY+yhJYMK/EHjd8JmhTqtkQCUdTf+oqxKSCEWLiZxxe/EcD
ouYySmZaBKz2Guv32uyq
=7pgd
-----END PGP SIGNATURE-----

--vtJ+CqYNzKB4ukR4--
