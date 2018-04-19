Return-Path: <cygwin-patches-return-9054-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 54379 invoked by alias); 19 Apr 2018 12:22:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 54369 invoked by uid 89); 19 Apr 2018 12:22:15 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-124.1 required=5.0 tests=AWL,BAYES_00,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,GOOD_FROM_CORINNA_CYGWIN,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=
X-HELO: mout.kundenserver.de
Received: from mout.kundenserver.de (HELO mout.kundenserver.de) (212.227.126.134) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 19 Apr 2018 12:22:13 +0000
Received: from calimero.vinschen.de ([217.91.18.234]) by mrelayeu.kundenserver.de (mreue001 [212.227.15.167]) with ESMTPSA (Nemesis) id 0LcK74-1ekI8l42mU-00jonj for <cygwin-patches@cygwin.com>; Thu, 19 Apr 2018 14:22:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)	id D233CA81EE7; Thu, 19 Apr 2018 14:22:08 +0200 (CEST)
Date: Thu, 19 Apr 2018 12:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 1/2] Posix asynchronous I/O support: fhandler files
Message-ID: <20180419122208.GO15911@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20180419080402.10932-1-mark@maxrnd.com> <20180419080402.10932-3-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;	protocol="application/pgp-signature"; boundary="C94crkcyjafcjHxo"
Content-Disposition: inline
In-Reply-To: <20180419080402.10932-3-mark@maxrnd.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-UI-Out-Filterresults: notjunk:1;V01:K0:07vc6Jft5ac=:6moF7pivw/lpvWJKJvOnmg EEsfZUGIZvFd29Iqy+9JMFZKlNRuCrejBghSnhHP6Xdnl0d2XlJJ92qMkheX8C2Rirv7APRzK hgT1NnYkb1mijFDtkV+mjyOhcHQnpH4fktLuXAOLMaAcVYsaDgWs2+hfF1fqUy9kv5BDarpwT GrObVBGtwfn3Ow5CCnU9BeDr77T6AnGzlXmA7xgpWpPer+6eC+Jox0uNH6Zw+PvpwIBgHO3Hu XPsmwFlV4ktGjZz5Ph58z+Wmt54io7+58cVnkdRWbRRRVT/Zm4EfaW6TmXSHVQ9QT2jevxGkd FN0/0t9uZvMKXemIeEe/6ZS0jIzNQiLLa/P99PZ0Mvs/vIc15pmj/lMzPj7jyxOMEUCdaQVFa 7vkZ4FnEW/hty1fleTn9ovaTpS2XuhRIF8t6a8oj6fRA3JcCR357bPB1Udf13G1sw/3bO/Wyj nEq2FH+7ATssA0hsqO0Z4dS74btjGTK+DAR3S2yqxcTR6mKbZ9yjjcD0O5BWOEYhCxcgmLvzf MtPqs8+jbF432CIFQUqIB03wM3XpYZOeki5XLi0Vbwee+fRKaxqUaZTLh/Q7lG9nNdtIdZmbe SbJQjrQsh+I0adK+eS0Li8b3H26xub93U8yYpdf4lU7GgG2xyGbr/J3ZTXQHxm1l0Ql1iaUZb 6aC54LC3ZWy6J59EMwhDhGhMVY3iLWTaoJGlRKqd9+jVNIlhQ9StouuBsW5JvoSar2xAA7goZ WW09gsZzExPB9//Q4ouyaXXjZObOihICAASYDw==
X-SW-Source: 2018-q2/txt/msg00011.txt.bz2


--C94crkcyjafcjHxo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-length: 2810

On Apr 19 01:04, Mark Geisert wrote:
> This code is where the AIO implementation is wired into existing Cygwin
> mechanisms for file and device I/O: the fhandler* functions.  It makes
> use of an existing internal routine prw_open to supply a "shadow fd"
> that permits asynchronous operations on a file the user app accesses
> via its own fd.  This allows AIO to read or write at arbitrary locations
> within a file without disturbing the app's file pointer.  (This was
> already the case with normal pread|pwrite; we're just adding "async"
> to the mix.)
>=20
> This is the 2nd WIP patch set for AIO.  The string XXX marks issues
> I'm specifically requesting comments on, but feel free to comment or
> suggest changes on any of this code.
> ---
>  winsup/cygwin/fhandler.cc           |  4 +-
>  winsup/cygwin/fhandler.h            | 10 ++---
>  winsup/cygwin/fhandler_disk_file.cc | 89 +++++++++++++++++++++++++------=
------
>  3 files changed, 67 insertions(+), 36 deletions(-)
> [...]
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.cc
> index fc87d91c1..c9b231a31 100644
> --- a/winsup/cygwin/fhandler_disk_file.cc
> +++ b/winsup/cygwin/fhandler_disk_file.cc
> @@ -24,6 +24,7 @@ details. */
>  #include "tls_pbuf.h"
>  #include "devices.h"
>  #include "ldap.h"
> +#include <aio.h>
>=20=20
>  #define _COMPILING_NEWLIB
>  #include <dirent.h>
> @@ -1511,28 +1512,34 @@ fhandler_base::open_fs (int flags, mode_t mode)
>     parameter to the latter. */
>=20=20
>  int
> -fhandler_disk_file::prw_open (bool write)
> +fhandler_disk_file::prw_open (bool write, void *aio)
>  {
>    NTSTATUS status;
>    IO_STATUS_BLOCK io;
>    OBJECT_ATTRIBUTES attr;
> +  ULONG options =3D get_options ();
> +
> +  /* If async i/o is intended, turn off default synchronous operation op=
tion */
> +  //XXX prw_open() only called for first pread|pwrite on an fd. options =
persist!

Ouch, yes.  It's probably unlikely that anybody uses the same descriptor
for synchronous and asynchronous operations but it's not impossible.
Another (third) handle?  Sounds ugly.  Maybe it makes sense to just note
the usage of the handle and close and reopen it if the usage changes...

The rest of the patch looks good, but it just occured to me that there's
a problem I really ignored so far.  If we use pread/pwrite like this for
aio, aio is restricted to on-disk files.  No sockets, no pipes, no
nothing works with aio.

It seems we need top provide pread/pwrite API for other fhandlers as
well in the long run, evn if only for aio.  In the non-aio pread/pwrite
case, returning an ESPIPE error would still be the right thing to do.


Thanks,
Corinna

--=20
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat

--C94crkcyjafcjHxo
Content-Type: application/pgp-signature; name="signature.asc"
Content-length: 833

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEoVYPmneWZnwT6kwF9TYGna5ET6AFAlrYifAACgkQ9TYGna5E
T6BRvA/9HPcxbXdZWJEa1R1TA5YJPrtF63dGk6BZ7S5asVendX0OpyhQu8ac6DnH
Nr7U9547yn3RXhC6AOgNYB3WkxFAaqLSiLvRRQQu6/KV+Q68ykh0Z8D4Bo4FXTp+
NsJtyCofZi5SoscNaba7/v4AY42KJYQ5GH1StTKaHiYOZ+aIqh9xeiHI2BiwrHsI
sPLr61Q2Yb8i1sAIEaqV4Bvh/4ZGWCdKJLOaUbeXjyEzBm0EhjiqjGaA/Yz3aHJ7
kVKR0wRNopdzntcHcZIwHZFk0oveWnvwQGwdeGdjo2ULwOqXKHoZvRsRk1VCh2Ab
BtLgp4ogBCaoJz+xgAacP13YnEIfxZESDkDpHk9DT5f13KUXckRrbYTNtSP5yOs6
wRIm78V8V3NBn8rT2PFsyE5rGKM410A0juiFEojqYZI4bAprgAgSIxGiBEf9p1Jh
m5D8EB0TMPuC9PhDALCEJv8VFWwpvgfI5zX/erNxpsprHuldFLxHY7Q33gOphKMU
5ApO+ax9jlUVpod85vYyIJzJjJWdAVHRz4+bcsihrV/hWrJU4PZIZ1otzvDxP8nB
fdR2BbNG12thx5Nh6OjpeUag3vfZyfpUr+EgYZE7n4FdD9EgxVdu1ISp+YsiuoKr
ZFY2fa7ml7/RJJGxKYFMbL/PTDLPIilI5aEuQQ5zD1HW35py6ng=
=m1J/
-----END PGP SIGNATURE-----

--C94crkcyjafcjHxo--
