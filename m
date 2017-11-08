Return-Path: <cygwin-patches-return-8911-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 71931 invoked by alias); 8 Nov 2017 12:35:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 71917 invoked by uid 89); 8 Nov 2017 12:35:04 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-125.4 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 08 Nov 2017 12:35:02 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 4B1EE7213B005	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2017 13:34:59 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id A08B35E01BE	for <cygwin-patches@cygwin.com>; Wed,  8 Nov 2017 13:34:58 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 8BB36A80579; Wed,  8 Nov 2017 13:34:58 +0100 (CET)
Date: Wed, 08 Nov 2017 12:35:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] pread() returns non-zero if read beyond EOF, because NtReadFile returns  EOF status but doesn't set information to 0. Need reset io status block  before NtReadFile is called, so that pread() will return 0 if read beyond EOF.
Message-ID: <20171108123458.GM18070@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1958376489.4046072.1510075992854.ref@mail.yahoo.com> <1958376489.4046072.1510075992854@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="utPK4TBebyzZxMrE"
Content-Disposition: inline
In-Reply-To: <1958376489.4046072.1510075992854@mail.yahoo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00041.txt.bz2


--utPK4TBebyzZxMrE
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 1296

On Nov  7 17:33, Xiaofeng Liu via cygwin-patches wrote:
> ---=C2=A0winsup/cygwin/fhandler_disk_file.cc |=C2=A0 =C2=A0 1 +=C2=A01 fi=
les changed, 1 insertions(+), 0 deletions(-)
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_disk=
_file.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ fhan=
dler_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGER of=
f =3D { QuadPart:offset };=C2=A0+=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, sizeof=
(io));=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!prw_handle && prw_open (false))=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 goto non_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D=
 NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,--=C2=A01.7.1

This is still completely broken, unfortunately.  I took a look, though,
and fixed this problem slightly differently.  Please have a look at
https://sourceware.org/git/?p=3Dnewlib-cygwin.git;a=3Dcommitdiff;h=3D46702f=
92ea49
I retained your authorship, of course.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--utPK4TBebyzZxMrE
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAvnyAAoJEPU2Bp2uRE+gWY0P/inPN9rw5YYjLUhiHurSYxbE
xKZNisZXCSpLjMo9yNY8A7U4fxC8F7QUT5y0xjD+9WbXEpgHtU+S82U0KcqCc7Uw
jj5Qk8lIkUgm0ks12+2R4zGLmE/P5PgFZXyEL2g7Akn44S+IeyCCau85U7MOmJJo
YBB7dO7QJaq4AwJ92g6CfKN1mN0aeI6RT/xxG0YFV9/4jN5v2hVXsGTJSkzrP977
o9zrVtYRXo1AFujMZf9Gu4os3ZvfHw6hduBgT+jaPZxrfqpC3nOTfbUSyQf8xytJ
WQhrIw0tBJGTZUjmAOwmclzEmfrZoFvpgWyureX38JNlZNwBQImImoTbItz8JC8H
iiodo5SGKrrjgnrVGUDApTZz2PDSNHIr9AAynNkIWM0wkAvweOCEockTaNnI6c8H
7NWxxfAbpEaCimJjOuiKI0n/iV9BbMu/zBlsbj2MA4VwcqUcN84T2boVsYKiB4zu
IzYsvNs29mpRvVgE87FfUyqtEqAX93doAbCU5rp39Sb9IXmv5DnAc8dqNJsc1T7k
tAh9JNA/aH4+NVyCPENnMZjDCQ/HlOcgIbnau4iR16tEIA9bma1T9HzLdx4T/c8e
U8jMpq6wb/vDDOAJoLAdALBsprTq+Y/UV7tajM+wbFnmBJiEAkMB/LIUTivZgYxv
wtNTDNaPvmvZPbVPRN3/
=bfHe
-----END PGP SIGNATURE-----

--utPK4TBebyzZxMrE--
