Return-Path: <cygwin-patches-return-8112-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 35391 invoked by alias); 3 Apr 2015 11:09:47 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 35378 invoked by uid 89); 3 Apr 2015 11:09:46 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 03 Apr 2015 11:09:45 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 69F05A80975; Fri,  3 Apr 2015 13:09:43 +0200 (CEST)
Date: Fri, 03 Apr 2015 11:09:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Add FAQ entry on how Cygwin counters install and update MITM attacks
Message-ID: <20150403110943.GN13285@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <E1YdjU7-0007zi-Bw@rmm6prod02.runbox.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="jQblWL/lOOo35ApW"
Content-Disposition: inline
In-Reply-To: <E1YdjU7-0007zi-Bw@rmm6prod02.runbox.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00013.txt.bz2


--jQblWL/lOOo35ApW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 471

On Apr  2 14:04, David A. Wheeler wrote:
> 	* faq-setup.xml: Document how Cygwin secures installation and
> 	update against man-in-the-middle (MITM) attacks.  Note that
> 	setup embeds a public key to check the signature of setup.ini,
> 	and that setup.ini includes SHA-512 cryptographic hashes.

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--jQblWL/lOOo35ApW
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVHnT3AAoJEPU2Bp2uRE+gIeQQAKDRcJB/tes+pzx4NmP5NW4L
uB9medBirQ3J5nWLOVgInm8VIJ8Z1UX+8jc9FRkS3Et2SklASTcBQFWtTHQvv1xv
HOtsys0bGrKJtZm1qjLHzVv4lKE1/TEqB8PUGPqag4FdF0mGgLJ7DNthfun6ShS5
mtukYSlMY7bZHu/YLpdT+fJzMVrib0YuO13Qiztj8EgGKTCg5lUfNL1DMSJik1MB
VfkVFDjZZC3GgssRJu+P+kIgAguy5z2UvSFth9ROlFyYEZzJFHs0VSf5FzGrc2Yw
KTS3ADEN4EYxU1J25HIrMGI5CHJA3sHsUtGWphDA/zux+aPNI+/Q9Oc2H2keQXkx
T/dCT3CXIaJkEeyl26jtF6plu67wCucAgf555PvZofmripJmHJGL6VIjQIcC322g
uzZDKDp2esz64VGxr56lc67dsffBWnA02z647QnXJAL0oYcSld8g8Vnovwq2mBjA
y7B/lDFQqORE3zIEoM9X7x9EeTmj1/i0UYcEnATCa/6DoDPKiKElI0OXEhcbL6c1
Pxy3QWVtFFEhp84bDuvEl9CCpFjHv8ZX/oSrAePhDxeafyV+o+Uy/ky2LtIUrl0Y
W3kjQU0xwID9+A948h2OIMKkoaRcE80WZ9nybeiT9RLRZHcmn7PYsqNKyW5ZMX30
bxHfHITvh02UkHyrBvDH
=S4FQ
-----END PGP SIGNATURE-----

--jQblWL/lOOo35ApW--
