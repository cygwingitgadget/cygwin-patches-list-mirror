Return-Path: <cygwin-patches-return-8163-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 70434 invoked by alias); 15 Jun 2015 17:04:48 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 70420 invoked by uid 89); 15 Jun 2015 17:04:48 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-4.7 required=5.0 tests=AWL,BAYES_05,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 15 Jun 2015 17:04:47 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 67C23A807CE; Mon, 15 Jun 2015 19:04:45 +0200 (CEST)
Date: Mon, 15 Jun 2015 17:04:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/8] winsup/doc: Some preparatory XML fixes
Message-ID: <20150615170445.GC26901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1434371793-3980-1-git-send-email-jon.turney@dronecode.org.uk> <1434371793-3980-4-git-send-email-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="7qSK/uQB79J36Y4o"
Content-Disposition: inline
In-Reply-To: <1434371793-3980-4-git-send-email-jon.turney@dronecode.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00064.txt.bz2


--7qSK/uQB79J36Y4o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 632

On Jun 15 13:36, Jon TURNEY wrote:
> Remove the inconsistent .exe suffix in strace and umount usage lines.
>=20
> Consistently refer to cross-references outside utils.xml as being in the =
Cygwin
> User's Guide.  This helps to generate sensible looking references in gene=
rated
> manpages.

... but it generates a bit of clutter in the HTML user guide itself.
Any chance to add those *only* to the man pages?

Removing the date and trailing whitespaces is approved.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--7qSK/uQB79J36Y4o
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVfwWtAAoJEPU2Bp2uRE+gqjMQAIxnl1DOX5tjiWeGSKUkTh/B
Al5yFd5Mn5MK/YUj0tWOkVByn8p4NtzxD75TxhFWm7K2lLBNNMnvM76xSsyqBfgC
Wi7yVgqZMyDVvbAzq8rTe0fDe61uQoSyIYgrsS8jmJzRQ3xX+3HKxr4iRimqAT7J
Tx2mzGsUTmLqJSzgTPp9rMzmtYnoMSjws6xOSBYEcBnnSSsQAHwcSYm0cutK8w9+
8MsgOYKWTn6SZ1eD+SmgSSKptZywb0X3dyhDQVhByWY8FWJsVnEhIMGypGdbnI8J
JWna10XT7H5lokJEeB6sHcbs7ZVnKmRFWXLf/Ps8Uq1feHImPRsDJm4R491YNVS5
pw0b57HTgTsZgOEpqIMRZ9VJ0oZyqT+vpo6o9lwU9lTtY75B1t/4EIHa3OvG25jP
EQTXfpaxg7/N0scVV34LI1U/9IHgRoeOcS53p+xzWFo5LqfaNq/tmwcwpCXoC4c+
rcUTaTz7p/LQv8pF5R1sYRwtM+pTPRpysAn5ez/fN5daXX/8X9R92aRwPZ2MY+H8
ECw+fRlcZtsLCNy9N0RkCwdHPFH3AwiEu87XWq4nMYUboija/mfS3gkR5MZNGAcX
5GsD8lj1KczchIiLAcM+KHVAJZIQrk4htlRCd3XoPO6OER64S5N8hLUSmLuYrVog
XH7A8yXtb53uYSz+sC+d
=yIK/
-----END PGP SIGNATURE-----

--7qSK/uQB79J36Y4o--
