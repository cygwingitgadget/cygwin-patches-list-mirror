Return-Path: <cygwin-patches-return-8171-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 50622 invoked by alias); 16 Jun 2015 09:35:32 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 50610 invoked by uid 89); 16 Jun 2015 09:35:31 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 16 Jun 2015 09:35:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A933BA807DA; Tue, 16 Jun 2015 11:35:27 +0200 (CEST)
Date: Tue, 16 Jun 2015 09:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/8] winsup/doc: Some preparatory XML fixes
Message-ID: <20150616093527.GB31537@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-4-git-send-email-jon.turney@dronecode.org.uk> <20150615170445.GC26901@calimero.vinschen.de> <557FEAB9.5040404@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="CMEQapY8OuP5ao1l"
Content-Disposition: inline
In-Reply-To: <557FEAB9.5040404@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00072.txt.bz2


--CMEQapY8OuP5ao1l
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 772

On Jun 16 10:22, Jon TURNEY wrote:
> On 15/06/2015 18:04, Corinna Vinschen wrote:
> >On Jun 15 13:36, Jon TURNEY wrote:
> >>Remove the inconsistent .exe suffix in strace and umount usage lines.
> >>
> >>Consistently refer to cross-references outside utils.xml as being in th=
e Cygwin
> >>User's Guide.  This helps to generate sensible looking references in ge=
nerated
> >>manpages.
> >
> >... but it generates a bit of clutter in the HTML user guide itself.
> >Any chance to add those *only* to the man pages?
>=20
> Ok, I'll look into how to do that.

Preprocessing via m4 or something like that, would be ok...


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--CMEQapY8OuP5ao1l
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVf+3fAAoJEPU2Bp2uRE+gyoMQAJAgYM6bIuZB5pGdYHlv4jKe
2Np4NDe4ut/K2CXVyt3HHjVgnOMvYOaoUUCOUt3oyLu11p78YXzlc3DbkUIovC1y
sAL6371cWWcUHQ6UBKPXysLeGtfihBmwj56kmIvPoOK152f5hLGusbF/yeddMwED
LXSowAoN1ZQV3l3ZKMmZ+vKQSJlG1cEBtDh9iVWG/5aTQLDkLR5/s39TBkeEFqA8
EyvjEHqUd5nKi9V9KFf2r0gh3gqKI70PhLbpHiD72s1u57kmrLQRvaygYtwiiykZ
BfE2bhnclpWboP2Bklk3dEIDZpas5ih1OYOItZvH8dvJOylBJCisozzmzi/yfu5C
12uJhwasZ/1wiubguFEad5h/xRRQqJr+uqsGYFrsYNafioIWLxpe7qTkRMWv2JoC
x0JduUrpyyigCo2vAHUyZCDTRysHPQZgwm6l8UKvqDt9mx+Lag05GKCBQTLv2h6E
0sTTnJFeQgvjM3ZNtbtyHUh0lXynNhIT2ob3yw40w+ltY+qV+8WmLqhT43wP0io8
e6CNakzDKQzJ/bpFRdYmZdE37ljD72uNJ9lsTmJVCDj5NX6OT7/flg7+J/AyxvPp
zMvTze+40EWI/z5reWXIJJWZlZwR602cR3lvtnx2umChVyI6WF7Pazpyajcwr4kk
C/s06CtKWWonBC1GVU35
=dhQs
-----END PGP SIGNATURE-----

--CMEQapY8OuP5ao1l--
