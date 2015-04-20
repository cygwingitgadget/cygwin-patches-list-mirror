Return-Path: <cygwin-patches-return-8129-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 51872 invoked by alias); 20 Apr 2015 09:22:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 51856 invoked by uid 89); 20 Apr 2015 09:22:08 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-5.4 required=5.0 tests=AWL,BAYES_00,KAM_LAZY_DOMAIN_SECURITY autolearn=no version=3.3.2
X-HELO: calimero.vinschen.de
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 20 Apr 2015 09:22:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id CA1D7A80951; Mon, 20 Apr 2015 11:22:04 +0200 (CEST)
Date: Mon, 20 Apr 2015 09:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix inconsistencies in docs regarding fstab and executable file detection
Message-ID: <20150420092204.GA12862@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <55326E6D.7010703@gmail.com> <5532CBBB.5010103@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <5532CBBB.5010103@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SW-Source: 2015-q2/txt/msg00030.txt.bz2


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 584

On Apr 18 23:25, David Macek wrote:
> The inline list of mount options seemed redundant, so the paragraph now p=
oints
> to the list below it.
>=20
> List of executable extensions updated according to fhandler_disk_file.cc.=
 List
> of executable magic numbers updated according to path.h (has_exec_chars).
>=20
> 	* pathnames.xml: Fix inconsistencies in docs regarding fstab and
> 	executable file detection

Applied.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVNMU8AAoJEPU2Bp2uRE+g/6sP/1GMgBnj7jcfveN7fwcRu+V6
9JSbgulahNiZATgJe2b8ZPRFcTqKKk4omX9TYDxPIVxdFl0zcFGsLQMI1Xk9Bmmt
bMs0zQTvUnhDcd+x2+1BbOTKgycOqQXrQz1PqEjBxdn7jI5X2i4WlqN3sntOrCU7
qgBER1Y96dB1EKwxRWMNahFz4C9m51Y/3hJOMu5qAIl50EUZjziiBishzt/ox/oJ
FXJNSIFp6/gRe5hZgmfZWXkfwAzcMpwHJ847kLQtYuGBXtpCDdDPQ6nWGJhi5Mh2
x8UmQQKqXLjpGXIjdGd53T+9pqqrzw/Gxutcb1OaIuSBDUZ9l0Og32LsnaGR0OpP
NX57JKt1QNzHnC8TarmOUqlusM7R/qJeXrK5KtQ+JfJ5lTNbwyQFhFV3qsJa2yko
fqZicLy+XhuI9NXIMJMtIyhXzZSHq1+F25iPWEAzSIrB4sTtWietwXVZ8KkdC4yT
2wQKKL4KpwZwc/LYSfo3hSUmOrq9+YyEk1pnW5SvFWH8sfv1G/jYiUItCeblyKhX
YQEJlYJgliz4oJW3x9xPxu3xRtfBge2NHPPDbQKvFsxh5qA19Pm+Mt9xPMLCgAUv
/wTIBO+qY0EkIYxkbGC2OidvOViVug8R5ksRov/l/AjjO+qJpIgTm4IVi7lm1FdU
fl8tsy3WYOzE2oRijQiL
=nm5k
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
