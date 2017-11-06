Return-Path: <cygwin-patches-return-8901-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 43983 invoked by alias); 6 Nov 2017 20:23:42 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 43315 invoked by uid 89); 6 Nov 2017 20:23:42 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.7 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=H*R:U*cygwin-patches
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 Nov 2017 20:23:40 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 00093721E2830	for <cygwin-patches@cygwin.com>; Mon,  6 Nov 2017 21:23:35 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 453435E01BE	for <cygwin-patches@cygwin.com>; Mon,  6 Nov 2017 21:23:35 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 37A85A8045C; Mon,  6 Nov 2017 21:23:35 +0100 (CET)
Date: Mon, 06 Nov 2017 20:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: PATCH: pread() return non-zero if read beyond end of file
Message-ID: <20171106202335.GI18070@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1363864083.3348449.1509996042945.ref@mail.yahoo.com> <1363864083.3348449.1509996042945@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="nhYGnrYv1PEJ5gA2"
Content-Disposition: inline
In-Reply-To: <1363864083.3348449.1509996042945@mail.yahoo.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00031.txt.bz2


--nhYGnrYv1PEJ5gA2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2194

Hi,

On Nov  6 19:20, Xiaofeng Liu via cygwin-patches wrote:
> pread() return 0 if read beyond end of file in linux, but not zero in cyg=
win.=C2=A0
> I have a small code to show the problem:
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <errno.h>
>=20
> int main()
> {
>   const char* file =3D "/home/xliu/work/exome/a.bam";
>   struct stat st;
>   stat(file, &st);
>   char buf[65536];
>   int fd =3D open(file, O_RDONLY);
>   int ret =3D pread(fd, buf, sizeof buf, st.st_size);
>   fprintf(stderr, "filesize %ld, after eof pread() return =3D %d, errno =
=3D %d\n", st.st_size, ret, errno);
>   lseek(fd, st.st_size, SEEK_SET);
>   ret =3D read(fd, buf, sizeof buf);
>   fprintf(stderr, "filesize %ld, after eof read() return =3D %d, errno =
=3D %d\n", st.st_size, ret, errno);
> }
> $ ./a.exe
> filesize 6126093048, after eof pread() return =3D 3, errno =3D 0
> filesize 6126093048, after eof read() return =3D 0, errno =3D 0
> The issue is that NtReadFile() return EOF status, but doesn't set io.info=
rmation to 0. As a result, the current pread() implementation could return =
an arbitrary number in the stack.=C2=A0The fix is a one line fix: reset io =
status block.=C2=A0
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_disk=
_file.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ fhan=
dler_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGER of=
f =3D { QuadPart:offset };
> +=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, sizeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!prw_handle && prw_open (false))=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto non=
_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D NtReadFile (prw_handle, NULL,=
 NULL, NULL, &io, buf, count,

your mailer screwed up the patch and so it can't apply.  Can you please
send it as an attachment?

Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--nhYGnrYv1PEJ5gA2
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAMTHAAoJEPU2Bp2uRE+gxDIP/3OI2RPBApAGRouM9BSpJ6Mw
3vdkD9m0YJpYGTMWT5fpSY+BNeWIhtet/EtCDgg9fmT04umm+pcSteevTv9U3kO3
oagvaDk/sNQ/mPKoJZQDTE0j/QniiTXYROHmCHwt2h//wKaOv+TaKlepZmQ/C7Sp
+5B5jtW5Xkt473meS+g8F1FLnG8l2UUH3BI7IJwTNeMOaKFFbcv7ZMDdDJjYVVvz
9xYFLubwTNP1amhb4lfEKkJOECymGMPmxaUpICDpfeRajcWwkAqBq6ZtSnJCpjuQ
BB5nV3R7EOlcJGOy1MfY3fCUNBJVR3CUEXX4OezYYVNJ9/4ic3mRhkra0KLgAaMY
CJViSnGMmJ4WqPBH+s16qEn/Z/MrY0XWCgmsYxisVeoQqML7ZYInVcNWWrKBR6pV
+A82r53YBj8fozcEz2eZ+ymoRdQwTNjIcnwm9GObvvnVmfIGAWcSp9xhIKJkhJ6Y
PvSQL7IA4t4pNoLpWJ9dqLI7mai/VSU4UGO2qt9vYr4VaKCYrI7QutLR868EbF2M
itx5hJqXHS0xQ5W/bZdhNEHJrbh4YQ+3O+QTeB5yEEtMmUnCf/64q6F2CMCvJqeT
YrrYoBY58OllY1jimVwb2u0L58dhXjePiDjcfe1+gZJpzG90rmS+5avPxJboc1Xt
x7TcCT9E6lIDtGNhqF91
=Wa8+
-----END PGP SIGNATURE-----

--nhYGnrYv1PEJ5gA2--
