Return-Path: <cygwin-patches-return-8891-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 48774 invoked by alias); 2 Nov 2017 14:58:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 48756 invoked by uid 89); 2 Nov 2017 14:58:52 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-125.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_BRBL_LASTEXT,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS autolearn=ham version=3.3.2 spammy=bray
X-HELO: drew.franken.de
Received: from mail-n.franken.de (HELO drew.franken.de) (193.175.24.27) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 02 Nov 2017 14:58:50 +0000
Received: from aqua.hirmke.de (aquarius.franken.de [193.175.24.89])	(Authenticated sender: aquarius)	by mail-n.franken.de (Postfix) with ESMTPSA id 2049D721E2830	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 15:58:46 +0100 (CET)
Received: from calimero.vinschen.de (calimero.vinschen.de [192.168.129.6])	by aqua.hirmke.de (Postfix) with ESMTP id 5EA715E038E	for <cygwin-patches@cygwin.com>; Thu,  2 Nov 2017 15:58:45 +0100 (CET)
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 50F00A80658; Thu,  2 Nov 2017 15:58:45 +0100 (CET)
Date: Thu, 02 Nov 2017 14:58:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] posix_fadvise() *returns* error codes but does not set errno
Message-ID: <20171102145845.GE8599@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20171102132622.5756-1-erik.m.bray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <20171102132622.5756-1-erik.m.bray@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-SW-Source: 2017-q4/txt/msg00021.txt.bz2


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 3585

Hi Eric,

On Nov  2 14:26, Erik M. Bray wrote:
> Also updates the fhandler_*::fadvise implementations to adhere to the same
> semantics.

Good catch.  I have just some style nits.

> ---
>  winsup/cygwin/fhandler.cc           |  3 +--
>  winsup/cygwin/fhandler_disk_file.cc | 16 ++++++----------
>  winsup/cygwin/pipe.cc               |  3 +--
>  winsup/cygwin/syscalls.cc           |  2 +-
>  4 files changed, 9 insertions(+), 15 deletions(-)
>=20
> diff --git a/winsup/cygwin/fhandler.cc b/winsup/cygwin/fhandler.cc
> index d719b7c..858c1fd 100644
> --- a/winsup/cygwin/fhandler.cc
> +++ b/winsup/cygwin/fhandler.cc
> @@ -1764,8 +1764,7 @@ fhandler_base::fsetxattr (const char *name, const v=
oid *value, size_t size,
>  int
>  fhandler_base::fadvise (off_t offset, off_t length, int advice)
>  {
> -  set_errno (EINVAL);
> -  return -1;
> +  return EINVAL;
>  }
>=20=20
>  int
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.cc
> index 2144a4c..f46e355 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -1076,8 +1076,7 @@ fhandler_disk_file::fadvise (off_t offset, off_t le=
ngth, int advice)
>  {
>    if (advice < POSIX_FADV_NORMAL || advice > POSIX_FADV_NOREUSE)
>      {
> -      set_errno (EINVAL);
> -      return -1;
> +      return EINVAL;
>      }

Please remove the braces for a one-line block.

>=20=20
>    /* Windows only supports advice flags for the whole file.  We're using
> @@ -1097,21 +1096,18 @@ fhandler_disk_file::fadvise (off_t offset, off_t =
length, int advice)
>    NTSTATUS status =3D NtQueryInformationFile (get_handle (), &io,
>  					    &fmi, sizeof fmi,
>  					    FileModeInformation);
> -  if (!NT_SUCCESS (status))
> -    __seterrno_from_nt_status (status);
> -  else
> +  if (NT_SUCCESS (status))
>      {
>        fmi.Mode &=3D ~FILE_SEQUENTIAL_ONLY;
>        if (advice =3D=3D POSIX_FADV_SEQUENTIAL)
> -	fmi.Mode |=3D FILE_SEQUENTIAL_ONLY;
> +        fmi.Mode |=3D FILE_SEQUENTIAL_ONLY;

You changed indentation here for no apparent reason (TABs vs spaces).

>        status =3D NtSetInformationFile (get_handle (), &io, &fmi, sizeof =
fmi,
> -				     FileModeInformation);
> +                                     FileModeInformation);
>        if (NT_SUCCESS (status))
> -	return 0;
> -      __seterrno_from_nt_status (status);
> +	    return 0;
>      }

Ditto and ditto.

> -  return -1;
> +  return geterrno_from_nt_status (status);
>  }
>=20=20
>  int
> diff --git a/winsup/cygwin/pipe.cc b/winsup/cygwin/pipe.cc
> index 79b7966..8738d34 100644
> --- a/winsup/cygwin/pipe.cc
> +++ b/winsup/cygwin/pipe.cc
> @@ -165,8 +165,7 @@ fhandler_pipe::lseek (off_t offset, int whence)
>  int
>  fhandler_pipe::fadvise (off_t offset, off_t length, int advice)
>  {
> -  set_errno (ESPIPE);
> -  return -1;
> +  return ESPIPE;
>  }
>=20=20
>  int
> diff --git a/winsup/cygwin/syscalls.cc b/winsup/cygwin/syscalls.cc
> index caa3a77..d0d735b 100644
> --- a/winsup/cygwin/syscalls.cc
> +++ b/winsup/cygwin/syscalls.cc
> @@ -2937,7 +2937,7 @@ posix_fadvise (int fd, off_t offset, off_t len, int=
 advice)
>    if (cfd >=3D 0)
>      res =3D cfd->fadvise (offset, len, advice);
>    else
> -    set_errno (EBADF);
> +    res =3D EBADF;
>    syscall_printf ("%R =3D posix_fadvice(%d, %D, %D, %d)",
>  		  res, fd, offset, len, advice);
>    return res;
> --=20
> 2.8.3

Other than that, looks good.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 819

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZ+zKlAAoJEPU2Bp2uRE+gMGcP/jMtyu6fgV4Wg6hiRBO7rGZQ
0b3dRl5b0++B/+igVbWInCdb04JhAvsfZEgRewxphn3ozB8CkQ+lV8B29W5/m5DJ
auDT6WQ63CuJjCHQ85HpPvRa88zpBil4cUAUgLc7tCp4ux73D5Qsg+Bfbnb/BhsF
5JsOgTcdNJ66n2B+aqtpRuH6CPe/WyO4IuTQzH7X9l1v28Ft+r78Ds9nTVNpNzl+
bA18AoQBd0AXHgI6q0oNGWKdfQtSQvcA902iADZDW6ja/QTvE/xviE5TCYR7MLgx
N/wj2665dybJ8BZHhQudqa1t02SiJKMRQBfiDgTQpjEBGAh37b2c+vFeyXHfskL1
M20O/jB2ResKgSmw7lhK3qoO+tupp5VIwZ4Zzu8iFZmpZWqDKhOH3KlDYt9pRJWC
IJFp5YQQgkfFlFW+6QOstNKvHwZXxRYyXc9L8ZByZUrJOVC4PRTF8fk5BEDsaQcb
rzIIMmM8GZRDaRxablpjBaPxE2wgOks7xq8qLwgGMtc3aII+W8JVw05F6fUFJuOh
car8BW1dEpegdkbf+yn4cxeJtJqAaJXdRpCoZ65I1/Try+MAKKdFjcyyOyumPzXM
lA28/yRG+bQv9L3+Qa3Oagy95Gq1W44e5LVdTnuTAg8aCETi7mVYBdN8fEgDKo5D
ddQi4i5yc7fW+DwVR+Da
=ayTI
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
