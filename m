Return-Path: <cygwin-patches-return-8189-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48212 invoked by alias); 17 Jun 2015 13:49:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48197 invoked by uid 89); 17 Jun 2015 13:49:40 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 17 Jun 2015 13:49:39 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EF651A807BF; Wed, 17 Jun 2015 15:49:36 +0200 (CEST)
Date: Wed, 17 Jun 2015 13:49:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/5] Generate cygwin-api manpages
Message-ID: <20150617134936.GK31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="MR0szId23pLNtImL"
Content-Disposition: inline
In-Reply-To: <1434544626-2516-1-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00090.txt.bz2


--MR0szId23pLNtImL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 923

Hi JOn,

On Jun 17 13:37, Jon TURNEY wrote:
> This patch set changes the DocBook source XML for the Cygwin API referenc=
e to=20
> use refentry elements, and also generates man pages from that.
>=20
> Again, note that after this, the chunked html now has a page for each fun=
ction,=20
> rather than one containing all functions.

Patchset approved, basically, except...

The next cygwin.cygport file will explicitely exclude the man pages
section 1.  But it won't exclude section 3, and I'm rather not hot
on excluding each newly generated API file explicitely.

Do you have an idea how far away we are from including the cygwin-doc
package into the cygwin package set?  I'm not planning a new release
very soon, so we can coordinate that without pressure.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--MR0szId23pLNtImL
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVgXrwAAoJEPU2Bp2uRE+gh4oP/3Uqle66Ezk3bmkYPnsfXWLq
06Z0HlzYrQ7DOk1F/p931PbQxhkIWrHVNGW7rlCDGGw5shCpmElD7b+QfhYQQpwM
glUzETxNhz/Pn7VO58YOS3ATOKXxFksNI4N6UtdtfOHF88CCiWbW1CZCAm5DAhJc
+B6mZIXNt5Gy4rLe43Tau8R/Bq/haL4IalzWdLGOnj2SKiFrKAnkixokT0e/iAV8
6iiz2z47w/iMXXvks+P2aRwFVS4wV36yAZaedX66vVWtzABH1xGFfsX1NN6ltg3F
m+MpGRf/CsIEyc8kO3h+zAeIivmuUoVYEyW2PWYAbMi0X3lwqJqqVyu0nCpDo1VH
EGTXTGRJ6i0w+8zYG2hVUe5UBfJcufdRF1sA5AolgOXgHJBOKdkrdMcNZLDmF18a
oMC4fYu43kpkxlvBdOs1sSDBJ1BgkFV1ue3tkAu1MVhNQxTzv/LNpYq5ctu5Meiz
euZoiAtqGDZK/rGvmHeCvSCJYoqZ2O9wGPZ97m2pyBWwvGMDsQB8x/kj8f0Cb4k5
sM5eWFGkCLvASotSuJ1XLroRDHV8wQvv4k9T9eykTa9Dx9czEGBZxvtSHzKH65fP
61vwxTBwmgY3/KEB1+koRcYrlWWCC7hOF/ayK+v6dfNu7hxZWD5JVqjjNrM6/uPA
l2+r63/YszNTFoy3KGjb
=F30G
-----END PGP SIGNATURE-----

--MR0szId23pLNtImL--
