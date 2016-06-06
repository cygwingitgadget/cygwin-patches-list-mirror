Return-Path: <cygwin-patches-return-8570-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 80782 invoked by alias); 6 Jun 2016 09:54:06 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 80771 invoked by uid 89); 6 Jun 2016 09:54:05 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-96.3 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC autolearn=ham version=3.3.2 spammy=Hx-languages-length:783, HTo:U*cygwin-patches, H*Ad:U*cygwin-patches
X-HELO: calimero.vinschen.de
Received: from ipbcc0227e.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.34.126) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 Jun 2016 09:54:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id DE8F4A80396; Mon,  6 Jun 2016 11:54:01 +0200 (CEST)
Date: Mon, 06 Jun 2016 09:54:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Fix 'make distclean'
Message-ID: <20160606095401.GA30439@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <393c4fcd-4eeb-84cf-e330-e4c1ecfc3a9d@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <393c4fcd-4eeb-84cf-e330-e4c1ecfc3a9d@cornell.edu>
User-Agent: Mutt/1.6.1 (2016-04-27)
X-SW-Source: 2016-q2/txt/msg00045.txt.bz2


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 803

On Jun  5 13:15, Ken Brown wrote:
> Sometimes when a build of Cygwin fails, there will be a message suggesting
> running 'make distclean'.  But this fails to clean the winsup/cygwin
> subdirectory, and the build still fails.
>=20
> On the other hand, 'make clean' in winsup/cygwin removes two source files,
> which have to be restored before one can rebuild.
>=20
> The attached patch fixes both problems.

Applied with a minor change (adding "*clean" targets to .PHONY).

I also added a patch which removes the tlsoffsets file if regenerating
it failed.  This fixes an annoying build problem if gentls_offsets fails
to compile cygtls.h.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--azLHFNyN32YCQGCU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXVUg5AAoJEPU2Bp2uRE+gHJkQAIZ/n2al3OTWZYwoKf0JkVAH
RsmcxzspATjZ9GS+kLUqSgvdl3weprQ8w8U5RmVdnXMJKHSekEykdYytiVp3wr5g
2/Jj6v98/2fQuz5N+kzOV18dynTCXrHRyvpDMpMKFRkOkI5SQ8/cIxRO0c9LV4Hf
puPv7OyNAyfBkgNJopvOGzIY9iqaRrcmbuENJMU3GTAQnoaydc4CNM38y0sVaO5c
d5RNoHUcIiZEYdUgMSTv9JuACCFC/FmC19LAEvF1FjZzaUCaZx9qzGrbn75qFvIW
jaz5l3a417FFDXx9gVogtHQDq9Beq138R3qTZ5fyuwvcTIkc9cCNeqWJZz+aooHL
inDLIASnXCy65GneYU4vOKuiIUTj2QeizJ/Es7Ra9h7v7nYlyg6fcKRMhqQxYgAt
zZ1kWXYqPIHofaGkN48l9UyQSSKOnaW5NgTk8dFBIr2lBUuZt6KSPOpWdv/5FAto
ieiIdG4twogeJD4SX/5iI4ckdCLhbEBTx+u3lDfDt49/r9C2y/GJCCEoag6MM942
VarB3O2bzYHYlevo9509avQ1Nzxzn8Ob3vecRNys5Iv9FTYHMbrxOTxnn/8F/p/D
tUYfPBvWT2Rx3hH9ZjGbaojiwBGTepLOn+LLgRXGL3Q3Pex1BOucu0f74sCtyamU
da+C+CDydSRqKO+9ZW+O
=YBkw
-----END PGP SIGNATURE-----

--azLHFNyN32YCQGCU--
