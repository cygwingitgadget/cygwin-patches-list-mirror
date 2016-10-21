Return-Path: <cygwin-patches-return-8643-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 131062 invoked by alias); 21 Oct 2016 11:39:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 131003 invoked by uid 89); 21 Oct 2016 11:39:53 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-101.5 required=5.0 tests=AWL,BAYES_00,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches, H*F:D*cygwin.com
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Fri, 21 Oct 2016 11:39:51 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 994D371E3F90D	for <cygwin-patches@cygwin.com>; Fri, 21 Oct 2016 13:39:47 +0200 (CEST)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 91D995E0357	for <cygwin-patches@cygwin.com>; Fri, 21 Oct 2016 13:39:46 +0200 (CEST)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8280EA8041C; Fri, 21 Oct 2016 13:39:46 +0200 (CEST)
Date: Fri, 21 Oct 2016 11:39:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Add _PC_CASE_INSENSITIVE flag to pathconf
Message-ID: <20161021113946.GA4875@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <82692078-877f-0acf-01f7-17c5a886d64e@cornell.edu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="k1lZvvs/B4yU6o8G"
Content-Disposition: inline
In-Reply-To: <82692078-877f-0acf-01f7-17c5a886d64e@cornell.edu>
User-Agent: Mutt/1.7.1 (2016-10-04)
X-SW-Source: 2016-q4/txt/msg00001.txt.bz2


--k1lZvvs/B4yU6o8G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1319

On Oct 20 15:54, Ken Brown wrote:
> Patch attached.
>=20
> I tested it by running getconf.exe, and also as follows:
>=20
> $ cat case_sens_test.c
> #include <unistd.h>
> #include <stdio.h>
>=20
> void
> test (const char *path)
> {
>   int ret =3D pathconf (path, _PC_CASE_INSENSITIVE);
>   printf ("pathconf (\"%s\", _PC_CASE_INSENSITIVE) returns %d\n", path,
> ret);
>   if (ret =3D=3D -1)
>     perror ("  pathconf");
> }
>=20
> int
> main ()
> {
>   test ("/tmp");
>   test ("/tmp/a");
>   test ("/cygdrive/c/cygwin");
>   test ("/");
>   test (".");
> }
>=20
> $ gcc case_sens_test.c
>=20
> $ ./a
> pathconf ("/tmp", _PC_CASE_INSENSITIVE) returns 0
> pathconf ("/tmp/a", _PC_CASE_INSENSITIVE) returns -1
>   pathconf: No such file or directory
> pathconf ("/cygdrive/c/cygwin", _PC_CASE_INSENSITIVE) returns 1
> pathconf ("/", _PC_CASE_INSENSITIVE) returns 0
> pathconf (".", _PC_CASE_INSENSITIVE) returns 0
>=20
> This test was done, obviously, on a system with the obcaseinsensitive
> registry key set to 0, and with /tmp/a non-existent.  I also tested with =
the
> registry key set to 1, with the expected results.
>=20
> Ken

Thanks Ken.  Patch applied.


Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--k1lZvvs/B4yU6o8G
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYCf6CAAoJEPU2Bp2uRE+gQq4QAIumnChPim+uNj1lAunm8MCL
0IQWwABMSS0yzpFERPo80L1XKSVkhfy8CI0lKIJE1PQZkDxj/kBEKwNMgmE3XG2I
J5KVyxKXMRCWfRec/bx8c6b9trWOqayOPkuee5V/31iVSk23tfEjXg5y7AW45w/i
t6ySVTFY/b9x4jFC7Epz77rrGsBVW0AyEHTzVNTcUMGI/qHEZa0zA/xzvRzL0ZBE
AQuFmMHnYR6kbOGAG0BeBmv2lJUUGciEWRc1+OUOqLGKCLKLVWkcg2QdWEAMzTmL
Va/cholOZ4FFQoOArxOpRyEuscp0lMPyiZMhtrMI4BhCrjuMZxD6kgTJyIV/XmNb
g1iC8kPxjhQda36hEqxUHUbPIMXNDQ0+IxfAmpc2zoD19/3xgGZ7tNmNXw5lCSAf
1e583QdpxB81gXmZWhJBq+WVimGatLaW84hjxuxRZmC+V8kT+1dQwfDmlhkOhy3q
TBUjERG1lNG60tb1KN65zeDZkAU81Yy+I/pRWenGFVUHNB4dH37zOyQmRQiGZCof
wxcGeiFbmQFXbMq42qqYK9JYXE+iG3pPuScUkVbZdA4Af2jp9phxNvyPprSN2LLe
CSRUZ9jE0QUc7C2qwW0pzW0+dKu2MQmUAsmRM24f8f1+5CSs9dZJFlM/tmDP1cBa
OuPKIWTqufTDanq9KGvb
=WnXn
-----END PGP SIGNATURE-----

--k1lZvvs/B4yU6o8G--
