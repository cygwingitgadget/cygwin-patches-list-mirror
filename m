Return-Path: <cygwin-patches-return-8390-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 61253 invoked by alias); 11 Mar 2016 10:11:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 60324 invoked by uid 89); 11 Mar 2016 10:11:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-93.9 required=5.0 tests=BAYES_50,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_PBL,RDNS_DYNAMIC,USER_IN_WHITELIST autolearn=no version=3.3.2 spammy=DOT, Geisert, geisert, user's
X-HELO: calimero.vinschen.de
Received: from ipbcc0d020.dynamic.kabel-deutschland.de (HELO calimero.vinschen.de) (188.192.208.32) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 11 Mar 2016 10:11:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id EFF2DA805E5; Fri, 11 Mar 2016 11:11:10 +0100 (CET)
Date: Fri, 11 Mar 2016 10:11:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Documentation covering profiling Cygwin programs.
Message-ID: <20160311101110.GB3666@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <56E27CAE.20609@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <56E27CAE.20609@maxrnd.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SW-Source: 2016-q1/txt/msg00096.txt.bz2


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 565

On Mar 11 00:07, Mark Geisert wrote:
> This patch set updates the Cygwin User's Guide to say something about pro=
filing.
>=20
> Existing winsup/doc files programming.xml and setup-env.xml are updated.
> A new winsup/doc file gprof.xml is added.
>=20
> I'd appreciate any comments y'all may have on formatting and/or content.
> Thanks much,

Only one comment: This looks really neat.  Patch applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW4pm+AAoJEPU2Bp2uRE+gVKEP/A6ukdwZEivnJgJDRQuNa7Yn
UhQumyVyGi3XcftrXhdroLJXmBFrGAGGCIZSph2b+gdz3xJvZmoqE6K6Qnlfx3fz
CHeDspcGcBldAQhBmnRH3KWbXp/DhIxvaRazRFtYyq1JO9kMWVsssL15uxt1huH4
54AUrYQq62FOBB+6BQjmNDw/bvZ/rCCszk6dYVGeOS0t9GYdDB+qyuztA3cPFj0R
j7gP7uq0rfwQtt24cpmKCAdIIT7e4h0j0NvEax6EuCnxvTm7LYYMMruaLU7eKA/8
wAtdVsee4V9h2ZxU/sm/O8HQ1E99zQXn1IPQQ65xGvabmrj9G4CpeeJ0XiDSjHvb
5C7fl8+eMpAzmt8So44ttxAwmVip2+bR7/Sopp2HkLUDTMSk5m499di0SfL1Y5Og
ha/a0j1soMUZ2kjC/yo2H4S8cKkamwQW95eTpfnwsoE3D4xN2zFIolSIKSkuMnEx
Pl3RyHjg4axaa4rw/L9eVnNWQPaGHUkYlI0l0def+36wqf+h4NrYaQuYzGJ6cXET
sHCKTOncDbhf0hNa2q9HziO6sdMUsZ4SqrQaRD6xdTBtMEx4dGAO+b94fwO4kOFg
Pib5D+bEVNMBWdy8S5LpnKoVH5pNL6MeQBWA7FjKYzmEBfniveWdj/x6zrmeyhWf
nzewDK+Cg9f1lEHQIIle
=S6IB
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
