Return-Path: <cygwin-patches-return-8904-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7070 invoked by alias); 7 Nov 2017 10:33:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 6994 invoked by uid 89); 7 Nov 2017 10:33:00 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.9 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=Hx-languages-length:1774, cygwinpatchescygwincom, H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 07 Nov 2017 10:32:58 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 3683F721E2830	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2017 11:32:54 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id ED8945E01E7	for <cygwin-patches@cygwin.com>; Tue,  7 Nov 2017 11:32:52 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D8818A803B6; Tue,  7 Nov 2017 11:32:52 +0100 (CET)
Date: Tue, 07 Nov 2017 10:33:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: pread() return non-zero if read beyond end of file
Message-ID: <20171107103252.GJ18070@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1363864083.3348449.1509996042945.ref@mail.yahoo.com> <1363864083.3348449.1509996042945@mail.yahoo.com> <20171106202335.GI18070@calimero.vinschen.de> <312490784.3476342.1510005286779@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Content-Disposition: inline
In-Reply-To: <312490784.3476342.1510005286779@mail.yahoo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00034.txt.bz2


--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3620

On Nov  6 21:54, Xiaofeng Liu via cygwin-patches wrote:
>  try again, after saving the diff in linux first.
> git diff=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0diff --git a/winsup/cygwin/fha=
ndler_disk_file.cc b/winsup/cygwin/fhandler_disk_file.cc=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0index bc8fead..525cb32 100644=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0--- a/winsup/cygwin/fhandler_disk_file.cc=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0+++ b/wins=
up/cygwin/fhandler_disk_file.cc=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0=C2=A0@@ -1525,6 +1525,7 @@ fhandler_disk_file::pread (=
void *buf, size_t count, off_t offset)=C2=A0 =C2=A0 =C2=A0 =C2=A0IO_STATUS_=
BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0LARGE_INTEGER off =3D { QuadPart:offset };=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0=C2=A0
> +=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, sizeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (!prw_handle && prw_open (false))=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 got=
o non_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0=
 =C2=A0 =C2=A0status =3D NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf=
, count,=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0

Didn't help.  Here's an idea:

`git commit' the patch with a nice log message and call

  git format-patch -1

Then send the generated patch file called 0001-something.patch with

  git send-email --to=3D"cygwin-patches@cygwin.com" 0001-*

That should work.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAYvUAAoJEPU2Bp2uRE+ge1cQAKWWIbFNMFdIGkKRx51d3q4R
yBj/aqcH6I3NR55I9L0m4jxSBsWQu9zxMXJHVcdc/zvBZDYfz7QcQckYWHBiGSq5
EaBuLYABMs1BckRovOiDSrkz69NdNNeF6GPO3zF7YCJilwx/sVxnsb7/zZKTfSpn
w2fGrhgoleZ1I2q4sKC2BDzO5NcywrqtO1EbpUczr7LkLIRIcS2xM4B/u5DUDbvv
Lapsim2/ZoLQZYJFUI0uLijUstQZrbq8uIacR3A2hPfQ+VyEoYyDKgtVCFgiOvqP
2k2hxWc3QAyAjJv/qYBGeL8DjQDG8ynLisQ8WAWyeW2f3yDrzAnVazruPfkdnfST
bxyDst+RHCuF9jHDLgvUJyeUu17iA80qxLVmKD/nLIFl9tyiobsUUNlUAf2tA44/
LG7NqRR8K/bhGlreoRN1KbUUAUHr+h2NZHYGe+UOsfUBmhCBORap3osWLOWDORKR
7789L0U4GslAzqyc3DWc1a58N1taBuPhJwwHWCmUx5vPAhQN5KUtFIOtut1PlqtX
2FXF3rm14tHmfqt1ysTaTY++hlmnC1A46rG19bF0z4QjFcJUQtrcOfAkuqECk+e/
muUHlFbbOx+nL2c5bzblbZuKpOeyBSxYAEWkuQ2lo5Qtzui/hF2bgjtMnPMNcyV6
FCYXQLT7unn/NzCjHe5H
=9ZGd
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--
